import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Item {
    id: root
    property var model
    signal nodeClicked(int index)

    // 节点样式
    property int nodeSize: 28
    property int cardWidth: 140
    property int cardHeight: 80
    property int spacing: 100


    // 颜色主题
    property color primaryColor: "#4C8BF5"
    property color secondaryColor: "#E8F2FF"
    property color backgroundColor: "#FFFFFF"
    property color borderColor: "#E2E8F0"
    property color textColor: "#1E293B"
    property color subtextColor: "#64748B"
    property color axisColor: "#CBD5E1"


    // 背景
    Rectangle {
        anchors.fill: parent
        color: Style.windowBg
        radius: 12
    }

    // 主容器
    Item {
        id: timelineContainer
        anchors.fill: parent
        anchors.margins: 24

        // 时间轴主体
        Item {
            id: timelineBody
            anchors.fill: parent
            anchors.bottomMargin: 80

            // 滚动视图
            ScrollView {
                id: scrollView
                anchors.fill: parent
                clip: true

                // 内容区域
                Item {
                    id: contentArea
                    width: Math.max(scrollView.width, timelineRow.width + 200) // 增加右侧边距
                    height: scrollView.height

                    // 计算实际内容宽度，用于滚动限制
                    property real effectiveContentWidth: {
                        if (root.model && root.model.count > 0) {
                            // 计算所有节点的总宽度 + 间距
                            // 确保有足够的空间显示所有节点
                            var totalWidth = root.model.count * root.cardWidth +
                                  (root.model.count - 1) * root.spacing +
                                  200 // 增加左右边距，确保最后一个节点完全可见
                            return Math.max(totalWidth, scrollView.width + 200) // 确保内容宽度足够大
                        }
                        return scrollView.width // 默认至少与视口同宽
                    }

                    // 监听滚动条位置变化，同步更新滑块位置
                    Connections {
                        target: scrollView.ScrollBar.horizontal
                        function onPositionChanged() {
                            // 避免循环更新
                            if (timelineSlider.value !== scrollView.ScrollBar.horizontal.position) {
                                timelineSlider.value = scrollView.ScrollBar.horizontal.position
                            }
                        }
                    }

                    // 主时间轴线
                    Rectangle {
                        id: mainTimeline
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 40
                        anchors.left: parent.left
                        anchors.leftMargin: 40
                        width: timelineRow.width
                        height: 3
                        color: primaryColor
                        radius: 1.5

                        // 渐变效果
                        gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop { position: 0.0; color: Qt.lighter(primaryColor, 1.3) }
                            GradientStop { position: 0.5; color: primaryColor }
                            GradientStop { position: 1.0; color: Qt.lighter(primaryColor, 1.3) }
                        }
                    }

                    // 时间轴节点行
                    Row {
                        id: timelineRow
                        spacing: root.spacing
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 60
                        x: 40

                        Repeater {
                            model: root.model
                            delegate: Item {
                                id: timelineItem
                                width: root.cardWidth
                                height: contentArea.height - 60

                                property bool isHovered: false
                                property bool isActive: index === 0
                                property string itemDate: {
                                    if (model.timestamp) {
                                        return Qt.formatDate(model.timestamp, "MM/dd")
                                    } else if (model.formattedTime) {
                                        return model.formattedTime
                                    } else {
                                        return Qt.formatDate(new Date(), "MM/dd")
                                    }
                                }

                                // 垂直连接线
                                Rectangle {
                                    id: verticalLine
                                    width: 2
                                    height: 35
                                    color: isActive ? primaryColor : axisColor
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: -18
                                    radius: 1

                                    Behavior on color {
                                        ColorAnimation { duration: 300 }
                                    }
                                }

                                // 日期标签背景
                                Rectangle {
                                    id: dateLabelBg
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: -55
                                    width: dateLabel.implicitWidth + 16
                                    height: 28
                                    radius: 14
                                    color: isActive ? primaryColor : backgroundColor
                                    border.color: isActive ? "transparent" : borderColor
                                    border.width: 1

                                    // 阴影效果
                                    Rectangle {
                                        anchors.fill: parent
                                        anchors.topMargin: 2
                                        radius: parent.radius
                                        color: Qt.rgba(0, 0, 0, 0.1)
                                        z: -1
                                        opacity: isActive ? 0.3 : 0.1
                                    }

                                    Behavior on color {
                                        ColorAnimation { duration: 300 }
                                    }

                                    // 日期文本
                                    Text {
                                        id: dateLabel
                                        text: timelineItem.itemDate
                                        font.pixelSize: 13
                                        font.weight: Font.Medium
                                        color: isActive ? "white" : textColor
                                        anchors.centerIn: parent

                                        Behavior on color {
                                            ColorAnimation { duration: 300 }
                                        }
                                    }
                                }

                                // 节点
                                Rectangle {
                                    id: dot
                                    width: root.nodeSize
                                    height: root.nodeSize
                                    radius: root.nodeSize/2
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.bottom: verticalLine.top
                                    anchors.bottomMargin: 8

                                    color: isActive ? primaryColor : (isHovered ? Qt.lighter(primaryColor, 1.2) : backgroundColor)
                                    border.color: isActive ? "white" : primaryColor
                                    border.width: isActive ? 3 : 2

                                    // 外圈效果
                                    Rectangle {
                                        anchors.centerIn: parent
                                        width: parent.width + 8
                                        height: parent.height + 8
                                        radius: width/2
                                        color: "transparent"
                                        border.color: Qt.rgba(primaryColor.r, primaryColor.g, primaryColor.b, 0.3)
                                        border.width: isActive ? 2 : 0
                                        opacity: isActive ? 1 : 0

                                        Behavior on opacity {
                                            NumberAnimation { duration: 300 }
                                        }
                                    }

                                    // 内部数字
                                    Text {
                                        anchors.centerIn: parent
                                        text: index + 1
                                        font.pixelSize: 12
                                        font.weight: Font.Bold
                                        color: isActive ? "white" : primaryColor
                                    }

                                    // 脉冲动画
                                    SequentialAnimation on scale {
                                        running: isActive
                                        loops: Animation.Infinite
                                        NumberAnimation { to: 1.15; duration: 1200; easing.type: Easing.InOutQuad }
                                        NumberAnimation { to: 1.0; duration: 1200; easing.type: Easing.InOutQuad }
                                    }

                                    Behavior on color {
                                        ColorAnimation { duration: 300 }
                                    }

                                    Behavior on scale {
                                        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                                    }
                                }

                                // 卡片
                                Rectangle {
                                    id: card
                                    anchors.horizontalCenter: dot.horizontalCenter
                                    anchors.bottom: dot.top
                                    anchors.bottomMargin: 16
                                    width: root.cardWidth
                                    height: root.cardHeight
                                    radius: 12

                                    color: backgroundColor
                                    border.color: isHovered ? primaryColor : borderColor
                                    border.width: isHovered ? 2 : 1

                                    // 渐变背景
                                    gradient: Gradient {
                                        GradientStop { position: 0.0; color: backgroundColor }
                                        GradientStop { position: 1.0; color: isHovered ? secondaryColor : "#FAFBFC" }
                                    }

                                    // 阴影
                                    Rectangle {
                                        anchors.fill: parent
                                        anchors.topMargin: 3
                                        radius: parent.radius
                                        color: Qt.rgba(0, 0, 0, isHovered ? 0.15 : 0.08)
                                        z: -1
                                    }

                                    // 内容
                                    Column {
                                        anchors.fill: parent
                                        anchors.margins: 12
                                        spacing: 6

                                        // 标题
                                        Text {
                                            text: model.title ?? ""
                                            font.pixelSize: 13
                                            font.weight: Font.Bold
                                            color: textColor
                                            elide: Text.ElideRight
                                            width: parent.width
                                            wrapMode: Text.WordWrap
                                            maximumLineCount: 2
                                        }

                                        // 描述
                                        Text {
                                            text: model.description ?? ""
                                            font.pixelSize: 11
                                            color: subtextColor
                                            elide: Text.ElideRight
                                            width: parent.width
                                            wrapMode: Text.WordWrap
                                            maximumLineCount: 1
                                            visible: text !== ""
                                        }

                                        // 类别标签
                                        Rectangle {
                                            width: Math.min(categoryText.implicitWidth + 12, parent.width)
                                            height: 20
                                            radius: 10
                                            color: Qt.rgba(primaryColor.r, primaryColor.g, primaryColor.b, 0.1)
                                            visible: model.category !== undefined && model.category !== ""

                                            Text {
                                                id: categoryText
                                                anchors.centerIn: parent
                                                text: model.category ?? ""
                                                font.pixelSize: 10
                                                font.weight: Font.Medium
                                                color: primaryColor
                                            }
                                        }
                                    }

                                    // 悬停效果
                                    Behavior on border.color {
                                        ColorAnimation { duration: 200 }
                                    }

                                    scale: isHovered ? 1.05 : 1.0
                                    Behavior on scale {
                                        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                                    }
                                }

                                // 鼠标交互
                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor

                                    onEntered: {
                                        timelineItem.isHovered = true
                                    }

                                    onExited: {
                                        timelineItem.isHovered = false
                                    }

                                    onClicked: {
                                        root.nodeClicked(index)
                                        // 点击动画
                                        clickAnimation.start()
                                    }

                                    // 点击动画
                                    SequentialAnimation {
                                        id: clickAnimation
                                        NumberAnimation { target: card; property: "scale"; to: 0.95; duration: 100 }
                                        NumberAnimation { target: card; property: "scale"; to: 1.05; duration: 100 }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        // 底部信息栏
        Rectangle {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: 70
                radius: 12

                // 渐变背景
                gradient: Gradient {
                    GradientStop { position: 0.0; color: Qt.rgba(primaryColor.r, primaryColor.g, primaryColor.b, 0.03) }
                    GradientStop { position: 1.0; color: Qt.rgba(primaryColor.r, primaryColor.g, primaryColor.b, 0.08) }
                }

                // 顶部细线装饰
                Rectangle {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 1
                    color: Qt.rgba(primaryColor.r, primaryColor.g, primaryColor.b, 0.15)
                }

                // 内容容器
                Item {
                    anchors.fill: parent
                    anchors.margins: 15

                    // 左侧节点统计
                    Row {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 12

                        // 图标容器
                        Rectangle {
                            width: 36
                            height: 36
                            radius: 18
                            color: Qt.rgba(primaryColor.r, primaryColor.g, primaryColor.b, 0.15)

                            // 图标
                            Text {
                                anchors.centerIn: parent
                                text: "📊"
                                font.pixelSize: 16
                            }

                            // 微妙的阴影效果
                            layer.enabled: true
                            layer.effect: DropShadow {
                                transparentBorder: true
                                horizontalOffset: 0
                                verticalOffset: 2
                                radius: 4
                                samples: 8
                                color: Qt.rgba(0, 0, 0, 0.1)
                                cached: true
                            }
                        }

                        // 统计信息
                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 2

                            // 标题
                            Text {
                                text: qsTr("节点总数")
                                font.pixelSize: 12
                                font.weight: Font.Medium
                                color: Style.text
                            }

                            // 数值
                            Text {
                                text: root.model ? root.model.count : 0
                                font.pixelSize: 18
                                font.weight: Font.Bold
                                color: Style.text
                            }
                        }
                    }

                    // 水平滑块控制器 (修正: 从 Row 中移出并居中)
                    Item {
                        id: sliderContainer
                        width: Math.min(parent.width * 0.6, 400)
                        height: 30
                        anchors.centerIn: parent // 关键改动：使其在父容器中居中

                        // 定义滑块
                        Slider {
                            id: timelineSlider
                            objectName: "timelineSlider"
                            anchors.fill: parent // 关键改动：填满居中的容器
                            from: 0
                            to: 1
                            value: scrollView.ScrollBar.horizontal.position

                            // 自定义滑块样式
                            background: Rectangle {
                                x: timelineSlider.leftPadding
                                y: timelineSlider.topPadding + timelineSlider.availableHeight / 2 - height / 2
                                width: timelineSlider.availableWidth
                                height: 6
                                radius: 3
                                color: Qt.rgba(root.primaryColor.r, root.primaryColor.g, root.primaryColor.b, 0.2)

                                Rectangle {
                                    width: timelineSlider.visualPosition * parent.width
                                    height: parent.height
                                    color: root.primaryColor
                                    radius: 3
                                }
                            }

                            handle: Rectangle {
                                x: timelineSlider.leftPadding + timelineSlider.visualPosition * (timelineSlider.availableWidth - width)
                                y: timelineSlider.topPadding + timelineSlider.availableHeight / 2 - height / 2
                                width: 16
                                height: 16
                                radius: 8
                                color: timelineSlider.pressed ? Qt.darker(root.primaryColor, 1.1) : root.primaryColor
                                border.color: root.primaryColor
                                border.width: 2

                                // 滑块阴影效果
                                Rectangle {
                                    anchors.fill: parent
                                    anchors.margins: -2
                                    radius: 10
                                    color: "transparent"
                                    border.color: Qt.rgba(root.primaryColor.r, root.primaryColor.g, root.primaryColor.b, 0.3)
                                    border.width: 2
                                    visible: timelineSlider.hovered || timelineSlider.pressed
                                }
                            }

                            // 当用户拖动滑块时更新滚动位置
                            onMoved: {
                                // 计算内容宽度与视口宽度的比例
                                var contentWidth = contentArea.effectiveContentWidth
                                var viewportWidth = scrollView.width

                                // 如果内容宽度小于等于视口宽度，则不需要滚动
                                if (contentWidth <= viewportWidth) {
                                    return
                                }

                                // 直接使用滑块的值作为滚动位置 (0-1之间)
                                var targetPosition = Math.max(0, Math.min(1, value))

                                // 更新滚动位置和滚轮处理器的目标位置
                                scrollView.ScrollBar.horizontal.position = targetPosition
                            }

                            // 添加滑块拖动动画
                            Behavior on value {
                                enabled: !timelineSlider.pressed
                                NumberAnimation {
                                    duration: 100
                                    easing.type: Easing.OutCubic
                                }
                            }
                        }
                    }
                }
            }

    }
}
