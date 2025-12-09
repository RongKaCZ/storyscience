// TextOutlineView.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import storyScience 1.0

Frame {
    id: root
    Layout.fillWidth: true
    Layout.fillHeight: true
    background: Rectangle { color: Style.windowBg }
    padding: 0

    function saveOutLine(){
        DataManager.textOutlineModel.setContent(textArea.text)
    }

    ScrollView {
        anchors.fill: parent
        clip: true
        background: Rectangle {
            color: Style.panelBg
            border.color: Style.panelBorder
        }

        TextArea {
            id: textArea
            text: DataManager.textOutlineModel.content
            wrapMode: Text.Wrap
            padding: Style.spacing
            font.pixelSize: 16
            color: Style.text
            background: Rectangle { color: "transparent" }
            topInset: Style.marginLarge
            // 当模型的内容从外部改变时，更新文本
            Connections {
                target: DataManager.textOutlineModel
                function onContentChanged() {
                    if (textArea.text !== DataManager.textOutlineModel.content) {
                        textArea.text = DataManager.textOutlineModel.content
                    }
                }
            }
        }
    }
}
