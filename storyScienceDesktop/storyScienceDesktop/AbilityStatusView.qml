// AbilityStatusView.qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import storyScience 1.0

ColumnLayout {
    id: root
    property var elementStatus: ({})
    property color statusColor: Style.primary

    spacing: Style.spacing

    // 标题区域 - 增强视觉效果
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 50
        color: Qt.rgba(statusColor.r, statusColor.g, statusColor.b, 0.15)
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
            text: qsTr("能力信息")
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

            Repeater {
                model: [
                    { label: qsTr("力量类型"), value: elementStatus.powerCategory || qsTr("普通") },
                    { label: qsTr("消耗"), value: elementStatus.cost || "1" },
                    { label: qsTr("冷却时间"), value: elementStatus.cooldown || "0" },
                    { label: qsTr("等级"), value: elementStatus.rank || qsTr("等级") }
                ]
                delegate: RowLayout {
                    Layout.fillWidth: true
                    spacing: Style.spacing

                    Label {
                        text: modelData.label + ":"
                        font: Style.bodyFont
                        color: Style.text
                        Layout.preferredWidth: 80
                        horizontalAlignment: Text.AlignRight
                    }

                    Label {
                        text: modelData.value
                        font: Style.bodyFont
                        color: Style.text
                        Layout.fillWidth: true
                        wrapMode: Text.Wrap
                        elide: Text.ElideRight
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
                    readOnly: true
                    wrapMode: Text.Wrap
                    background: Rectangle { color: "transparent" }
                    selectByMouse: true
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

            ScrollView {
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                
                TextArea {
                    text: (elementStatus.prerequisites || []).join(", ") || qsTr("无")
                    font: Style.bodyFont
                    color: Style.text
                    readOnly: true
                    wrapMode: Text.Wrap
                    background: Rectangle { color: "transparent" }
                    selectByMouse: true
                }
            }
        }
    }
}
