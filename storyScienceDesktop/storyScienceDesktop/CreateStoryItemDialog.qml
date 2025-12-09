// CreateStoryItemPopup.qml - 轻量级替代方案
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import storyScience 1.0
import StoryType 1.0

Popup {
    id: root
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    
    // 尺寸和位置
    width: 400
    height: 150
    // 动态计算位置，适应各种情况
    x: {
        if (parent && parent.width > 0) {
            return Math.max(0, (parent.width - width) / 2)
        }
        return 0
    }

    y: {
        if (parent && parent.height > 0) {
            return Math.max(0, (parent.height - height) / 3)
        }
        return 0
    }

    // 确保在窗口调整大小时重新定位
    Connections {
        target: root.parent ? root.parent : null
        enabled: root.visible
        function onWidthChanged() {
            root.x = Qt.binding(function() {
                return root.parent ? Math.max(0, (root.parent.width - root.width) / 2) : 0
            })
        }
        function onHeightChanged() {
            root.y = Qt.binding(function() {
                return root.parent ? Math.max(0, (root.parent.height - root.height) / 3) : 0
            })
        }
    }

    property var parentIndex: Qt.invalidModelIndex
    property int itemType: StoryType.Scene
    property string itemTypeName: qsTr("项")
    signal creationRequested(var parentIndex, int itemType, string title)

    background: Rectangle {
        color: Style.windowBg || "white"
        border.color: Style.border || "gray"
        radius: 4
    }

    onOpened: {
        titleField.text = ""
        titleField.forceActiveFocus()
        okButton.enabled = false
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        Label {
            text: root.itemTypeName
            font.bold: true
            font.pixelSize: 16
            Layout.alignment: Qt.AlignHCenter
        }

        TextField {
            id: titleField
            Layout.fillWidth: true
            placeholderText: qsTr("开始创作吧...")
            font.pixelSize: 14
            onAccepted: {
                if (okButton.enabled) okButton.clicked()
            }
            onTextChanged: {
                okButton.enabled = text.trim().length > 0
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignRight
            spacing: 8

            Button {
                text: qsTr("取消")
                onClicked: root.close()
            }

            Button {
                id: okButton
                text: qsTr("确定")
                enabled: false
                onClicked: {
                    root.creationRequested(root.parentIndex, root.itemType, titleField.text.trim())
                    root.close()
                }
            }
        }
    }
}
