// RightPanel.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import storyScience 1.0
import ElementType 1.0

Frame {
    id: root

    property bool isCollapsed: false
    property int expandedWidth: 320
    property int collapsedWidth: collapsedButton.width + 10
    property bool isForeshadowingView: false  // 添加伏笔页浏览状态
    property bool isAiCreating: false

    Layout.preferredWidth: isCollapsed ? collapsedWidth : expandedWidth
    Behavior on Layout.preferredWidth {
        NumberAnimation { duration: Style.durationFast; easing.type: Style.ease }
    }

    signal aiCreating(var data)
    signal aiCreated(var data)
    // 添加定位信号，发送到EditorArea
    signal foreshadowingLocated(string chapterId, string content)
    signal aiError(var error)
    signal connectElement()
    background: Rectangle {
        color: Style.panelBg
    }
    padding: 0
    clip: true

    // 配置对象，用于动态设置按钮的文本和创建元素的参数
    property var tabConfigs: [
        {
            "text": qsTr("+ 新建人物"),
            "type": ElementType.Character,
            "defaultTitle": qsTr("新人物"),
            "defaultColor": "#558B2F",
            "defaultIcon": "qrc:/icons/people.svg"
        },
        {
            "text": qsTr("+ 新建地点"),
            "type": ElementType.Location,
            "defaultTitle": qsTr("新地点"),
            "defaultColor": "#FF7043",
            "defaultIcon": "qrc:/icons/location.svg"
        },
        {
            "text": qsTr("+ 新建道具"),
            "type": ElementType.Item,
            "defaultTitle": qsTr("新道具"),
            "defaultColor": "#7E57C2",
            "defaultIcon": "qrc:/icons/prop.svg"
        },
        {
            "text": qsTr("+ 新建能力"),
            "type": ElementType.Abilities,
            "defaultTitle": qsTr("新能力"),
            "defaultColor": "#66BB6A",
            "defaultIcon": "qrc:/icons/power.svg"
        },
        {
            "text": qsTr("+ 新建组织"),
            "type": ElementType.Organisation,
            "defaultTitle": qsTr("新组织"),
            "defaultColor": "#42A5F5",
            "defaultIcon": "qrc:/icons/Organization.svg"
        },
        {
            "text": qsTr("+ 新建事件"),
            "type": ElementType.Event,
            "defaultTitle": qsTr("新事件"),
            "defaultColor": "#FFA726",
            "defaultIcon": "qrc:/icons/event.svg"
        }
    ]

    property int selectedTabIndex: tabBar.currentIndex

    AddElementPopup {
        id: addElementPopup
        // 3. 监听 accepted 信号，当弹窗确认后，调用 DataManager
        onAccepted: (elementData) => {
            DataManager.createElementForCurrentStoryItem(
                elementData.type,
                elementData.title,
                elementData.description,
                elementData.color,
                elementData.icon,
                elementData.tags
            )
        }
    }
    
    AICreateElementPopup {
        id: aiCreateElementPopup
        // 监听 accepted 信号，当弹窗确认后，调用 AI 创建元素
        onAccepted: (description, type) => {
            var aiManager = DataManager.aiContinuationManager
            aiManager.requestCreateElement(description, type)
            root.selectedTabIndex = tabBar.currentIndex
            root.isAiCreating = true
            root.aiCreating({
                "description": description,
            })
        }
    }

    Connections {
        target: DataManager.aiContinuationManager

        function onCreateElementStreamChunkReceived(chunk) {
        }

        function onCreateElementResponseReceived(response) {
            // 停止创建元素
            root.isAiCreating = false;
            
            console.log("原始响应:", response);

            // 1. 预处理：提取 JSON 内容（兼容 Markdown 代码块）
            var cleanedResponse = response.trim();

            // 正则匹配 ```json{...}``` 或 ```{...}```，提取中间内容
            var jsonMatch = cleanedResponse.match(/```(?:json)?\s*([\s\S]*?)\s*```/i);
            if (jsonMatch && jsonMatch[1]) {
                cleanedResponse = jsonMatch[1].trim();
            }

            // 2. 尝试解析 JSON
            var jsonObject;
            try {
                jsonObject = JSON.parse(cleanedResponse);
            } catch (e) {
                console.error("❌ 无法解析 AI 响应为 JSON:", e, "原始内容:", response);
                // 可选：弹出错误提示或使用默认值
                return;
            }

            // 3. 提取字段（可加安全检查）
            var title = jsonObject.title || "未命名";
            var description = jsonObject.description || "";
            var color = jsonObject.color || "#666666";
            var icon = jsonObject.icon || "qrc:/icons/people.svg";
            var tags = Array.isArray(jsonObject.tags) ? jsonObject.tags : [];

            // 4. 创建元素对象
            var element = {
                title: title,
                description: description,
                color: color,
                icon: icon,
                tags: tags
            };

            root.aiCreated(element);

            // 5. 添加到 DataManager
            DataManager.createElementForCurrentStoryItem(
                tabConfigs[root.selectedTabIndex].type,
                title,
                description,
                color,
                icon,
                tags
            );
        }

        function onCreateElementRequestError(error) {
            root.isAiCreating = false;
            root.aiError(error);
            console.error("请求错误:", error);
        }

        function onCreateElementRequestFinished(data) {
            root.isAiCreating = false;
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // --- Header ---
        Rectangle {
            id: header
            Layout.fillWidth: true
            Layout.preferredHeight: Style.topBarHeight
            color: Style.panelBg
            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: Style.spacing
                anchors.rightMargin: root.isCollapsed ? 0 : Style.spacingSmall

                ToolButton {
                    id: collapsedButton
                    icon.source: "qrc:/icons/Right.png"
                    icon.color: Style.text
                    ToolTip.visible: hovered
                    ToolTip.text: root.isCollapsed ? qsTr("展开") : qsTr("收起")
                    rotation: root.isCollapsed ? 180 : 0
                    Behavior on rotation { RotationAnimation { duration: Style.durationFast; easing.type: Style.ease } }
                    onClicked: root.isCollapsed = !root.isCollapsed
                    background: Rectangle { color: "transparent" }
                }

                Label {
                    id: labelItem
                    text: root.isForeshadowingView ? qsTr("伏笔库") : qsTr("元素库")
                    font: Style.titleFont
                    color: Style.text
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                    opacity: root.isCollapsed ? 0 : 1
                    Behavior on opacity { NumberAnimation { duration: Style.durationShort } }
                    property bool isHovered: false

                    // 添加 ToolTip
                    ToolTip.visible: labelItem.isHovered
                    ToolTip.text: text  // 用当前 Label 的 text
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: labelItem.isHovered = true
                        onExited: labelItem.isHovered = false
                    }
                }


                Item{
                    Layout.fillWidth: true
                }
                //伏笔库or元素库切换按钮
                ToolButton {
                    id: btn
                    objectName: "switchForEBtn"
                    icon.source: !root.isForeshadowingView ? "qrc:/icons/Foreshadowing.png" : "qrc:/icons/element.png"
                    icon.color: Style.text
                    background: Rectangle {
                        color: btn.hovered ? Style.hover: "transparent"
                    }
                    onClicked: root.isForeshadowingView = !root.isForeshadowingView
                }
            }
        }

        // --- Main Content Area ---
        ColumnLayout {
            id: mainContentArea
            objectName: "mainContentArea"
            Layout.fillWidth: true
            Layout.fillHeight: true
            opacity: root.isCollapsed ? 0 : 1
            visible: !root.isCollapsed
            Behavior on opacity { NumberAnimation { duration: Style.durationShort } }

            // 元素库内容（原有的TabBar和StackLayout）
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                visible: !root.isForeshadowingView  // 仅在非伏笔页浏览时显示
                
                TabBar {
                    id: tabBar
                    Layout.fillWidth: true
                    background: Rectangle {
                        color: Style.windowBg
                        radius: 8          // 圆角
                        border.color: Style.border
                        border.width: 1
                    }
                    
                    TabButton {
                        text: qsTr("人物")
                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: Style.text       
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    TabButton {
                        text: qsTr("地点")
                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: Style.text
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    TabButton {
                        text: qsTr("道具")
                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: Style.text
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    TabButton {
                        text: qsTr("能力")
                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: Style.text
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    TabButton {
                        text: qsTr("组织")
                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: Style.text
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    TabButton {
                        text: qsTr("事件")
                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: Style.text
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                StackLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    currentIndex: tabBar.currentIndex

                    // View 1: Characters
                    ListView {
                        model: DataManager.characterModel
                        clip: true
                        spacing: Style.spacingSmall
                        synchronousDrag: true
                        delegate: ElementDelegate {
                            width: ListView.view.width
                            property ListView listView
                        }
                        ScrollBar.vertical: ScrollBar {
                            policy: ScrollBar.AsNeeded // 或者 ScrollBar.AsNeeded
                        }
                    }

                    // View 2: Locations
                    ListView {
                        model: DataManager.locationModel
                        clip: true
                        spacing: Style.spacingSmall
                        delegate: ElementDelegate {
                            width: ListView.view.width
                            property ListView listView
                        }
                    }

                    // View 3: Items
                    ListView {
                        model: DataManager.itemModel
                        clip: true
                        spacing: Style.spacingSmall
                        delegate: ElementDelegate {
                            width: ListView.view.width
                            property ListView listView
                        }
                    }
                    // View 4:Abilities
                    ListView{
                        model:DataManager.abilitiesModel
                        clip:true
                        spacing: Style.spacingSmall
                        delegate: ElementDelegate {
                            width: ListView.view.width
                            property ListView listView
                        }
                    }

                    // View 5: Origanisation
                    ListView{
                        model:DataManager.origanisationModel
                        clip:true
                        spacing: Style.spacingSmall
                        delegate: ElementDelegate {
                            width: ListView.view.width
                            property ListView listView
                        }
                    }
                    // View 6:Event
                    ListView{
                        model:DataManager.eventModel
                        clip:true
                        spacing: Style.spacingSmall
                        delegate: ElementDelegate {
                            width: ListView.view.width
                            property ListView listView
                        }
                    }
                }

            }

            // 伏笔页内容
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                visible: root.isForeshadowingView

                // 伏笔列表
                ListView {
                    id: foreshadowingListView
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    model: DataManager.foreshadowingModel
                    clip: true
                    spacing: Style.spacing

                    delegate: Frame {
                        width: foreshadowingListView.width - 20
                        background: Rectangle {
                            color: Style.cardBg
                            border.color: Style.border
                            border.width: 1
                            radius: Style.radiusSmall
                        }
                        padding: Style.spacing

                        Column {
                            width: parent.width
                            spacing: Style.spacingSmall

                            // 1. 伏笔原文 - 修复循环依赖问题
                            Label {
                                text: qsTr("<b>原文：</b>") + model.content
                                font: Style.labelFont
                                color: Style.text
                                width: parent.width
                                wrapMode: Text.Wrap
                                textFormat: Text.RichText
                                maximumLineCount: 3
                                elide: Text.ElideRight
                                clip: true
                                // 移除 Layout.preferredHeight: contentHeight
                            }

                            // 2. 伏笔描述
                            Label {
                                text: qsTr("<b>描述: </b>") + model.description
                                font: Style.readerBodyFont
                                color: Style.textSecondary
                                width: parent.width
                                wrapMode: Text.Wrap
                                clip: true
                                visible: model.description.length > 0
                                // 移除 Layout.preferredHeight: contentHeight
                            }

                            // 章节信息
                            Label {
                                id: chapterInfo
                                Layout.fillWidth: true
                                text: qsTr("<b>来自章节:</b> ") + DataManager.getChapterTitleById(model.sourceChapterId)
                                font: Style.captionFont
                                color: Style.textSecondary
                                elide: Text.ElideRight
                            }

                            // 3. 分割线
                            Rectangle {
                                width: parent.width
                                height: 1
                                color: Style.divider
                                visible: model.description.length > 0
                            }

                            // 4. 元数据和操作按钮行 - 使用 RowLayout 作为容器
                            RowLayout {
                                width: parent.width
                                spacing: 0

                                // 左侧“回顾”按钮
                                Button {
                                    id: backText
                                    Layout.alignment: Qt.AlignLeft
                                    Layout.preferredWidth: 80
                                    text: qsTr("回顾")
                                    font: Style.textFont

                                    contentItem: Text {
                                        text: backText.text
                                        font: backText.font
                                        color: Style.buttonPrimaryText
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                    background: Rectangle {
                                        color: Style.buttonPrimaryBg
                                        border.width: 0
                                        border.color: Style.borderHovered
                                        radius: 10

                                        Behavior on border.width { NumberAnimation { duration: 100 } }
                                        Behavior on color { ColorAnimation { duration: 100 } }
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onEntered: backText.background.border.width = 2
                                        onExited: backText.background.border.width = 0
                                        onPressed: backText.background.color = Style.buttonPrimaryBgPressed
                                        onReleased: backText.background.color = Style.buttonPrimaryBg

                                        onClicked: {
                                            var sourceChapterId = model.sourceChapterId
                                            var targetArticle = DataManager.getArticleForStoryItemByChapterId(sourceChapterId)
                                            if (targetArticle) {
                                                var storyIndex = DataManager.getStoryIndexByChapterId(sourceChapterId)
                                                if (storyIndex.valid)
                                                    DataManager.selectStoryItem(storyIndex)
                                                root.foreshadowingLocated(sourceChapterId, model.content)
                                            }
                                        }
                                    }
                                }

                                // 占位符，保证对称
                                Item {
                                    Layout.fillWidth: true
                                }

                                // 右侧“完成/未完成”按钮
                                Button {
                                    id: actionButton
                                    Layout.alignment: Qt.AlignRight
                                    Layout.preferredWidth: 80
                                    text: model.status === ForeshadowingItem.Unresolved ? qsTr("完成") : qsTr("未完成")
                                    font: Style.textFont

                                    contentItem: Text {
                                        text: actionButton.text
                                        font: actionButton.font
                                        color: Style.buttonPrimaryText
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                    background: Rectangle {
                                        color: Style.buttonPrimaryBg
                                        border.width: 0
                                        border.color: Style.borderHovered
                                        radius: 10

                                        Behavior on border.width { NumberAnimation { duration: 100 } }
                                        Behavior on color { ColorAnimation { duration: 100 } }
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onEntered: actionButton.background.border.width = 2
                                        onExited: actionButton.background.border.width = 0
                                        onPressed: actionButton.background.color = Style.buttonPrimaryBgPressed
                                        onReleased: actionButton.background.color = Style.buttonPrimaryBg
                                        onClicked: DataManager.foreshadowingModel.updateStatus(model.id)
                                    }
                                }
                            }

                        }
                    }
                }
            }

        }

        // --- Footer with AI Auto Create Button and New Element Button ---
        Rectangle {
            id: footer
            Layout.fillWidth: true
            Layout.preferredHeight: Math.max(aiAutoCreateButton.implicitHeight, newElementButton.implicitHeight) + Style.spacing * 2
            color: Style.panelBg
            opacity: root.isCollapsed ? 0 : 1
            visible: !root.isCollapsed && !root.isForeshadowingView  // 在非伏笔页浏览时显示
            Behavior on opacity { NumberAnimation { duration: Style.durationShort } }

            RowLayout {
                anchors.fill: parent
                anchors.margins: Style.spacing
                spacing: Style.spacingSmall
                anchors.leftMargin: Style.spacing * 0.5
                anchors.rightMargin: Style.spacing * 0.5
                Button{
                    id: connectElementButton
                    objectName: "connectElementBtn"
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width * 0.2
                    text: qsTr("关联")
                    enabled: DataManager.currentStoryIndex.valid
                    opacity: DataManager.currentStoryIndex.valid ? 1.0 : 0.5
                    background: Rectangle {
                        color: connectElementButton.down ? Style.buttonSuccessBgPressed : (connectElementButton.hovered ? Style.buttonSuccessBgHover : Style.buttonSuccessBg)
                        radius: Style.radiusLarge *1.5
                    }
                    contentItem: Label {
                        text: connectElementButton.text
                        font: connectElementButton.font
                        color: Style.buttonSuccessText
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        // 打开关联元素弹窗
                        root.connectElement()
                    }
                }

                Button {
                    id: aiAutoCreateButton
                    objectName: "aiAutoCreateBtn"
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width * 0.3
                    text: root.isAiCreating ? qsTr("AI创建中...") : qsTr("AI创建")
                    enabled: !root.isAiCreating
                    onClicked: {
                        // 打开AI创建元素弹窗
                        aiCreateElementPopup.elementType = root.tabConfigs[tabBar.currentIndex].type
                        aiCreateElementPopup.open()
                    }
                    font: Style.buttonFont
                    background: Rectangle {
                        color: !root.isAiCreating ? (aiAutoCreateButton.down ? Style.buttonPrimaryBgPressed : (aiAutoCreateButton.hovered ? Style.buttonPrimaryBgHover : Style.buttonPrimaryBg)) : Style.statusInProgress
                        radius: Style.buttonRadius
                    }
                    contentItem: Label {
                        text: aiAutoCreateButton.text
                        font: aiAutoCreateButton.font
                        color: Style.buttonPrimaryText
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Button {
                    id: newElementButton
                    objectName: "newElementBtn"
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width * 0.45
                    // Text is now dynamic based on the selected tab
                    text: root.tabConfigs[tabBar.currentIndex].text
                    onClicked: {
                        var config = root.tabConfigs[tabBar.currentIndex];
                        addElementPopup.config = config
                        addElementPopup.open()
                    }
                    font: Style.buttonFont
                    background: Rectangle {
                        color: newElementButton.down ? Style.buttonPrimaryBgPressed : (newElementButton.hovered ? Style.buttonPrimaryBgHover : Style.buttonPrimaryBg)
                        radius: Style.buttonRadius
                    }
                    contentItem: Label {
                        text: newElementButton.text
                        font: newElementButton.font
                        color: Style.buttonPrimaryText
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }
}
