// AICreateElementPopup.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import storyScience 1.0
import ElementType 1.0

Popup {
    id: root
    width: 400
    height: 300
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    anchors.centerIn: Overlay.overlay
    padding: Style.spacing

    // 公共API
    property int elementType: ElementType.Character
    property string elementTypeName: getElementTypeName(elementType)
    
    // 信号：当用户提交描述时触发
    signal accepted(string description, int type)

    function getElementTypeName(type) {
        switch(type) {
        case ElementType.Character:
            return qsTr("人物")
        case ElementType.Location:
            return qsTr("地点")
        case ElementType.Item:
            return qsTr("道具")
        case ElementType.Abilities:
            return qsTr("能力")
        case ElementType.Organisation:
            return qsTr("组织")
        case ElementType.Event:
            return qsTr("事件")
        default:
            return qsTr("元素")
        }
    }

    // 弹窗打开时，重置状态并聚焦输入框
    onOpened: {
        descriptionField.text = ""
        descriptionField.forceActiveFocus()
    }

    // 弹窗布局
    Frame {
        anchors.fill: parent
        background: Rectangle { color: Style.panelBg }

        ColumnLayout {
            anchors.fill: parent
            spacing: Style.spacing

            // 标题
            Label {
                text: qsTr("AI创建" + root.elementTypeName)
                font: Style.titleFont
                color: Style.text
                Layout.alignment: Qt.AlignHCenter
            }

            // 提示文本
            Label {
                text: qsTr("请描述您想要创建的" + root.elementTypeName + "：")
                font: Style.bodyFont
                color: Style.textSecondary
                Layout.fillWidth: true
                wrapMode: Text.Wrap
            }

            // 描述输入区域
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: Style.textFieldBg
                border.color: descriptionField.activeFocus ? Style.textFieldBorderFocus : Style.textFieldBorder
                border.width: descriptionField.activeFocus ? Style.borderWidthFocus : Style.borderWidth
                radius: Style.textFieldRadius
                
                ScrollView {
                    id: scrollView
                    anchors.fill: parent
                    anchors.margins: 5
                    clip: true
                    ScrollBar.horizontal.policy: ScrollBar.AsNeeded
                    ScrollBar.vertical.policy: ScrollBar.AsNeeded

                    TextArea {
                        id: descriptionField
                        width: scrollView.width
                        height: scrollView.height
                        placeholderText: qsTr("例如：一个性格冷酷但内心善良的女剑客，有着神秘的过去和特殊的剑术能力...")
                        wrapMode: Text.Wrap
                        font: Style.bodyFont
                        color: Style.text
                        background: null // 移除TextArea自身的背景，使用外部Rectangle作为背景
                        padding: 5
                    }
                }
            }

            // 底部按钮区域
            RowLayout {
                Layout.fillWidth: true
                spacing: Style.spacingMedium

                Button {
                    text: qsTr("取消")
                    Layout.fillWidth: true
                    font: Style.buttonFont
                    onClicked: root.close()
                    
                    background: Rectangle {
                        color: parent.down ? Style.buttonGhostBgPressed : (parent.hovered ? Style.buttonGhostBgHover : Style.buttonGhostBg)
                        radius: Style.buttonRadius
                    }
                    contentItem: Label {
                        text: parent.text
                        font: parent.font
                        color: Style.buttonGhostText
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Button {
                    text: qsTr("创建")
                    Layout.fillWidth: true
                    font: Style.buttonFont
                    enabled: descriptionField.text.trim().length > 0
                    
                    onClicked: {
                        if (descriptionField.text.trim().length > 0) {
                            root.accepted(descriptionField.text.trim(), root.elementType)
                            root.close()
                        }
                    }
                    
                    background: Rectangle {
                        color: parent.enabled ? 
                               (parent.down ? Style.buttonPrimaryBgPressed : (parent.hovered ? Style.buttonPrimaryBgHover : Style.buttonPrimaryBg)) : 
                               Style.buttonDisabledBg
                        radius: Style.buttonRadius
                    }
                    contentItem: Label {
                        text: parent.text
                        font: parent.font
                        color: parent.enabled ? Style.buttonPrimaryText : Style.buttonDisabledText
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }
}
