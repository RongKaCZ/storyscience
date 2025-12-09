// TutorialOverlay.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    visible: tutorialManager.tutorialActive
    anchors.fill: parent
    z: 9999

    // 获取顶层 contentItem（适配 ApplicationWindow）
    property Item rootItem: ApplicationWindow ? ApplicationWindow.contentItem : parent

    property rect highlightRect: Qt.rect(0, 0, 0, 0)
    property string currentStepText: ""
    property string currentStepObjectName: ""

    signal switchPage()

    function updateHighlight() {
        if (!currentStepObjectName) {
            highlightRect = Qt.rect(0, 0, 0, 0);
            return;
        }

        tryUpdateHighlight(10, 0); // 最多尝试15次，每次间隔50ms
    }

    function tryUpdateHighlight(maxAttempts, attempt) {
        var target = Utils.findItemByObjectName(rootItem, currentStepObjectName);
        if (target && target.visible && target.width > 0 && target.height > 0) {
            var pos = target.mapToItem(root, 0, 0);
            highlightRect = Qt.rect(pos.x, pos.y, target.width, target.height);
        } else if (attempt < maxAttempts) {
            Qt.createQmlObject('import QtQuick 2.0; Timer { interval: 50; repeat: false; onTriggered: root.tryUpdateHighlight(' + maxAttempts + ', ' + (attempt + 1) + ') }', root);
        } else {
            console.warn("Highlight failed after retries:", currentStepObjectName);
            highlightRect = Qt.rect(0, 0, 0, 0);
        }
    }


    Connections {
        target: tutorialManager
        function onCurrentStepChanged() {
            var step = tutorialManager.getCurrentStepData();
            root.currentStepText = step.text || "";
            root.currentStepObjectName = step.objectName || "";
            // 增强延迟机制确保组件加载完成
            Qt.callLater(function() {
                Qt.callLater(function() {
                    root.updateHighlight();
                });
            });
        }

        function onTutorialActiveChanged(){
            if (tutorialManager.tutorialActive) {
                // 修复：确保激活教程时重置到第一页
                tutorialManager.setCurrentPage(0);
                var step = tutorialManager.getCurrentStepData();
                root.currentStepText = step.text || "";
                root.currentStepObjectName = step.objectName || "";
                // 添加多层延迟确保组件完全加载后再更新高亮
                Qt.callLater(function() {
                    Qt.callLater(function() {
                        Qt.callLater(function() {
                            root.updateHighlight();
                        });
                    });
                });
            }
        }

        function onTutorialFinished() {
            //console.log("开始切换下一个页面")
            switchPage();//切换下一个页面的新手教程
        }

        function onCurrentPageChanged(){
            var step = tutorialManager.getCurrentStepData();
            root.currentStepText = step.text || "";
            root.currentStepObjectName = step.objectName || "";
            // 添加多层延迟确保页面切换完成后再更新高亮
            Qt.callLater(function() {
                Qt.callLater(function() {
                    Qt.callLater(function() {
                        root.updateHighlight();
                    });
                });
            });
        }
    }

    Component.onCompleted: {
        if (tutorialManager.tutorialActive) {
            // 添加多层延迟确保所有组件完全加载后再更新高亮
            Qt.callLater(function() {
                Qt.callLater(function() {
                    Qt.callLater(function() {
                        Qt.callLater(function() {
                            var step = tutorialManager.getCurrentStepData();
                            root.currentStepText = step.text || "";
                            root.currentStepObjectName = step.objectName || "";
                            root.updateHighlight();
                        });
                    });
                });
            });
        }
    }

    // 监听窗口大小变化并重新计算高亮位置
    onWidthChanged: {
        if (currentStepObjectName) {
            // 添加延迟确保重新布局完成
            Qt.callLater(function() {
                updateHighlight();
            });
        }
    }

    onHeightChanged: {
        if (currentStepObjectName) {
            // 添加延迟确保重新布局完成
            Qt.callLater(function() {
                updateHighlight();
            });
        }
    }

    // 遮罩
    Rectangle {
        anchors.fill: parent
        color: "#000"
        opacity: 0.55
    }

    // 高亮框
    Rectangle {
        x: root.highlightRect.x
        y: root.highlightRect.y
        width: root.highlightRect.width
        height: root.highlightRect.height
        radius: 8
        color: "transparent"
        border.color: "#FFD700"
        border.width: 3

        Behavior on x { NumberAnimation { duration: 200; easing.type: Easing.OutQuad } }
        Behavior on y { NumberAnimation { duration: 200; easing.type: Easing.OutQuad } }
        Behavior on width { NumberAnimation { duration: 200; easing.type: Easing.OutQuad } }
        Behavior on height { NumberAnimation { duration: 200; easing.type: Easing.OutQuad } }
    }

    // 提示框
    Pane {
        id: tipBox
        width: 360
        padding: 12
        visible: root.currentStepText.length > 0  // 修改这里，只要有文本就显示
        y: {
            var targetY = root.highlightRect.y + root.highlightRect.height + 10;
            var maxY = root.height - height - 10;
            return Math.min(targetY, maxY);
        }

        // ====== x: 中心对齐，但若靠近底部则根据位置左右偏移 ======
        x: {
            // 如果高亮区域有效，则基于高亮区域定位
            if (root.highlightRect.width > 0 && root.highlightRect.height > 0) {
                var idealX = root.highlightRect.x + (root.highlightRect.width - width) / 2;

                // 判断是否需要调整（即是否太靠下）
                var isTooLow = (root.highlightRect.y + root.highlightRect.height + 10 + height > root.height);

                if (!isTooLow) {
                    // 正常情况：居中对齐
                    return Math.max(10, Math.min(idealX, root.width - width - 10));
                } else {
                    // 太靠下了，需调整位置避免遮挡
                    var centerX = root.highlightRect.x + root.highlightRect.width / 2;
                    var midScreen = root.width / 2;

                    // 如果高亮在左侧（centerX < midScreen），则将提示框右移
                    if (centerX < midScreen) {
                        return Math.max(10, root.width - width - 10);
                    } else {
                        // 如果高亮在右侧，则左移
                        return 10;
                    }
                }
            } else {
                // 如果没有有效的高亮区域，则居中显示
                return (root.width - width) / 2;
            }
        }
        background: Rectangle {
            color: Qt.rgba(1, 1, 1, 0.96)
            radius: 10
            border.color: "#ccc"
        }

        ColumnLayout {
            spacing: 8
            Text {
                text: root.currentStepText
                wrapMode: Text.WordWrap
                color: "#222"
                font.pixelSize: 15
                Layout.fillWidth: true
                Layout.maximumWidth: tipBox.width - 24    // 限制最大宽度（考虑 padding）
            }

            RowLayout {
                spacing: 10
                Button {
                    text: qsTr("上一步")
                    enabled: tutorialManager.currentStep > 0
                    onClicked: tutorialManager.previousStep()
                }
                Button {
                    text: tutorialManager.currentStep < tutorialManager.totalSteps() - 1 ? qsTr("下一步") : qsTr("完成")
                    enabled: tutorialManager.currentStep <= tutorialManager.totalSteps() - 1
                    onClicked: {
                        tutorialManager.nextStep()
                    }
                }
                Button {
                    text: qsTr("跳过")
                    onClicked: tutorialManager.setTutorialActive(false)
                }
            }
        }
    }

}