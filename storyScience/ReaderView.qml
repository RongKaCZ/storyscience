// ReaderView.qml - AI读者视角页面
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects
import storyScience 1.0

Rectangle {
    id: readerView
    color: Style.readerBg
    // radius: Style.radiusMedium
    // clip: true

    // 定义信号
    signal switchWriteView()

    // 属性：当前阅读的章节内容
    property string chapterContent: ""
    property string chapterTitle: qsTr("无标题章节")
    property int fontSize: 14
    property string fontFamily: "微软雅黑, SimSun, serif"
    property bool isAiAnalysisEnabled: false
    signal aiError(var error)

    TextAnalyzer {
        id: analyzer
    }

    property var storyData:[
    {
      "text": "林天一睁开眼时，日头已高悬中天。\n\n阳光如金刃斜劈，从窗帘缝隙刺入，在地板上割出一道灼热的光痕。他躺在那张吱呀作响的旧木床上，脑袋沉如灌铅，昨夜在烧烤摊洗碗到凌晨三点的画面仍如走马灯般闪回——油腻的围裙、老板唾沫横飞的呵斥、醉汉拍桌狂笑的喧嚣……还有苏婉最后那条语音，冷得像冰锥扎进耳膜：“林天一，你给不了我未来。”",
      "comment": "开篇节奏拉满！三句话把废柴男主+社畜惨状+前任背刺全怼脸上，00后直呼‘是我本人’。瞳孔地震程度：?????，建议改名叫《当代打工人重生之我是爽文男主》。"
    },
    {
      "text": "【叮！无敌修炼系统绑定成功！】\n\n林天一浑身一僵，猛地翻身坐直，环顾四壁。房间空荡如废墟，墙角堆着几箱泡面，连蟑螂都懒得光顾。",
      "comment": "系统降临名场面！‘蟑螂都懒得光顾’这句神来之笔，惨中带梗，弹幕预定：‘蟑螂：这届宿主太穷，撤了撤了’。爽点起飞前的蓄力，坐牢？不，是蹲起跳台！"
    },
    {
      "text": "他随手一拳挥出——\n\n“砰！！！”\n\n空气被生生打爆，气浪炸开，窗框咔嚓裂开蛛网般的纹路，楼下野猫吓得炸毛狂奔，连垃圾桶都被掀翻！",
      "comment": "物理外挂启动！拳风掀翻垃圾桶这细节太真实了，读者狂拍大腿：‘打工人の愤怒具象化’！建议加更：《论如何用炼气三层修为投诉小区物业噪音扰民》。"
    },
    {
      "text": "林天一一步跨出，瞬息逼近，单手如铁钳般掐住王德发的脖子，将他整个人提离地面！\n\n“刚才，你说要打断我的腿？”林天一声音低沉，却带着山岳般的压迫感，“现在，我给你三秒——跪下，磕头，然后，滚。”",
      "comment": "职场复仇爽点核爆！但人设微尬：前脚还穷到吃泡面，后脚就中二台词拉满？建议补个内心OS：‘系统快教我霸总语录第3章’。弹幕刷屏：‘王经理の工伤鉴定报告呢？’"
    },
    {
      "text": "【叮！主线任务‘登天之路’已激活：三十日内，踏入筑基境，否则——抹杀。】\n\n林天一嘴角微扬，目光如刀，刺破云层。\n\n“这才，刚刚开始。”",
      "comment": "经典飞卢式‘爽完就上紧箍咒’！总结建议：别光顾着打脸前任，快肝任务啊卷王！毕竟——‘系统：我赌五毛钱你活不过三章’（狗头保命）"
    }
    ]

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

    // [新增] 核心函数：计算并更新所有高亮区域的矩形块
    function updateHighlightRects() {
        highlightRectsModel.clear();
        if (!contentDisplay || analyzer.model.count === 0 || contentDisplay.width <= 0) {
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
                var startY = contentDisplay.positionToRectangle(lineStartPos).y;
                var endOfLinePos = lineStartPos;

                // 找到在同一行内的最后一个字符的位置
                while (endOfLinePos + 1 < endPos && contentDisplay.positionToRectangle(endOfLinePos + 1).y === startY) {
                    endOfLinePos++;
                }

                // 计算这一行高亮片段的起始和结束矩形
                var segmentStartRect = contentDisplay.positionToRectangle(lineStartPos);
                var segmentEndRect = contentDisplay.positionToRectangle(endOfLinePos);

                var rectX = segmentStartRect.x;
                var rectY = segmentStartRect.y;
                var rectWidth = (segmentEndRect.x + segmentEndRect.width) - segmentStartRect.x;
                var rectHeight = contentDisplay.font.pixelSize * 1.5; // 使用字体大小估算行高

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


    Connections {
        target: DataManager.aiContinuationManager

        function onAiCommentAnalyzeResponseReceived(response){
            isAiAnalysisEnabled = false;
            analyzer.analyzeText(chapterContent, response)
        }

        function onAiCommentAnalyzeRequestError(error){
            isAiAnalysisEnabled = false;
            readerView.aiError(error)
            console.log("AI评论分析错误: " + error);
        }
    }

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

    onChapterContentChanged: {
        if (chapterContent.length > 0) {
            delayAnalysisTimer.restart();
        }
        updateHighlightsTimer.restart(); // 内容改变时总是触发高亮更新
    }

    // [修改] 字体大小改变时，触发高亮更新
    onFontSizeChanged: updateHighlightsTimer.restart()

    // 延迟分析的定时器
    Timer {
        id: delayAnalysisTimer
        interval: 500 // 500毫秒延迟
        onTriggered: {
            // 清除之前的分析结果
            //analyzer.clear();
            //重新进行分析
        }
    }

    // Tooltip隐藏定时器
    Timer {
        id: tooltipHideTimer
        interval: 300 // [优化] 300毫秒延迟隐藏，响应更灵敏
        onTriggered: {
            commentTooltip.visible = false
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Style.padding
        spacing: Style.spacing

        // 标题栏卡片
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: Style.cardHeight
            color: Style.cardBg
            radius: Style.cardRadius

            // 添加阴影效果
            layer.enabled: true
            layer.effect: DropShadow {
                horizontalOffset: 0
                verticalOffset: 2
                radius: 8
                samples: 16
                color: Style.cardShadow
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: Style.cardPadding
                spacing: Style.spacing

                Button {
                    text: qsTr("返回编辑")
                    objectName: "backButton"
                    icon.source: Style.isDark ? "qrc:/icons/writerLight.png" : "qrc:/icons/writerBlack.png"
                    onClicked: {
                        readerView.switchWriteView()
                    }

                    background: Rectangle {
                        color: parent.down ? Style.buttonSecondaryBgPressed :
                              parent.hovered ? Style.buttonSecondaryBgHover :
                              Style.buttonSecondaryBg
                        border.color: parent.down ? Style.primaryDark :
                                     parent.hovered ? Style.primary :
                                     Style.buttonSecondaryBorder
                        border.width: 1
                        radius: Style.buttonRadius

                        // 添加阴影效果
                        layer.enabled: true
                        layer.effect: DropShadow {
                            horizontalOffset: 0
                            verticalOffset: parent.down ? 1 : 2
                            radius: parent.down ? 2 : 4
                            samples: parent.down ? 4 : 8
                            color: Style.shadow
                        }
                    }

                    contentItem: Row {
                        spacing: Style.buttonIconSpacing
                        Image {
                            source: parent.parent.icon.source
                            width: Style.iconSizeSmall
                            height: Style.iconSizeSmall
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            text: parent.parent.text
                            color: parent.down ? Style.primaryDark :
                                   parent.hovered ? Style.primary :
                                   Style.buttonSecondaryText
                            font: Style.buttonFont
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    // 添加悬停和按下效果
                    scale: parent.down ? Style.pressedScale :
                           parent.hovered ? Style.hoverScale : 1.0
                    Behavior on scale {
                        NumberAnimation {
                            duration: Style.transitionDuration
                            easing.type: Style.ease
                        }
                    }
                }

                Label {
                    text: readerView.chapterTitle
                    font: Style.readerTitleFont
                    color: Style.text
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                }

                RowLayout {
                    spacing: Style.spacingSmall

                    Label {
                        text: qsTr("字体大小:")
                        color: Style.text
                        font: Style.labelFont
                    }

                    Slider {
                        id: fontSizeSlider
                        objectName: "fontSizeSlider"
                        from: 12
                        to: 24
                        value: readerView.fontSize
                        stepSize: 1
                        onValueChanged: readerView.fontSize = fontSizeSlider.value
                        Layout.preferredWidth: 80
                        Layout.preferredHeight: 20

                        // 使用Style.qml中定义的Slider样式
                        background: Rectangle {
                            x: fontSizeSlider.leftPadding
                            y: fontSizeSlider.topPadding + fontSizeSlider.availableHeight / 2 - height / 2
                            implicitWidth: fontSizeSlider.availableWidth
                            implicitHeight: Style.sliderGrooveHeight
                            radius: Style.sliderGrooveHeight / 2
                            color: Style.sliderGroove

                            Rectangle {
                                width: fontSizeSlider.visualPosition * parent.width
                                height: parent.height
                                color: Style.sliderFill
                                radius: Style.sliderGrooveHeight / 2
                            }
                        }

                        handle: Rectangle {
                            x: fontSizeSlider.leftPadding + fontSizeSlider.visualPosition * (fontSizeSlider.availableWidth - width)
                            y: fontSizeSlider.topPadding + fontSizeSlider.availableHeight / 2 - height / 2
                            implicitWidth: Style.sliderHandleSize
                            implicitHeight: Style.sliderHandleSize
                            radius: Style.sliderHandleSize / 2
                            color: fontSizeSlider.pressed ? Style.sliderHandlePressed :
                                   fontSizeSlider.hovered ? Style.sliderHandleHover :
                                   Style.sliderHandle
                            border.color: Style.textOnPrimary
                            border.width: 1

                            // 添加阴影效果
                            layer.enabled: true
                            layer.effect: DropShadow {
                                horizontalOffset: 0
                                verticalOffset: 1
                                radius: 4
                                samples: 8
                                color: Style.shadow
                            }
                        }
                    }

                    Label {
                        text: readerView.fontSize + "px"
                        color: Style.text
                        font: Style.labelFont
                        Layout.preferredWidth: 40
                    }

                    Button {
                        id: aiCommentButton
                        objectName: "aiCommentButton"
                        text: qsTr("AI点评")
                        icon.source: Style.isDark ? "qrc:/icons/ai_commentLight.png" : "qrc:/icons/ai_commentBlack.png"

                        // 使用专门为AI功能设计的按钮样式
                        background: Rectangle {
                            color: parent.down ? Style.buttonAIBgPressed :
                                  parent.hovered ? Style.buttonAIBgHover :
                                  Style.buttonAIBg
                            border.color: Style.buttonAIBorder
                            border.width: 1
                            radius: Style.buttonRadius
                        }

                        contentItem: Row {
                            spacing: Style.buttonIconSpacing
                            Image {
                                source: parent.parent.icon.source
                                width: 16
                                height: 16
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text {
                                text: parent.parent.text
                                color: Style.buttonAIText
                                font: Style.buttonFont
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        // 添加悬停和按下效果
                        scale: parent.down ? Style.pressedScale :
                               parent.hovered ? Style.hoverScale : 1.0
                        Behavior on scale {
                            NumberAnimation {
                                duration: Style.transitionDuration
                                easing.type: Style.ease
                            }
                        }

                        // 添加阴影效果
                        layer.enabled: true
                        layer.effect: DropShadow {
                            horizontalOffset: 0
                            verticalOffset: parent.hovered ? 2 : 1
                            radius: parent.hovered ? 8 : 4
                            samples: parent.hovered ? 16 : 8
                            color: Style.buttonAIShadow
                        }

                        onClicked: {
                            var aiManager = DataManager.aiContinuationManager;
                            if (aiManager && typeof aiManager.requestAiCommentAnalyze === "function") {
                                readerView.isAiAnalysisEnabled = true;
                                aiManager.requestAiCommentAnalyze(chapterContent);
                            } else {
                                console.log("AI管理器或点评功能不可用");
                            }
                        }
                    }
                }
            }
        }

        // 阅读区域
        Rectangle {
            objectName: "readerArea"
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Style.cardBg
            radius: Style.cardRadius

            // 添加阴影效果
            layer.enabled: true
            layer.effect: DropShadow {
                horizontalOffset: 0
                verticalOffset: 2
                radius: 8
                samples: 16
                color: Style.cardShadow
            }

            // 使用ScrollView包装TextArea以显示滚动条
            ScrollView {
                id: scrollView
                anchors.fill: parent
                anchors.margins: Style.cardPadding
                clip: true

                // 确保显示滚动条
                ScrollBar.vertical.policy: ScrollBar.AlwaysOn
                ScrollBar.horizontal.policy: ScrollBar.AsNeeded

                TextArea {
                    id: contentDisplay
                    text: chapterContent
                    wrapMode: TextArea.Wrap
                    readOnly: true
                    selectByMouse: true
                    color: Style.text
                    font.pixelSize: readerView.fontSize
                    font.family: readerView.fontFamily
                    width: scrollView.width - scrollView.ScrollBar.vertical.width
                    height: Math.max(contentHeight, scrollView.height)

                    background: Rectangle {
                        color: readerView.isAiAnalysisEnabled ? Style.highlightHover :"transparent"
                    }
                    // 文本格式设置
                    textFormat: TextEdit.PlainText

                    // 确保文本有合适的边距
                    leftPadding: Style.paddingLarge
                    rightPadding: Style.paddingLarge
                    topPadding: Style.padding
                    bottomPadding: Style.padding

                    // // [代码已修改]
                    // // 这个MouseArea现在是空的，它的作用是确保整个文本区域可以响应鼠标事件，
                    // // 但具体的悬停逻辑完全交给下面的高亮块处理，以避免冲突。
                    // MouseArea {
                    //     anchors.fill: parent
                    //     hoverEnabled: true
                    //     acceptedButtons: Qt.NoButton
                    // }
                }

                // 高亮层 - 使用覆盖层方式实现
                Item {
                    id: highlightLayer
                    anchors.fill: contentDisplay
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

                            // 这是唯一处理悬停逻辑的地方，确保了精确性
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                acceptedButtons: Qt.NoButton

                                onEntered: {
                                    commentTooltip.text = model.comment
                                    commentTooltip.visible = true
                                    tooltipHideTimer.stop()
                                }
                                onExited: {
                                    tooltipHideTimer.restart()
                                }
                                onPositionChanged: {
                                    // 将高亮块内的局部坐标转换为整个视图的全局坐标
                                    var globalPos = highlightRect.mapToItem(readerView, mouseX, mouseY);
                                    // [优化] 将提示框定位在鼠标指针右下方
                                    commentTooltip.x = globalPos.x + 15;
                                    commentTooltip.y = globalPos.y + 15;
                                }
                            }
                        }
                    }
                }
            }
        }
        // 底部状态栏
        Rectangle {
            Layout.fillWidth: true
            height: 30
            color: Style.panelBgAlt
            radius: Style.radiusSmall

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: Style.paddingSmall
                anchors.rightMargin: Style.paddingSmall
                spacing: Style.spacingSmall

                Label {
                    text: qsTr("字数: ") + (chapterContent.length || 0)
                    color: Style.readerTextSecondary
                    font: Style.captionFont
                }

                Rectangle {
                    width: 1
                    height: 16
                    color: Style.divider
                }

                Item { Layout.fillWidth: true }

                Label {
                    text: qsTr("AI读者视角")
                    color: Style.readerTextSecondary
                    font: Style.captionFont
                }
            }
        }
    }

    // 连接DataManager的信号，监听当前选中故事项的变化
    Connections {
        target: DataManager

        function onCurrentStoryIndexChanged() {
            var currentIndex = DataManager.currentStoryIndex
            if (currentIndex.valid) {
                var itemData = DataManager.storyModel.getItemData(currentIndex)
                if (itemData && itemData.valid) {
                    chapterTitle = itemData.title || qsTr("无标题章节")
                } else {
                    chapterTitle = qsTr("无标题章节")
                }
            } else {
                chapterTitle = qsTr("无标题章节")
            }
        }

        function onCurrentArticleChanged() {
            var currentArticle = DataManager.currentArticle
            if (currentArticle && currentArticle.content != "") {
                chapterContent = currentArticle.content || ""
                //var aiString = JSON.stringify(storyData);
                //analyzer.analyzeText(chapterContent, aiString)
            } else {
                chapterContent = qsTr("请选择左侧故事树中的一个章节进行阅读")
            }
        }
    }

    // 初始化：设置初始内容
    Component.onCompleted: {
        var currentArticle = DataManager.currentArticle
        if (currentArticle) {
            chapterContent = currentArticle.content || ""
        } else {
            chapterContent = qsTr("请选择左侧故事树中的一个章节进行阅读\n\nAI读者视角提供了更舒适的阅读体验，适合查看和审阅作品。")
        }

        var currentIndex = DataManager.currentStoryIndex
        if (currentIndex.valid) {
            var itemData = DataManager.storyModel.getItemData(currentIndex)
            if (itemData && itemData.valid) {
                chapterTitle = itemData.title || qsTr("无标题章节")
            }
        } else {
            chapterTitle = qsTr("无标题章节")
        }

       contentDisplay.widthChanged.connect(function() { updateHighlightsTimer.restart() });
       analyzer.model.countChanged.connect(function() { updateHighlightsTimer.restart() });
    }
}
