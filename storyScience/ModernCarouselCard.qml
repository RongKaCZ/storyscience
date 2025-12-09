import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Item {
    id: root

    // 数据属性
    property string cardId: ""
    property string title: ""
    property string description: ""
    property string content: ""
    property string category: ""
    property string iconName: "circle"
    property string formattedTime: ""
    property int priority: 0
    property bool isActive: true
    property bool isCurrent: false
    property bool isHovered: false

    // 视觉属性 - 使用Style样式
    property real cardRadius: Style.carouselCardRadius
    property real shadowRadius: 16
    property color primaryColor: Style.primary
    property color backgroundColor: Style.carouselCardBg
    property color textColor: Style.carouselCardText
    property color secondaryTextColor: Style.carouselCardTextSecondary

    // 动画属性 - 使用Style样式
    property int animationDuration: Style.animationDuration
    property real scaleValue: isCurrent ? Style.hoverScale : (isHovered ? 1.02 : 1.0)

    // 性能优化属性
    property bool enableAnimations: true
    property bool enableShadows: false  // 禁用阴影以避免模糊
    property bool enableGradients: true

    // 信号
    signal clicked()
    signal doubleClicked()
    signal rightClicked()

    width: Style.carouselCardWidth
    height: Style.carouselCardHeight

    // 主卡片容器
    Rectangle {
        id: cardContainer
        anchors.fill: parent
        radius: cardRadius
        color: backgroundColor

        // 渐变背景 - 可选择性启用
        gradient: enableGradients ? cardGradient : null

        Gradient {
            id: cardGradient
            GradientStop {
                position: 0.0
                color: Style.carouselCardBg
            }
            GradientStop {
                position: 1.0
                color: Style.panelBgAlt
            }
        }

        // 边框 - 使用Style样式
        border.width: isCurrent ? Style.borderWidthFocus : Style.borderWidth
        border.color: isCurrent ? Style.carouselCardBorderActive : Style.carouselCardBorder

        //阴影效果
        layer.enabled: enableShadows
        layer.effect: DropShadow {
            color: Qt.rgba(0, 0, 0, 0.15)
            radius: root.shadowRadius
            samples: 20
            spread: 0.1
            horizontalOffset: 4
            verticalOffset: 3
        }

        // 缩放动画 - 可选择性启用
        transform: Scale {
            origin.x: cardContainer.width / 2
            origin.y: cardContainer.height / 2
            xScale: scaleValue
            yScale: scaleValue

            Behavior on xScale {
                enabled: enableAnimations
                NumberAnimation {
                    duration: animationDuration
                    easing.type: Style.ease
                }
            }
            Behavior on yScale {
                enabled: enableAnimations
                NumberAnimation {
                    duration: animationDuration
                    easing.type: Style.ease
                }
            }
        }

        // 内容布局
        ColumnLayout {
            id: contentLayout
            anchors.fill: parent
            anchors.margins: 24
            spacing: 16

            // 头部区域
            RowLayout {
                id: headerRow
                Layout.fillWidth: true
                spacing: 12

                // 图标区域 - 性能优化
                Rectangle {
                    id: iconContainer
                    width: Style.carouselCardIconSize
                    height: Style.carouselCardIconSize
                    radius: Style.carouselCardIconRadius
                    color: Style.carouselCardIconBg

                    // 图标渐变 - 可选择性启用
                    gradient: enableGradients ? iconGradient : null

                    Gradient {
                        id: iconGradient
                        GradientStop { position: 0.0; color: Qt.lighter(primaryColor, 1.2) }
                        GradientStop { position: 1.0; color: primaryColor }
                    }

                    // 图标文字 (可以替换为实际图标)
                    Text {
                        anchors.centerIn: parent
                        text: iconName.charAt(0).toUpperCase()
                        font.pixelSize: 20
                        font.weight: Font.Bold
                        color: Style.carouselCardIconText
                        renderType: Text.NativeRendering  // 性能优化
                    }

                    // 图标动画 - 可选择性启用
                    transform: Rotation {
                        origin.x: iconContainer.width / 2
                        origin.y: iconContainer.height / 2
                        angle: isCurrent ? 5 : 0

                        Behavior on angle {
                            enabled: enableAnimations
                            NumberAnimation {
                                duration: animationDuration
                                easing.type: Style.ease
                            }
                        }
                    }
                }

                // 标题和分类区域
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 4

                    // 标题 - 性能优化
                    Text {
                        id: titleText
                        Layout.fillWidth: true
                        text: title
                        font: Style.carouselCardTitleFont
                        color: textColor
                        elide: Text.ElideRight
                        maximumLineCount: 1
                        renderType: Text.NativeRendering

                        // 标题动画 - 可选择性启用
                        Behavior on color {
                            enabled: enableAnimations
                            ColorAnimation {
                                duration: animationDuration
                            }
                        }
                    }

                    // 分类标签
                    Rectangle {
                        Layout.preferredHeight: Style.carouselCardCategoryHeight
                        Layout.preferredWidth: categoryText.implicitWidth + 12
                        radius: Style.carouselCardCategoryRadius
                        color: Style.carouselCardCategoryBg
                        visible: category !== ""

                        Text {
                            id: categoryText
                            anchors.centerIn: parent
                            text: category
                            font: Style.carouselCardCategoryFont
                            color: Style.carouselCardCategoryText
                            renderType: Text.NativeRendering
                        }
                    }
                }

                // 时间标签
                Text {
                    text: formattedTime
                    font: Style.carouselCardTimeFont
                    color: secondaryTextColor
                    opacity: 0.8
                    renderType: Text.NativeRendering
                }
            }

            // 描述内容区域 - 性能优化
            ScrollView {
                id: contentScroll
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AsNeeded
                ScrollBar.vertical.interactive: true

                TextArea {
                    id: contentText
                    text: content || description
                    font: Style.carouselCardContentFont
                    color: textColor
                    wrapMode: Text.WordWrap
                    readOnly: true
                    selectByMouse: true
                    background: null
                    renderType: Text.NativeRendering  // 性能优化

                    // 文本渐变效果 - 可选择性启用
                    opacity: isCurrent ? 1.0 : 0.75

                    Behavior on opacity {
                        enabled: enableAnimations
                        NumberAnimation {
                            duration: animationDuration
                        }
                    }
                }
            }

            // 底部操作区域
            RowLayout {
                id: footerRow
                Layout.fillWidth: true
                spacing: 8

                // 优先级指示器 - 性能优化
                Row {
                    spacing: 2
                    Repeater {
                        model: 5
                        Rectangle {
                            width: Style.carouselCardPrioritySize
                            height: Style.carouselCardPrioritySize
                            radius: Style.carouselCardPriorityRadius
                            color: index < priority ? Style.carouselCardPriorityActive : Style.carouselCardPriorityInactive

                            Behavior on color {
                                enabled: enableAnimations
                                ColorAnimation {
                                    duration: animationDuration
                                }
                            }
                        }
                    }
                }

                Item { Layout.fillWidth: true }

                // 状态指示器 - 性能优化
                Rectangle {
                    width: Style.carouselCardStatusSize
                    height: Style.carouselCardStatusSize
                    radius: Style.carouselCardStatusRadius
                    color: isActive ? Style.carouselCardStatusActive : Style.carouselCardStatusInactive

                    // 呼吸动画 - 可选择性启用
                    SequentialAnimation on opacity {
                        running: isActive && enableAnimations
                        loops: Animation.Infinite
                        NumberAnimation { to: 0.5; duration: 1000 }
                        NumberAnimation { to: 1.0; duration: 1000 }
                    }
                }
            }
        }

        // 悬停效果
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onEntered: {
                isHovered = true
            }

            onExited: {
                isHovered = false
            }

            onClicked: function(mouse) {
                if (mouse.button === Qt.LeftButton) {
                    root.clicked()
                } else if (mouse.button === Qt.RightButton) {
                    root.rightClicked()
                }
            }

            onDoubleClicked:function(mouse){
                if (mouse.button === Qt.RightButton)
                root.doubleClicked()
            }
        }

        // 选中状态指示器 - 性能优化
        Rectangle {
            id: selectionIndicator
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 12
            width: Style.carouselCardSelectionSize
            height: Style.carouselCardSelectionSize
            radius: Style.carouselCardSelectionRadius
            color: Style.carouselCardSelectionBg
            visible: isCurrent

            Text {
                anchors.centerIn: parent
                text: "✓"
                color: Style.carouselCardSelectionText
                font.pixelSize: 14
                font.weight: Font.Bold
                renderType: Text.NativeRendering
            }

            // 选中指示器动画 - 可选择性启用
            transform: Scale {
                origin.x: selectionIndicator.width / 2
                origin.y: selectionIndicator.height / 2
                xScale: isCurrent ? 1.0 : 0.0
                yScale: isCurrent ? 1.0 : 0.0

                Behavior on xScale {
                    enabled: enableAnimations
                    NumberAnimation {
                        duration: animationDuration
                        easing.type: Easing.OutBack
                    }
                }
                Behavior on yScale {
                    enabled: enableAnimations
                    NumberAnimation {
                        duration: animationDuration
                        easing.type: Easing.OutBack
                    }
                }
            }
        }
    }

    // 背景色动画 - 可选择性启用
    Behavior on backgroundColor {
        enabled: enableAnimations
        ColorAnimation {
            duration: animationDuration
        }
    }

    // 边框动画 - 可选择性启用
    Behavior on primaryColor {
        enabled: enableAnimations
        ColorAnimation {
            duration: animationDuration
        }
    }

    // 性能优化方法
    function setPerformanceMode(highPerformance) {
        enableAnimations = !highPerformance
        enableShadows = !highPerformance
        enableGradients = !highPerformance
    }
}
