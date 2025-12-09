// CharacterStatusView.qml
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
            text: qsTr("角色信息")
            font: Style.titleFont
            color: Style.text
            anchors.centerIn: parent
        }
    }

    // 头像卡片 - 改进布局和视觉效果
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: childrenRect.height
        color: Style.cardBg
        radius: Style.radius
        Layout.topMargin: Style.spacing
        Layout.bottomMargin: Style.spacingMedium

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

            AvatarCard {
                id: avatar
                Layout.alignment: Qt.AlignHCenter
                portrait: elementStatus.portrait || ""    // 头像路径
                size: 120                         // 调整头像大小
                borderWidth: 3
                borderColor: Style.primary
                
                // 添加悬停效果
                scale: mouseArea.containsMouse ? 1.05 : 1.0
                Behavior on scale { NumberAnimation { duration: Style.transitionDuration } }
                
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                }
            }
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
                    { label: qsTr("等级"), value: elementStatus.level || qsTr("青铜") },
                    { label: qsTr("经验值"), value: elementStatus.xp || "100/200" },
                    { label: qsTr("阶段"), value: elementStatus.stage || qsTr("1级") }
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

    // 属性卡片
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
                text: qsTr("属性")
                font: Style.titleFont
                color: Style.text
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Style.border
            }

            Repeater {
                model: Object.keys(elementStatus.attributes || {})

                delegate: RowLayout {
                    Layout.fillWidth: true
                    spacing: Style.spacing

                    Label {
                        text: "[" + modelData + "] : "
                        font: Style.bodyFont
                        color: Style.text
                        Layout.preferredWidth: 80
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        color: "transparent"

                        // 用 anchors.fill 而不是 width 绑定，避免父项大小变化时不同步
                        Text {
                            anchors.fill: parent
                            anchors.margins: 0
                            text: elementStatus.attributes[modelData]
                            font: Style.bodyFont
                            color: Style.text
                            wrapMode: Text.Wrap
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }
        }
    }

    // 能力列表卡片
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
                text: qsTr("能力列表")
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
                    text: (elementStatus.abilities || []).join(", ") || qsTr("无")
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

    // 物品列表卡片
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
                text: qsTr("物品列表")
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
                    text: (elementStatus.inventory || []).join(", ") || qsTr("无")
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

    // 状态效果卡片
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
                text: qsTr("状态效果")
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
                    text: (elementStatus.statusEffects || []).join(", ") || qsTr("无")
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

    // 传记卡片
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: childrenRect.height
        color: Style.cardBg
        radius: Style.radius
        Layout.topMargin: Style.spacing
        Layout.bottomMargin: Style.spacingMedium

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
                text: qsTr("传记")
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
                Layout.preferredHeight: 200
                
                TextArea {
                    text: elementStatus.biography || qsTr("无")
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
