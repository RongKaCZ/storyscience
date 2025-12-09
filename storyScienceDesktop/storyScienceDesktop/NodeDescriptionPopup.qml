// NodeDescriptionPopup.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import storyScience 1.0

Item {
    id: nodeDescriptionPopupContainer
    width: 250
    height: parent.height
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom

    // 属性
    property string nodeId: ""
    property var model: null
    property bool isAnimating: false
    property string lastNodeId: ""  // 用于跟踪节点ID变化

    // 信号
    signal closeRequested()

    // 可见性和动画控制
    visible: nodeId !== "" || isAnimating
    clip: true
    
    // 监听节点ID变化，触发动画重置
    onNodeIdChanged: {
        if (nodeId !== "" && lastNodeId !== "" && nodeId !== lastNodeId) {
            // 节点切换时重新触发动画
            resetAnimation();
        }
        lastNodeId = nodeId;
    }
    
    // 重置动画状态，强制重新触发动画
    function resetAnimation() {
        // 临时将属性设置为"隐藏"状态的值
        nodeDescriptionPopup.x = width;
        nodeDescriptionPopup.opacity = 0.0;
        nodeDescriptionPopup.scale = 0.95;
        
        // 使用定时器延迟一帧，让属性变化生效
        resetTimer.restart();
    }
    
    // 重置动画的定时器
    Timer {
        id: resetTimer
        interval: 10  // 非常短的延迟，只是为了让属性变化生效
        onTriggered: {
            // 恢复到"显示"状态的值，这将触发动画
            if (nodeId !== "") {
                nodeDescriptionPopup.x = 0;
                nodeDescriptionPopup.opacity = 1.0;
                nodeDescriptionPopup.scale = 1.0;
            }
        }
    }

    // 弹窗主体
    Rectangle {
        id: nodeDescriptionPopup
        width: parent.width
        height: parent.height
        radius: Style.radiusMedium
        color: Style.popupBackground
        border.color: Style.popupBorder
        border.width: 1

        // 初始位置在屏幕外
        x: nodeId !== "" ? 0 : parent.width
        opacity: nodeId !== "" ? 1.0 : 0.0
        scale: nodeId !== "" ? 1.0 : 0.95

        // 平滑的弹入/弹出动画
        Behavior on x {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutCubic
                onRunningChanged: {
                    if (running) {
                        nodeDescriptionPopupContainer.isAnimating = true;
                    } else {
                        // 动画结束后延迟一点再设置isAnimating为false，确保其他动画完成
                        animationEndTimer.restart();
                    }
                }
            }
        }
        
        Behavior on opacity {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutCubic
            }
        }
        
        Behavior on scale {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutCubic
            }
        }
        
        // 动画结束计时器
        Timer {
            id: animationEndTimer
            interval: 50
            onTriggered: {
                if (nodeId === "") {
                    nodeDescriptionPopupContainer.isAnimating = false;
                }
            }
        }

        // // 阴影效果
        // layer.enabled: true
        // layer.effect: MultiEffect {
        //     shadowEnabled: true
        //     shadowBlur: 1.0
        //     shadowHorizontalOffset: -3
        //     shadowVerticalOffset: 0
        //     shadowColor: "#30000000"
        // }

        // 内容布局
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            // 标题栏
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                color: Style.popupTitleBackground || Style.primary
                radius: 4

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10

                    Label {
                        Layout.fillWidth: true
                        text: qsTr("节点描述")
                        font: Style.buttonFont
                        color: "white"
                    }

                    Button {
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 30
                        text: "✕"
                        flat: true
                        contentItem: Text {
                            text: parent.text
                            font.pixelSize: 14
                            color: "white"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        background: Rectangle {
                            color: parent.hovered ? Qt.darker(Style.primary, 1.2) : "transparent"
                            radius: 4
                        }
                        onClicked: {
                            // 确保信号被正确发送
                            //console.log("Close button clicked");
                            descriptionTextArea.readOnly = true;
                            nodeDescriptionPopupContainer.closeRequested()
                        }
                    }
                }
            }

            // 节点标题
            Label {
                Layout.fillWidth: true
                Layout.preferredHeight: 20
                text: {
                    if (nodeId && model) {
                        const node = model.nodes.find(n => n.id === nodeId)
                        return node ? node.text : ""
                    }
                    return ""
                }
                font.bold: true
                font.pixelSize: 16
                wrapMode: Text.WordWrap
                color: Style.popupTitleText || "black"
            }

            // 分隔线
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 1
                color: Style.popupBorder || "#cccccc"
            }

            // 描述内容
            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                TextArea {
                    id: descriptionTextArea
                    readOnly: true
                    wrapMode: TextEdit.Wrap
                    text: {
                        if (nodeId && model) {
                            const node = model.nodes.find(n => n.id === nodeId)
                            return node && node.description ? node.description : qsTr("暂无描述")
                        }
                        return ""
                    }
                    background: null
                    color: Style.text
                    font: Style.textFont

                    onTextChanged:{
                        // 当文本改变时，更新对应节点的description
                        if (nodeId && model && !descriptionTextArea.readOnly) {
                            const node = model.nodes.find(n => n.id === nodeId);
                            if (node) {
                                // 更新节点的description属性
                                node.description = text;
                                // 如果模型有更新方法，调用它来确保变更被正确处理
                                if (model.updateNodeDescription) {
                                    model.updateNodeDescription(nodeId, text);
                                }
                            }
                        }
                    }
                }
            }

            // 编辑按钮
            Button {
                Layout.fillWidth: true
                Layout.preferredHeight: 35
                text: qsTr("编辑描述")
                onClicked: {
                    if (nodeId) {
                    //console.log("Edit button clicked");
                       descriptionTextArea.readOnly = false;
                       descriptionTextArea.selectAll();
                       descriptionTextArea.forceActiveFocus();
                    }
                }
            }
        }
    }

    // 状态变化时的动画
    states: [
        State {
            name: "visible"
            when: nodeId !== ""
            PropertyChanges {
                target: nodeDescriptionPopup
                x: 0
                opacity: 1.0
                scale: 1.0
            }
        },
        State {
            name: "hidden"
            when: nodeId === ""
            PropertyChanges {
                target: nodeDescriptionPopup
                x: nodeDescriptionPopupContainer.width
                opacity: 0.0
                scale: 0.95
            }
        }
    ]

    transitions: [
        Transition {
            from: "*"; to: "visible"
            ParallelAnimation {
                NumberAnimation {
                    property: "x"
                    duration: 300
                    easing.type: Easing.OutCubic
                }
                NumberAnimation {
                    property: "opacity"
                    duration: 300
                    easing.type: Easing.OutCubic
                }
                NumberAnimation {
                    property: "scale"
                    duration: 300
                    easing.type: Easing.OutCubic
                }
            }
        },
        Transition {
            from: "*"; to: "hidden"
            ParallelAnimation {
                NumberAnimation {
                    property: "x"
                    duration: 300
                    easing.type: Easing.InCubic
                }
                NumberAnimation {
                    property: "opacity"
                    duration: 300
                    easing.type: Easing.InCubic
                }
                NumberAnimation {
                    property: "scale"
                    duration: 300
                    easing.type: Easing.InCubic
                }
            }
        }
    ]
}
