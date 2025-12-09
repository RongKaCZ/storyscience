// OrganizationStatusView.qml
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
            text: qsTr("组织信息")
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
                    { label: qsTr("影响力"), value: elementStatus.influence || "0" },
                    { label: qsTr("总部"), value: elementStatus.hq || qsTr("未设置") },
                    { label: qsTr("目标"), value: elementStatus.goals || qsTr("无") }
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

    // 资源列表卡片
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
                text: qsTr("资源列表")
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
                    text: (elementStatus.resources || []).join(", ") || qsTr("无")
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

    // 成员列表卡片
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
                text: qsTr("成员列表")
                font: Style.titleFont
                color: Style.text
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Style.border
            }

            Repeater {
                model: elementStatus.members || []
                delegate: RowLayout {
                    Layout.fillWidth: true
                    spacing: Style.spacing

                    Label {
                        text: qsTr("成员 " + (index + 1) + ":")
                        font: Style.bodyFont
                        color: Style.text
                        Layout.preferredWidth: 60
                        horizontalAlignment: Text.AlignRight
                    }

                    Label {
                        text: (modelData.id || qsTr("未知ID")) + " (" + (modelData.role || qsTr("未知角色")) + ")"
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
}
