// MessageBox.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import storyScience 1.0

Popup {
    id: messageBox
    width: 400
    height: 200
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    
    // 属性定义
    property string title: qsTr("提示")
    property string content: qsTr("确定要执行此操作吗？")
    property string confirmText: qsTr("确定")
    property string cancelText: qsTr("取消")
    property string otherText: ""
    // 添加位置控制属性
    property int popupPosition: 0 // 0: 居中, 1: 右侧, 2: 左侧, 3: 上方, 4: 下方
    property int offsetX: 0
    property int offsetY: 0
    
    // 信号定义
    signal confirmed()
    signal cancelled()
    
    // 默认位置（使用动画）
    Behavior on x {
        NumberAnimation {
            duration: 200
            easing.type: Easing.InQuad
        }
    }
    
    Behavior on y {
        NumberAnimation {
            duration: 200
            easing.type: Easing.InQuad
        }
    }
    
    // 计算位置的函数
    function calculateAndSetPosition() {
        if (!parent) return;
        
        var newX, newY;
        
        switch(popupPosition) {
            case 1: // 右侧
                newX = parent.width + offsetX
                newY = (parent.height - height) / 2 + offsetY
                break;
            case 2: // 左侧
                newX = -width + offsetX
                newY = (parent.height - height) / 2 + offsetY
                break;
            case 3: // 上方
                newX = (parent.width - width) / 2 + offsetX
                newY = -height + offsetY
                break;
            case 4: // 下方
                newX = (parent.width - width) / 2 + offsetX
                newY = parent.height + offsetY
                break;
            default: // 居中
                newX = (parent.width - width) / 2
                newY = (parent.height - height) / 2
        }
        
        // 边界检查
        if (newX + width > parent.width) {
            newX = parent.width - width - 10
        }
        if (newX < 0) {
            newX = 10
        }
        if (newY + height > parent.height) {
            newY = parent.height - height - 10
        }
        if (newY < 0) {
            newY = 10
        }
        
        // 设置位置
        x = newX
        y = newY
    }
    
    // 当弹出框即将打开时计算位置
    onAboutToShow: {
        // 延迟一帧确保尺寸已更新
        Qt.callLater(calculateAndSetPosition)
    }
    
    // 当父组件或位置参数变化时重新计算
    onParentChanged: if (opened) calculateAndSetPosition()
    onPopupPositionChanged: if (opened) calculateAndSetPosition()
    onOffsetXChanged: if (opened) calculateAndSetPosition()
    onOffsetYChanged: if (opened) calculateAndSetPosition()
    
    background: Rectangle {
        color: Style.popupBackground
        border.color: Style.popupBorder
        border.width: 1
        radius: Style.popupRadius
        
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 2
            radius: 8
            samples: 16
            color: Style.popupShadow
        }
    }
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15
        
        // 标题
        Text {
            text: messageBox.title
            font.pixelSize: Style.popupTitleFontSize
            font.bold: Style.popupTitleBold
            color: Style.popupTitleText
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 30
        }
        
        // 内容
        Text {
            text: messageBox.content
            font.pixelSize: 14
            color: Style.popupSearchText
            Layout.fillWidth: true
            Layout.fillHeight: true
            horizontalAlignment: Text.AlignHLeft
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
        }
        
        // 按钮行
        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            spacing: 10
            
            Button {
                text: messageBox.cancelText
                Layout.fillWidth: true
                
                background: Rectangle {
                    color: Style.buttonGhostBg
                    border.color: Style.buttonGhostBorder
                    radius: Style.buttonRadius
                    
                    Behavior on color {
                        ColorAnimation { duration: Style.durationShort }
                    }
                }
                
                contentItem: Text {
                    text: messageBox.cancelText
                    color: Style.buttonGhostText
                    font: parent.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: parent.background.color = Style.buttonGhostBgHover
                    onExited: parent.background.color = Style.buttonGhostBg
                    onClicked: {
                        messageBox.cancelled()
                        messageBox.close()
                    }
                }
            }
            
            Button {
                text: messageBox.confirmText
                Layout.fillWidth: true
                
                background: Rectangle {
                    color: Style.buttonPrimaryBg
                    border.color: Style.buttonPrimaryBorder
                    radius: Style.buttonRadius
                    
                    Behavior on color {
                        ColorAnimation { duration: Style.durationShort }
                    }
                }
                
                contentItem: Text {
                    text: messageBox.confirmText
                    color: Style.buttonPrimaryText
                    font: parent.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: parent.background.color = Style.buttonPrimaryBgHover
                    onExited: parent.background.color = Style.buttonPrimaryBg
                    onClicked: {
                        messageBox.confirmed()
                        messageBox.close()
                    }
                }
            }
        }
    }
}
