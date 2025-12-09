// OptimizationPreviewDialog.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import storyScience 1.0

Popup {
    id: previewDialog
    modal: true
    focus: true
    closePolicy: Popup.NoAutoClose
    width: Math.min(parent ? parent.width * 0.9 : 800, 800)
    height: Math.min(parent ? parent.height * 0.8 : 600, 600)
    padding: 0

    property string originalText: ""
    property string optimizedText: ""
    property bool enabledBtn: false
    signal applyOptimization()
    signal cancel()

    function appendChunk(chunk) {
        optimizedText += chunk
        // 延迟滚动到底部，确保文本已经渲染完成
        Qt.callLater(scrollToBottom)
    }

    function scrollToBottom() {
        var maxScroll = Math.max(0, textOptimized.contentHeight - textOptimizedFlickable.height)
        textOptimizedFlickable.contentY = maxScroll
    }

    function clearTexts() {
        originalText = ""
        optimizedText = ""
    }

    background: Rectangle {
        id: backgroundRect
        color: Style.windowBg
        border.color: Style.border
        border.width: Style.borderWidth
        radius: Style.radiusLarge
        
        // 添加渐变背景效果
        gradient: Gradient {
            GradientStop { position: 0.0; color: Style.windowBg }
            GradientStop { position: 1.0; color: Style.isDark ? Qt.darker(Style.windowBg, 1.1) : Qt.lighter(Style.windowBg, 1.1) }
        }

        // 添加阴影效果
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 8
            radius: 24
            samples: 17
            color: Style.shadow
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // 标题栏
        Rectangle {
            id: titleBar
            Layout.preferredHeight: 60
            Layout.fillWidth: true
            
            // 使用渐变背景
            gradient: Gradient {
                GradientStop { position: 0.0; color: Style.isDark ? Qt.lighter(Style.menuBackground, 1.1) : Style.menuBackground }
                GradientStop { position: 1.0; color: Style.menuBackground }
            }
            
            border.color: Style.border
            border.width: Style.borderWidth
            radius: Style.radiusLarge
            
            // 添加底部阴影
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                horizontalOffset: 0
                verticalOffset: 2
                radius: 8
                samples: 17
                color: Style.shadow
            }

            Text {
                anchors.centerIn: parent
                text: qsTr("AI 优化预览")
                color: Style.text
                font.pixelSize: Style.popupTitleFontSize
                font.bold: Style.popupTitleBold
                font.family: Style.fontFamily
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        // 对比区域
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: Style.spacingMedium
            Layout.margins: Style.paddingSmall
            // 左侧：原文
            ColumnLayout {
                Layout.preferredWidth: parent.width / 2 - 6
                Layout.fillHeight: true
                spacing: Style.spacingSmall

                Text {
                    text: qsTr("原文")
                    color: Style.text
                    font.bold: true
                    font.pixelSize: 16
                    font.family: Style.fontFamily
                    Layout.alignment: Qt.AlignLeft
                }

                Rectangle {
                    id: originalTextContainer
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: Style.panelBg
                    radius: Style.radiusMedium
                    border.color: Style.border
                    border.width: Style.borderWidth
                    clip: true

                    // 添加卡片阴影
                    layer.enabled: true
                    layer.effect: DropShadow {
                        transparentBorder: true
                        horizontalOffset: 0
                        verticalOffset: 2
                        radius: 8
                        samples: 17
                        color: Style.shadow
                    }

                    Flickable {
                        id: textOriginalFlickable
                        anchors.fill: parent
                        anchors.margins: 2
                        contentWidth: width
                        contentHeight: textOriginal.height + textOriginal.topPadding + textOriginal.bottomPadding
                        boundsBehavior: Flickable.StopAtBounds
                        ScrollBar.vertical: ScrollBar {
                            policy: ScrollBar.AsNeeded
                            width: Style.scrollBarWidth
                            background: Rectangle {
                                color: Style.scrollBarBg
                                radius: Style.radiusSmall
                            }
                            contentItem: Rectangle {
                                color: Style.scrollBarHandle
                                radius: Style.radiusSmall
                            }
                        }

                        TextEdit {
                            id: textOriginal
                            width: parent.width
                            text: previewDialog.originalText || qsTr("<空>")
                            color: Style.text
                            font.family: "Courier New, Consolas, monospace"
                            font.pixelSize: 14
                            wrapMode: Text.Wrap
                            topPadding: Style.paddingSmall
                            bottomPadding: Style.paddingSmall
                            leftPadding: Style.paddingSmall
                            rightPadding: Style.paddingSmall
                            readOnly: true
                            selectByMouse: true

                            // 正确计算文本高度
                            onTextChanged: {
                                // 强制重新计算高度
                                textOriginal.height = textOriginal.contentHeight
                            }

                            // 确保初始高度正确
                            Component.onCompleted: {
                                textOriginal.height = textOriginal.contentHeight
                            }
                        }
                    }
                }
            }

            // 右侧：优化后
            ColumnLayout {
                Layout.preferredWidth: parent.width / 2 - 6
                Layout.fillHeight: true
                spacing: Style.spacingSmall

                Text {
                    text: qsTr("优化后")
                    color: Style.text
                    font.bold: true
                    font.pixelSize: 16
                    font.family: Style.fontFamily
                    Layout.alignment: Qt.AlignLeft
                }

                Rectangle {
                    id: optimizedTextContainer
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: Style.panelBg
                    radius: Style.radiusMedium
                    border.color: Style.border
                    border.width: Style.borderWidth
                    clip: true

                    // 添加卡片阴影
                    layer.enabled: true
                    layer.effect: DropShadow {
                        transparentBorder: true
                        horizontalOffset: 0
                        verticalOffset: 2
                        radius: 8
                        samples: 17
                        color: Style.shadow
                    }

                    Flickable {
                        id: textOptimizedFlickable
                        anchors.fill: parent
                        anchors.margins: 2
                        contentWidth: width
                        contentHeight: textOptimized.height + textOptimized.topPadding + textOptimized.bottomPadding
                        boundsBehavior: Flickable.StopAtBounds
                        ScrollBar.vertical: ScrollBar {
                            policy: ScrollBar.AsNeeded
                            width: Style.scrollBarWidth
                            background: Rectangle {
                                color: Style.scrollBarBg
                                radius: Style.radiusSmall
                            }
                            contentItem: Rectangle {
                                color: Style.scrollBarHandle
                                radius: Style.radiusSmall
                            }
                        }

                        TextEdit {
                            id: textOptimized
                            width: parent.width
                            text: previewDialog.optimizedText || qsTr("<空>")
                            color: Style.text
                            font.family: "Courier New, Consolas, monospace"
                            font.pixelSize: 14
                            wrapMode: Text.Wrap
                            topPadding: Style.paddingSmall
                            bottomPadding: Style.paddingSmall
                            leftPadding: Style.paddingSmall
                            rightPadding: Style.paddingSmall
                            readOnly: true
                            selectByMouse: true

                            // 正确计算文本高度
                            onTextChanged: {
                                // 强制重新计算高度
                                textOptimized.height = textOptimized.contentHeight
                                // 自动滚动到底部
                                Qt.callLater(scrollToBottom)
                            }

                            // 确保初始高度正确
                            Component.onCompleted: {
                                textOptimized.height = textOptimized.contentHeight
                            }
                        }
                    }
                }
            }
        }

        // 按钮栏
        Rectangle {
            id: buttonBar
            Layout.preferredHeight: 60
            Layout.fillWidth: true
            color: "transparent"
            
            // 添加顶部边框和阴影
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                horizontalOffset: 0
                verticalOffset: -2
                radius: 8
                samples: 17
                color: Style.shadow
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: Style.paddingSmall
                spacing: Style.spacingSmall

                Item { Layout.fillWidth: true } // 左侧占位

                // 取消按钮 - 使用次按钮样式
                Rectangle {
                    id: cancelButton
                    Layout.preferredHeight: Style.buttonHeight
                    Layout.preferredWidth: 100
                    radius: Style.buttonRadius
                    border.color: Style.buttonSecondaryBorder
                    border.width: Style.borderWidth
                    
                    // 使用渐变背景
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: cancelButtonMouseArea.pressed ? Style.buttonSecondaryBgPressed : 
                                                           (cancelButtonMouseArea.containsMouse ? Style.buttonSecondaryBgHover : Style.buttonSecondaryBg) }
                        GradientStop { position: 1.0; color: cancelButtonMouseArea.pressed ? Style.buttonSecondaryBgPressed : 
                                                           (cancelButtonMouseArea.containsMouse ? Style.buttonSecondaryBgHover : Style.buttonSecondaryBg) }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: qsTr("取消")
                        color: Style.buttonSecondaryText
                        font.family: Style.fontFamily
                        font.pixelSize: 14
                        font.bold: true
                    }

                    MouseArea {
                        id: cancelButtonMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            cancel()
                            previewDialog.close()
                        }
                    }

                    // 添加点击动画
                    Behavior on scale {
                        NumberAnimation { duration: Style.durationShort; easing.type: Easing.OutCubic }
                    }
                    
                    scale: cancelButtonMouseArea.pressed ? 0.95 : 1.0
                }

                // 应用优化按钮 - 使用主按钮样式
                Rectangle {
                    id: applyButton
                    Layout.preferredHeight: Style.buttonHeight
                    Layout.preferredWidth: 120
                    radius: Style.buttonRadius
                    border.color: Style.buttonPrimaryBorder
                    border.width: Style.borderWidth
                    
                    // 使用渐变背景
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: applyButtonMouseArea.pressed ? Style.buttonPrimaryBgPressed : 
                                                           (applyButtonMouseArea.containsMouse ? Style.buttonPrimaryBgHover : Style.buttonPrimaryBg) }
                        GradientStop { position: 1.0; color: applyButtonMouseArea.pressed ? Style.buttonPrimaryBgPressed : 
                                                           (applyButtonMouseArea.containsMouse ? Style.buttonPrimaryBgHover : Style.buttonPrimaryBg) }
                    }
                    
                    // 禁用状态处理
                    opacity: enabledBtn ? 1.0 : 0.5

                    Text {
                        anchors.centerIn: parent
                        text: qsTr("应用优化")
                        color: Style.buttonPrimaryText
                        font.family: Style.fontFamily
                        font.pixelSize: 14
                        font.bold: true
                    }

                    MouseArea {
                        id: applyButtonMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: enabledBtn ? Qt.PointingHandCursor : Qt.ArrowCursor
                        enabled: enabledBtn
                        onClicked: {
                            applyOptimization()
                            previewDialog.close()
                        }
                    }

                    // 添加点击动画
                    Behavior on scale {
                        NumberAnimation { duration: Style.durationShort; easing.type: Easing.OutCubic }
                    }
                    
                    scale: applyButtonMouseArea.pressed ? 0.95 : 1.0
                    
                    // 添加悬停效果
                    Behavior on border.color {
                        ColorAnimation { duration: Style.durationShort }
                    }
                }
            }
        }
    }
}
