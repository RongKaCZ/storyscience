import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Item {
    id: root

    // 数据模型
    property var model
    property alias currentIndex: carousel.currentIndex
    // 详情视图状态
    property bool detailMode: false
    property int selectedIndex: -1
    property var selectedData: null

    // 视觉配置 - 使用Style样式
    property int cardWidth: Style.carouselCardWidth
    property int cardHeight: Style.carouselCardHeight
    property int cardSpacing: Style.carouselCardSpacing
    property real viewportRatio: 0.8 // 视口显示比例

    // 轮播配置
    property bool autoPlay: false
    property int autoPlayInterval: 4000
    property bool loop: true
    property bool showIndicators: true
    property bool showNavigation: true

    // 鼠标悬停配置
    property bool pauseOnHover: true
    property bool hoverNavigation: true
    // 悬停交互增强配置
    property bool enableHoverInteraction: true
    property int hoverDelayMs: 1000
    property real hoverScale: 1.08
    property bool hoverEffectActive: false
    // 点击触发淡出/放大效果的持续时间（毫秒）
    property int clickEffectDurationMs: 1500

    // 全局悬停效果状态变化调试（必须放在根 Item 作用域）

    // 动画配置 - 使用Style样式
    property int transitionDuration: Style.animationDuration
    property var easingType: Style.ease

    // 性能优化配置
    property bool enableVirtualization: true
    property int cacheBuffer: 2  // 缓存前后各2个项目
    property bool enableHighPerformanceMode: false

    // 颜色主题 - 使用Style样式
    property color primaryColor: Style.primary
    property color backgroundColor: Style.carouselViewBg
    property color indicatorColor: Style.carouselIndicatorInactive
    property color activeIndicatorColor: Style.carouselIndicatorActive

    // 信号
    signal cardClicked(int index, var cardData)
    signal cardDoubleClicked(int index, var cardData)

    // 卡片点击进入详情视图
    onCardClicked: (index, cardData) => enterDetail(index, cardData)

    implicitWidth: 800
    implicitHeight: cardHeight + 120

    // 主要内容区域
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        // 轮播区域
        Item {
            id: carouselContainer
            Layout.fillWidth: true
            Layout.preferredHeight: cardHeight
            visible: !detailMode

            // 轮播视图 - 性能优化版本
            ListView {
                id: carousel
                anchors.centerIn: parent
                width: Math.min(parent.width, cardWidth * 3 + cardSpacing * 2)
                height: cardHeight

                model: root.model
                orientation: ListView.Horizontal
                snapMode: ListView.SnapToItem
                highlightRangeMode: ListView.StrictlyEnforceRange
                highlightMoveDuration: transitionDuration
                currentIndex: 0  // 确保有初始当前项

                // 添加高亮项以确保 isCurrentItem 正常工作
                highlight: Rectangle {
                    width: cardWidth
                    height: cardHeight
                    color: "transparent"
                    visible: false  // 不显示高亮，只用于激活 isCurrentItem
                }
                highlightFollowsCurrentItem: true

                onCurrentIndexChanged: {
                    // 只有在非悬停状态下才复位效果，避免打断悬停交互
                    if (!root.hoverEffectActive) {
                        root.hoverEffectActive = false
                    }
                }

                // 性能优化设置
                cacheBuffer: enableVirtualization ? root.cacheBuffer * (cardWidth + cardSpacing) : 0
                displayMarginBeginning: cardWidth + cardSpacing
                displayMarginEnd: cardWidth + cardSpacing

                // 居中显示当前项
                preferredHighlightBegin: (width - cardWidth) / 2
                preferredHighlightEnd: (width + cardWidth) / 2

                // 鼠标悬停区域
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    acceptedButtons: Qt.NoButton
                    // 鼠标滚轮切换
                    onWheel: (wheel) => {
                        if (hoverNavigation) {
                            if (wheel.angleDelta.y > 0) {
                                // 向上滚动，切换到上一张
                                if (carousel.currentIndex > 0) {
                                    carousel.currentIndex--
                                } else if (loop) {
                                    carousel.currentIndex = carousel.count - 1
                                }
                            } else if (wheel.angleDelta.y < 0) {
                                // 向下滚动，切换到下一张
                                if (carousel.currentIndex < carousel.count - 1) {
                                    carousel.currentIndex++
                                } else if (loop) {
                                    carousel.currentIndex = 0
                                }
                            }
                        }
                    }
                    onExited: {
                        // 只有在没有悬停效果激活时才复位，避免打断正在进行的悬停交互
                        if (!root.hoverEffectActive) {
                            root.hoverEffectActive = false
                        }
                    }
                }

                // 代理项 - 性能优化
                delegate: Item {
                    id: delegateItem
                    width: cardWidth + cardSpacing
                    height: cardHeight

                    // 延迟加载机制
                    property bool isVisible: {
                        var itemX = x - carousel.contentX
                        return itemX > -width && itemX < carousel.width
                    }
                    // 悬停状态标记
                    property bool hoverActive: false

                    // 手动跟踪当前项状态（备用方案）
                    property bool isCurrentDelegate: index === carousel.currentIndex


                    ModernCarouselCard {
                        id: card
                        anchors.centerIn: parent
                        width: cardWidth
                        height: cardHeight

                        // 性能优化：只有可见时才完全渲染
                        visible: delegateItem.isVisible || !enableVirtualization

                        // 绑定数据
                        cardId: model.id || ""
                        title: model.title || ""
                        description: model.description || ""
                        content: model.content || ""
                        category: model.category || ""
                        iconName: model.iconName || "circle"
                        formattedTime: model.formattedTime || ""
                        priority: model.priority || 0
                        isActive: model.isActive !== undefined ? model.isActive : true
                        isCurrent: delegateItem.isCurrentDelegate  // 使用手动跟踪的当前项状态

                        // 调试当前项状态
                        Component.onCompleted: {
                            if (enableHighPerformanceMode) {
                                setPerformanceMode(true)
                            }
                        }
                        // 主题色
                        primaryColor: root.primaryColor

                        // 信号处理
                        onClicked: {
                            carousel.currentIndex = index
                            root.cardClicked(index, model)
                            // 点击当前卡片时也触发一次视觉聚焦效果
                            if (delegateItem.isCurrentDelegate && root.enableHoverInteraction) {
                                delegateItem.hoverActive = true
                                root.hoverEffectActive = true
                                clickEffectTimer.restart()
                            }
                        }
                        onRightClicked:{
                            root.cardDoubleClicked(index, model)
                        }
                        onDoubleClicked: {
                            root.cardDoubleClicked(index, model)
                        }

                        // 悬停时淡出非当前卡片
                        opacity: root.hoverEffectActive ? (delegateItem.isCurrentDelegate ? 1 : 0.3) : 1

                        // 平滑缩放动画
                        Behavior on scale {
                            enabled: !enableHighPerformanceMode
                            NumberAnimation {
                                duration: transitionDuration
                                easing.type: easingType
                            }
                        }

                        Behavior on opacity {
                            enabled: !enableHighPerformanceMode
                            NumberAnimation {
                                duration: transitionDuration
                                easing.type: easingType
                            }
                        }
                    }

                    // 2秒延时检测定时器
                    Timer {
                        id: hoverTimer
                        interval: root.hoverDelayMs
                        repeat: false
                        running: false
                        onTriggered: {
                            if (root.enableHoverInteraction && delegateItem.isCurrentDelegate && card.isHovered) {
                                delegateItem.hoverActive = true
                                root.hoverEffectActive = true
                            }
                        }
                    }

                    // 点击触发效果的复位定时器
                    Timer {
                        id: clickEffectTimer
                        interval: root.clickEffectDurationMs
                        repeat: false
                        running: false
                        onTriggered: {
                            // 若此时仍在悬停计时或悬停已生效，则不强制复位
                            if (!hoverTimer.running && !card.isHovered) {
                                root.hoverEffectActive = false
                                delegateItem.hoverActive = false
                            }
                        }
                    }

                    // 连接卡片内部悬停状态，避免重叠MouseArea冲突
                    Connections {
                        target: card
                        function onIsHoveredChanged() {
                            if (root.enableHoverInteraction && delegateItem.isCurrentDelegate && card.isHovered) {
                                hoverTimer.restart()
                            } else {
                                hoverTimer.stop()
                                delegateItem.hoverActive = false
                                root.hoverEffectActive = false
                            }
                        }
                    }

                    // 状态机：悬停时放大当前卡片
                    states: [
                        State {
                            name: "hovered"
                            when: root.enableHoverInteraction && delegateItem.hoverActive && delegateItem.isCurrentDelegate
                            PropertyChanges { target: card; scaleValue: root.hoverScale }
                            PropertyChanges { target: card; z: 2 }
                        }
                    ]
                }

                // 滚动条
                ScrollBar.horizontal: ScrollBar {
                    policy: ScrollBar.AlwaysOff
                }

                // 性能优化：减少不必要的重新布局
                reuseItems: enableVirtualization
            }
        }

        // 详情模式：左右分栏布局
        Item {
            id: detailContainer
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height
            visible: detailMode
            opacity: detailMode ? 1 : 0
            Behavior on opacity { NumberAnimation { duration: transitionDuration; easing.type: easingType } }

            RowLayout {
                anchors.fill: parent
                spacing: 20

                // 左侧：当前卡片放置区域（带锚点动画从居中到左侧）
                Item {
                    id: leftPane
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width * 0.45

                    ModernCarouselCard {
                        id: detailCard
                        width: Math.min(leftPane.width - 12, cardWidth + 140)
                        height: cardHeight
                        anchors.centerIn: parent

                        // 绑定数据（来自 cardClicked 的传递）
                        cardId: selectedData && selectedData.id || ""
                        title: selectedData && selectedData.title || ""
                        description: selectedData && selectedData.description || ""
                        content: selectedData && selectedData.content || ""
                        category: selectedData && selectedData.category || ""
                        iconName: selectedData && selectedData.iconName || "circle"
                        formattedTime: selectedData && selectedData.formattedTime || ""
                        priority: selectedData && selectedData.priority || 0
                        isActive: selectedData && selectedData.isActive !== undefined ? selectedData.isActive : true
                        isCurrent: true

                        states: [
                            State {
                                name: "expanded"
                                when: detailMode
                                AnchorChanges {
                                    target: detailCard
                                    anchors.left: leftPane.left
                                    anchors.verticalCenter: leftPane.verticalCenter
                                }
                                //AnchorChanges { target: detailCard; anchors.centerIn: undefined; anchors.left: leftPane.left; anchors.verticalCenter: leftPane.verticalCenter }
                                PropertyChanges { target: detailCard; z: 3 }
                            }
                        ]

                        transitions: [
                            Transition {
                                AnchorAnimation { duration: transitionDuration; easing.type: easingType }
                                NumberAnimation { properties: "width,height"; duration: transitionDuration; easing.type: easingType }
                            }
                        ]
                    }
                }

                // 右侧：详情内容区域（滚动查看长文本）
                Rectangle {
                    id: rightPane
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width * 0.55
                    Layout.preferredHeight: parent.height
                    radius: Style.radius
                    color: Style.panelBg
                    border.width: Style.borderWidth
                    border.color: Style.panelBorder
                    clip: true
                    opacity: detailMode ? 1 : 0
                    Behavior on opacity { NumberAnimation { duration: transitionDuration } }

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 16
                        spacing: 12

                        // 顶部工具栏（标题 + 关闭）
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 8
                            Text {
                                text: selectedData && selectedData.title || ""
                                font: Style.titleFont
                                color: Style.text
                                elide: Text.ElideRight
                                Layout.fillWidth: true
                                renderType: Text.NativeRendering
                            }
                            Rectangle {
                                width: 28; height: 28; radius: 14
                                color: Style.panelBgAlt
                                border.width: Style.borderWidth
                                border.color: Style.panelBorder
                                MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: exitDetail() }
                                Text { anchors.centerIn: parent; text: "×"; font.pixelSize: 16; color: Style.textSecondary }
                            }
                        }

                        // 分类与时间信息
                        RowLayout {
                            spacing: 10
                            visible: (selectedData && (selectedData.category || selectedData.formattedTime))
                            Rectangle {
                                visible: selectedData && selectedData.category
                                radius: Style.radiusSmall
                                color: Style.carouselCardCategoryBg
                                Layout.preferredHeight: Style.carouselCardCategoryHeight
                                Layout.preferredWidth: categoryText.implicitWidth + 12
                                Text { id: categoryText; anchors.centerIn: parent; text: selectedData && selectedData.category || ""; font: Style.carouselCardCategoryFont; color: Style.carouselCardCategoryText; renderType: Text.NativeRendering }
                            }
                            Text { visible: selectedData && selectedData.formattedTime; text: selectedData && selectedData.formattedTime || ""; font: Style.captionFont; color: Style.textSecondary; renderType: Text.NativeRendering }
                        }

                        // 分隔线
                        Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 1; color: Style.divider }

                        // 内容滚动区域
                        Flickable {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            contentWidth: contentText.paintedWidth
                            contentHeight: contentText.paintedHeight
                            clip: true
                            ScrollBar.vertical: ScrollBar {}

                            Text {
                                id: contentText
                                width: rightPane.width - 32
                                wrapMode: Text.WordWrap
                                text: selectedData && selectedData.content || (selectedData && selectedData.description) || ""
                                font: Style.bodyFont
                                color: Style.text
                                renderType: Text.NativeRendering
                            }
                        }
                    }
                }
            }

            MouseArea{
                anchors.fill: parent
                visible: root.detailMode
                enabled: root.detailMode
                cursorShape: Qt.ArrowCursor     
                acceptedButtons: Qt.LeftButton | Qt.BackButton  // 只接受左键和后退键
                onClicked: exitDetail()
                // 鼠标后退键
                onPressed: (mouse) => {
                    if (mouse.button === Qt.BackButton) {
                        exitDetail()
                        // 阻止事件继续向下传递（防止界面误触）
                        mouse.accepted = true
                    }
                }
            }
        }

        // 指示器区域
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 12
            visible: showIndicators && !detailMode

            // 页面指示器 - 性能优化
            Row {
                spacing: 8

                Repeater {
                    model: Math.min(carousel.count, 20)  // 限制指示器数量以提高性能

                    Rectangle {
                        width: index === carousel.currentIndex ? Style.carouselIndicatorActiveWidth : Style.carouselIndicatorInactiveWidth
                        height: Style.carouselIndicatorHeight
                        radius: Style.carouselIndicatorRadius
                        color: index === carousel.currentIndex ? activeIndicatorColor : indicatorColor

                        Behavior on width {
                            enabled: !enableHighPerformanceMode
                            NumberAnimation {
                                duration: 200
                                easing.type: Easing.OutCubic
                            }
                        }

                        Behavior on color {
                            enabled: !enableHighPerformanceMode
                            ColorAnimation {
                                duration: 200
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: carousel.currentIndex = index
                            cursorShape: Qt.PointingHandCursor
                        }
                    }
                }
            }

            // 计数器
            Text {
                text: `${carousel.currentIndex + 1} / ${carousel.count}`
                font: Style.captionFont
                color: Style.textSecondary
                renderType: Text.NativeRendering
            }
        }
    }

    // 公共方法
    function enterDetail(index, data) {
        selectedIndex = index
        selectedData = data
        detailMode = true
    }

    function exitDetail() {
        detailMode = false
    }

    function goToIndex(index) {
        if (index >= 0 && index < carousel.count) {
            carousel.currentIndex = index
        }
    }

    function next() {
        if (carousel.currentIndex < carousel.count - 1) {
            carousel.currentIndex++
        } else if (loop) {
            carousel.currentIndex = 0
        }
    }

    function previous() {
        if (carousel.currentIndex > 0) {
            carousel.currentIndex--
        } else if (loop) {
            carousel.currentIndex = carousel.count - 1
        }
    }

    // 性能优化方法
    function setHighPerformanceMode(enabled) {
        enableHighPerformanceMode = enabled
        enableVirtualization = enabled

        // 更新所有可见卡片的性能模式
        for (var i = 0; i < carousel.count; i++) {
            var item = carousel.itemAtIndex(i)
            if (item && item.children[0] && item.children[0].setPerformanceMode) {
                item.children[0].setPerformanceMode(enabled)
            }
        }
    }

    // 内存管理
    function clearCache() {
        if (carousel.cacheBuffer > 0) {
            carousel.cacheBuffer = 0
            carousel.cacheBuffer = root.cacheBuffer * (cardWidth + cardSpacing)
        }
    }
}
