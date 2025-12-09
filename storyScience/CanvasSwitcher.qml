// CanvasSwitcher.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: canvasSwitcher
    height: 50
    
    property var canvasManager
    // 使用不同的属性名来避免与Menu的FINAL属性冲突
    property int contextMenuCurrentIndex: -1
    property int renameDialogCurrentIndex: -1
    
    // 使用ScrollView来支持水平滚动
    ScrollView {
        id: scrollView
        anchors.fill: parent
        clip: true
        
        // 隐藏垂直滚动条，只显示水平滚动条
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff
        ScrollBar.horizontal.policy: ScrollBar.AsNeeded
        contentWidth: buttonRow.implicitWidth
        contentHeight: buttonRow.height

        Row {
            id: buttonRow
            spacing: 5
            
            Repeater {
                model: canvasManager ? canvasManager.canvases : []
                
                Button {
                    id: canvasButton
                    text: modelData.name
                    checked: index === (canvasManager ? canvasManager.currentCanvasIndex : -1)
                    checkable: true
                    onClicked: {
                        if (canvasManager) {
                            canvasManager.switchToCanvas(index)
                        }
                    }
                    
                    // 限制按钮最大宽度
                    Layout.maximumWidth: 200
                    // 右键菜单用于重命名和删除
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.RightButton
                        onClicked: (mouse) => {
                            if (mouse.button === Qt.RightButton) {
                                canvasSwitcher.contextMenuCurrentIndex = index
                                contextMenu.popup()
                            }
                        }
                        // 防止右键点击触发按钮的onClicked事件
                        preventStealing: true
                    }
                }
            }
        }
        
        // 处理鼠标滚轮事件，使垂直滚轮控制水平滚动
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.NoButton
            onWheel: (wheel) => {
                if (scrollView.contentWidth > scrollView.width) {
                    // 根据滚轮方向水平滚动
                    var newPos = scrollView.ScrollBar.horizontal.position + (wheel.angleDelta.y > 0 ? -0.1 : 0.1)
                    scrollView.ScrollBar.horizontal.position = Math.max(0, Math.min(1, newPos))
                    wheel.accepted = true
                }
            }
        }
    }
    
    // 右键菜单
    Menu {
        id: contextMenu
        
        MenuItem {
            text: qsTr("重命名")
            onTriggered: {
                // 显示重命名对话框
                canvasSwitcher.renameDialogCurrentIndex = canvasSwitcher.contextMenuCurrentIndex
                renameDialog.open()
            }
        }
        
        MenuItem {
            text: qsTr("删除")
            enabled: canvasManager && canvasManager.canvases.length > 1
            onTriggered: {
                if (canvasManager && canvasManager.canvases.length > 1) {
                    canvasManager.removeCanvas(canvasSwitcher.contextMenuCurrentIndex)
                }
            }
        }
    }
    
    // 重命名对话框
    Dialog {
        id: renameDialog
        title: qsTr("重命名图谱")
        standardButtons: Dialog.Ok | Dialog.Cancel
        modal: true
        
        TextField {
            id: renameField
            text: canvasManager && canvasSwitcher.renameDialogCurrentIndex >= 0 && canvasSwitcher.renameDialogCurrentIndex < canvasManager.canvases.length ? 
                  canvasManager.canvases[canvasSwitcher.renameDialogCurrentIndex].name : ""
            selectByMouse: true
            onAccepted: renameDialog.accept()
        }
        
        onAccepted: {
            if (canvasManager && renameField.text.trim() !== "") {
                canvasManager.setCurrentCanvasName(renameField.text.trim())
            }
        }
    }
}
