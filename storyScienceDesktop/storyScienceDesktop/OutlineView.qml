// OutlineView.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import storyScience 1.0
import Qt5Compat.GraphicalEffects
Item {
    id: outlineView
    property int currentPageIndex: 0

    function saveOutLine() {
        if (mindMapView && mindMapView.model) {
            // 添加检查确保DataManager可用
            if (typeof DataManager !== 'undefined') {
                var json = mindMapView.model.saveToJson();
                var content = JSON.stringify(json);
                DataManager.updateCurrentBookMindMapOutline(content);
            } else {
                console.warn("DataManager不可用，无法保存大纲内容")
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        objectName:"outlineViewContainer"

        // --- 重新设计的顶部导航/工具栏 (水平居中) ---
        Rectangle {
            id: outlineToolbar
            objectName: "outlineButtons"
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            color: Style.panelBg
            RowLayout {
                anchors.centerIn: parent
                height: parent.height
                spacing: Style.spacing

                // --- 视图切换按钮组 (居中显示) ---
                Row {
                    spacing: Style.spacingSmall
                    objectName: "topBarToolBar"  // 恢复原来的名称
                    Repeater {
                        model: [
                            { text: qsTr("大纲视图"), index: 0 },
                            { text: qsTr("文本大纲"), index: 1 }
                        ]

                        Button {
                            id: viewButton
                            text: modelData.text
                            checked: currentPageIndex === modelData.index
                            onClicked: currentPageIndex = modelData.index

                            // === 尺寸与布局 ===
                            height: Style.buttonMediumHeight
                            leftPadding: Style.buttonPaddingHorizontal
                            rightPadding: Style.buttonPaddingHorizontal
                            font: Style.labelFont

                            // === 背景色 ===
                            background: Rectangle {
                                radius: Style.radiusLarge
                                border.width: 1
                                color: viewButton.checked ? Style.buttonPrimaryBg :
                                    viewButton.pressed ? Style.buttonSecondaryBgPressed :
                                    viewButton.hovered ? Style.buttonSecondaryBgHover :
                                    Style.buttonSecondaryBg

                                border.color: viewButton.checked ? Style.buttonPrimaryBg :
                                            Style.buttonSecondaryBorder

                                // 平滑过渡
                                Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
                                Behavior on border.color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
                            }

                            // === 文字颜色 ===
                            contentItem: Text {
                                text: parent.text
                                font: parent.font
                                color: Style.text
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight

                                Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
                            }

                            // === 阴影（仅在 checked 时显示，增强选中感）===
                            layer.enabled: viewButton.checked
                            layer.effect: DropShadow {
                                width: viewButton.width
                                height: viewButton.height
                                horizontalOffset: 0
                                verticalOffset: 2
                                radius: 6
                                samples: 12
                                color: Style.shadow
                                Behavior on opacity { NumberAnimation { duration: Style.transitionDuration } }
                            }

                            // 可选：添加轻微缩放动画（按下时）
                            transform: Scale {
                                origin.x: viewButton.width / 2
                                origin.y: viewButton.height / 2
                                xScale: viewButton.pressed ? 0.97 : 1.0
                                yScale: viewButton.pressed ? 0.97 : 1.0
                                Behavior on xScale { NumberAnimation { duration: Style.durationShort; easing.type: Easing.OutCubic } }
                                Behavior on yScale { NumberAnimation { duration: Style.durationShort; easing.type: Easing.OutCubic } }
                            }
                        }
                    }
                }

                // 分隔符
                Rectangle {
                    width: 1
                    height: parent.height * 0.6
                    color: Style.panelBorder
                    Layout.alignment: Qt.AlignVCenter
                    visible: currentPageIndex === 0 // 只在思维导图模式下显示
                }

                // --- 操作按钮组 (根据当前视图显示不同按钮) ---
                RowLayout {
                    objectName: "outlineButtons"  // 将objectName移到这里
                    spacing: Style.spacingSmall
                    visible: currentPageIndex === 0 || currentPageIndex === 1  // 在两种模式下都可见

                    // 思维导图模式下的按钮
                    Button{
                        text:qsTr("保存")
                        visible: currentPageIndex === 0  // 仅在思维导图模式下可见
                        onClicked: {
                            if (typeof outlineView !== 'undefined') {
                                outlineView.saveOutLine();
                            } else {
                                console.warn("outlineView未定义，无法保存大纲");
                            }
                        }
                    }

                    Button {
                        text: qsTr("添加子节点")
                        visible: currentPageIndex === 0  // 仅在思维导图模式下可见
                        enabled: mindMapView.selectedNodeId !== ""
                        onClicked: {
                            if (mindMapView.model && mindMapView.selectedNodeId !== "") {
                                mindMapView.model.addNode(mindMapView.selectedNodeId, "新子节点", false);
                            }
                        }
                    }
                    Button {
                        text: qsTr("删除节点")
                        visible: currentPageIndex === 0  // 仅在思维导图模式下可见
                        enabled: mindMapView.selectedNodeId !== "" && mindMapView.selectedNodeId !== mindMapView.model.rootId
                        onClicked: {
                            if (mindMapView.model && mindMapView.selectedNodeId !== "") {
                                mindMapView.model.removeNode(mindMapView.selectedNodeId);
                                mindMapView.selectedNodeId = "";
                            }
                        }
                    }
                    Button {
                        text: qsTr("自动布局")
                        visible: currentPageIndex === 0  // 仅在思维导图模式下可见
                        onClicked: mindMapView.model.autoLayout()
                    }

                    // 文本大纲模式下的按钮
                    Button{
                        text:qsTr("保存")
                        visible: currentPageIndex === 1  // 仅在文本大纲模式下可见
                        onClicked: {
                            if (typeof textOutlineView !== 'undefined') {
                                textOutlineView.saveOutLine();
                            } else {
                                console.warn("textOutlineView未定义，无法保存文本大纲");
                            }
                        }
                    }
                }

                // --- 状态显示 ---
                Label {
                    text: qsTr("缩放: ") + Math.round(mindMapView.scaleFactor * 100) + "%"
                    color: Style.text
                    Layout.alignment: Qt.AlignVCenter
                    visible: currentPageIndex === 0
                }
            }
        }

        // --- 页面内容区域 ---
        StackLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            currentIndex: currentPageIndex

            MindMapView {
                id: mindMapView
                model: DataManager.mindMapOutlineModel
            }

            TextOutlineView {
                id: textOutlineView
            }
        }
    }
}
