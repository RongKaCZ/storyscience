// main.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import storyScience 1.0

ApplicationWindow {
    id: root
    visible: true
    width: 1280
    height: 720
    title: "Story Science"
    color: "transparent"
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowMinimizeButtonHint | Qt.WindowMaximizeButtonHint

    property bool isReaderView: false
    property int lastEditorViewIndex: 0 // 保存上次的编辑视图索引
    property bool isImmersiveMode: false // 沉浸式写作模式状态

    // 应用启动时同步主题设置并自动加载上次打开的文件
    Component.onCompleted: {

        if (typeof tutorialManager !== 'undefined') {
            tutorialManager.windowWidth = width
            tutorialManager.windowHeight = height
        }

        // 延迟执行以确保DataManager完全初始化
        Qt.callLater(function() {
            if (typeof DataManager !== 'undefined') {
                // 直接访问 DataManager 的属性而不是通过 loadSetting
                // 因为在应用启动时可能还没有完全初始化
                var darkThemeEnabled = DataManager.loadSetting("darkThemeEnabled", false)
                // 确保布尔值正确转换
                if (typeof darkThemeEnabled === 'string') {
                    darkThemeEnabled = (darkThemeEnabled === "true");
                }
                Style.isDark = darkThemeEnabled

                // 加载语言设置
                var language = DataManager.loadSetting("language", "zh")
                if (typeof languageManager !== 'undefined') {
                    languageManager.selectLanguage(language)
                }

                // 自动加载上次打开的文件
                var lastOpenedFile = DataManager.loadSetting("lastOpenedFile", "")
                //console.log("上次打开的文件路径:", lastOpenedFile)
                if (lastOpenedFile && lastOpenedFile.length > 0) {
                    ///console.log("自动加载上次打开的文件:", lastOpenedFile)
                    // 延迟加载以确保DataManager完全初始化
                    Qt.callLater(function() {
                        DataManager.loadProject(lastOpenedFile)
                    })
                }
            } else {
                Style.isDark = false  // 默认使用浅色主题
            }
        })
    }

    Component.onDestruction: {
        // 保存设置页面中的所有设置
        settingPage.saveSettings()
        // 保存项目文件
        var lastOpenedFile = DataManager.loadSetting("lastOpenedFile", settingPage.lastOpenedFile)
        DataManager.saveProject(lastOpenedFile)
    }

    SystemCardManager{
        id:system
    }

    SummaryOverlay {
        id: summaryOverlay


        onAiSummary:function(title){
            var prompt = qsTr("正在为章节 \"%1\" 生成总结，请稍候...").arg(title);
            system.showSystemInfos(qsTr("AI正在生成总结"), prompt, 1, "qrc:/icons/AICreate.png");
        }

        Connections {
            target:DataManager.aiContinuationManager
            // function onAiSummarizeResponseReceived(response){
            //     //summaryOverlay.summaryContent = response
            // }
            function onAiSummarizeStreamChunkReceived(chunk){
                summaryOverlay.appendSummaryContent(chunk)
            }
            function onAiSummarizeResponseReceived(response){
                DataManager.setPreviousSummary(DataManager.currentStoryIndex,response)
                system.showSystemInfos(qsTr("AI总结生成完成"), qsTr("总结已更新"),1, "qrc:/icons/AICreate.png");
            }
        }
    }

    // 爱心捐赠页面
    DonatePage{
        id: donatePage
    }

    KeyDetailsView {
        id: keyDetailsPopup
    }

    // 切换读者视角的函数
    function switchReaderView() {
        if (isReaderView) {
            // 切换回编辑视角
            isReaderView = false
            mainStack.currentIndex = lastEditorViewIndex
        } else {
            // 切换到读者视角
            isReaderView = true
            lastEditorViewIndex = mainStack.currentIndex
            mainStack.currentIndex = 4 // 读者视角的索引
        }
    }

    // 进入沉浸式写作模式的函数
    function toggleImmersiveMode() {
        system.showSystemInfos(qsTr("沉浸式写作模式"), qsTr("按ESC键可退出"), 0, "qrc:/icons/ImmersiveMode.svg");
        isImmersiveMode = !isImmersiveMode
    }

    // 使用 ColumnLayout 作为主布局，底部面板始终在底部
    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // 顶部工具栏（始终显示）
        TopBar {
            Layout.fillWidth: true
            id: topBar

            onShowWriterView: mainStack.currentIndex = 0
            onShowGraphView: {
                mainStack.currentIndex = 1
                // 确保GraphView已加载
                if (graphViewLoader.status === Loader.Null) {
                    graphViewLoader.active = true
                }
            }
            onShowOutlineView: {
                mainStack.currentIndex = 2
                // 确保OutlineView已加载
                if (outlineViewLoader.status === Loader.Null) {
                    outlineViewLoader.active = true
                }
            }
            onShowWorldbuildingView: {
                mainStack.currentIndex = 3
                // 确保WorldbuildingView已加载
                if (worldbuildingViewLoader.status === Loader.Null) {
                    worldbuildingViewLoader.active = true
                }
                // 如果WorldbuildingView已经加载，确保加载内容
                else if (worldbuildingViewLoader.status === Loader.Ready && worldbuildingViewLoader.item) {
                    worldbuildingViewLoader.item.loadContentFromDataManager()
                }
            }
            onShowNotesView: {
                mainStack.currentIndex = 5
                notesView.loadNotes()
            }// 随手笔记视图索引
            onShowSettings: settingPage.open() // 处理显示设置页面信号
            onToggleReaderView: switchReaderView()
            onEnterImmersiveMode: toggleImmersiveMode() // 处理沉浸式写作模式信号
            onLastOpenedFilePathChanged: function(path){
                if (typeof settingPage !== 'undefined') {
                    settingPage.lastOpenedFile = path
                    settingPage.saveSettings()
                }
            }

            onSaveData:{
                // 保存大纲视图数据
                if (mainStack.currentIndex === 2) {  // 大纲视图
                    if (outlineViewLoader.status === Loader.Ready && outlineViewLoader.item) {
                        outlineViewLoader.item.saveOutLine();
                    } else if (typeof outlineView !== 'undefined') {
                        outlineView.saveOutLine();
                    }
                }
                
                // 保存世界观视图数据
                if (mainStack.currentIndex === 3) {  // 世界观视图
                    if (worldbuildingViewLoader.status === Loader.Ready && worldbuildingViewLoader.item) {
                        worldbuildingViewLoader.item.saveWordBuilding();
                    } else if (typeof worldbuildingView !== 'undefined') {
                        worldbuildingView.saveWordBuilding();
                    }
                }
            }

            onLanguageChanged:function(lang){
                if (typeof settingPage !== 'undefined') {
                    settingPage.language = lang
                    settingPage.saveSettings()
                }
                editorArea.switchLanguage(lang);
            }

            onTutorialRequested:{
                mainStack.currentIndex = 0;// 切换到写作视图
                tutorialManager.tutorialActive = true
            }

            onAdvancedTutorialRequested:{
                system.showSystemInfos(qsTr("高级教程"),qsTr("不会哪里，左键无效点右键，双键无效则滑动鼠标滚轮"),1,"qrc:/icons/Tutorial.svg");
            }

            onShowkeyDetails:{
                keyDetailsPopup.loadKeyData(":/keydetails.json");
                keyDetailsPopup.open();
            }

            onShowDonate:{
                donatePage.open()
            }

            // 在沉浸式模式下隐藏顶部工具栏
            visible: !root.isImmersiveMode
        }

        // 主内容区域（使用 StackLayout 在不同视图间切换）
        StackLayout {
            id: mainStack
            Layout.fillWidth: true
            Layout.fillHeight: true
            currentIndex: 0 // 默认显示索引为 0 的写作视图

            onCurrentIndexChanged:{
                topBar.switchNavBarIndex(currentIndex)
                // 当切换到某个视图时，确保对应的Loader已经加载
                switch(currentIndex) {
                    case 1: // GraphView
                        if (graphViewLoader.status === Loader.Null) {
                            graphViewLoader.active = true
                        }
                        break
                    case 2: // OutlineView
                        if (outlineViewLoader.status === Loader.Null) {
                            outlineViewLoader.active = true
                        }
                        break
                    case 3: // WorldbuildingView
                        if (worldbuildingViewLoader.status === Loader.Null) {
                            worldbuildingViewLoader.active = true
                        }
                        break
                }
            }

            // --- 视图 0: 写作视图 ---
            Rectangle {
                id: writerView
                objectName: "writerView"
                radius: Style.radiusMedium
                color: Style.windowBg
                clip: true
                Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }

                RowLayout {
                    anchors.fill: parent
                    spacing: Style.spacing

                    LeftPanel {
                        id: leftPanel
                        Layout.fillHeight: true
                        onSwitchReadView:{
                            root.switchReaderView();
                        }
                        onDeleteRootBook:{
                            system.showSystemInfos(qsTr("不可删除书籍"),qsTr("提示，书籍根节点不可删除"),1,"qrc:/icons/Warning.svg");
                        }
                        // 在沉浸式模式下隐藏左侧面板
                        visible: !root.isImmersiveMode
                    }
                    EditorArea {
                        id: editorArea
                        Layout.fillHeight: true; Layout.fillWidth: true
                        onPolishing:function(data){
                            system.showSystemInfos(qsTr("文本润色中"),data.prompt,1,"qrc:/icons/Polishing.png");
                        }
                        onPolished:{
                            system.showSystemInfos(qsTr("润色完成"),qsTr("请查看润色结果"),1,"qrc:/icons/Polishing.png");
                        }

                        onContiuationWriting:function(data){
                            leftPanel.enabled = false;
                            system.showSystemInfos(qsTr("续写中"),data,1,"qrc:/icons/Polishing.png");
                        }

                        onContinuationWrited:{
                            leftPanel.enabled = true;
                            system.showSystemInfos(qsTr("续写完成"),qsTr("请查看续写结果"),1,"qrc:/icons/Polishing.png");
                        }

                        onRequestSave:{
                            system.showSystemInfos(qsTr("保存"),qsTr("保存成功"),0,"qrc:/icons/SaveData.svg");
                            topBar.ctrl_s_shortcut_activated();
                        }
                        onAiError:function(data){
                            system.showSystemInfos(qsTr("AI润色请求失败"),data,2,"qrc:/icons/Error.svg");
                        }

                        onAiWritingError:function(data){
                            leftPanel.enabled = true;
                            system.showSystemInfos(qsTr("AI续写请求失败"),data,2,"qrc:/icons/Error.svg");
                        }
                        rightPanel: rightPanel
                    }
                    RightPanel {
                        id: rightPanel
                        Layout.fillHeight: true
                        onAiCreating:function(data){
                            system.showSystemInfos(qsTr("AI创建中"),data.description,1,"qrc:/icons/AICreate.png");
                        }
                        onAiCreated:function(data){
                            system.showSystemInfos(qsTr("创建完成"),data.title,1,"qrc:/icons/Polishing.png");
                        }
                        onAiError:function(data){
                            system.showSystemInfos(qsTr("AI创建请求失败"),data,2,"qrc:/icons/Error.svg");
                        }
                        onConnectElement:{
                            leftPanel.connectElement()
                        }

                        // 在沉浸式模式下隐藏右侧面板
                        visible: !root.isImmersiveMode
                    }
                }
            }

            // --- 视图 1: 关系图谱视图 (懒加载) ---
            Loader {
                id: graphViewLoader
                active: false  // 初始时不加载
                sourceComponent: graphViewComponent
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            
            Component {
                id: graphViewComponent
                GraphView {
                    id: graphView
                    anchors.fill: parent
                }
            }

            // --- 视图 2: 大纲视图 (懒加载) ---
            Loader {
                id: outlineViewLoader
                active: false  // 初始时不加载
                sourceComponent: outlineViewComponent
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            
            Component {
                id: outlineViewComponent
                OutlineView {
                    id: outlineView
                    anchors.fill: parent
                }
            }

            // --- 视图 3: 世界观视图 (懒加载) ---
            Loader {
                id: worldbuildingViewLoader
                active: false  // 初始时不加载
                sourceComponent: worldbuildingViewComponent
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            
            Component {
                id: worldbuildingViewComponent
                WorldbuildingView {
                    id: worldbuildingView
                    anchors.fill: parent
                }
            }

            // --- 视图 4: 读者视角 ---
            ReaderView {
                id: readerView
                Layout.fillWidth: true
                Layout.fillHeight: true

                onSwitchWriteView:{
                    switchReaderView();
                }

                onAiError:function(data){
                    system.showSystemInfos(qsTr("AI点评请求失败"),data,2,"qrc:/icons/Error.svg");
                }
            }

            // --- 视图 5: 随手笔记 ---
            NotesView {
                id: notesView
                Layout.fillWidth: true
                Layout.fillHeight: true

                // onNoteAdded: function(noteData) {
                //     console.log("添加了新笔记:", noteData.title)
                // }

                // onNoteDeleted: function(index) {
                //     console.log("删除了笔记，索引:", index)
                // }

                // onNoteClicked: function(index, noteData) {
                //     console.log("点击了笔记:", noteData.title)
                // }
            }
        }
    }

    //设置页
    BottomPanel{
        id:settingPage

        // 监听字体大小变化并同步给EditorArea
        onFontSizeChanged: {
            if (typeof editorArea !== 'undefined') {
                editorArea.fontSize = settingPage.fontSize
            }
        }
    }

    // 沉浸式模式下的悬浮退出按钮
    ImmersiveExitButton {
        id: immersiveExitButton
        isImmersiveMode: root.isImmersiveMode
        x: 10
        y: 60
        
        // 添加拖拽功能
        MouseArea {
            anchors.fill: parent
            drag.target: immersiveExitButton
            drag.axis: Drag.XAndYAxis
            drag.minimumX: 0
            drag.maximumX: root.width - immersiveExitButton.width
            drag.minimumY: 0
            drag.maximumY: root.height - immersiveExitButton.height
            onPressed: {

            }

            onClicked: {
                if (root.isImmersiveMode){
                    root.showNormal()
                    root.isImmersiveMode = false
                }
            }
        }
        
        onExitImmersiveMode: {
            root.showNormal()
            root.isImmersiveMode = false
        }
    }
    
    //取消沉浸式模式快捷键
    Shortcut {
        sequence: StandardKey.Cancel    // 即 ESC 键
        onActivated: {
            if (root.isImmersiveMode){
                root.showNormal()
                root.isImmersiveMode = false
            }
        }
    }

    Shortcut {
        sequence: "F11"    // 即 F11 键
        onActivated: {
            if (!root.isImmersiveMode){
                root.showMaximized()
                root.toggleImmersiveMode()
            }
        }
    }

    TutorialOverlay {
        id: tutorialOverlay
    }

    Connections{
        target:tutorialOverlay
        function onSwitchPage(){
            if (mainStack.currentIndex < mainStack.count - 1) {
                mainStack.currentIndex = mainStack.currentIndex + 1;
                tutorialManager.setCurrentPage(mainStack.currentIndex);
            } else {
                tutorialManager.setTutorialActive(false);
            }
        }
    }

    // 监听窗口大小变化并通知TutorialManager
    onWidthChanged: {
        tutorialOverlay.updateHighlight();
    }

    onHeightChanged: {
        tutorialOverlay.updateHighlight();
    }

}


















