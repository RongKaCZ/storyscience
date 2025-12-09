// NodeComponent.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import storyScience 1.0
import Qt5Compat.GraphicalEffects

Rectangle {
    id: root
    
    // 属性
    property var nodeData
    property var elementData
    property bool isConnecting: false
    // 添加缩放因子属性
    property real scaleFactor: 1.0
    
    // 信号
    signal nodeClicked(string nodeId)
    signal startConnection(string nodeId)
    signal deleteNode(string nodeId)
    signal nodeMoved(string nodeId, point newPos)
    
    // 节点外观 - 根据缩放因子调整大小
    width: 160 * scaleFactor
    height: 50 * scaleFactor
    
    // 监听主题变化以更新边框颜色
    Connections {
        target: Style
        function onIsDarkChanged() {
            updateBorderColor()
        }
    }
    
    // 更新边框颜色的函数
    function updateBorderColor() {
        border.color = isConnecting ? "#ffff00" : (Style.isDark ? "#666666" : "#999999")
    }
    
    Component.onCompleted: {
        if (nodeData && nodeData.position) {
            x = nodeData.position.x * scaleFactor
            y = nodeData.position.y * scaleFactor
            positionInitialized = true
        }
        updateBorderColor()
    }
    
    // 监听 nodeData 变化，但只在初始化时设置位置
    onNodeDataChanged: {
        if (nodeData && nodeData.position && !positionInitialized) {
            x = nodeData.position.x * scaleFactor
            y = nodeData.position.y * scaleFactor
            positionInitialized = true
        }
    }
    
    // 监听缩放因子变化
    onScaleFactorChanged: {
        if (nodeData && nodeData.position) {
            // 重新计算位置
            x = nodeData.position.x * scaleFactor
            y = nodeData.position.y * scaleFactor
        }
    }
    
    property bool positionInitialized: false
    
    color: elementData ? elementData.ecolor : "#666666"
    radius: 8 * scaleFactor
    border.color: isConnecting ? "#ffff00" : (Style.isDark ? "#666666" : "#999999")
    border.width: (isConnecting ? 3 : 1) * scaleFactor
    
    // 添加阴影效果
    layer.enabled: isConnecting
    layer.effect: DropShadow {
        horizontalOffset: 0
        verticalOffset: 0
        radius: isConnecting ? 8 : 0
        samples: isConnecting ? 16 : 0
        color: isConnecting ? "#ffff00" : "transparent"
        spread: 0.3
        Behavior on radius { NumberAnimation { duration: 300 } }
        Behavior on samples { NumberAnimation { duration: 300 } }
    }
    
    // 添加发光效果
    Rectangle {
        id: glowEffect
        anchors.centerIn: parent
        width: parent.width + (isConnecting ? 20 : 0)
        height: parent.height + (isConnecting ? 20 : 0)
        color: "transparent"
        radius: parent.radius + 2
        border.color: isConnecting ? "#ffff00" : "transparent"
        border.width: isConnecting ? 2 : 0
        scale: isConnecting ? 1.1 : 1.0
        opacity: isConnecting ? 0.6 : 0
        
        Behavior on width { NumberAnimation { duration: 300 } }
        Behavior on height { NumberAnimation { duration: 300 } }
        Behavior on scale { NumberAnimation { duration: 300 } }
        Behavior on opacity { NumberAnimation { duration: 300 } }
        Behavior on border.width { NumberAnimation { duration: 300 } }
    }
    
    // 节点标签 - 根据缩放因子调整字体大小
    Label {
        anchors.centerIn: parent
        text: root.elementData ? root.elementData.etitle : qsTr("未知元素")
        color: "white"
        font.bold: true
        font.pixelSize: 14 * scaleFactor
    }
    
    // 拖动处理器
    DragHandler {
        id: dragHandler
        
        onActiveChanged: {
            if (!active) {
                // 拖动结束，更新位置（需要转换回原始坐标）
                root.nodeMoved(root.nodeData.elementId, Qt.point(root.x / scaleFactor, root.y / scaleFactor))
            }
        }
    }
    
    // 点击处理器
    TapHandler {
        acceptedButtons: Qt.LeftButton
        
        onTapped: {
            if (!dragHandler.active) {
                // 只有在非拖动状态下才处理点击
                root.nodeClicked(root.nodeData.elementId)
            }
        }
    }
    
    // 右键处理器
    TapHandler {
        acceptedButtons: Qt.RightButton
        
        onTapped: {
            contextMenu.open()
        }
    }
    
    // 上下文菜单
    Menu {
        id: contextMenu
        
        MenuItem {
            text: qsTr("开始连接")
            enabled: !root.isConnecting
            onTriggered: root.startConnection(root.nodeData.elementId)
        }
        
        MenuSeparator {}
        
        MenuItem {
            text: qsTr("删除节点")
            onTriggered: root.deleteNode(root.nodeData.elementId)
        }
    }
    
    // 视觉反馈
    states: [
        State {
            name: "pressed"
            when: dragHandler.active
            PropertyChanges {
                target: root
                scale: 1.05
                z: 100
            }
        },
        State {
            name: "connecting"
            when: isConnecting
            PropertyChanges {
                target: root
                scale: 1.05
                z: 50
            }
        }
    ]
    
    transitions: [
        Transition {
            NumberAnimation {
                properties: "scale"
                duration: 300
                easing.type: Easing.OutQuad
            }
        },
        Transition {
            from: "*"
            to: "connecting"
            NumberAnimation {
                properties: "scale,z"
                duration: 300
                easing.type: Easing.OutBack
            }
        },
        Transition {
            from: "connecting"
            to: "*"
            NumberAnimation {
                properties: "scale,z"
                duration: 300
                easing.type: Easing.InBack
            }
        }
    ]

}
