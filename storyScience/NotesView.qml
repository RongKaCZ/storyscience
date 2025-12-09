// NotesView.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects  // 添加这行来支持 DropShadow
import storyScience 1.0
import Qt5Compat.GraphicalEffects

Item {
    id: root

    // 显示模式枚举
    enum ViewMode {
        Timeline,
        Carousel
    }

    property int currentViewMode: NotesView.ViewMode.Timeline
    property alias carouselModel: carouselCardModel
    property bool notesLoaded: false
    // 预设分类供选择
    property var presetCategories: [
        qsTr("学习"), qsTr("工作"), qsTr("创作"), qsTr("生活"),
        qsTr("读书"), qsTr("灵感"), qsTr("待办"), qsTr("想法")
    ]

    // 信号
    signal noteAdded(var noteData)
    signal noteDeleted(int index)
    signal noteClicked(int index, var noteData)

    function dirname(path) {
        if (typeof path !== "string") {
            console.error("dirname: expected string, got", typeof path, path);
            return "";
        }
        const i = Math.max(path.lastIndexOf('/'), path.lastIndexOf('\\'));
        return i > 0 ? path.substring(0, i) : '';
    }

    function loadNotes() {
        // 如果需要强制重新加载，可以调用carouselCardModel.resetLoadedState()
        // 如果已经加载过笔记，则不再重复加载
        if (notesLoaded) {
            //console.log("笔记已加载，跳过重复加载");
            return;
        }

        const projectPath = DataManager.currentProjectPath(); // 注意这里要加括号！
        if (!projectPath || projectPath.length === 0) {
            //console.log("项目路径为空，不加载笔记");
            return;
        }
        const dir = dirname(projectPath);
        carouselCardModel.loadFromFile(dir);

        // 标记为已加载
        notesLoaded = true;
    }

    // 背景渐变
    Rectangle {
        anchors.fill: parent

        gradient: Gradient {
            GradientStop { position: 0.0; color: Style.windowBg }
            GradientStop { position: 1.0; color: Qt.lighter(Style.windowBg, 1.02) }
        }

        // 微妙的阴影效果
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 2
            radius: 8
            samples: 16
            color: Qt.rgba(0, 0, 0, 0.05)
            cached: true
        }

        Behavior on color {
            ColorAnimation {
                duration: Style.transitionDuration
                easing.type: Style.ease
            }
        }
    }

    // 主布局
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 20

        // 顶部工具栏
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            radius: Style.radius
            color: Qt.rgba(Style.primary.r, Style.primary.g, Style.primary.b, 0.05)
            border.color: Qt.rgba(Style.primary.r, Style.primary.g, Style.primary.b, 0.1)
            border.width: 1

            RowLayout {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 16

                // 标题区域
                RowLayout {
                    spacing: 12
                    // 标题
                    Text {
                        text: qsTr("随手笔记")
                        font.pixelSize: 20
                        font.weight: Font.Bold
                        color: Style.text
                    }
                }

                Item { Layout.fillWidth: true }

                // 视图模式切换按钮组
                Rectangle {
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 36
                    radius: 18
                    color: Style.panelBg
                    border.color: Style.border
                    border.width: 1

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 2
                        spacing: 0

                        ButtonGroup {
                            id: viewModeGroup
                        }

                        Button {
                            id: timelineButton
                            objectName: "timelineButton"
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            text: qsTr("时间轴")
                            checkable: true
                            checked: currentViewMode === NotesView.ViewMode.Timeline
                            ButtonGroup.group: viewModeGroup

                            background: Rectangle {
                                radius: 16
                                color: timelineButton.checked ? Style.primary : "transparent"

                                Behavior on color {
                                    ColorAnimation { duration: 200 }
                                }
                            }

                            contentItem: Text {
                                text: timelineButton.text
                                color: timelineButton.checked ? "white" : Style.text
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pixelSize: 13
                                font.weight: Font.Medium

                                Behavior on color {
                                    ColorAnimation { duration: 200 }
                                }
                            }

                            onClicked: {
                                currentViewMode = NotesView.ViewMode.Timeline
                            }
                        }

                        Button {
                            objectName: "carouselButton"
                            id: carouselButton
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            text: qsTr("轮播图")
                            checkable: true
                            checked: currentViewMode === NotesView.ViewMode.Carousel
                            ButtonGroup.group: viewModeGroup

                            background: Rectangle {
                                radius: 16
                                color: carouselButton.checked ? Style.primary : "transparent"

                                Behavior on color {
                                    ColorAnimation { duration: 200 }
                                }
                            }

                            contentItem: Text {
                                text: carouselButton.text
                                color: carouselButton.checked ? "white" : Style.text
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pixelSize: 13
                                font.weight: Font.Medium

                                Behavior on color {
                                    ColorAnimation { duration: 200 }
                                }
                            }

                            onClicked: {
                                currentViewMode = NotesView.ViewMode.Carousel
                            }
                        }
                    }
                }

                // 添加笔记按钮
                Button {
                    objectName: "addNoteButton"
                    id: addNoteButton
                    text: qsTr("+ 添加笔记")
                    Layout.preferredHeight: 36

                    background: Rectangle {
                        radius: 18
                        color: addNoteButton.hovered ? Style.buttonPrimaryBgHover : Style.buttonPrimaryBg
                        border.color: "transparent"

                        // 微妙的阴影
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

                        Behavior on color {
                            ColorAnimation { duration: 200 }
                        }
                    }

                    contentItem: Text {
                        text: addNoteButton.text
                        color: Style.buttonPrimaryText
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 13
                        font.weight: Font.Medium
                    }

                    onClicked: {
                        addNoteDialog.open()
                    }
                }
            }
        }

        // 内容区域
        StackLayout {
            id: contentStack
            Layout.fillWidth: true
            Layout.fillHeight: true
            currentIndex: currentViewMode

            // 时间轴视图
            TimelineOverview {
                id: timelineView
                model: carouselCardModel

                onNodeClicked: function(index) {
                    var noteData = carouselCardModel.getCard(index)
                    root.noteClicked(index, noteData)

                    // 精准跳转到轮播图对应位置
                    if (currentViewMode === NotesView.ViewMode.Carousel) {
                        carouselView.goToIndex(index)
                    } else {
                        // 如果当前在时间轴模式，切换到轮播图模式并跳转
                        currentViewMode = NotesView.ViewMode.Carousel
                        Qt.callLater(function() {
                            carouselView.goToIndex(index)
                        })
                    }
                }
            }

            // 轮播图视图
            ModernCarouselView {
                id: carouselView
                model: carouselCardModel

                onCardClicked: function(index, cardData) {
                    root.noteClicked(index, cardData)
                }

                onCardDoubleClicked: function(index, cardData) {
                    // 双击编辑笔记
                    editNoteDialog.currentIndex = index
                    editNoteDialog.loadNoteData(cardData)
                    editNoteDialog.open()
                }
            }

            // MouseArea{
            //     Layout.fillWidth: true
            //     Layout.fillHeight: true
            //     cursorShape: Qt.ArrowCursor
            //     acceptedButtons: Qt.ForwardButton | Qt.BackButton  // 只接受左键和后退键
            //     // 鼠标后退键
            //     onPressed: (mouse) => {
            //         if (mouse.button === Qt.BackButton) {
            //             if (currentViewMode === NotesView.ViewMode.Carousel){
            //                 currentViewMode = NotesView.ViewMode.Timeline
            //             }
            //         }else{
            //             if(currentViewMode === NotesView.ViewMode.Timeline)
            //                 currentViewMode = NotesView.ViewMode.Carousel
            //         }
            //     }
            // }
        }
    }

    // 数据模型
    CarouselCardModel {
        id: carouselCardModel

        onCardAdded: function(index) {
            // 将C++结构体转为QML可用的纯JS对象，避免undefined问题
            var c = carouselCardModel.getCard(index)
            var noteData = {
                id: c.id || "",
                title: c.title || "",
                description: c.description || "",
                content: c.content || "",
                category: c.category || "",
                priority: c.priority !== undefined ? c.priority : 0,
                isActive: c.isActive !== undefined ? c.isActive : true
            }
            root.noteAdded(noteData)
        }

        onCardRemoved: function(index) {
            root.noteDeleted(index)
        }
    }

    // 添加笔记对话框
    Dialog {
        id: addNoteDialog
        title: qsTr("添加新笔记")
        width: 520
        height: 580
        anchors.centerIn: parent
        modal: true

        // 添加自定义背景和样式
        background: Rectangle {
            color: Style.panelBg
            border.color: Style.panelBorder
            border.width: Style.borderWidth
            radius: Style.radiusMedium

            // 添加阴影效果
            layer.enabled: true
            layer.effect: DropShadow {
                horizontalOffset: 0
                verticalOffset: 4
                radius: 8
                samples: 16
                color: Style.shadow
            }
        }

        // 自定义标题栏样式
        header: Rectangle {
            color: Style.primary
            height: 40
            radius: Style.radiusMedium
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top

            Label {
                text: addNoteDialog.title
                color: Style.textOnPrimary
                font: Style.titleFont
                anchors.centerIn: parent
            }
        }

        // 自定义按钮栏样式
        footer: Rectangle {
            color: Style.panelBg
            height: 50
            radius: Style.radiusMedium
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            RowLayout {
                anchors.centerIn: parent
                spacing: Style.spacing

                Button {
                    text: qsTr("取消")
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 40
                    flat: true

                    background: Rectangle {
                        color: {
                            if (parent.pressed) return Style.buttonGhostBgPressed;
                            else if (parent.hovered) return Style.buttonGhostBgHover;
                            else return Style.buttonGhostBg;
                        }
                        border.color: Style.buttonGhostBorder
                        radius: Style.buttonRadius
                        Behavior on color { ColorAnimation { duration: Style.transitionDuration } }
                    }
                    contentItem: Text {
                        text: parent.text
                        color: Style.buttonGhostText
                        font: Style.buttonFont
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            addNoteDialog.close()
                            addNoteDialog.clearFields()
                        }
                    }
                }

                Button {
                    text: qsTr("添加")
                    enabled: titleField.text.trim() !== ""
                    Layout.preferredWidth: 120
                    Layout.preferredHeight: 40
                    flat: true

                    background: Rectangle {
                        color: {
                            if (!parent.enabled) return Style.buttonDisabledBg;
                            else if (parent.pressed) return Style.buttonPrimaryBgPressed;
                            else if (parent.hovered) return Style.buttonPrimaryBgHover;
                            else return Style.buttonPrimaryBg;
                        }
                        border.color: parent.enabled ? Style.buttonPrimaryBorder : Style.buttonDisabledBorder
                        radius: Style.buttonRadius
                        Behavior on color { ColorAnimation { duration: Style.transitionDuration } }
                    }
                    contentItem: Text {
                        text: parent.text
                        color: parent.enabled ? Style.buttonPrimaryText : Style.buttonDisabledText
                        font: Style.buttonFont
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            // 使用模型的完整数据重载一次性添加
                            var noteId = "note_" + Date.now()
                            var categoryText = (categoryField.editable ? categoryField.editText : categoryField.currentText) || ""
                            var cardMap = {
                                id: noteId,
                                title: titleField.text.trim(),
                                description: contentField.text.trim(),
                                content: contentField.text.trim(),
                                category: categoryText.trim(),
                                priority: Math.round(prioritySlider.value),
                                isActive: true,
                                iconName: "note"
                            }
                            carouselCardModel.addCard(cardMap)

                            addNoteDialog.close()
                            addNoteDialog.clearFields()
                        }
                    }
                }
            }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: Style.padding
            spacing: Style.spacing


            ColumnLayout {
                spacing: Style.spacingSmall

                Text {
                    text: qsTr("标题")
                    font: Style.labelFont
                    color: Style.text
                }

                TextField {
                    id: titleField
                    Layout.fillWidth: true
                    font: Style.bodyFont
                    color: Style.text
                    selectionColor: Style.selection
                    selectedTextColor: Style.text
                    placeholderTextColor: Style.textDim

                    // 移除inset设置，使用padding来控制内边距
                    leftPadding: Style.paddingSmall
                    rightPadding: Style.paddingSmall
                    topPadding: Style.paddingSmall
                    bottomPadding: Style.paddingSmall

                    // 使用Style.qml中的输入框样式
                    background: Rectangle {
                        color: Style.textFieldBg
                        border.color: titleField.activeFocus ? Style.textFieldBorderFocus : Style.textFieldBorder
                        border.width: Style.borderWidth
                        radius: Style.textFieldRadius
                        Behavior on border.color { ColorAnimation { duration: Style.transitionDuration } }
                    }
                }
            }


            ColumnLayout {
                spacing: Style.spacingSmall
                Text {
                    text: qsTr("分类")
                    font: Style.labelFont
                    color: Style.text
                }

                // 分类选择（支持预设 + 可编辑）
                ComboBox {
                    id: categoryField
                    Layout.fillWidth: true
                    editable: true
                    font: Style.bodyFont
                    model: presetCategories.concat(carouselCardModel.getCategories())

                    // 占位提示
                    contentItem: TextField {
                        text: categoryField.editable ? categoryField.editText : categoryField.currentText
                        font: Style.bodyFont
                        color: Style.text
                        selectionColor: Style.selection
                        selectedTextColor: Style.text
                        placeholderTextColor: Style.textDim

                        // 移除inset设置，使用padding来控制内边距
                        leftPadding: Style.paddingSmall
                        rightPadding: Style.paddingSmall + (categoryField.indicator ? categoryField.indicator.width + Style.spacingSmall : 0) + 5
                        topPadding: Style.paddingSmall
                        bottomPadding: Style.paddingSmall

                        // 使用Style.qml中的输入框样式
                        background: Rectangle {
                            color: "transparent" // 背景透明，使用ComboBox的背景
                        }
                    }

                    // 下拉按钮样式
                    indicator: Canvas {
                        id: categoryFieldIndicator
                        x: categoryField.width - width - categoryField.rightPadding + 15
                        y: (categoryField.height - height) / 2
                        width: 20
                        height: 20
                        contextType: "2d"
                        onPaint: {
                            var ctx = getContext("2d")
                            ctx.fillStyle = categoryField.hovered ? Style.primary : Style.comboBoxArrow
                            ctx.beginPath()
                            // 绘制向下箭头
                            ctx.moveTo(width * 0.3, height * 0.4)
                            ctx.lineTo(width * 0.7, height * 0.4)
                            ctx.lineTo(width * 0.5, height * 0.7)
                            ctx.closePath()
                            ctx.fill()
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onPressed: categoryField.popup.open()
                        }
                    }

                    // 下拉框背景样式
                    background: Rectangle {
                        color: categoryField.hovered ? Qt.darker(Style.comboBoxBg, 1.1) : Style.comboBoxBg
                        border.color: categoryField.activeFocus ? Style.comboBoxBorderFocus : (categoryField.hovered ? Style.primary : Style.comboBoxBorder)
                        border.width: Style.borderWidth
                        radius: Style.comboBoxRadius
                        Behavior on color { ColorAnimation { duration: Style.transitionDuration } }
                        Behavior on border.color { ColorAnimation { duration: Style.transitionDuration } }
                    }
                   
                }
            }

            // 优先级选择（影响卡片左下角圆点数量/颜色）
            ColumnLayout {
                spacing: Style.spacingSmall

                Text {
                    text: qsTr("优先级")
                    font: Style.labelFont
                    color: Style.text
                }

                Slider {
                    id: prioritySlider
                    Layout.fillWidth: true
                    from: 0
                    to: 5
                    stepSize: 1
                    value: 3

                    background: Rectangle {
                        x: prioritySlider.leftPadding
                        y: prioritySlider.topPadding + prioritySlider.availableHeight / 2 - height / 2
                        implicitWidth: 200
                        implicitHeight: Style.sliderGrooveHeight
                        width: prioritySlider.availableWidth
                        height: implicitHeight
                        radius: Style.sliderGrooveHeight / 2
                        color: Style.sliderGroove

                        Rectangle {
                            width: prioritySlider.visualPosition * parent.width
                            height: parent.height
                            color: Style.sliderFill
                            radius: Style.sliderGrooveHeight / 2
                        }
                    }

                    handle: Rectangle {
                        x: prioritySlider.leftPadding + prioritySlider.visualPosition * (prioritySlider.availableWidth - width)
                        y: prioritySlider.topPadding + prioritySlider.availableHeight / 2 - height / 2
                        implicitWidth: Style.sliderHandleSize
                        implicitHeight: Style.sliderHandleSize
                        radius: Style.sliderHandleSize / 2
                        color: prioritySlider.pressed ? Style.sliderHandlePressed : (prioritySlider.hovered ? Style.sliderHandleHover : Style.sliderHandle)
                        border.color: Style.primary
                        border.width: 2

                        Behavior on color {
                            ColorAnimation { duration: Style.transitionDuration }
                        }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: prioritySlider.value.toString()
                        font: Style.bodyFont
                        color: Style.text
                    }
                }
            }


            ColumnLayout {
                spacing: Style.spacingSmall

                Text {
                    text: qsTr("内容")
                    font: Style.labelFont
                    color: Style.text
                }

                ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true

                    ScrollBar.vertical.policy: ScrollBar.AsNeeded
                    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                    TextArea {
                        id: contentField
                        wrapMode: TextArea.Wrap
                        selectByMouse: true
                        font: Style.bodyFont
                        color: Style.text
                        selectionColor: Style.selection
                        selectedTextColor: Style.text
                        placeholderTextColor: Style.textDim

                        // 移除inset设置，使用padding来控制内边距
                        leftPadding: Style.padding
                        rightPadding: Style.padding
                        topPadding: Style.padding
                        bottomPadding: Style.padding

                        // 使用Style.qml中的输入框样式
                        background: Rectangle {
                            color: Style.textFieldBg
                            border.color: contentField.activeFocus ? Style.textFieldBorderFocus : Style.textFieldBorder
                            border.width: Style.borderWidth
                            radius: Style.textFieldRadius
                            Behavior on border.color { ColorAnimation { duration: Style.transitionDuration } }
                        }
                    }
                }
            }
        }

        function clearFields() {
            titleField.text = ""
            if (categoryField.editable) { categoryField.editText = "" }
            contentField.text = ""
            prioritySlider.value = 3
        }
    }

    // 编辑笔记对话框
    Dialog {
        id: editNoteDialog
        title: qsTr("编辑笔记")
        width: 520
        height: 620
        anchors.centerIn: parent
        modal: true

        property int currentIndex: -1

        // 添加自定义背景和样式
        background: Rectangle {
            color: Style.panelBg
            border.color: Style.panelBorder
            border.width: Style.borderWidth
            radius: Style.radiusMedium

            // 添加阴影效果
            layer.enabled: true
            layer.effect: DropShadow {
                horizontalOffset: 0
                verticalOffset: 4
                radius: 8
                samples: 16
                color: Style.shadow
            }
        }

        // 自定义标题栏样式
        header: Rectangle {
            color: Style.primary
            height: 40
            radius: Style.radiusMedium
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top

            Label {
                text: editNoteDialog.title
                color: Style.textOnPrimary
                font: Style.titleFont
                anchors.centerIn: parent
            }
        }

        // 自定义按钮栏样式
        footer: Rectangle {
            color: Style.panelBg
            height: 50
            radius: Style.radiusMedium
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            RowLayout {
                anchors.centerIn: parent
                spacing: Style.spacing

                Button {
                    text: qsTr("删除")
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 40
                    flat: true

                    background: Rectangle {
                        color: {
                            if (parent.pressed) return Qt.darker(Style.buttonGhostBgPressed, 1.2);
                            else if (parent.hovered) return Style.buttonGhostBgHover;
                            else return Style.buttonGhostBg;
                        }
                        border.color: Style.buttonGhostBorder
                        radius: Style.buttonRadius
                        Behavior on color { ColorAnimation { duration: Style.transitionDuration } }
                    }
                    contentItem: Text {
                        text: parent.text
                        color: Style.error  // 删除按钮使用错误色
                        font: Style.buttonFont
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            if (editNoteDialog.currentIndex >= 0) {
                                carouselCardModel.removeCard(editNoteDialog.currentIndex)
                                editNoteDialog.close()
                            }
                        }
                    }
                }

                Item { Layout.fillWidth: true }

                Button {
                    text: qsTr("取消")
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 40
                    flat: true

                    background: Rectangle {
                        color: {
                            if (parent.pressed) return Style.buttonGhostBgPressed;
                            else if (parent.hovered) return Style.buttonGhostBgHover;
                            else return Style.buttonGhostBg;
                        }
                        border.color: Style.buttonGhostBorder
                        radius: Style.buttonRadius
                        Behavior on color { ColorAnimation { duration: Style.transitionDuration } }
                    }
                    contentItem: Text {
                        text: parent.text
                        color: Style.buttonGhostText
                        font: Style.buttonFont
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    // 添加鼠标区域来检测hover和pressed状态
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            editNoteDialog.close()
                        }
                    }
                }

                Button {
                    text: qsTr("保存")
                    enabled: editTitleField.text.trim() !== ""
                    Layout.preferredWidth: 120
                    Layout.preferredHeight: 40
                    flat: true

                    background: Rectangle {
                        color: {
                            if (!parent.enabled) return Style.buttonDisabledBg;
                            else if (parent.pressed) return Style.buttonPrimaryBgPressed;
                            else if (parent.hovered) return Style.buttonPrimaryBgHover;
                            else return Style.buttonPrimaryBg;
                        }
                        border.color: parent.enabled ? Style.buttonPrimaryBorder : Style.buttonDisabledBorder
                        radius: Style.buttonRadius
                        Behavior on color { ColorAnimation { duration: Style.transitionDuration } }
                    }
                    contentItem: Text {
                        text: parent.text
                        color: parent.enabled ? Style.buttonPrimaryText : Style.buttonDisabledText
                        font: Style.buttonFont
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    // 添加鼠标区域来检测hover和pressed状态
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            if (editNoteDialog.currentIndex >= 0) {
                                var originalCard = carouselCardModel.getCard(editNoteDialog.currentIndex);
                                if (!originalCard) {
                                    console.warn("Failed to get card at index", editNoteDialog.currentIndex);
                                    return;
                                }
                                var updatedCard = {
                                    id: originalCard.id,
                                    title: editTitleField.text.trim(),
                                    content: editContentField.text.trim(),
                                    category: editCategoryField.text.trim(),
                                    description: originalCard.description,
                                    imageUrl: originalCard.imageUrl,
                                    iconName: originalCard.iconName,
                                    priority: originalCard.priority,
                                    isActive: originalCard.isActive,
                                    timestamp: originalCard.timestamp,
                                    metadata: originalCard.metadata
                                };

                                console.log("Saving card:", JSON.stringify(updatedCard));
                                carouselCardModel.updateCard(editNoteDialog.currentIndex, updatedCard);
                                editNoteDialog.close();
                            }
                        }
                    }
                }
            }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: Style.padding
            spacing: Style.spacing

            // 标题输入区域
            ColumnLayout {
                spacing: Style.spacingSmall

                Text {
                    text: qsTr("标题")
                    font: Style.labelFont
                    color: Style.text
                }

                TextField {
                    id: editTitleField
                    Layout.fillWidth: true
                    font: Style.bodyFont
                    color: Style.text
                    selectionColor: Style.selection
                    selectedTextColor: Style.text
                    placeholderTextColor: Style.textDim

                    // 移除inset设置，使用padding来控制内边距
                    leftPadding: Style.paddingSmall
                    rightPadding: Style.paddingSmall
                    topPadding: Style.paddingSmall
                    bottomPadding: Style.paddingSmall

                    // 使用Style.qml中的输入框样式
                    background: Rectangle {
                        color: Style.textFieldBg
                        border.color: editTitleField.activeFocus ? Style.textFieldBorderFocus : Style.textFieldBorder
                        border.width: Style.borderWidth
                        radius: Style.textFieldRadius
                        Behavior on border.color { ColorAnimation { duration: Style.transitionDuration } }
                    }
                }
            }


            // 分类输入区域

            ColumnLayout {
                spacing: Style.spacingSmall

                Text {
                    text: qsTr("分类")
                    font: Style.labelFont
                    color: Style.text
                }

                TextField {
                    id: editCategoryField
                    Layout.fillWidth: true
                    font: Style.bodyFont
                    color: Style.text
                    selectionColor: Style.selection
                    selectedTextColor: Style.text
                    placeholderTextColor: Style.textDim

                    // 移除inset设置，使用padding来控制内边距
                    leftPadding: Style.paddingSmall
                    rightPadding: Style.paddingSmall
                    topPadding: Style.paddingSmall
                    bottomPadding: Style.paddingSmall

                    // 使用Style.qml中的输入框样式
                    background: Rectangle {
                        color: Style.textFieldBg
                        border.color: editCategoryField.activeFocus ? Style.textFieldBorderFocus : Style.textFieldBorder
                        border.width: Style.borderWidth
                        radius: Style.textFieldRadius
                        Behavior on border.color { ColorAnimation { duration: Style.transitionDuration } }
                    }
                }
            }


            // 内容输入区域
            ColumnLayout {
                spacing: Style.spacingSmall

                Text {
                    text: qsTr("内容")
                    font: Style.labelFont
                    color: Style.text
                }

                ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true

                    ScrollBar.vertical.policy: ScrollBar.AsNeeded
                    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                    TextArea {
                        id: editContentField
                        wrapMode: TextArea.Wrap
                        selectByMouse: true
                        font: Style.bodyFont
                        color: Style.text
                        selectionColor: Style.selection
                        selectedTextColor: Style.text
                        placeholderTextColor: Style.textDim

                        // 移除inset设置，使用padding来控制内边距
                        leftPadding: Style.padding
                        rightPadding: Style.padding
                        topPadding: Style.padding
                        bottomPadding: Style.padding

                        // 使用Style.qml中的输入框样式
                        background: Rectangle {
                            color: Style.textFieldBg
                            border.color: editContentField.activeFocus ? Style.textFieldBorderFocus : Style.textFieldBorder
                            border.width: Style.borderWidth
                            radius: Style.textFieldRadius
                            Behavior on border.color { ColorAnimation { duration: Style.transitionDuration } }
                        }
                    }
                }
            }
        }

        function loadNoteData(noteData) {
            editTitleField.text = noteData.title || ""
            editCategoryField.text = noteData.category || ""
            editContentField.text = noteData.content || ""
        }
    }

    // 键盘快捷键
    Keys.onPressed: function(event) {
        if (event.modifiers & Qt.ControlModifier) {
            if (event.key === Qt.Key_N) {
                // Ctrl+N 添加新笔记
                addNoteDialog.open()
                event.accepted = true
            }
        }
    }

    Component.onCompleted: {
        //console.log("初始化完成")
        // 确保焦点以接收键盘事件
        forceActiveFocus()
    }
}
