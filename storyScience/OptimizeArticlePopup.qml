// OptimizeArticlePopup.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects
import storyScience 1.0

Popup {
    id: optimizeArticlePopup
    width: 400
    height: 300
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    
    signal optimizeRequested(string prompt)
    
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
        anchors.margins: 10
        spacing: 10
        
        // 标题
        Text {
            text: qsTr("优化文章")
            font.pixelSize: Style.popupTitleFontSize
            font.bold: Style.popupTitleBold
            color: Style.popupTitleText
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 30
        }
        
        // 预设优化选项 - 水平滚动
        ScrollView {
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            
            ScrollBar.horizontal.policy: ScrollBar.AsNeeded
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff
            
            ListView {
                id: presetOptionsList
                orientation: ListView.Horizontal
                spacing: 10
                clip: true
                property real contentXAnimTarget: contentX
                property alias contentXAnim: contentXAnimation
                // 添加平滑的鼠标滚轮支持
                MouseArea {
                    anchors.fill: parent
                    onWheel: function(wheel) {
                        // 使用更平滑的滚动，根据滚轮角度调整滚动距离
                        var delta = wheel.angleDelta.y / 2 + wheel.angleDelta.y / 6;
                        // 创建动画对象
                        presetOptionsList.contentXAnim.to = presetOptionsList.contentX - delta
                        presetOptionsList.contentXAnim.start()
                    }
                    z: -1  // 确保不影响列表项的点击事件
                }
                NumberAnimation {
                    id: contentXAnimation
                    target: presetOptionsList
                    property: "contentX"
                    duration: 150       // 动画时间，可根据需求调整
                    easing.type: Easing.OutQuad  // 缓动类型
                }
                model: ListModel {
                    ListElement { text: qsTr("借鉴名家写作手法") }
                    ListElement { text: qsTr("优化文章整体结构") }
                    ListElement { text: qsTr("增强语言表现力") }
                    ListElement { text: qsTr("丰富细节描写") }
                    ListElement { text: qsTr("调整段落逻辑顺序") }
                    ListElement { text: qsTr("提升故事连贯性") }
                    ListElement { text: qsTr("强化人物刻画") }
                    ListElement { text: qsTr("增加场景感和氛围") }
                }

                delegate: Rectangle {
                    width: Math.max(50, optText.implicitWidth + 10)
                    height: 30
                    color: Style.buttonGhostBg
                    border.color: Style.buttonGhostBorder
                    radius: 4
                    
                    Text {
                        id: optText
                        anchors.centerIn: parent
                        text: model.text
                        color: Style.buttonGhostText
                        font.pixelSize: 12
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = Style.buttonGhostBgHover
                        onExited: parent.color = Style.buttonGhostBg
                        onClicked: {
                            // 插入文本到输入框光标位置，而不是直接赋值
                            var cursorPos = optimizePromptInput.cursorPosition;
                            var currentText = optimizePromptInput.text;
                            var newText = currentText.substring(0, cursorPos) + model.text + currentText.substring(cursorPos);
                            optimizePromptInput.text = newText;
                            optimizePromptInput.cursorPosition = cursorPos + model.text.length;
                            optimizePromptInput.forceActiveFocus();
                        }
                    }
                }
            }
        }
        
        // 输入框 - 包装在ScrollView中以支持滚动，并设置固定宽度
        ScrollView {
            Layout.preferredWidth: 360  // 固定宽度
            Layout.fillHeight: true
            
            TextArea {
                id: optimizePromptInput
                placeholderText: qsTr("如何优化文章。使语言更生动?增加细节描述?调整文章结构?提升逻辑性?")
                font.pixelSize: 14
                color: Style.popupSearchText
                wrapMode: TextArea.Wrap
                selectByMouse: true
                padding: 8
                leftPadding: 12
                rightPadding: 12
                topPadding: 20
                bottomPadding: 10
                
                background: Rectangle {
                    color: Style.popupSearchBackground
                    border.color: Style.popupSearchBorder
                    border.width: 1
                    radius: 4
                }
            }

            ScrollBar.vertical.policy: ScrollBar.AlwaysOff
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        }
        
        // 按钮行
        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 25
            spacing: 10
            
            Button {
                text: qsTr("取消")
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
                    text: qsTr("取消")
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
                    onClicked: optimizeArticlePopup.close()
                }
            }
            
            Button {
                text: qsTr("优化")
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
                    text: qsTr("优化")
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
                        if (optimizePromptInput.text.trim() !== "") {
                            optimizeRequested(optimizePromptInput.text)
                            optimizeArticlePopup.close()
                        }
                    }
                }
            }
        }
    }
    
    // 打开弹窗时清空输入框
    onOpened: {
        optimizePromptInput.text = ""
        optimizePromptInput.forceActiveFocus()
    }
}
