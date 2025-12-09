import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Item {
    id: root
    property string title: "系统提示"
    property string description: "系统提示"
    property int level: 1
    property string iconSource: "📝"
    property bool isUnlocked: false
    property int displayTime: 3200

    signal clicked()

    width: 320
    height: 110
    opacity: 0
    scale: 0.85
    visible: false

    SequentialAnimation {
        id: showAnimation
        ScriptAction { script: root.visible = true }
        ParallelAnimation {
            NumberAnimation { target: root; property: "opacity"; to: 1; duration: 500; easing.type: Easing.OutQuad }
            NumberAnimation { target: root; property: "scale"; to: 1; duration: 500; easing.type: Easing.OutBack }
        }
        PauseAnimation { duration: root.displayTime }
        ParallelAnimation {
            NumberAnimation { target: root; property: "opacity"; to: 0; duration: 300; easing.type: Easing.InQuad }
            NumberAnimation { target: root; property: "scale"; to: 0.85; duration: 300; easing.type: Easing.InQuad }
        }
        ScriptAction { script: { root.visible = false; root.destroy(); } }
    }

    // 卡片背景 + 阴影
    Rectangle {
        id: cardBackground
        anchors.fill: parent
        radius: 14
        color: "#2c3e50"
        border.color: Style.cardBorder
        border.width: 1.5

        gradient: Gradient {
            GradientStop { position: 0.0; color: Style.panelBg }
            GradientStop { position: 1.0; color: Style.panelBgAlt }
        }

        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 16
            color: Style.iconBg // 使用Style中定义的阴影颜色
        }

        RowLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 15

            // 图标
            Rectangle {
                id: iconWrapper
                Layout.preferredWidth: 60
                Layout.preferredHeight: 60
                radius: 30
                color: Style.iconBg

                Image{
                    anchors.centerIn: parent
                    source: root.iconSource
                    width: 34
                    height: 34
                    fillMode: Image.PreserveAspectFit
                }

                // 等级指示器
                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    width: 22
                    height: 22
                    radius: 11
                    color: Style.primary
                    border.width: 1
                    border.color: Style.c("cardBorder")

                    Text {
                        anchors.centerIn: parent
                        text: root.level
                        font.pixelSize: 11
                        font.bold: true
                        color: "white"
                    }
                }
            }

            // 文本区
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 4

                Text {
                    Layout.fillWidth: true
                    text: root.title
                    font.pixelSize: 18
                    font.bold: true
                    color: Style.c("textPrimary")
                    elide: Text.ElideRight
                    wrapMode: Text.WordWrap
                    maximumLineCount: 2
                }

                Text {
                    Layout.fillWidth: true
                    text: root.description
                    font.pixelSize: 13
                    color: Style.c("textSecondary")
                    wrapMode: Text.WordWrap
                    elide: Text.ElideRight
                    maximumLineCount: 3
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.clicked()
            showAnimation.complete()
        }
    }

    function show() {
        showAnimation.start()
    }
}
