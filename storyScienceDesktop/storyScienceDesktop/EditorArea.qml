// EditorArea.qml - 修正版：支持AI流式追加，光标自动后移
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import storyScience 1.0
import Qt5Compat.GraphicalEffects

Frame {
    id: root

    property int wordCount: DataManager.currentArticle ? DataManager.currentArticle.wordCount : 0
    property bool isUpdating: false
    property point globalMousePos: Qt.point(0, 0)
    property int insertPosition: -1 // 核心：动态记录下一次插入位置
    property bool isFirstChunk: true // 标记是否为第一段响应
    property bool isAIWriting: false
    property bool lockSelection: false
    property bool isPolishing: false // 新增：润色状态
    // 添加保存选择状态的属性
    property int savedSelectionStart: -1
    property int savedSelectionEnd: -1
    property int savedCursorPosition: -1

    property int writingSpeed: 0 // 单位: WPM (Words Per Minute)
    property var typingSessionStartTime: null // 记录一次连续输入开始的时间
    property int typingSessionStartWordCount: 0 // 记录一次连续输入开始时的字数
    property int fontSize: 16 // 添加字体大小属性，默认值为16

    property var rightPanel; // 引用右侧面板

    signal contiuationWriting(var data);
    signal continuationWrited();
    signal polishing(var data);
    signal polished();
    signal aiError(var error)
    signal aiWritingError(var error)
    signal requestSave();
    // 添加Tooltip组件用于显示评论
    ToolTip {
        id: commentTooltip
        visible: false
        background: Rectangle {
            color: "#222"
            border.color: "#666"
            radius: 4
        }
    }

    Shortcut {
        sequence: "Ctrl+S"    // 即 F11 键
        onActivated: {
            requestSave();
        }
    }

    function switchLanguage(lang){
        vocabularyHelperPopup.switchLanguage(lang);
    }

    // Tooltip隐藏定时器
    Timer {
        id: tooltipHideTimer
        interval: 300 // 300毫秒延迟隐藏，响应更灵敏
        onTriggered: {
            commentTooltip.visible = false
        }
    }

    // 添加TextAnalyzer组件
    TextAnalyzer {
        id: analyzer
    }

    // [新增] 用于存储每个高亮块几何信息的模型
    ListModel {
        id: highlightRectsModel
    }

    // [新增] 用于延迟执行高亮计算的计时器，确保UI布局更新完毕
    Timer {
        id: updateHighlightsTimer
        interval: 50 // 短暂延迟
        repeat: false
        onTriggered: updateHighlightRects()
    }
    //防抖动计时器
    Timer {
       id: highlightRecalculationTimer
       interval: 1000 // 用户停止输入1秒后触发
       repeat: false
       onTriggered: updateForeshadowingHighlights()
   }


    //计算并更新所有高亮区域的矩形块
    function updateHighlightRects() {
        highlightRectsModel.clear();
        if (!textArea || analyzer.model.count === 0 || textArea.width <= 0) {
            return;
        }

        for (var i = 0; i < analyzer.model.count; i++) {
            var item = analyzer.model.get(i);
            var startPos = item.start;
            var endPos = startPos + item.length;
            var comment = item.comment;

            if (endPos <= startPos) continue;

            var lineStartPos = startPos;

            while (lineStartPos < endPos) {
                // 获取当前处理行的Y坐标
                var startY = textArea.positionToRectangle(lineStartPos).y;
                var endOfLinePos = lineStartPos;

                // 找到在同一行内的最后一个字符的位置
                while (endOfLinePos + 1 < endPos && textArea.positionToRectangle(endOfLinePos + 1).y === startY) {
                    endOfLinePos++;
                }

                // 计算这一行高亮片段的起始和结束矩形
                var segmentStartRect = textArea.positionToRectangle(lineStartPos);
                var segmentEndRect = textArea.positionToRectangle(endOfLinePos);

                var rectX = segmentStartRect.x;
                var rectY = segmentStartRect.y;
                var rectWidth = (segmentEndRect.x + segmentEndRect.width) - segmentStartRect.x;
                var rectHeight = textArea.font.pixelSize * 1.5; // 使用字体大小估算行高

                // 添加有效的矩形到模型中
                if (rectWidth > 0) {
                    highlightRectsModel.append({
                        "rectX": rectX,
                        "rectY": rectY,
                        "rectWidth": rectWidth,
                        "rectHeight": rectHeight,
                        "comment": comment
                    });


                }

                // 准备处理下一行
                lineStartPos = endOfLinePos + 1;
            }
        }
    }

    function updateForeshadowingHighlights() {
        if (!DataManager.currentArticle) {
            analyzer.clear(); // 如果没有当前文章，清空高亮
            return;
        }

        var currentChapterId = DataManager.currentArticle.id.toString();

        // 从C++ Model获取当前章节的、未解决的伏笔JSON
        var jsonString = DataManager.foreshadowingModel.getUnresolvedAsJson(currentChapterId);
        // 将JSON交给analyzer进行文本匹配和分析
        if (textArea.text.length > 0 && jsonString !== "[]") {
            analyzer.analyzeText(textArea.text, jsonString);
        } else {
            analyzer.clear();
        }
    }

    Connections {
        target: DataManager.foreshadowingModel
        // 当伏笔被添加、删除、或状态更新时，都重新加载高亮
        function onModelReset() { updateForeshadowingHighlights(); }
        function onRowsInserted() { updateForeshadowingHighlights(); }
        function onRowsRemoved() { updateForeshadowingHighlights(); }
        function onDataChanged() { updateForeshadowingHighlights(); }
    }

    ForeShadowPopup {
        id: foreshadowPopup
    }


    Connections {
        target: DataManager
        function onCurrentArticleChanged() {
            root.wordCount = DataManager.currentArticle ? DataManager.currentArticle.wordCount : 0

            Qt.callLater(updateForeshadowingHighlights);
        }
    }

    background: Rectangle { color: Style.windowBg }
    padding: 0

    // 添加处理RightPanel信号的Connections块
    Connections {
        target: rightPanel // RightPanel组件的id在main.qml中定义
        function onForeshadowingLocated(chapterId, content) {
            // 延迟执行定位，确保内容已加载
            locateForeshadowingTimer.chapterId = chapterId;
            locateForeshadowingTimer.content = content;
            locateForeshadowingTimer.restart();
        }
    }
    
    // 定位伏笔的计时器
    Timer {
        id: locateForeshadowingTimer
        interval: 500 // 短暂延迟以确保UI更新完毕
        repeat: false
        property string chapterId: ""
        property string content: ""
        
        onTriggered: {
            var position = textArea.text.indexOf(content)
            if (position !== -1) {
                var rect = textArea.positionToRectangle(position)
                if (rect) {
                    var scrollPos = (rect.y - scrollArea.height / 2) / textArea.contentHeight
                    scrollArea.ScrollBar.vertical.position = Math.max(0, Math.min(1, scrollPos))
                }
            }
        }

    }

    VocabularyHelperPopup { 
        id: vocabularyHelperPopup 
        objectName: "vocabularyHelper"
    }
    //续写
    AIContinuePopup {
        id: aiContinuePopup
        
        // 润色时禁用续写功能
        enabled: !root.isPolishing
        
        onSendRequest: function(prompt) {
            //传递信号给main做提示
            root.contiuationWriting(prompt)

            var aiManager = DataManager.aiContinuationManager

            // 使用保存的选择状态而不是当前状态
            var currentSelStart = root.savedSelectionStart !== -1 ? root.savedSelectionStart : textArea.selectionStart
            var currentSelEnd = root.savedSelectionEnd !== -1 ? root.savedSelectionEnd : textArea.selectionEnd
            var currentCursorPos = root.savedCursorPosition !== -1 ? root.savedCursorPosition : textArea.cursorPosition

            // 如果通过右键菜单触发且没有选中文本，则从文本末尾开始续写
            if (currentSelStart === currentSelEnd) {
                // 没有选中文本，从文本末尾开始续写
                root.insertPosition = textArea.text.length
            } else {
                // 有选中文本，从选区开始位置续写
                var selStart = Math.min(currentSelStart, currentSelEnd)
                root.insertPosition = selStart
            }

            root.isFirstChunk = true
            root.isAIWriting = true
            root.lockSelection = true

            aiManager.requestContinuation(prompt, textArea.text)
        }
    }

    function resetAIState() {
        root.isAIWriting = false
        root.lockSelection = false
        root.insertPosition = -1
        root.isFirstChunk = true
        // 重置保存的选择状态
        root.savedSelectionStart = -1
        root.savedSelectionEnd = -1
        root.savedCursorPosition = -1
    }


    // 文章优化预览对话框
    OptimizationPreviewDialog{
        id: optimizationPreviewDialog
        onApplyOptimization: function(optimizedText) {
            // 检查是否有选中文本
            if (textArea.selectedText && textArea.selectedText.length > 0) {
                // 如果有选中文本，只替换选中部分
                var selectionStart = Math.min(textArea.selectionStart, textArea.selectionEnd)
                var selectionEnd = Math.max(textArea.selectionStart, textArea.selectionEnd)
                textArea.remove(selectionStart, selectionEnd)
                textArea.insert(selectionStart, optimizationPreviewDialog.optimizedText)
            } else {
                // 如果没有选中文本，替换全文
                textArea.remove(0, textArea.length);
                textArea.insert(0, optimizationPreviewDialog.optimizedText);
            }
        }
        onCancel: function() {
            // 取消优化请求
            var aiManager = DataManager.aiContinuationManager
            aiManager.cancelRequest()
            // 重置润色状态
            root.isPolishing = false
            root.lockSelection = false
        }
    }

    // 文章优化弹窗
    OptimizeArticlePopup {
        id: optimizeArticlePopup
        onOptimizeRequested: function(prompt) {
            var aiManager = DataManager.aiContinuationManager
            
            // 判断是否有选中文本
            var selectedText = textArea.selectedText
            var textToOptimize = ""
            
            if (selectedText && selectedText.length > 0) {
                // 如果有选中文本，则只优化选中部分
                textToOptimize = selectedText
            } else {
                // 如果没有选中文本，则优化全文
                textToOptimize = textArea.text
            }
            
            // 注意参数顺序：文章内容在前，优化目标在后
            aiManager.requestOptimizeArticle(prompt,textToOptimize)
            
            // 保存原始文本用于预览对话框
            optimizationPreviewDialog.originalText = textToOptimize
            optimizationPreviewDialog.optimizedText = ""
            optimizationPreviewDialog.open();
            // 设置润色状态
            root.isPolishing = true
            root.lockSelection = true

            root.polishing(prompt);
        }

        Connections{
            target: DataManager.aiContinuationManager
            function onOptimizeArticleStreamChunkReceived(chunk){
                //processAIResponse(chunk)
                optimizationPreviewDialog.appendChunk(chunk)

            }
            function onOptimizeArticleRequestFinished(){
                resetAIState()
                root.isPolishing = false // 重置润色状态
                root.polished()
                optimizationPreviewDialog.enabledBtn = true
            }
            function onOptimizeArticleRequestError(error){
                resetAIState()
                root.aiError(error)
                console.log("优化文章请求出错: " + error)
            }
        }
    }

    function processAIResponse(text) {
        if (!text || text.trim() === "") return

        // 清理Markdown但保留换行符
        var cleanText = cleanMarkdownText(text);
        // 不再删除换行符，保留 \n\n 以实现段落分隔效果
        // var cleanText = text;
        if (cleanText.length === 0) return

        // 第一次：删除选区（如果有）
        if (root.isFirstChunk) {
            //console.log("处理第一次AI响应: selectionStart=" + textArea.selectionStart + ", selectionEnd=" + textArea.selectionEnd + ", selectedText='" + textArea.selectedText + "'")
            // 使用保存的选择状态
            var currentSelStart = root.savedSelectionStart !== -1 ? root.savedSelectionStart : textArea.selectionStart
            var currentSelEnd = root.savedSelectionEnd !== -1 ? root.savedSelectionEnd : textArea.selectionEnd

            //console.log("处理第一次AI响应: using saved/current state - selectionStart=" + currentSelStart + ", selectionEnd=" + currentSelEnd)

            // 无论用户选择的是哪一部分文本，从选择起点开始到文章末尾的所有内容都要被替换
            if (currentSelStart !== currentSelEnd) {
                // 规范化选区范围，确保selStart <= selEnd
                var selStart = Math.min(currentSelStart, currentSelEnd)
                //console.log("处理第一次AI响应: normalized selStart=" + selStart)
                //console.log("处理第一次AI响应: 删除前文本长度=" + textArea.text.length)
                ////console.log("处理第一次AI响应: 将要删除从位置" + selStart + "到末尾的所有文本")
                // 删除从选区起始位置到文本末尾的所有内容
                textArea.remove(selStart, textArea.text.length)
                //console.log("处理第一次AI响应: 删除后文本长度=" + textArea.text.length)
                // 设置插入位置为选区起始位置
                root.insertPosition = selStart
                //console.log("处理第一次AI响应: 设置insertPosition=" + root.insertPosition)
            } else {
                // 如果没有选区，则在当前光标位置插入
                var currentCursorPos = root.savedCursorPosition !== -1 ? root.savedCursorPosition : textArea.cursorPosition
                root.insertPosition = currentCursorPos
                //console.log("处理第一次AI响应: 无选区，设置insertPosition=" + root.insertPosition)
            }
            root.isFirstChunk = false
        }

        // 在 insertPosition 插入文本
        //console.log("准备在位置" + root.insertPosition + "插入文本: '" + cleanText + "'")
        //console.log("插入前文本长度: " + textArea.text.length)
        textArea.insert(root.insertPosition, cleanText)
        //console.log("插入后文本长度: " + textArea.text.length)

        // 更新插入位置（光标自动后移）
        root.insertPosition += cleanText.length
        //console.log("更新insertPosition=" + root.insertPosition)

        // 移动光标到末尾（可选，增强体验）
        textArea.cursorPosition = root.insertPosition
        //console.log("设置光标位置=" + textArea.cursorPosition)

        // 同步到模型（防抖）
        if (DataManager.currentArticle && !root.isUpdating) {
            root.isUpdating = true
            DataManager.currentArticle.content = textArea.text
            root.wordCount = DataManager.currentArticle.wordCount
            DataManager.markProjectDirty()
            root.isUpdating = false
        }
    }
    // 核心修正：AI流式响应处理器
    Connections {
        target: DataManager.aiContinuationManager

        function onStreamChunkReceived(chunk) {
            processAIResponse(chunk)
        }

        function onResponseReceived(response) {
            continuationWrited();
            //不需要这个处理
            //processAIResponse(response)
        }

        function onRequestError(error) {
            resetAIState()
            root.aiWritingError(error)
            console.log("续写请求出错: " + error)
        }

        function onRequestFinished() {
            resetAIState()
        }
    }
    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Frame {
            Layout.fillWidth: true
            Layout.fillHeight: true
            padding: 12
            background: Rectangle { color: Style.windowBg; border.color: Style.border }

            ColumnLayout {
                anchors.fill: parent
                spacing: 10

                // 字数统计栏
                RowLayout {
                    Layout.fillWidth: true

                    Label {
                        id: wordCountLabel
                        text: qsTr("字数: ") + root.wordCount
                        color: Style.text
                        font.pixelSize: 14
                    }

                    Label {
                       id: wpmLabel
                       text: qsTr("速度: ") + root.writingSpeed + qsTr(" 字/分钟")
                       color: Style.text
                       font.pixelSize: 14
                       visible: root.writingSpeed > 0 // 仅在速度大于0时显示
                       Layout.leftMargin: 16 // 与字数统计保持一些间距
                    }


                    Item { Layout.fillWidth: true }

                    RowLayout {
                        spacing: 8

                        Rectangle {
                            width: 16; height: 16; radius: 8
                            color: DataManager.hasUnsavedChanges ? Style.warning : Style.success
                            Behavior on color { ColorAnimation { duration: Style.durationShort } }
                        }

                        Label {
                            text: DataManager.hasUnsavedChanges ? qsTr("未保存") : qsTr("已保存")
                            color: DataManager.hasUnsavedChanges ? Style.warning : Style.success
                            font.pixelSize: 12; font.weight: Font.Medium
                            Behavior on color { ColorAnimation { duration: Style.durationShort } }
                        }
                    }
                }

                RowLayout{
                    id: titleRow
                    // 标题输入框
                    Item {
                        Layout.fillWidth: true
                    }

                    TextField {
                        id: chapterTitleField
                        objectName: "titleField"
                        Layout.preferredWidth: 400
                        horizontalAlignment: Text.AlignHCenter
                        font.bold: true; font.pixelSize: 18; color: Style.text
                        enabled: DataManager.currentStoryIndex.valid
                        background: Rectangle { color: "transparent"; border.color: "#e06c75"; border.width: 1; radius: 4 }

                        onTextEdited: {
                            if (!root.isUpdating && DataManager.currentStoryIndex.valid) {
                                DataManager.updateCurrentStoryItemTitle(text)
                                Qt.callLater(() => DataManager.forceRefreshTreeView())
                            }
                        }

                        Connections {
                            target: DataManager
                            function onCurrentStoryIndexChanged() {
                                root.isUpdating = true
                                if (DataManager.currentStoryIndex.valid) {
                                    var itemData = DataManager.storyModel.getItemData(DataManager.currentStoryIndex)
                                    chapterTitleField.text = itemData?.valid ? itemData.title : qsTr("新章节")
                                } else {
                                    chapterTitleField.text = qsTr("请选择一个章节或场景")
                                }
                                root.isUpdating = false
                            }
                        }

                        Component.onCompleted: {
                            if (DataManager.currentStoryIndex.valid) {
                                var itemData = DataManager.storyModel.getItemData(DataManager.currentStoryIndex)
                                text = itemData?.valid ? itemData.title : "新章节"
                            } else {
                                text = "请选择一个章节或场景"
                            }
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    Button{
                        id: btnFocusTitle
                        objectName: "btnFocusTitle"
                        text: qsTr("润色")
                        width:20
                        height:20
                        font.pixelSize: 11

                        contentItem: Text {
                            text: btnFocusTitle.text
                            font: btnFocusTitle.font
                            color: Style.text
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        background: Rectangle {
                            color: Style.buttonPrimaryBg
                            border.width: 0
                            border.color: Style.borderHovered
                            radius:5
                            Behavior on border.width {
                                NumberAnimation {
                                    duration: 100
                                }
                            }

                            Behavior on color {
                                ColorAnimation {
                                    duration: 100
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                btnFocusTitle.background.border.width = 2
                            }
                            onExited: {
                                btnFocusTitle.background.border.width = 0
                            }
                            onPressed: {
                                btnFocusTitle.background.color = Style.buttonPrimaryBgPressed
                            }
                            onReleased: {
                                btnFocusTitle.background.color = Style.buttonPrimaryBg
                            }
                            onClicked: {
                                // 按钮点击事件处理
                                optimizeArticlePopup.open()
                            }
                        
                        // 润色时禁用按钮
                        enabled: !root.isPolishing && !root.isAIWriting
                        }
                    }
                }
                // 正文编辑区
                ScrollView {
                    id: scrollArea
                    Layout.fillWidth: true;
                    Layout.fillHeight: true;
                    clip: true
                    ScrollBar.vertical.policy: ScrollBar.AsNeeded
                    TextArea {
                        id: textArea
                        objectName: "textArea"
                        width: parent.width
                        height: parent.height - 30
                        wrapMode: Text.Wrap;
                        font.pixelSize: root.fontSize;
                        color: Style.text
                        padding: 10;
                        // 修改文本格式以支持换行显示
                        textFormat: TextEdit.PlainText
                        textMargin: 4
                        enabled: DataManager.currentArticle !== null && !root.isAIWriting && !root.isPolishing
                        // 禁用默认的上下文菜单
                        selectByMouse: true
                        persistentSelection: true
                        //cursorShape: Qt.IBeamCursor
                        Keys.onPressed: function(event) {
                            if ((event.key === Qt.Key_Enter || event.key === Qt.Key_Return) && !event.isAutoRepeat) {
                                if (!root.isAIWriting && !root.isPolishing && enabled) {
                                    // 插入两个换行符，使用 insert 方法保持 undo stack
                                    textArea.insert(textArea.cursorPosition, "\n");
                                    // 光标会自动移到末尾，无需手动设置
                                    event.accepted = true;
                                }
                            }
                        }
                        Timer {
                            id: typingTimeoutTimer
                            interval: 2000 // 暂停输入2秒后触发计算
                            repeat: false // 只触发一次
                            onTriggered: {
                                if (root.typingSessionStartTime === null) return;

                                var endTime = new Date();
                                // 计算时间差（分钟）
                                var timeElapsedMs = endTime - root.typingSessionStartTime;
                                var timeElapsedMinutes = timeElapsedMs / 60000.0;

                                // 计算字数差
                                var wordsTyped = root.wordCount - root.typingSessionStartWordCount;

                                // 只有在有意义的输入（超过2个词）和足够的时间（超过1秒）时才计算
                                if (wordsTyped > 2 && timeElapsedMinutes > (1.0/60.0)) {
                                    root.writingSpeed = Math.round(wordsTyped / timeElapsedMinutes);
                                }

                                // 重置会话，为下一次输入做准备
                                root.typingSessionStartTime = null;
                            }
                        }
                        onSelectionStartChanged: {
                            //console.log("selectionStart changed to: " + textArea.selectionStart + ", selectedText='" + textArea.selectedText + "'")
                            maybeScheduleMenu()
                            if (!root.isAIWriting && !root.lockSelection) {
                                // 不再记录 selectionStart/End，由 insertPosition 动态管理
                            }
                        }
                        onSelectionEndChanged: {
                            //console.log("selectionEnd changed to: " + textArea.selectionEnd + ", selectedText='" + textArea.selectedText + "'")
                            maybeScheduleMenu()
                            if (!root.isAIWriting && !root.lockSelection) {
                                // 同上
                            }
                        }

                        onTextChanged: {
                            if (DataManager.currentArticle && !root.isUpdating) {
                                DataManager.currentArticle.content = text
                                root.wordCount = DataManager.currentArticle.wordCount
                                DataManager.markProjectDirty()

                                if (root.typingSessionStartTime === null) {
                                    root.typingSessionStartTime = new Date();
                                    root.typingSessionStartWordCount = root.wordCount;
                                }
                                // 每次输入都重启计时器
                                typingTimeoutTimer.restart();

                                // 文本改变时触发高亮更新
                                updateHighlightsTimer.restart();
                            }

                            // var cursorAtEnd = (textArea.cursorPosition === textArea.text.length)
                            // if (cursorAtEnd) {
                            //     scrollArea.ScrollBar.vertical.position = scrollArea.ScrollBar.vertical.visualPosition + 0.002
                            //     //console.log("currentPosition:",scrollArea.ScrollBar.vertical.position);
                            //     textArea.update()
                            // }
                        }
                        onEditingFinished:{

                            highlightRecalculationTimer.restart();
                        }

                        Timer {
                            id: menuTimer
                            interval: 300
                            onTriggered: {
                                if (textArea.selectionStart !== textArea.selectionEnd) {
                                    textArea.showContextMenu()
                                }
                            }
                        }

                        function maybeScheduleMenu() {
                            if (contextMenu.visible) return;
                            menuTimer.restart()
                        }

                        function showContextMenu() {
                            if (textArea.selectionStart === textArea.selectionEnd) return;
                            // 保存选择状态
                            root.savedSelectionStart = textArea.selectionStart
                            root.savedSelectionEnd = textArea.selectionEnd
                            root.savedCursorPosition = textArea.cursorPosition
                            //console.log("保存选择状态: selectionStart=" + root.savedSelectionStart + ", selectionEnd=" + root.savedSelectionEnd + ", cursorPosition=" + root.savedCursorPosition + ", selectedText='" + textArea.selectedText + "'")

                            contextMenu.visible = true;
                            var menuX = root.globalMousePos.x - contextMenu.width / 2;
                            var menuY = root.globalMousePos.y + 10;
                            if (menuX < 0) menuX = 0;
                            if (menuY + contextMenu.height > root.height)
                                menuY = root.height - contextMenu.height;
                            contextMenu.x = menuX; contextMenu.y = menuY;
                        }

                        // 添加新的函数用于在光标位置显示菜单
                        function showContextMenuAtCursor() {
                            //console.log("showContextMenuAtCursor called")
                            // 保存当前光标位置
                            root.savedSelectionStart = textArea.selectionStart
                            root.savedSelectionEnd = textArea.selectionEnd
                            root.savedCursorPosition = textArea.cursorPosition

                            // 如果没有选中文本，则将插入位置设置为文本末尾
                            if (textArea.selectionStart === textArea.selectionEnd) {
                                root.insertPosition = textArea.text.length
                                //console.log("No selection, insertPosition set to end: " + root.insertPosition)
                            } else {
                                // 如果有选中文本，则设置为选区开始位置
                                root.insertPosition = Math.min(textArea.selectionStart, textArea.selectionEnd)
                                //console.log("Has selection, insertPosition set to: " + root.insertPosition)
                            }

                            contextMenu.visible = true;
                            //console.log("Context menu visibility set to true")
                            var menuX = root.globalMousePos.x - contextMenu.width / 2;
                            var menuY = root.globalMousePos.y + 10;
                            if (menuX < 0) menuX = 0;
                            if (menuY + contextMenu.height > root.height)
                                menuY = root.height - contextMenu.height;
                            contextMenu.x = menuX; contextMenu.y = menuY;
                            //console.log("Context menu positioned at: x=" + menuX + ", y=" + menuY)
                        }

                        MouseArea {
                            id: mouseInterceptor
                            anchors.fill: parent
                            propagateComposedEvents: true
                            acceptedButtons: Qt.LeftButton | Qt.RightButton  // 明确指定接受的按钮
                            cursorShape: Qt.IBeamCursor;

                            onPressed: function(mouse) {
                                //console.log("Mouse pressed: button=" + mouse.button + ", x=" + mouse.x + ", y=" + mouse.y)
                                //console.log("Mouse pressed: selectionStart=" + textArea.selectionStart + ", selectionEnd=" + textArea.selectionEnd + ", selectedText='" + textArea.selectedText + "'")
                                if (root.isAIWriting || root.lockSelection) {
                                    //console.log("AI writing or lock selection, ignoring mouse press")
                                    mouse.accepted = true
                                    return
                                }
                                // 检查是否为右键点击 (Qt.RightButton = 2)
                                if (mouse.button === 2 || mouse.button === Qt.RightButton) {
                                    //console.log("Right button pressed, showing context menu")
                                    // 右键点击，保存当前光标位置并显示菜单
                                    root.savedSelectionStart = textArea.selectionStart
                                    root.savedSelectionEnd = textArea.selectionEnd
                                    root.savedCursorPosition = textArea.cursorPosition
                                    // 更新全局鼠标位置
                                    var pos = mapToItem(root, mouse.x, mouse.y);
                                    root.globalMousePos = Qt.point(pos.x, pos.y);
                                    // 显示菜单
                                    textArea.showContextMenuAtCursor()
                                    mouse.accepted = true
                                    return
                                }

                                //console.log("Not right button (button=" + mouse.button + "), propagating event")
                                mouse.accepted = false
                                if (contextMenu.visible) contextMenu.visible = false
                                var pos = mapToItem(root, mouse.x, mouse.y);
                                root.globalMousePos = Qt.point(pos.x, pos.y);
                            }

                            onReleased: function(mouse) {
                                //console.log("Mouse released: button=" + mouse.button)
                                //console.log("Mouse released: selectionStart=" + textArea.selectionStart + ", selectionEnd=" + textArea.selectionEnd + ", selectedText='" + textArea.selectedText + "'")
                                if (root.isAIWriting || root.lockSelection) {
                                    //console.log("AI writing or lock selection, ignoring mouse release")
                                    mouse.accepted = true
                                    return
                                }
                                // 检查是否为右键点击 (Qt.RightButton = 2)
                                if (mouse.button === 2 || mouse.button === Qt.RightButton) {
                                    //console.log("Right button released, already handled in press")
                                    // 右键已经在pressed中处理了
                                    mouse.accepted = true
                                    return
                                }

                                //console.log("Not right button (button=" + mouse.button + "), propagating event")
                                mouse.accepted = false
                                var pos = mapToItem(root, mouse.x, mouse.y);
                                root.globalMousePos = Qt.point(pos.x, pos.y);
                                if (textArea.selectionStart !== textArea.selectionEnd) {
                                    textArea.maybeScheduleMenu()
                                }
                            }

                            onPositionChanged: function(mouse) {
                                if (root.isAIWriting || root.lockSelection) {
                                    mouse.accepted = true
                                    return
                                }
                                mouse.accepted = false
                                if (contextMenu.visible) {
                                    contextMenu.visible = false
                                    menuTimer.stop()
                                }
                                var pos = mapToItem(root, mouse.x, mouse.y);
                                root.globalMousePos = Qt.point(pos.x, pos.y);
                            }
                        }
                        Connections {
                            target: DataManager
                            function onCurrentArticleChanged() {
                                root.isUpdating = true
                                textArea.text = DataManager.currentArticle?.content || ""
                                root.isUpdating = false
                            }
                        }

                        Component.onCompleted: {
                            textArea.widthChanged.connect(function() {
                                updateHighlightsTimer.restart()
                            });

                            // 连接分析器模型变化信号
                            analyzer.model.countChanged.connect(function() {
                                updateHighlightsTimer.restart()
                            });
                        }
                    }

                    // 高亮层 - 使用覆盖层方式实现
                    Item {
                        id: highlightLayer
                        anchors.fill: textArea
                        z: 1 // 确保在文本上方

                        Repeater {
                            model: highlightRectsModel
                            delegate: Rectangle {
                                id: highlightRect
                                x: model.rectX
                                y: model.rectY
                                width: model.rectWidth
                                height: model.rectHeight

                                color: Style.foreShadowing //"#FFFF00" // 黄色高亮
                                opacity: 0.4
                                //border.color: "#FFD700"
                                //border.width: 1
                                visible: width > 0 && height > 0 // 确保有效区域才显示

                                // 添加鼠标区域以支持悬停提示
                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    acceptedButtons: Qt.NoButton

                                    onEntered: {
                                        // 显示评论提示
                                        commentTooltip.text = model.comment
                                        commentTooltip.visible = true
                                        tooltipHideTimer.stop()
                                    }
                                    onExited: {
                                        // 隐藏评论提示
                                        tooltipHideTimer.restart()
                                    }
                                    onPositionChanged: {
                                        // 将高亮块内的局部坐标转换为整个视图的全局坐标
                                        var globalPos = highlightRect.mapToItem(root, mouseX, mouseY);
                                        // 将提示框定位在鼠标指针右下方
                                        commentTooltip.x = globalPos.x + 15;
                                        commentTooltip.y = globalPos.y + 15;
                                    }
                                }
                            }
                        }
                    }
                }

            }
        }
    }

    // 右键菜单
    Rectangle {
        id: contextMenu
        width: rowMenu.implicitWidth + 24
        height: rowMenu.implicitHeight + 12
        radius: 8
        color: Style.menuBackground
        border.color: Style.menuBorder
        border.width: 1
        visible: false
        z: 1000

        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0; verticalOffset: 2; radius: 6; samples: 12
            color: Style.menuShadow; spread: 0.1
        }

        Row {
            id: rowMenu
            anchors.centerIn: parent
            spacing: 4

            Component {
                id: menuItemComponent
                Rectangle {
                    width: label.implicitWidth + 24; height: 36; radius: 6
                    color: mouseArea.pressed ? Style.menuItemPressed :
                           mouseArea.containsMouse ? Style.menuItemHover : "transparent"
                    border.color: mouseArea.containsMouse ? Style.menuItemHoverBorder : "transparent"
                    border.width: mouseArea.containsMouse ? 1 : 0

                    Text {
                        id: label
                        anchors.centerIn: parent
                        text: modelData.text
                        font.pixelSize: 14
                        color: Style.menuText
                        font.family: "Microsoft YaHei"
                    }
                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            modelData.action()
                            contextMenu.visible = false
                        }
                    }
                }
            }

            Repeater {
                model: [
                    { text: qsTr("复制"), action: () => clipboard.copy(textArea.selectedText) },
                    { text: qsTr("词典"), action: () => vocabularyHelperPopup.open() },
                    { text: qsTr("AI写"), action: () => {
                        //console.log("AI写菜单项被点击: selectionStart=" + textArea.selectionStart + ", selectionEnd=" + textArea.selectionEnd + ", cursorPosition=" + textArea.cursorPosition + ", selectedText='" + textArea.selectedText + "'")
                        //console.log("AI写菜单项被点击: mouse position=", root.globalMousePos.x, ",", root.globalMousePos.y)
                        aiContinuePopup.anchorPoint = Qt.point(root.globalMousePos.x, root.globalMousePos.y)
                        aiContinuePopup.open()
                    } },
                    { text: qsTr("伏笔"), action: () => {
                            if (textArea.selectedText.length > 0) {
                                // 调用我们定义好的函数，传入所有必要信息
                                var selectionStart = textArea.selectionStart;
                                var selectionEnd = textArea.selectionEnd;
                                var fullText = textArea.text;
                                var contextCharCount = 10; // 定义上下文长度

                                var prefix = fullText.substring(
                                    Math.max(0, selectionStart - contextCharCount),
                                    selectionStart
                                );

                                var suffix = fullText.substring(
                                    selectionEnd,
                                    Math.min(fullText.length, selectionEnd + contextCharCount)
                                );

                                // 将所有数据打包成一个对象传递
                                foreshadowPopup.openWith({
                                    content: textArea.selectedText,
                                    prefix: prefix,
                                    suffix: suffix,
                                    sourceChapterId: DataManager.currentArticle.id.toString()
                                })
                            }
                        }
                    }
                ]
                delegate: menuItemComponent
            }
        }

        MouseArea {
            anchors.fill: parent
            anchors.margins: -100
            propagateComposedEvents: true
            onClicked: (mouse) => {
                //console.log("Context menu background clicked: button=" + mouse.button)
                mouse.accepted = false;
                contextMenu.visible = false
            }
            onPressed: (mouse) => {
                //console.log("Context menu background pressed: button=" + mouse.button)
                mouse.accepted = false
            }
        }
    }


    // 清理函数（修改版）
    function cleanMarkdownText(text) {
        // 保留双换行符，但清理其他Markdown格式
        text = text.replace(/\*\*(.*?)\*\*/g, '$1')
        text = text.replace(/\*\*/g, '')
        text = text.replace(/^>\s*/gm, '')
        text = text.replace(/\s*>\s*/g, ' ')
        text = text.replace(/^-{3,}\s*$/gm, '')
        text = text.replace(/^\s*-{3,}\s*$/gm, '')
        text = text.replace(/\s*-{3,}\s*/g, ' ')
        text = text.replace(/^#{1,6}\s*/gm, '')
        text = text.replace(/^-+\s*/gm, '')
        // 保留双换行符，但将三个或更多换行符合并为两个
        text = text.replace(/\n{3,}/g, '\n\n')
        text = text.replace(/[ \t]+$/gm, '')
        text = text.replace(/^[ \t]+/gm, '')
        text = text.replace(/\\n/g, '\n')
        text = text.replace(/\\t/g, '\t')
        return text
    }
}
