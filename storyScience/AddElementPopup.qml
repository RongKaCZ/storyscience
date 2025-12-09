// AddElementPopup.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import storyScience 1.0
import ElementType 1.0

pragma ComponentBehavior: Bound

Popup {
    id: root

    // 接收来自 RightPanel 的配置对象
    property var config: ({})
    // 当用户点击"创建"时，发射此信号，并携带收集到的数据
    signal accepted(var elementData)


    property color selectedColor: "#ffffff"
    property string selectedIcon: ""
    property var currentTags: []
    property var elementStatus: ({})  // 存储元素状态数据

    width: 400
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    anchors.centerIn: Overlay.overlay
    padding: Style.spacing

    background: Rectangle {
        color: Style.panelBg
    }

    // 弹窗打开时，根据传入的 config 重置所有状态
    onOpened: {
        titleField.text = config.defaultTitle || qsTr("新元素")
        descField.text = ""
        selectedColor = config.defaultColor || "#ffffff"
        selectedIcon = config.defaultIcon || ""
        currentTags = []
        elementStatus = {}
        // 初始化对应类型的默认状态
        initializeStatus()
        titleField.forceActiveFocus()
    }

    function initializeStatus() {
        // 根据元素类型初始化默认状态
        switch(config.type) {
        case ElementType.Character:
            elementStatus.level = 1
            elementStatus.xp = 0
            elementStatus.stage = 1
            elementStatus.attributes = {}
            elementStatus.abilities = []
            elementStatus.inventory = []
            elementStatus.statusEffects = []
            elementStatus.biography = ""
            elementStatus.portrait = ""
            break
        case ElementType.Location:
            elementStatus.region = ""
            elementStatus.population = 0
            elementStatus.control = ""
            elementStatus.importance = 1
            elementStatus.coordinates = ""
            elementStatus.resources = []
            elementStatus.climate = ""
            elementStatus.accessibility = 1
            break
        case ElementType.Item:
            elementStatus.rarity = 1
            elementStatus.category = ""
            elementStatus.durability = 100
            elementStatus.effects = []
            elementStatus.ownerId = ""
            elementStatus.value = 0
            break
        case ElementType.Abilities:
            elementStatus.power = 1
            elementStatus.cost = 1
            elementStatus.cooldown = 0
            elementStatus.prerequisites = []
            elementStatus.rank = 1
            break
        case ElementType.Organisation:
            elementStatus.members = []
            elementStatus.influence = 0
            elementStatus.hq = ""
            elementStatus.goals = ""
            elementStatus.resources = []
            break
        case ElementType.Event:
            elementStatus.datetime = ""
            elementStatus.timelinePos = 0.0
            elementStatus.participants = []
            elementStatus.locationId = ""
            elementStatus.status = "planned"
            elementStatus.outcome = ""
            elementStatus.impactScore = 0
            break
        }
    }

    // --- Dialogs ---
    ColorDialog {
        id: colorDialog
        onAccepted: root.selectedColor = colorDialog.selectedColor
    }

    // --- Layout ---
    Frame {
        anchors.fill: parent
        background: Rectangle { color: Style.panelBg }

        ColumnLayout {
            anchors.fill: parent
            spacing: Style.spacing

            Label {
                text: qsTr("创建")
                font: Style.titleFont
                Layout.alignment: Qt.AlignHCenter
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                contentWidth: availableWidth  // 确保内容宽度匹配可用宽度
                contentHeight: innerColumn.implicitHeight
                ColumnLayout {
                    id:innerColumn
                    width: parent.width // 确保内部布局宽度正确
                    spacing: Style.spacing

                    // --- 标题 ---
                    TextField {
                        id: titleField
                        Layout.fillWidth: true
                        placeholderText: qsTr("标题")
                    }

                    // --- 描述（自适应高度版本）---
                    ScrollView {
                        Layout.fillWidth: true
                        Layout.preferredHeight: Math.min(descField.implicitHeight, 200) // 最大高度200
                        clip: true

                        TextArea {
                            id: descField
                            width: parent.width
                            placeholderText: qsTr("描述...")
                            wrapMode: Text.Wrap
                        }
                    }

                    // --- 颜色选择 ---
                    RowLayout {
                        Label { text: qsTr("颜色:") }
                        Rectangle {
                            width: 32;
                            height: 24
                            color: root.selectedColor
                            border.color: "gray"
                            radius: 4
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: colorDialog.open()
                            }
                        }
                    }

                    RowLayout {
                        spacing: Style.spacingSmall

                        ToolButton {
                            icon.source: "qrc:/icons/people.svg"
                            icon.color: "transparent"
                            onClicked: selectedIcon = "qrc:/icons/people.svg"
                            background: Rectangle {
                                color: selectedIcon === "qrc:/icons/people.svg" ?
                                       Qt.rgba(root.selectedColor.r, root.selectedColor.g, root.selectedColor.b, 0.3) :
                                       "transparent"
                                radius: 4
                            }
                        }

                        ToolButton {
                            icon.source: "qrc:/icons/location.svg"
                            icon.color: "transparent"
                            onClicked: selectedIcon = "qrc:/icons/location.svg"
                            background: Rectangle {
                                color: selectedIcon === "qrc:/icons/location.svg" ?
                                       Qt.rgba(root.selectedColor.r, root.selectedColor.g, root.selectedColor.b, 0.3) :
                                       "transparent"
                                radius: 4
                            }
                        }

                        ToolButton {
                            icon.source: "qrc:/icons/prop.svg"
                            icon.color: "transparent"
                            onClicked: selectedIcon = "qrc:/icons/prop.svg"
                            background: Rectangle {
                                color: selectedIcon === "qrc:/icons/prop.svg" ?
                                       Qt.rgba(root.selectedColor.r, root.selectedColor.g, root.selectedColor.b, 0.3) :
                                       "transparent"
                                radius: 4
                            }
                        }

                        ToolButton {
                            icon.source: "qrc:/icons/power.svg"
                            icon.color: "transparent"
                            onClicked: selectedIcon = "qrc:/icons/power.svg"
                            background: Rectangle {
                                color: selectedIcon === "qrc:/icons/power.svg" ?
                                       Qt.rgba(root.selectedColor.r, root.selectedColor.g, root.selectedColor.b, 0.3) :
                                       "transparent"
                                radius: 4
                            }
                        }

                        ToolButton {
                            icon.source: "qrc:/icons/Organization.svg"
                            icon.color: "transparent"
                            onClicked: selectedIcon = "qrc:/icons/Organization.svg"
                            background: Rectangle {
                                color: selectedIcon === "qrc:/icons/Organization.svg" ?
                                       Qt.rgba(root.selectedColor.r, root.selectedColor.g, root.selectedColor.b, 0.3) :
                                       "transparent"
                                radius: 4
                            }
                        }
                        ToolButton {
                            icon.source: "qrc:/icons/event.svg"
                            icon.color: "transparent"
                            onClicked: selectedIcon = "qrc:/icons/event.svg"
                            background: Rectangle {
                                color: selectedIcon === "qrc:/icons/event.svg" ?
                                       Qt.rgba(root.selectedColor.r, root.selectedColor.g, root.selectedColor.b, 0.3) :
                                       "transparent"
                                radius: 4
                            }
                        }

                    }

                    Label { text: qsTr("标签:") }

                    ColumnLayout {
                        id: tagColumn
                        Layout.fillWidth: true
                        spacing: Style.spacingSmall
                        Repeater {
                            model: root.currentTags
                            delegate: Rectangle {
                                required property int index
                                required property string modelData
                                Layout.fillWidth: true
                                height: 32
                                radius: 16
                                color: Qt.rgba(root.selectedColor.r,
                                               root.selectedColor.g,
                                               root.selectedColor.b, 0.2)

                                RowLayout {
                                    anchors.fill: parent
                                    spacing: 8

                                    Item{
                                        width: 8
                                    }

                                    Label {
                                        text: modelData
                                        color: {
                                            let luminance = 0.299 * root.selectedColor.r +
                                                            0.587 * root.selectedColor.g +
                                                            0.114 * root.selectedColor.b;
                                            return luminance > 0.6 ? "black" : "white";
                                        }
                                        Layout.fillWidth: true
                                        elide: Text.ElideMiddle  // 文本过长时显示省略号
                                        horizontalAlignment: Text.AlignLeft
                                    }

                                    ToolButton {
                                        id: closeButton
                                        text: qsTr("×")
                                        Layout.alignment: Qt.AlignRight
                                        Layout.preferredWidth: 24
                                        background: Rectangle {
                                            color: closeButton.hovered ? Qt.rgba(0, 0, 0, 0.1) : "transparent"
                                            radius: 12  // 圆形背景
                                        }
                                        onClicked: {
                                            var newTags = currentTags.slice()
                                            newTags.splice(index, 1)
                                            currentTags = newTags
                                        }
                                    }

                                    Item{
                                        width: 8
                                    }
                                }
                            }
                        }
                    }

                    RowLayout{
                        Layout.fillWidth: true
                        spacing: 10
                        TextField {
                            id: tagInput
                            Layout.fillWidth: true
                            placeholderText: qsTr("输入新标签后按 Enter")
                            onAccepted: {
                                let t = text.trim()
                                if (t !== "" && currentTags.indexOf(t) === -1) {
                                    currentTags = currentTags.concat([t])  // 用 concat，确保 QML 看到变化
                                    text = ""
                                }
                            }
                        }

                        Button {
                            Layout.preferredWidth: 80
                            text: qsTr("添加")
                            onClicked: {
                                let t = tagInput.text.trim()
                                if (t !== "" && currentTags.indexOf(t) === -1) {
                                    currentTags = currentTags.concat([t])  // 用 concat，确保 QML 看到变化
                                    tagInput.text = ""
                                }
                            }
                        }
                    }
                }
            }

            // --- 底部按钮 ---
            RowLayout {
                Layout.fillWidth: true
                Button {
                    text: qsTr("创建")
                    Layout.fillWidth: true
                    highlighted: true
                    onClicked: {
                        // 1. 收集所有数据到一个 JS 对象中
                        var elementData = {
                            "type": config.type,
                            "title": titleField.text,
                            "description": descField.text,
                            "color": selectedColor,
                            "icon": selectedIcon,
                            "tags": currentTags,
                            "status": elementStatus  // 添加状态数据
                        }
                        // 2. 发射信号，将数据传递出去
                        root.accepted(elementData)
                        // 3. 关闭弹窗
                        root.close()
                    }
                }
                Button {
                    text: qsTr("取消")
                    Layout.fillWidth: true
                    onClicked: root.close()
                }
            }
        }
    }
}
