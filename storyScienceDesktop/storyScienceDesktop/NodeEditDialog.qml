import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Dialog {
    id: root

    // --- Public API ---
    property string nodeId: ""
    property string currentText: ""
    // 信号，在用户点击“确定”时发射
    signal textAccepted(string nodeId, string newText)

    // --- Dialog Properties ---
    title: qsTr("编辑文本")
    modal: true // 模态对话框
    standardButtons: Dialog.Ok | Dialog.Cancel
    width: 400     // 设置宽度
    height: 200    // 设置高度

    onOpened: {
        textField.text = root.currentText
        textField.forceActiveFocus()
        textField.selectAll()
    }

    onAccepted: {
        root.textAccepted(root.nodeId, textField.text)
    }

    // --- Main Layout ---
    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        Label {
            text: qsTr("请输入新的文本:")
        }

        TextField {
            id: textField
            Layout.preferredHeight: 40
            Layout.fillWidth: true
            placeholderText: qsTr("文本")
            onAccepted: {
                root.textAccepted(root.nodeId, textField.text) // 按 Enter 键也视为接受
                root.close()
            }
        }
    }
}
