import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import storyScience 1.0

Rectangle {
    id: overlay
    visible: false
    z: 9999
    anchors.fill: parent
    color: "transparent"

    // 使用绑定表达式，使其响应currentStoryIndex变化
    property string summaryContent: DataManager.getPrevSummary(DataManager.currentStoryIndex)
    property string chapterTitle: DataManager.getTitleOfPrevChapter(DataManager.currentStoryIndex)
    
    signal aiSummary(string title)

    // 监听currentStoryIndex变化并更新内容
    Connections {
        target: DataManager
        function onCurrentStoryIndexChanged() {
            overlay.summaryContent = DataManager.getPrevSummary(DataManager.currentStoryIndex)
            overlay.chapterTitle = DataManager.getTitleOfPrevChapter(DataManager.currentStoryIndex)
        }
    }

    Shortcut {
        sequences: ["Ctrl+Shift+M"]
        onActivated: overlay.visible = !overlay.visible
    }

    function appendSummaryContent(chunk) {
        summaryContent += chunk;

        // 延迟执行以确保内容已更新
        Qt.callLater(function() {
            // 获取ScrollBar并滚动到底部
            var scrollBar = summaryScrollView.ScrollBar.vertical;
            if (scrollBar) {
                scrollBar.position = 1.0 - scrollBar.size;
            }
        });
    }

    // 半透明遮罩（背景层不改）
    Rectangle {
        anchors.fill: parent
        color: Style.overlayBg
        opacity: 0.85
    }

    // 浮动窗口（降低透明度）
    Rectangle {
        id: summaryWindow
        width: Math.min(parent.width * 0.4, 600)
        height: Math.min(parent.height * 0.5, 400)
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        radius: Style.radiusLarge
        color: Style.panelBg
        opacity: 0.9    // 关键：降低窗口整体透明度
        border.color: Style.panelBorder
        border.width: 1

        layer.enabled: true
        layer.effect: DropShadow {
            color: Style.shadow
            horizontalOffset: 0
            verticalOffset: 6
            radius: 20
        }

        // 鼠标拖动
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.SizeAllCursor
            drag.target: summaryWindow
        }

        // 内容布局
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: Style.paddingLarge
            spacing: Style.spacingMedium

            // 标题栏
            RowLayout {
                Layout.fillWidth: true
                spacing: 10

                Label {
                    text: qsTr("【%1】总结").arg(overlay.chapterTitle)
                    font: Style.titleFont
                    color: Style.text
                    Layout.alignment: Qt.AlignLeft
                    Layout.fillWidth: true
                }
                Button {
                    id: closeButton
                    implicitWidth: 36
                    implicitHeight: 36
                    onClicked: overlay.visible = false

                    background: Rectangle {
                        radius: Style.buttonRadius
                        color: closeButton.hovered ? Style.buttonLightBgHover : Style.buttonLightBg
                        border.color: Style.buttonLightBorder
                        border.width: 1
                    }

                    contentItem: Item {
                        anchors.fill: parent
                        Image {
                            source: Style.isDark ? "qrc:/icons/closeLight.png" : "qrc:/icons/closeBlack.png"
                            fillMode: Image.PreserveAspectFit
                            anchors.centerIn: parent
                            width: parent.width * 0.5
                            height: parent.height * 0.5
                        }
                    }
                }
            }

            ScrollView {
                id: summaryScrollView
                implicitWidth: summaryWindow.width - 2 * Style.paddingLarge
                Layout.fillHeight: true
                clip: true
                ScrollBar.vertical.policy: ScrollBar.AsNeeded
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff  // 禁用水平滚动条

                TextArea {
                    id: summaryText
                    text: overlay.summaryContent
                    wrapMode: Text.Wrap
                    width: summaryWindow.width - 2 * Style.paddingLarge  // 固定宽度以匹配ScrollView
                    color: Style.text
                    font: Style.bodyFont
                }
            }

            Button {
                id: redoButton
                text: qsTr("重新总结")
                Layout.alignment: Qt.AlignHCenter
                background: Rectangle {
                    radius: Style.buttonRadius
                    color: redoButton.hovered ? Style.buttonPrimaryBgHover : Style.buttonPrimaryBg
                }
                contentItem: Text {
                    text: redoButton.text
                    color: Style.buttonPrimaryText
                    font: Style.buttonFont
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    overlay.aiSummary(overlay.chapterTitle)
                    overlay.summaryContent = ""
                    // 清空当前章节的上一章总结
                    DataManager.setPreviousSummary(DataManager.currentStoryIndex, "")
                    DataManager.aiContinuationManager.requestAiSummarize(DataManager.prevChapterContent)
                }
            }
        }
    }

    // 状态切换动画
    states: [
        State {
            name: "visible"
            when: overlay.visible
            PropertyChanges { target: overlay; opacity: 1.0 }
        },
        State {
            name: "hidden"
            when: !overlay.visible
            PropertyChanges { target: overlay; opacity: 0.0 }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "opacity"; duration: Style.animationDuration; easing.type: Style.ease }
    }
}
