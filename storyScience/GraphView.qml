// GraphView.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.Shapes
import QtQml.Models
import storyScience 1.0

pragma ComponentBehavior: Bound

Frame {
    id: root
    Layout.fillWidth: true
    Layout.fillHeight: true

    background: Rectangle {
        color: Style.windowBg
        Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
    }

    property bool isConnecting: false
    property string connectingFromNodeId: ""

    // 新增信号：用于通知连接线更新位置
    signal nodePositionChanged(string nodeId, point newPosition)

    // 状态反馈属性
    property bool isSaving: false
    property bool isLoading: false
    property string statusMessage: ""

    // 添加缩放相关属性
    property real scaleFactor: 1.0
    property real minScale: 0.1
    property real maxScale: 2.0
    // 添加平移偏移属性
    property point panOffset: Qt.point(0, 0)

    function getElementData(uuid) {
        return DataManager.elementModel.getByUuid(uuid)
    }

    function getElementTitle(uuid) {
        if (!uuid) return qsTr("未知元素")
        var elementData = getElementData(uuid)
        return elementData ? elementData.etitle : qsTr("未知元素")
    }

    // 主画布区域
    Flickable {
        id: canvas
        objectName: "canvas"
        anchors.top: toolbar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        contentWidth: parent.width
        contentHeight: parent.height
        clip: true

        // 监听当前GraphModel的缩放因子变化
        Connections {
            target: DataManager.canvasManager.currentGraphModel
            function onScaleFactorChanged() {
                if (DataManager.canvasManager.currentGraphModel) {
                    root.scaleFactor = DataManager.canvasManager.currentGraphModel.scaleFactor
                }
            }
            function onContentWidthChanged() {
                // contentWidth会自动更新
            }
            function onContentHeightChanged() {
                // contentHeight会自动更新
            }
        }

        // 画布背景（可点击添加节点）
        Rectangle {
            id: canvasBackground
            width: canvas.contentWidth
            height: canvas.contentHeight
            color: Style.panelBg
            Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }

            // 添加缩放变换
            transform: Scale {
                id: canvasScale
                xScale: root.scaleFactor
                yScale: root.scaleFactor
                origin.x: canvas.contentX + canvas.width / 2
                origin.y: canvas.contentY + canvas.height / 2
            }

            // 画布点击处理
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton

                onClicked: (mouse) => {
                    if (mouse.button === Qt.RightButton) {
                        // 右键显示画布菜单
                        canvasMenu.x = mouse.x
                        canvasMenu.y = mouse.y
                        canvasMenu.open()
                    } else if (mouse.button === Qt.LeftButton && root.isConnecting) {
                        // 连接模式下点击空白区域取消连接
                        root.cancelConnection()
                    }
                }

                // 实现滚轮功能
                onWheel: (wheel) => {
                    // Ctrl+滚轮缩放
                    if (wheel.modifiers & Qt.ControlModifier) {
                        wheel.accepted = true
                        var factor = wheel.angleDelta.y > 0 ? 1.1 : 0.9
                        var newScale = root.scaleFactor * factor
                        newScale = Math.max(root.minScale, Math.min(root.maxScale, newScale))

                        // 设置新的缩放因子到当前GraphModel
                        if (DataManager.canvasManager.currentGraphModel) {
                            DataManager.canvasManager.currentGraphModel.setScaleFactor(newScale)
                        }
                    }
                    // Shift+滚轮水平滚动
                    else if (wheel.modifiers & Qt.ShiftModifier) {
                        wheel.accepted = true
                        // 根据滚轮方向调整水平滚动
                        var step = wheel.angleDelta.y * 0.5
                        canvas.contentX -= step
                    }
                    // 单滚轮垂直滚动（不带修饰键）
                    else {
                        wheel.accepted = true
                        // 根据滚轮方向调整垂直滚动
                        var verticalStep = wheel.angleDelta.y * 0.5
                        canvas.contentY -= verticalStep
                    }
                }
            }

            // 连接线层（在节点下面）
            Repeater {
                id: edgeRepeater
                model: DataManager.canvasManager.currentGraphModel ? DataManager.canvasManager.currentGraphModel.edges : []
                delegate: Edge {
                    required property int index
                    required property var modelData

                    edgeData: modelData
                    nodesModel: DataManager.canvasManager.currentGraphModel ? DataManager.canvasManager.currentGraphModel.nodes : []
                    // 传递缩放因子给Edge组件
                    scaleFactor: root.scaleFactor

                    onDeleteEdge: (fromId, toId) => {
                        if (DataManager.canvasManager.currentGraphModel) {
                            DataManager.canvasManager.currentGraphModel.removeEdgeByNodes(fromId, toId)
                        }
                    }
                    onUpdateLabel: (fromId, toId, newLabel) => {
                        if (DataManager.canvasManager.currentGraphModel) {
                            DataManager.canvasManager.currentGraphModel.updateEdgeLabelByNodes(fromId, toId, newLabel)
                        }
                    }

                    // 监听节点位置变化信号
                    Connections {
                        target: root
                        function onNodePositionChanged(nodeId, newPosition) {
                            // 当节点位置变化时，通知连接线更新
                            if (edgeData.fromNodeId === nodeId || edgeData.toNodeId === nodeId) {
                                updatePositions()
                            }
                        }
                    }
                }
            }

            // 节点层（在连接线上面）
            Repeater {
                id: nodeRepeater
                model: DataManager.canvasManager.currentGraphModel ? DataManager.canvasManager.currentGraphModel.nodes : []
                delegate: Node {
                    required property int index
                    required property var modelData

                    nodeData: modelData
                    elementData: root.getElementData(modelData.elementId)
                    isConnecting: root.isConnecting
                    // 传递缩放因子给Node组件
                    scaleFactor: root.scaleFactor

                    onNodeMoved: (nodeId, newPos) => {
                        if (DataManager.canvasManager.currentGraphModel) {
                            DataManager.canvasManager.currentGraphModel.moveNodeById(nodeId, newPos)
                        }
                        // 发出信号通知连接线更新
                        root.nodePositionChanged(nodeId, newPos)
                    }

                    onStartConnection: (nodeId) => {
                        root.startConnection(nodeId)
                    }

                    onNodeClicked: (nodeId) => {
                        if (root.isConnecting && root.connectingFromNodeId !== nodeId) {
                            root.createConnection(root.connectingFromNodeId, nodeId)
                        }
                    }

                    onDeleteNode: (nodeId) => {
                        if (DataManager.canvasManager.currentGraphModel) {
                            DataManager.canvasManager.currentGraphModel.removeNodeById(nodeId)
                        }
                    }
                }
            }
        }
    }

    // 顶部工具栏 (重新设计为水平居中)
    Rectangle {
        id: toolbar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 50
        color: Style.panelBg
        Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }

        RowLayout {
            anchors.centerIn: parent
            height: parent.height
            spacing: Style.spacing

            // --- 左侧操作按钮组 ---
            Row {
                spacing: Style.spacingSmall

                Button {
                    id: addCanvasButton
                    text: qsTr("添加图谱")
                    objectName: "addCanvasButton"
                    implicitHeight: Style.buttonMediumHeight
                    implicitWidth: 100
                    hoverEnabled: true
                    z: 2
                    background: Rectangle {
                        color: addCanvasButton.hovered ? Style.buttonPrimaryBgHover : Style.buttonPrimaryBg
                        border.color: addCanvasButton.hovered ? "blue" : "transparent"
                        border.width: 1
                        radius: Style.buttonRadius
                        Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
                    }
                    contentItem: Text {
                        text: addCanvasButton.text
                        font: Style.buttonFont
                        color: Style.buttonPrimaryText
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideNone
                    }
                    onClicked: {
                        var canvasCount = DataManager.canvasManager.canvases.length;
                        DataManager.canvasManager.createCanvas(qsTr("新图谱") + (canvasCount + 1));
                    }
                }

                Button {
                    id: addNodeButton
                    text: qsTr("添加节点")
                    objectName: "addNodeButton"
                    enabled: !root.isConnecting && DataManager.canvasManager.currentGraphModel
                    implicitHeight: Style.buttonMediumHeight
                    implicitWidth: 100
                    hoverEnabled: true
                    z: 2
                    background: Rectangle {
                        color: addNodeButton.enabled ? (addNodeButton.hovered ? Style.buttonPrimaryBgHover : Style.buttonPrimaryBg) : Style.buttonDisabledBg
                        border.color: addNodeButton.hovered ? "blue" : "transparent"
                        border.width: 1
                        radius: Style.buttonRadius
                        Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
                    }
                    contentItem: Text {
                        text: addNodeButton.text
                        font: Style.buttonFont
                        color: addNodeButton.enabled ? Style.buttonPrimaryText : Style.buttonDisabledText
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideNone
                    }
                    onClicked: elementPicker.open()
                }

                Button {
                    id: cancelConnectionButton
                    text: qsTr("取消连接")
                    visible: root.isConnecting
                    objectName: "cancelConnectionButton"
                    height: Style.buttonMediumHeight
                    width: 100
                    z: 2
                    hoverEnabled: true
                    background: Rectangle {
                        color: cancelConnectionButton.hovered ? Style.buttonPrimaryBgHover : Style.buttonPrimaryBg
                        border.color: cancelConnectionButton.hovered ? "blue" : "transparent"
                        border.width: 1
                        radius: Style.buttonRadius
                        Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
                    }
                    contentItem: Text {
                        text: cancelConnectionButton.text
                        font: Style.buttonFont
                        color: Style.buttonPrimaryText
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideNone
                    }
                    onClicked: root.cancelConnection()
                }
            }

            // --- 分隔符 ---
            Rectangle {
                width: 2
                height: parent.height * 0.6
                color: Style.panelBorder
                Layout.alignment: Qt.AlignVCenter
            }

            // --- 图谱切换控件 (居中显示) ---
            CanvasSwitcher {
                canvasManager: DataManager.canvasManager
                Layout.preferredWidth: 400
                Layout.preferredHeight: parent.height
            }

            // --- 弹簧，将右侧元素推到最右边 ---
            Item { Layout.fillWidth: true }
        }
    }

    // 状态栏
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 30
        color: "transparent"
        opacity: 0.9

        RowLayout {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 10
            spacing: 10

            // 状态指示器
            Label {
                text: {
                    if (root.isSaving) return qsTr("保存中...")
                    if (root.isLoading) return qsTr("加载中...")
                    if (root.statusMessage) return root.statusMessage

                    // 显示当前图谱的信息
                    if (DataManager.canvasManager.currentGraphModel) {
                        return qsTr("节点: %1 | 连接: %2 | 缩放: %3%").arg(DataManager.canvasManager.currentGraphModel.nodes.length)
                                                                  .arg(DataManager.canvasManager.currentGraphModel.edges.length)
                                                                  .arg(Math.round(root.scaleFactor * 100))
                    } else {
                        return qsTr("无图谱数据")
                    }
                }
                color: {
                    if (root.isSaving || root.isLoading) return "#ffff00"
                    if (root.statusMessage.includes(qsTr("成功"))) return "#4CAF50"
                    if (root.statusMessage.includes(qsTr("失败"))) return "#F44336"
                    return "#cccccc"
                }
                font.pixelSize: 12
            }

            Button {
                id: clearButton
                text: qsTr("清空")
                enabled: !root.isSaving && !root.isLoading && DataManager.canvasManager.currentGraphModel
                implicitHeight: Style.buttonHeight
                implicitWidth: Math.max(60, implicitContentWidth + 20) // 确保最小宽度
                background: Rectangle {
                    color: clearButton.enabled ? (clearButton.hovered ? Style.buttonPrimaryBgHover : Style.buttonPrimaryBg) : Style.buttonDisabledBg
                    border.color: "transparent"
                    border.width: 1
                    radius: Style.buttonRadius
                    Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
                }
                contentItem: Text {
                    text: clearButton.text
                    font: Style.buttonFont
                    color: clearButton.enabled ? Style.buttonPrimaryText : Style.buttonDisabledText
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    clearConfirmDialog.open()
                }
            }
        }
    }

    // 连接管理函数
    function startConnection(fromNodeId) {
        root.isConnecting = true
        root.connectingFromNodeId = fromNodeId
        // console.log("开始连接模式，起始节点:", fromNodeId)
    }

    function createConnection(fromNodeId, toNodeId) {
        if (DataManager.canvasManager.currentGraphModel) {
            DataManager.canvasManager.currentGraphModel.addEdgeByNodeIds(fromNodeId, toNodeId, qsTr("关联"))
        }
        root.cancelConnection()
        // console.log("创建连接:", fromNodeId, "->", toNodeId)
    }

    function cancelConnection() {
        root.isConnecting = false
        root.connectingFromNodeId = ""
        // console.log("取消连接模式")
    }

    // 清空确认对话框
    Dialog {
        id: clearConfirmDialog
        title: qsTr("确认清空")
        modal: true
        standardButtons: Dialog.Yes | Dialog.No
        width: 300  // 设置一个固定宽度，避免绑定循环

        Label {
            width: parent.width - 20  // 设置一个相对于父元素的宽度，留出边距
            text: qsTr("确定要清空当前图谱的所有节点和连接吗？\n此操作不可撤销。")
            wrapMode: Text.WordWrap
        }

        onAccepted: {
            if (DataManager.canvasManager.currentGraphModel) {
                DataManager.canvasManager.currentGraphModel.clear()
                root.statusMessage = qsTr("已清空图谱")
                statusTimer.start()
            }
        }
    }

    // 画布右键菜单
    Menu {
        id: canvasMenu
        MenuItem {
            text: qsTr("添加节点")
            onTriggered: elementPicker.open()
        }
        MenuItem {
            text: qsTr("清空画布")
            onTriggered: clearConfirmDialog.open()
        }
    }

    // 状态消息自动清除定时器
    Timer {
        id: statusTimer
        interval: 3000
        onTriggered: root.statusMessage = ""
    }

    // ElementPicker 组件
    ElementPicker {
        id: elementPicker
        onElementsSelected: (selectedElementIds) => {
            if (!DataManager.canvasManager.currentGraphModel) return;

            // 为每个选中的元素创建节点，使用更好的布局算法避免重叠
            var startX = canvas.contentX + canvas.width / 2 - 100
            var startY = canvas.contentY + canvas.height / 2 - 100
            var columns = Math.ceil(Math.sqrt(selectedElementIds.length))

            for (var i = 0; i < selectedElementIds.length; i++) {
                var elementId = selectedElementIds[i]

                // 计算网格布局位置，避免重叠
                var row = Math.floor(i / columns)
                var col = i % columns
                var x = startX + (col * 200)  // 水平间距200px
                var y = startY + (row * 120)  // 垂直间距120px

                DataManager.canvasManager.currentGraphModel.addNode(elementId, Qt.point(x, y))
            }
        }
    }
}
