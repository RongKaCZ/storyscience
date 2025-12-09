import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import storyScience 1.0
import Qt5Compat.GraphicalEffects
pragma ComponentBehavior: Bound

Rectangle {
    id: root
    // ---------- 可配置属性 ----------
    property url portrait: ""                    // 头像路径
    property int size: 180                       // 头像大小
    property int borderWidth: 2                  // 边框宽度
    property color borderColor: Style.primary    // 边框颜色

    Layout.fillWidth: true
    Layout.preferredHeight: childrenRect.height
    color: Style.cardBg
    radius: Style.radiusSmall
    Layout.topMargin: Style.spacing

    ColumnLayout {
        anchors.margins: Style.paddingSmall
        width: parent.width
        spacing: Style.spacingSmall

        Label {
            text: qsTr("头像")
            font: Style.titleFont
            color: Style.text
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            color: Style.border
        }

        Loader {
            id: portraitLoader
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: root.size
            Layout.preferredHeight: root.size
            sourceComponent: {
                // 检查 portrait 是否有效，避免 undefined 错误
                if (root.portrait && root.portrait.toString().length > 0 && root.portrait !== qsTr("未设置")) {
                    //console.log("加载头像: " + root.portrait)
                    return portraitImageComponent
                } else {
                    return noPortraitTextComponent
                }
            }
        }

        // ---------- 有头像时 ----------
        Component {
            id: portraitImageComponent
            Item {
                width: root.size
                height: root.size

                Image{
                    id:image
                    anchors.centerIn: parent
                    source:root.portrait
                    smooth: true
                    visible: false
                    width: parent.width
                    height: parent.height
                    fillMode: Image.PreserveAspectCrop
                    antialiasing: true
                }

                Rectangle{
                    id:mask
                    color: "black"
                    anchors.fill: parent
                    radius: root.size/2
                    visible: false
                    smooth: true
                    antialiasing: true
                }

                OpacityMask{
                    anchors.fill:image
                    source: image
                    maskSource: mask
                    visible: true
                    antialiasing: true
                }
            }
        }

        // ---------- 无头像时 ----------
        Component {
            id: noPortraitTextComponent
            Label {
                text: qsTr("未设置头像")
                font: Style.bodyFont
                color: Style.textSecondary
                Layout.fillWidth: true
                Layout.preferredHeight: root.size
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
}
