// AIContinuePopup.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Popup {
    id: root
    width: 320
    height: 56
    padding: 0
    margins: 0

    // 非模态 + 可钉住 + 不自动关闭
    modal: false
    focus: false
    closePolicy: Popup.CloseOnPressOutside // 不自动关闭！必须手动关闭或钉住

    property alias textInput: inputField.text
    property bool isPinned: false // 默认钉住
    property point anchorPoint: Qt.point(0,0)
    property point dragMargin: Qt.point(0, 0) // 用于记录鼠标按下时的偏移
    signal sendRequest(string prompt)

    y: anchorPoint.y - 20 // 初始位置稍微上移
    Behavior on y { NumberAnimation { duration: 200 } }
    scale: 0.95
    opacity: 0
    Behavior on scale { NumberAnimation { duration: 150 } }
    Behavior on opacity { NumberAnimation { duration: 150 } }

    background: Rectangle {
        color: Style.menuBackground
        border.color: Style.border
        border.width: 1
        radius: 8

        // 阴影
        layer.enabled: true
        layer.effect: DropShadow {
            radius: 6
            samples: 12
            color: Qt.rgba(0, 0, 0, 0.2)
            verticalOffset: 2
        }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // 输入框
        TextField {
            id: inputField
            Layout.fillWidth: true
            height: parent.height
            padding: 8
            font.pixelSize: 13
            placeholderText: qsTr("输入续写提示，如“接着写一段战斗场景...”")
            color: Style.text
            selectionColor: Style.accent
            selectedTextColor: "white"
            background: Rectangle { color: "transparent" }

            // 按 Enter 发送
            onAccepted: {
                if (text.trim()) {
                    root.sendRequest(text.trim())
                    text = "" // 清空
                }
            }
        }

        // 发送按钮
        ToolButton {
            id: sendButton
            Layout.preferredWidth: 56
            Layout.fillHeight: true
            text: qsTr("发送")
            font.pixelSize: 13
            highlighted: hovered
            onClicked: {
                if (inputField.text.trim()) {
                    root.sendRequest(inputField.text.trim())
                    inputField.text = ""
                }
            }

            background: Rectangle {
                color: inputField.text.trim() ? Style.accent : Style.disabled
                radius: 0
                opacity: sendButton.hovered ? 0.9 : 0.8
            }
            contentItem: Text {
                text: sendButton.text
                color: "white"
                font: sendButton.font
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        // 钉住/取消钉住按钮
        ToolButton {
            id: pinButton
            Layout.preferredWidth: 36
            Layout.fillHeight: true
            text: root.isPinned ? "📌" : "📍"
            font.pixelSize: 14
            onClicked: {
                root.isPinned = !root.isPinned
                if (!root.isPinned) {
                    // 如果取消钉住，点击外部自动关闭
                    root.closePolicy = Popup.CloseOnPressOutside
                } else {
                    root.closePolicy = Popup.NoAutoClose
                }
            }
            ToolTip.text: root.isPinned ? qsTr("取消钉住") : qsTr("钉住窗口")
        }
    }
    onOpened: {
        var newX = anchorPoint.x
        var newY = anchorPoint.y

        // 边界保护
        if (ApplicationWindow.window) {
            var win = ApplicationWindow.window
            newX = Math.max(0, Math.min(newX, win.width - width))
            newY = Math.max(0, Math.min(newY, win.height - height))
        }

        root.x = newX
        root.y = newY

        Qt.callLater(function() {
            if (inputField) {
                inputField.forceActiveFocus()
            }
        })

        root.scale = 1.0
        root.opacity = 1.0
    }

    Connections {
        target: ApplicationWindow.window
        function onWidthChanged() { reposition() }
        function onHeightChanged() { reposition() }
    }
    function reposition() {
        if (!root.isPinned || !ApplicationWindow.window) return
        var win = ApplicationWindow.window
        root.x = Math.min(root.x, win.width - root.width - 10)
        root.y = Math.min(root.y, win.height - root.height - 10)
    }
}
