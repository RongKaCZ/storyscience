// AbilityStatusEdit.qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import storyScience 1.0

ColumnLayout {
    id: root
    property var elementStatus: ({})

    signal elementStatusUpdated()
    
    // 临时存储界面状态的属性
    property var tempPrerequisites: []
    
    // 初始化临时状态
    function initializeTempState() {
        tempPrerequisites = (elementStatus.prerequisites || []).slice()
    }
    
    // 同步临时状态到主状态对象
    function syncTempStateToElementStatus() {
        if (!elementStatus) elementStatus = {}
        elementStatus.prerequisites = tempPrerequisites.slice()
    }
    
    // 组件加载时初始化临时状态
    Component.onCompleted: {
        initializeTempState()
    }
    
    // 当外部elementStatus更新时，重新初始化临时状态
    onElementStatusChanged: {
        initializeTempState()
    }
    
    // 当临时状态改变时，同步到主状态
    onTempPrerequisitesChanged: syncTempStateToElementStatus()
    
    spacing: Style.spacing
    
    // 标题区域
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 50
        color: Qt.rgba(Style.primary.r, Style.primary.g, Style.primary.b, 0.15)
        radius: Style.radius
        Layout.bottomMargin: Style.spacing

        // 添加阴影效果
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 2
            radius: 8
            samples: 16
            color: Style.cardShadow
        }

        Label {
            text: qsTr("能力信息编辑")
            font: Style.titleFont
            color: Style.text
            anchors.centerIn: parent
        }
    }

    // 基本信息卡片 - 统一卡片样式
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: childrenRect.height
        color: Style.cardBg
        radius: Style.radius
        Layout.topMargin: Style.spacing
        Layout.bottomMargin: Style.spacing

        // 添加边框和阴影
        border.color: Style.border
        border.width: Style.borderWidth
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 3
            radius: 10
            samples: 16
            color: Style.cardShadow
        }

        ColumnLayout {
            anchors.margins: Style.padding
            width: parent.width
            spacing: Style.spacingMedium

            Label {
                text: qsTr("基本信息")
                font: Style.titleFont
                color: Style.text
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Style.border
            }

            Label {
                text: qsTr("力量类型:")
                color: Style.text
            }
            TextField {
                text: elementStatus.powerCategory || qsTr("普通")
                Layout.fillWidth: true
                color: Style.text
                selectByMouse: true
                background: Rectangle {
                    color: Style.textFieldBg
                    border.color: Style.textFieldBorder
                    border.width: Style.borderWidth
                    radius: Style.textFieldRadius
                }
                onTextChanged: {
                    if (!elementStatus) elementStatus = {}
                    if (elementStatus.powerCategory !== text) {
                        elementStatus.powerCategory = text
                        elementStatusUpdated()
                    }
                }
            }

            Label {
                text: qsTr("消耗:")
                color: Style.text
            }
            TextField {
                text: elementStatus.cost || "1"
                Layout.fillWidth: true
                color: Style.text
                selectByMouse: true
                background: Rectangle {
                    color: Style.textFieldBg
                    border.color: Style.textFieldBorder
                    border.width: Style.borderWidth
                    radius: Style.textFieldRadius
                }
                onTextChanged: {
                    if (!elementStatus) elementStatus = {}
                    if (elementStatus.cost !== text) {
                        elementStatus.cost = text
                        elementStatusUpdated()
                    }
                }
            }

            Label {
                text: qsTr("冷却时间:")
                color: Style.text
            }
            TextField {
                text: elementStatus.cooldown || "0"
                Layout.fillWidth: true
                color: Style.text
                selectByMouse: true
                background: Rectangle {
                    color: Style.textFieldBg
                    border.color: Style.textFieldBorder
                    border.width: Style.borderWidth
                    radius: Style.textFieldRadius
                }
                onTextChanged: {
                    if (!elementStatus) elementStatus = {}
                    if (elementStatus.cooldown !== text) {
                        elementStatus.cooldown = text
                        elementStatusUpdated()
                    }
                }
            }

            Label {
                text: qsTr("等级:")
                color: Style.text
            }
            TextField {
                text: elementStatus.rank || qsTr("等级")
                Layout.fillWidth: true
                color: Style.text
                selectByMouse: true
                background: Rectangle {
                    color: Style.textFieldBg
                    border.color: Style.textFieldBorder
                    border.width: Style.borderWidth
                    radius: Style.textFieldRadius
                }
                onTextChanged: {
                    if (!elementStatus) elementStatus = {}
                    if (elementStatus.rank !== text) {
                        elementStatus.rank = text
                        elementStatusUpdated()
                    }
                }
            }
        }
    }

    // 详情卡片
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: childrenRect.height
        color: Style.cardBg
        radius: Style.radius
        Layout.topMargin: Style.spacing
        Layout.bottomMargin: Style.spacing

        // 添加边框和阴影
        border.color: Style.border
        border.width: Style.borderWidth
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 3
            radius: 10
            samples: 16
            color: Style.cardShadow
        }

        ColumnLayout {
            anchors.margins: Style.padding
            width: parent.width
            spacing: Style.spacingMedium

            Label {
                text: qsTr("详情")
                font: Style.titleFont
                color: Style.text
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Style.border
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.preferredHeight: 150

                TextArea {
                    text: elementStatus.details || qsTr("无")
                    font: Style.bodyFont
                    color: Style.text
                    wrapMode: Text.Wrap
                    selectByMouse: true
                    background: Rectangle { color: "transparent" }
                    onTextChanged: {
                        if (!elementStatus) elementStatus = {}
                        if (elementStatus.details !== text) {
                            elementStatus.details = text
                            elementStatusUpdated()
                        }
                    }
                }
            }
        }
    }
    
    // 前置条件卡片
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: childrenRect.height
        color: Style.cardBg
        radius: Style.radius
        Layout.topMargin: Style.spacing
        Layout.bottomMargin: Style.spacing

        // 添加边框和阴影
        border.color: Style.border
        border.width: Style.borderWidth
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 3
            radius: 10
            samples: 16
            color: Style.cardShadow
        }

        ColumnLayout {
            anchors.margins: Style.padding
            width: parent.width
            spacing: Style.spacingMedium

            Label {
                text: qsTr("前置条件")
                font: Style.titleFont
                color: Style.text
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Style.border
            }

            // 前置条件编辑器
            ColumnLayout {
                Layout.fillWidth: true
                spacing: Style.spacingSmall

                // 显示已添加的前置条件
                Repeater {
                    model: tempPrerequisites
                    delegate: Rectangle {
                        required property int index
                        required property string modelData
                        Layout.fillWidth: true
                        height: 60
                        radius: 16
                        color: Qt.rgba(Style.primary.r, Style.primary.g, Style.primary.b, 0.2)

                        RowLayout {
                            anchors.fill: parent
                            spacing: 8

                            Item {
                                width: 8
                            }

                            ScrollView {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 44

                                Layout.alignment: Qt.AlignHCenter

                                TextArea {
                                    text: modelData
                                    color: {
                                        let luminance = 0.299 * Style.primary.r +
                                                        0.587 * Style.primary.g +
                                                        0.114 * Style.primary.b;
                                        return luminance > 0.6 ? "black" : "white";
                                    }
                                    font: Style.bodyFont
                                    wrapMode: Text.Wrap
                                    readOnly: true
                                    background: Rectangle { color: "transparent" }
                                }
                            }

                            ToolButton {
                                id: closePrereqButton
                                text: qsTr("×")
                                Layout.alignment: Qt.AlignRight | Qt.AlignHCenter
                                Layout.preferredWidth: 50
                                Layout.topMargin: 8
                                background: Rectangle {
                                    color: closePrereqButton.hovered ? Qt.rgba(0, 0, 0, 0.1) : "transparent"
                                    radius: 12
                                }
                                onClicked: {
                                    var prereqs = root.tempPrerequisites.slice()
                                    prereqs.splice(index, 1)
                                    tempPrerequisites = prereqs
                                    parent.elementStatusUpdated()
                                }
                            }

                            Item {
                                width: 8
                            }
                        }
                    }
                }

                // 添加新前置条件的输入行
                RowLayout {
                    Layout.fillWidth: true
                    spacing: Style.spacingSmall

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 100

                        TextArea {
                            id: newPrereq
                            placeholderText: qsTr("前置条件（能力ID或等级）")
                            Layout.fillWidth: true
                            wrapMode: Text.Wrap
                            color: Style.text
                            selectByMouse: true
                        }
                    }
                    Button {
                        text: qsTr("添加")
                        font: Style.buttonFont
                        background: Rectangle {
                            color: Style.buttonPrimaryBg
                            border.color: Style.buttonPrimaryBorder
                            border.width: Style.borderWidth
                            radius: Style.buttonRadius
                        }
                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: Style.buttonPrimaryText
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: {
                            if (newPrereq.text) {
                                var prereqs = tempPrerequisites.slice()
                                prereqs.push(newPrereq.text)
                                tempPrerequisites = prereqs
                                newPrereq.text = ""
                                elementStatusUpdated()
                            }
                        }
                    }
                }
            }
        }
    }
}
