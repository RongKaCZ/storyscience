// MindMapView.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes
import storyScience 1.0

Item {
    id: mindMapView
    property string selectedNodeId: ""
    property real scaleFactor: 1.0
    property point panOffset: Qt.point(0, 0)
    property string currentDescriptionNodeId: "" // 当前显示描述的节点ID

    Rectangle { anchors.fill: parent; color: Style.windowBg }
    
    // 节点描述弹窗
    NodeDescriptionPopup {
        id: nodeDescriptionPopup
        z:100
        model: mindMapView.model
        nodeId: currentDescriptionNodeId
        // 处理关闭请求
        onCloseRequested: {
            currentDescriptionNodeId = ""
        }
    }
    
    // 描述编辑对话框
    Dialog {
        id: descriptionEditDialog
        title: qsTr("编辑节点描述")
        width: 400
        height: 300
        modal: true
        anchors.centerIn: parent
        
        property string nodeId: ""
        property string currentDescription: ""
        
        contentItem: TextArea {
            id: descriptionEditor
            text: descriptionEditDialog.currentDescription
            wrapMode: TextEdit.Wrap
            selectByMouse: true
        }
        
        standardButtons: Dialog.Ok | Dialog.Cancel
        
        onAccepted: {
            if (nodeId) {
                model.updateNodeDescription(nodeId, descriptionEditor.text)
            }
        }
    }
    
    NodeEditDialog {
        id: nodeEditDialog
        // 当对话框被确认时，调用 C++ 模型的方法来更新文本
        onTextAccepted: (nodeId, newText) => {
            model.updateNodeText(nodeId, newText)
        }
    }

    Flickable {
        id: flickable
        anchors.fill: parent
        contentWidth: contentItem.childrenRect.width + 400
        contentHeight: contentItem.childrenRect.height + 400
        clip: true

        // Ctrl 缩放
        WheelHandler {
            id: wheelZoomHandler
            acceptedModifiers: Qt.ControlModifier       // 只在按下 Ctrl 时激活
            onWheel: function(event) {
                var factor = event.angleDelta.y > 0 ? 1.1 : 1/1.1;
                mindMapView.scaleFactor = Math.max(0.2, Math.min(2.0, mindMapView.scaleFactor * factor));
                event.accepted = true; // 拦截事件，避免 Flickable 继续滚动
            }
        }

        // Shift 横向平移
        WheelHandler {
            id: wheelShiftHandler
            acceptedModifiers: Qt.ShiftModifier         // 只在按下 Shift 时激活
            onWheel: function(event) {
                // 对触控板优先使用 angleDelta.x；鼠标竖滚则用 angleDelta.y
                var raw = (event.angleDelta.x !== 0) ? event.angleDelta.x : event.angleDelta.y;
                // raw 通常以 120 为一档，根据体验调整系数
                var step = raw * 0.5; // 调整平移灵敏度（可改为 1.0 或 0.3）
                // 方向：根据你期望的方向调整 +/-，这里向上滚动（raw>0）向右移动，所以减号可能需要反过来
                mindMapView.panOffset.x -= step;
                event.accepted = true;
            }
        }

        // 单滚轮上下移动，不进行缩放
        WheelHandler {
            id: wheelVerticalHandler
            acceptedModifiers: Qt.NoModifier         // 不按任何修饰键时激活
            orientation: Qt.Vertical                 // 只处理垂直滚动
            onWheel: function(event) {
                // 根据滚轮方向调整垂直滚动
                var step = event.angleDelta.y * 0.5
                mindMapView.panOffset.y += step
                event.accepted = true
            }
        }

        Item {
            id: contentItem
            x: flickable.width / 2 + panOffset.x
            y: flickable.height / 2 + panOffset.y
            scale: scaleFactor

            Repeater {
                model: mindMapView.model ? mindMapView.model.nodes.filter(node => node.parentId) : []
                delegate: Shape {
                    property var fromNode: mindMapView.getNodeItem(modelData.parentId)
                    property var toNode: mindMapView.getNodeItem(modelData.id)
                    visible: fromNode && toNode
                    ShapePath {
                        strokeWidth: 2; strokeColor: "#606060"
                        startX: fromNode ? fromNode.x + fromNode.width / 2 : 0
                        startY: fromNode ? fromNode.y + fromNode.height / 2 : 0
                        PathLine { 
                            x: toNode ? toNode.x + toNode.width / 2 : 0
                            y: toNode ? toNode.y + toNode.height / 2 : 0
                        }
                    }
                }
            }

            Repeater {
                id: nodeRepeater
                model: mindMapView.model ? mindMapView.model.nodes : []
                delegate: Rectangle {
                    id: nodeRect
                    property var nodeData: modelData
                    x: nodeData.x - width / 2
                    y: nodeData.y - height / 2
                    width: 160
                    height: 40
                    color: nodeData.id === mindMapView.selectedNodeId ? Style.primary : Style.secondary
                    border.color: "#333"; border.width: 2; radius: 8

                    Text { anchors.centerIn: parent; text: nodeData.text; color: "white" }

                    DragHandler {
                        target: nodeRect
                        property point startPos: Qt.point(0, 0)
                        onActiveChanged: {
                            if (active) {
                                startPos = Qt.point(nodeRect.x, nodeRect.y)
                            } else {
                                var endPos = Qt.point(nodeRect.x, nodeRect.y)
                                var delta = Qt.point(endPos.x - startPos.x, endPos.y - startPos.y)
                                if (delta.x !== 0 || delta.y !== 0) {
                                    mindMapView.model.moveNodeWithChildren(nodeData.id, delta)
                                }
                            }
                        }
                    }
                    TapHandler {
                        onDoubleTapped:{
                            nodeEditDialog.nodeId = nodeRect.nodeData.id
                            nodeEditDialog.currentText = nodeRect.nodeData.text
                            nodeEditDialog.open()
                        }
                        onTapped: {
                            mindMapView.selectedNodeId = nodeData.id
                            // 显示节点描述
                            mindMapView.currentDescriptionNodeId = nodeData.id
                        }
                    }
                    Menu {
                        id: nodeContextMenu
                        MenuItem {
                            text: qsTr("添加左子节点")
                            enabled: mindMapView.model.canAddChild(nodeRect.nodeData.id, true)
                            onClicked: mindMapView.model.addNode(nodeRect.nodeData.id, qsTr("左子节点"), true)
                        }
                        MenuItem {
                            text: qsTr("添加右子节点")
                            enabled: mindMapView.model.canAddChild(nodeRect.nodeData.id, false)
                            onClicked: mindMapView.model.addNode(nodeRect.nodeData.id, qsTr("右子节点"), false)
                        }
                        MenuSeparator {}
                        MenuItem {
                            text: qsTr("编辑文本")
                            onTriggered: {
                                // 配置并打开对话框
                                nodeEditDialog.nodeId = nodeRect.nodeData.id
                                nodeEditDialog.currentText = nodeRect.nodeData.text
                                nodeEditDialog.open()
                            }
                        }
                        
                        MenuItem {
                            text: qsTr("编辑描述")
                            onTriggered: {
                                descriptionEditDialog.nodeId = nodeRect.nodeData.id
                                const description = nodeRect.nodeData.description || ""
                                descriptionEditDialog.currentDescription = description
                                descriptionEditDialog.open()
                            }
                        }

                        MenuItem {
                                text: qsTr("删除节点")
                                enabled: nodeRect.nodeData.id !== mindMapView.model.rootId // 根节点不可删除
                                onClicked: mindMapView.model.removeNode(nodeRect.nodeData.id)
                            }                    
                        }
                    TapHandler { acceptedButtons: Qt.RightButton; onTapped: nodeContextMenu.open() }
                }
            }
        }
    }

    property var model: outlineViewModelLoader.item
    Loader { id: outlineViewModelLoader; sourceComponent: outlineViewModelComponent }
    Component {
        id: outlineViewModelComponent
        OutlineModel {}
    }

    function getNodeItem(nodeId) {
        // 添加对参数的检查
        if (!nodeId) {
            return null;
        }
        
        if (nodeRepeater) {
            for (var i = 0; i < nodeRepeater.count; i++) {
                var item = nodeRepeater.itemAt(i);
                // 添加对item和item.nodeData的检查
                if (item && item.nodeData && item.nodeData.id === nodeId) {
                    return item;
                }
            }
        }
        return null;
    }
}
