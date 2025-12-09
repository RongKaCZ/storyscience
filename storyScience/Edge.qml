// EdgeComponent.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import QtQuick.Layouts
import storyScience 1.0

Item {
    id: root
    anchors.fill: parent  // 让Item填满整个画布
    
    // 属性
    property var edgeData
    property var nodesModel
    // 添加缩放因子属性
    property real scaleFactor: 1.0
    // 删除 nodeRepeater 属性，避免绑定循环
    
    // 信号
    signal deleteEdge(string fromId, string toId)
    signal updateLabel(string fromId, string toId, string newLabel)
    
    // 监听主题变化以更新颜色
    Connections {
        target: Style
        function onIsDarkChanged() {
            arrowCanvas.requestPaint()
        }
    }
    
    // 获取节点位置 - 从 nodesModel 数据中获取
    function getNodePosition(nodeId) {
        if (nodesModel) {
            for (var i = 0; i < nodesModel.length; i++) {
                var node = nodesModel[i]
                if (node.elementId === nodeId) {
                    // 返回节点中心位置（根据缩放因子调整）
                    var nodeWidth = 160 * scaleFactor
                    var nodeHeight = 50 * scaleFactor
                    return Qt.point(node.position.x * scaleFactor + nodeWidth / 2, node.position.y * scaleFactor + nodeHeight / 2)
                }
            }
        }
        //console.warn("Node not found:", nodeId)
        return Qt.point(0, 0)
    }
    
    // 计算矩形边缘与线段的交点
    function getRectEdgeIntersection(rectCenter, rectWidth, rectHeight, targetPoint) {
        var dx = targetPoint.x - rectCenter.x
        var dy = targetPoint.y - rectCenter.y
        
        // 避免除零错误
        if (dx === 0 && dy === 0) {
            return rectCenter
        }
        
        // 矩形半宽和半高
        var halfWidth = rectWidth / 2
        var halfHeight = rectHeight / 2
        
        // 计算交点
        var t = Math.min(
            halfWidth / Math.abs(dx),
            halfHeight / Math.abs(dy)
        )
        
        // 返回边缘点
        return Qt.point(
            rectCenter.x + t * dx,
            rectCenter.y + t * dy
        )
    }
    
    // 计算两个节点之间的连接线端点
    function calculateConnectionPoints() {
        if (!edgeData || !edgeData.fromNodeId || !edgeData.toNodeId) {
            return { from: Qt.point(0, 0), to: Qt.point(0, 0) }
        }
        
        var fromPos = getNodePosition(edgeData.fromNodeId)
        var toPos = getNodePosition(edgeData.toNodeId)
        
        if (fromPos.x === 0 && fromPos.y === 0) return { from: Qt.point(0, 0), to: Qt.point(0, 0) }
        if (toPos.x === 0 && toPos.y === 0) return { from: Qt.point(0, 0), to: Qt.point(0, 0) }
        
        // 节点尺寸（根据缩放因子调整）
        var nodeWidth = 160 * scaleFactor
        var nodeHeight = 50 * scaleFactor
        
        // 计算从起点节点边缘到终点节点边缘的连接点
        var fromEdge = getRectEdgeIntersection(fromPos, nodeWidth, nodeHeight, toPos)
        var toEdge = getRectEdgeIntersection(toPos, nodeWidth, nodeHeight, fromPos)
        
        return { from: fromEdge, to: toEdge }
    }
    
    // 计算箭头位置和连接线终点
    function calculateArrowAndLineEnd() {
        if (root.fromPos.x === 0 && root.fromPos.y === 0) return { lineEnd: Qt.point(0, 0), arrowTip: Qt.point(0, 0) }
        if (root.toPos.x === 0 && root.toPos.y === 0) return { lineEnd: Qt.point(0, 0), arrowTip: Qt.point(0, 0) }
        
        // 计算方向向量
        var dx = root.toPos.x - root.fromPos.x
        var dy = root.toPos.y - root.fromPos.y
        var distance = Math.sqrt(dx * dx + dy * dy)
        
        // 避免除零错误
        if (distance === 0) return { lineEnd: root.toPos, arrowTip: root.toPos }
        
        // 单位向量
        var unitX = dx / distance
        var unitY = dy / distance
        
        // 箭头大小（根据缩放因子调整）
        var arrowLength = 15 * root.scaleFactor
        
        // 连接线终点应该在箭头之前结束
        var lineEndX = root.toPos.x - unitX * arrowLength
        var lineEndY = root.toPos.y - unitY * arrowLength
        
        return { 
            lineEnd: Qt.point(lineEndX, lineEndY), 
            arrowTip: root.toPos 
        }
    }
    
    property point fromPos: Qt.point(0, 0)
    property point toPos: Qt.point(0, 0)
    property point midPos: Qt.point((fromPos.x + toPos.x) / 2, (fromPos.y + toPos.y) / 2)
    property point lineEndPos: Qt.point(0, 0)  // 连接线的实际终点
    property point arrowTipPos: Qt.point(0, 0)  // 箭头的尖端位置
    
    // 组件初始化时更新位置
    Component.onCompleted: updatePositions()
    
    // 监听 nodesModel 变化，自动更新位置
    onNodesModelChanged: updatePositions()
    
    // 监听缩放因子变化
    onScaleFactorChanged: updatePositions()
    
    // 更新位置的函数（可以被外部调用）
    function updatePositions() {
        var points = calculateConnectionPoints()
        fromPos = points.from
        toPos = points.to
        
        // 计算箭头和连接线终点位置
        var arrowPoints = calculateArrowAndLineEnd()
        lineEndPos = arrowPoints.lineEnd
        arrowTipPos = arrowPoints.arrowTip
    }
    
    // 连接线
    Shape {
        id: connectionShape
        anchors.fill: parent
        visible: root.fromPos.x !== 0 && root.fromPos.y !== 0 && root.toPos.x !== 0 && root.toPos.y !== 0
        
        ShapePath {
            strokeWidth: 2 * root.scaleFactor
            strokeColor: Style.isDark ? "#4CAF50" : "#2E7D32"
            fillColor: "transparent"
            
            startX: root.fromPos.x
            startY: root.fromPos.y
            
            PathLine {
                x: root.lineEndPos.x
                y: root.lineEndPos.y
            }
        }
    }
    
    // 箭头
    Canvas {
        id: arrowCanvas
        anchors.fill: parent
        visible: connectionShape.visible
        
        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)
            
            if (root.fromPos.x === 0 && root.fromPos.y === 0) return
            if (root.toPos.x === 0 && root.toPos.y === 0) return
            
            // 算出箭头位置和角度
            var dx = root.arrowTipPos.x - root.fromPos.x
            var dy = root.arrowTipPos.y - root.fromPos.y
            var angle = Math.atan2(dy, dx)
            
            // 箭头大小（根据缩放因子调整）
            var arrowLength = 15 * root.scaleFactor
            var arrowWidth = 8 * root.scaleFactor
            
            // 计算箭头的三个顶点位置
            // 箭头尖端位置
            var arrowTipX = root.arrowTipPos.x
            var arrowTipY = root.arrowTipPos.y
            
            // 箭头底部两个点的位置（需要从箭头尖端向后偏移）
            var arrowBaseX = arrowTipX - Math.cos(angle) * arrowLength
            var arrowBaseY = arrowTipY - Math.sin(angle) * arrowLength
            
            // 箭头两侧点的位置
            var arrowSide1X = arrowBaseX + Math.cos(angle + Math.PI/2) * arrowWidth
            var arrowSide1Y = arrowBaseY + Math.sin(angle + Math.PI/2) * arrowWidth
            var arrowSide2X = arrowBaseX + Math.cos(angle - Math.PI/2) * arrowWidth
            var arrowSide2Y = arrowBaseY + Math.sin(angle - Math.PI/2) * arrowWidth
            
            ctx.fillStyle = Style.isDark ? "#4CAF50" : "#2E7D32"
            ctx.strokeStyle = Style.isDark ? "#4CAF50" : "#2E7D32"
            ctx.lineWidth = 2 * scaleFactor
            
            // 绘制箭头
            ctx.beginPath()
            ctx.moveTo(arrowTipX, arrowTipY)  // 箭头尖端
            ctx.lineTo(arrowSide1X, arrowSide1Y)  // 一侧
            ctx.lineTo(arrowSide2X, arrowSide2Y)  // 另一侧
            ctx.closePath()
            ctx.fill()
        }
        
        Connections {
            target: root
            function onFromPosChanged() { arrowCanvas.requestPaint() }
            function onToPosChanged() { arrowCanvas.requestPaint() }
            function onLineEndPosChanged() { arrowCanvas.requestPaint() }
            function onArrowTipPosChanged() { arrowCanvas.requestPaint() }
        }
    }
    
    // 关系标签
    Rectangle {
        id: labelContainer
        x: root.midPos.x - width / 2
        y: root.midPos.y - height / 2
        width: labelText.contentWidth + 20 * root.scaleFactor
        height: labelText.contentHeight + 10 * root.scaleFactor
        color: Style.isDark ? "#404040" : "#E0E0E0"
        radius: 4 * root.scaleFactor
        border.color: Style.isDark ? "#666666" : "#999999"
        border.width: 1 * root.scaleFactor
        
        Label {
            id: labelText
            anchors.centerIn: parent
            text: root.edgeData.label || qsTr("关联")
            color: Style.isDark ? "white" : "black"
            font.pixelSize: 12 * root.scaleFactor
        }
        
        // 标签点击编辑
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            
            onClicked: (mouse) => {
                if (mouse.button === Qt.LeftButton) {
                    labelEditor.open()
                } else if (mouse.button === Qt.RightButton) {
                    edgeMenu.open()
                }
            }
        }
        
        // 标签编辑对话框
        Dialog {
            id: labelEditor
            title: qsTr("编辑关系标签")
            modal: true
            
            ColumnLayout {
                Label { text: qsTr("关系描述:") }
                TextField {
                    id: labelInput
                    text: root.edgeData.label || qsTr("关联")
                    Layout.preferredWidth: 200 * root.scaleFactor
                }
            }
            
            standardButtons: Dialog.Ok | Dialog.Cancel
            
            onAccepted: {
                root.updateLabel(root.edgeData.fromNodeId, edgeData.toNodeId, labelInput.text)
            }
        }
        
        // 边的右键菜单
        Menu {
            id: edgeMenu
            
            MenuItem {
                text: qsTr("编辑标签")
                onTriggered: labelEditor.open()
            }
            
            MenuSeparator {}
            
            MenuItem {
                text: qsTr("删除连接")
                onTriggered: root.deleteEdge(root.edgeData.fromNodeId, edgeData.toNodeId)
            }
        }
    }
}
