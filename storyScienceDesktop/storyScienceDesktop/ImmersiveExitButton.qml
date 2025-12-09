import QtQuick
import Qt5Compat.GraphicalEffects
import storyScience 1.0

Rectangle {
    id: immersiveExitButton
    
    // 属性定义
    property bool isImmersiveMode: false
    signal exitImmersiveMode()
    
    // 设置默认尺寸和外观
    width: 80
    height: 40
    radius: Style.radiusMedium
    color: Style.primary
    border.color: Style.primaryDark
    border.width: Style.borderWidth
    opacity: isImmersiveMode ? 1.0 : 0.0
    
    // 悬浮视觉效果
    layer.enabled: true
    layer.effect: DropShadow {
        transparentBorder: true
        radius: 8
        samples: 16
        color: Style.shadow
        x: 0
        y: 4
    }
    
    // 鼠标区域
    MouseArea {
        id: immersiveExitMouseArea
        anchors.fill: parent
        hoverEnabled: true
        
        onEntered: {
            immersiveExitButton.color = Style.primaryDark
        }
        
        onExited: {
            immersiveExitButton.color = Style.primary
        }
        
        onPressed: {
            immersiveExitButton.color = Qt.darker(Style.primaryDark, 1.2)
        }
        
        onReleased: {
            immersiveExitButton.color = Style.primaryDark
        }
        
        onClicked: {
            exitImmersiveMode()
        }
    }
    
    Text {
        anchors.centerIn: parent
        text: qsTr("退出")
        color: Style.textOnPrimary
        font: Style.buttonFont
    }
    
    // 动画效果
    Behavior on color {
        ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease }
    }
    
    Behavior on opacity {
        NumberAnimation { duration: Style.animationDuration; easing.type: Style.ease }
    }
    
    Behavior on scale {
        NumberAnimation { duration: Style.animationDuration; easing.type: Style.ease }
    }
}