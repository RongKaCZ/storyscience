// TopBar.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Dialogs
import StoryType 1.0
import storyScience 1.0

Rectangle {
    id: topBar
    implicitHeight: Style.topBarHeight
    color: Style.windowBg
    Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
    property Window window: Window.window

    signal showWriterView();
    signal showGraphView();
    signal showOutlineView();      // 新增大纲视图信号
    signal showWorldbuildingView(); // 新增世界观视图信号
    signal showNotesView();        // 新增随手笔记视图信号
    signal lastOpenedFilePathChanged(string path);
    signal showSettings(); // 新增显示设置页面信号
    signal toggleReaderView(); // 新增切换阅读视图信号
    signal enterImmersiveMode(); // 新增进入沉浸式写作模式信号
    signal tutorialRequested(); // 新增请求显示教程信号
    signal advancedTutorialRequested(); // 新增请求显示高级教程信号
    signal showkeyDetails();
    // 防止空指针访问的安全属性
    readonly property bool windowAvailable: window !== null
    readonly property bool isMaximized: windowAvailable && (window.visibility === Window.Maximized)
    signal languageChanged(string language)
    signal saveData()
    signal showDonate()

    function switchNavBarIndex(current){
        if(current == 4) return; // 读者视角不在导航栏显示
        else if(current == 5) current--; // 如果是时间轴视图，索引减一显示
        navBar.currentIndex = current;
    }

    // 查找 EditorArea 组件的函数
    function findEditorArea() {
        // 从父级开始查找
        var parentItem = topBar.parent;
        while (parentItem) {
            // 查找名为 "writerView" 的子项
            if (parentItem.objectName === "writerView" || parentItem.toString().indexOf("writerView") !== -1) {
                // 在 writerView 中查找 EditorArea
                return findChildByType(parentItem, "EditorArea");
            }
            parentItem = parentItem.parent;
        }
        return null;
    }

    function ctrl_s_shortcut_activated() {
        if (DataManager.currentProjectPath() && DataManager.currentProjectPath().length > 0) {
            saveData();
            var result = DataManager.saveProject(DataManager.currentProjectPath())
            if (result) {
                ////console.log("快速保存成功")
            } else {
                console.error("快速保存失败")
            }
        } else {
            // 如果没有项目路径，则调用另存为
            saveAsButton.clicked()
        }
    }

    // 递归查找指定类型的子项
    function findChildByType(parent, typeName) {
        if (!parent || !parent.children) {
            return null;
        }

        for (var i = 0; i < parent.children.length; i++) {
            var child = parent.children[i];
            // 检查对象类型
            if (child.toString().indexOf(typeName) !== -1) {
                return child;
            }
            // 递归查找子项
            var found = findChildByType(child, typeName);
            if (found) {
                return found;
            }
        }
        return null;
    }

    // Component.onDestruction:{
    //     executeProjectSave();
    // }


    MouseArea {
        anchors.fill: parent
        propagateComposedEvents: false
        onPressed: mouse => {
            if (topBar.windowAvailable) {
                window.startSystemMove()
            }
            mouse.accepted = true
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: Style.padding
        anchors.rightMargin: Style.paddingSmall
        spacing: Style.spacing

        // 左侧 Logo + 标题
        RowLayout {
            objectName: "logoAndTitle"
            spacing: Style.spacing
            Layout.alignment: Qt.AlignVCenter
            Image {
                //anchors.fill: parent
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                source: "qrc:/icons/StorySciencePng2.png"
                fillMode: Image.PreserveAspectFit
            }
            Label {
                text: "Story Science"
                font: Style.titleFont
                color: Style.text
            }
        }

        // 中间导航
        TabBar {
            id: navBar
            Layout.fillWidth: true; Layout.alignment: Qt.AlignVCenter
            currentIndex: 0
            background: Rectangle {
                color: Style.tabBarBg
                Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
            }

            TabButton {
                id: tabButton1
                objectName:"writerView"
                text: qsTr("写作");
                font.weight: navBar.currentIndex===0?Font.DemiBold:Font.Normal
                onClicked: {
                    showWriterView();
                }
                background: Rectangle {
                    color: navBar.currentIndex===0 ? Style.tabButtonBgActive : (tabButtonMouseArea.containsMouse ? Style.tabButtonBgHover : Style.tabButtonBg)
                    Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }

                    Rectangle {
                        height: 3
                        radius: Style.radiusSmall
                        color: navBar.currentIndex===0 ? Style.primary : "transparent"
                        anchors {
                            left: parent.left
                            right: parent.right
                            bottom: parent.bottom
                        }
                        Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
                    }
                }
                contentItem: Text {
                    text: tabButton1.text
                    font: tabButton1.font
                    color: navBar.currentIndex===0 ? Style.tabButtonTextActive : Style.tabButtonText
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
                }

                MouseArea {
                    id: tabButtonMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    acceptedButtons: Qt.NoButton
                }
            }
            TabButton {
                id: tabButton2
                objectName: "graphView"
                text: qsTr("图谱");
                font.weight: navBar.currentIndex===1?Font.DemiBold:Font.Normal
                onClicked: {
                    showGraphView();
                }
                background: Rectangle {
                    color: navBar.currentIndex===1 ? Style.tabButtonBgActive : (tabButtonMouseArea2.containsMouse ? Style.tabButtonBgHover : Style.tabButtonBg)
                    Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }

                    Rectangle {
                        height: 3
                        radius: Style.radiusSmall
                        color: navBar.currentIndex===1 ? Style.primary : "transparent"
                        anchors {
                            left: parent.left
                            right: parent.right
                            bottom: parent.bottom
                        }
                        Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
                    }
                }
                contentItem: Text {
                    text: tabButton2.text
                    font: tabButton2.font
                    color: navBar.currentIndex===1 ? Style.tabButtonTextActive : Style.tabButtonText
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
                }

                MouseArea {
                    id: tabButtonMouseArea2
                    anchors.fill: parent
                    hoverEnabled: true
                    acceptedButtons: Qt.NoButton
                }
            }
            TabButton {
                id: tabButton3
                objectName: "outlineView"
                text: qsTr("大纲");
                font.weight: navBar.currentIndex===2?Font.DemiBold:Font.Normal
                onClicked: {
                    showOutlineView();
                }
                background: Rectangle {
                    color: navBar.currentIndex===2 ? Style.tabButtonBgActive : (tabButtonMouseArea3.containsMouse ? Style.tabButtonBgHover : Style.tabButtonBg)
                    Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }

                    Rectangle {
                        height: 3
                        radius: Style.radiusSmall
                        color: navBar.currentIndex===2 ? Style.primary : "transparent"
                        anchors {
                            left: parent.left
                            right: parent.right
                            bottom: parent.bottom
                        }
                        Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
                    }
                }
                contentItem: Text {
                    text: tabButton3.text
                    font: tabButton3.font
                    color: navBar.currentIndex===2 ? Style.tabButtonTextActive : Style.tabButtonText
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
                }

                MouseArea {
                    id: tabButtonMouseArea3
                    anchors.fill: parent
                    hoverEnabled: true
                    acceptedButtons: Qt.NoButton
                }
            }
            TabButton {
                id: tabButton4
                objectName: "buildingView"
                text: qsTr("世界观");
                font.weight: navBar.currentIndex===3?Font.DemiBold:Font.Normal
                onClicked: {
                    showWorldbuildingView();
                }
                background: Rectangle {
                    color: navBar.currentIndex===3 ? Style.tabButtonBgActive : (tabButtonMouseArea4.containsMouse ? Style.tabButtonBgHover : Style.tabButtonBg)
                    Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }

                    Rectangle {
                        height: 3
                        radius: Style.radiusSmall
                        color: navBar.currentIndex===3 ? Style.primary : "transparent"
                        anchors {
                            left: parent.left
                            right: parent.right
                            bottom: parent.bottom
                        }
                        Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
                    }
                }
                contentItem: Text {
                    text: tabButton4.text
                    font: tabButton4.font
                    color: navBar.currentIndex===3 ? Style.tabButtonTextActive : Style.tabButtonText
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
                }

                MouseArea {
                    id: tabButtonMouseArea4
                    anchors.fill: parent
                    hoverEnabled: true
                    acceptedButtons: Qt.NoButton
                }
            }
            TabButton {
                id: tabButton5
                objectName: "notesView"
                text: qsTr("随手笔记");
                font.weight: navBar.currentIndex===4?Font.DemiBold:Font.Normal
                onClicked: {
                    showNotesView();
                }
                background: Rectangle {
                    color: navBar.currentIndex===4 ? Style.tabButtonBgActive : (tabButtonMouseArea5.containsMouse ? Style.tabButtonBgHover : Style.tabButtonBg)
                    Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }

                    Rectangle {
                        height: 3
                        radius: Style.radiusSmall
                        color: navBar.currentIndex===4 ? Style.primary : "transparent"
                        anchors {
                            left: parent.left
                            right: parent.right
                            bottom: parent.bottom
                        }
                        Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
                    }
                }
                contentItem: Text {
                    text: tabButton5.text
                    font: tabButton5.font
                    color: navBar.currentIndex===4 ? Style.tabButtonTextActive : Style.tabButtonText
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
                }

                MouseArea {
                    id: tabButtonMouseArea5
                    anchors.fill: parent
                    hoverEnabled: true
                    acceptedButtons: Qt.NoButton
                }
            }
        }

        // 数据持久化按钮
        RowLayout {
            id: dataButtonsLayout
            spacing: Style.spacing
            Layout.alignment: Qt.AlignVCenter

            Button {
                id: newBook
                text: qsTr("新建")
                flat: true
                implicitHeight: Style.buttonHeight - 8
                ToolTip.text: qsTr("新建项目")
                ToolTip.visible: hovered
                background: Rectangle {
                    color: newBook.hovered ? Style.buttonPrimaryBgHover : Style.buttonPrimaryBg
                    border.color: "transparent"
                    border.width: 1
                    radius: Style.radius
                }
                contentItem: Label {
                    text: newBook.text
                    font: newBook.font
                    color: Style.buttonPrimaryText
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    // 弹出输入对话框让用户输入项目名称
                    projectNameDialog.open()
                }
            }

            // 快速保存按钮（触发30s内保存）
            Button {
                id: quickSaveButton
                text: qsTr("保存")
                flat: true
                implicitHeight: Style.buttonHeight - 8
                enabled: DataManager.hasUnsavedChanges
                ToolTip.text: qsTr("快速保存（立即保存当前项目）")
                ToolTip.visible: hovered
                background: Rectangle {
                    color: quickSaveButton.hovered ? Style.buttonPrimaryBgHover : (quickSaveButton.enabled ? Style.buttonPrimaryBg : Style.buttonDisabledBg)
                    border.color: "transparent"
                    border.width: 1
                    radius: Style.radius
                }
                contentItem: Label {
                    text: quickSaveButton.text
                    font: quickSaveButton.font
                    color: quickSaveButton.enabled ? Style.buttonPrimaryText : Style.buttonDisabledText
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    //console.log("点击了快速保存按钮,数据路径:",DataManager.currentProjectPath());
                    // 触发立即保存（如果有项目路径）
                    if (DataManager.currentProjectPath() && DataManager.currentProjectPath().length > 0) {
                        saveData();
                        var result = DataManager.saveProject(DataManager.currentProjectPath())
                        if (result) {
                            ////console.log("快速保存成功")
                        } else {
                            console.error("快速保存失败")
                        }
                    } else {
                        // 如果没有项目路径，则调用另存为
                        saveAsButton.clicked()
                    }
                }
            }

            Button {
                id: saveAsButton
                text: qsTr("另存为")
                flat: true
                implicitHeight: Style.buttonHeight - 8
                background: Rectangle {
                    color: saveAsButton.hovered ? Style.buttonPrimaryBgHover : (saveAsButton.enabled ? Style.buttonPrimaryBg : Style.buttonDisabledBg)
                    border.color: "transparent"
                    border.width: 1
                    radius: Style.radius
                }
                contentItem: Label {
                    text: saveAsButton.text
                    font: saveAsButton.font
                    color: saveAsButton.enabled ? Style.buttonPrimaryText : Style.buttonDisabledText
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    //console.log("点击了另存为按钮")
                    saveData()
                    // 设置文件对话框为保存模式
                    fileDialog.fileMode = FileDialog.SaveFile
                    fileDialog.operationType = "save"
                    fileDialog.nameFilters = ["StoryScience 项目 (*.ssp)"]
                    fileDialog.currentFile = "file://" + (DataManager.currentProjectPath() || "untitled.ssp")
                    fileDialog.open()
                }
            }

            Button {
                id: loadButton
                text: qsTr("加载")
                flat: true
                implicitHeight: Style.buttonHeight - 8
                background: Rectangle {
                    color: loadButton.hovered ? Style.buttonPrimaryBgHover : (loadButton.enabled ? Style.buttonPrimaryBg : Style.buttonDisabledBg)
                    border.color: "transparent"
                    border.width: 1
                    radius: Style.radius
                }
                contentItem: Label {
                    text: loadButton.text
                    font: loadButton.font
                    color: loadButton.enabled ? Style.buttonPrimaryText : Style.buttonDisabledText
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    //console.log("点击了加载按钮")
                    // 设置文件对话框为加载模式
                    fileDialog.fileMode = FileDialog.OpenFile
                    fileDialog.operationType = "load"
                    fileDialog.nameFilters = ["StoryScience 项目 (*.ssp)"]
                    fileDialog.open()
                }
            }
        }

        // 右侧按钮
        RowLayout {
            id: rightButtonsLayout
            spacing: 0; Layout.alignment: Qt.AlignVCenter

            ToolButton {
                id: settingButton
                objectName: "settingBtn"
                icon.source: Style.isDark ? "qrc:/icons/settingLight.png" : "qrc:/icons/settingBlack.png"
                implicitWidth: Style.iconSizeLarge
                implicitHeight: Style.topBarHeight
                ToolTip.text: qsTr("设置和视图选项")
                ToolTip.visible: settingButton.hovered

                background: Rectangle {
                    color: settingButton.hovered ? Style.hover : "transparent"
                    radius: Style.radiusLarge
                    Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
                }

                contentItem: Image {
                    source: settingButton.icon.source
                    anchors.centerIn: parent
                    width: settingButton.width * 0.6
                    height: settingButton.height * 0.6
                    fillMode: Image.PreserveAspectFit
                }

                onClicked: {
                    // 点击按钮时显示下拉菜单
                    settingMenu.popup(settingButton)
                }

                // 下拉菜单
                Menu {
                    id: settingMenu
                    width: 180

                    background: Rectangle {
                        color: Style.panelBg
                        border.color: Style.border
                        border.width: 1
                        radius: Style.radius
                    }

                    // 设置菜单项
                    MenuItem {
                        id: settingsMenuItem
                        height: 40

                        contentItem: Row {
                            spacing: 10
                            anchors.verticalCenter: parent.verticalCenter

                            Image {
                                source: Style.isDark ? "qrc:/icons/settingLight.png" : "qrc:/icons/settingBlack.png"
                                width: 20
                                height: 20
                                anchors.verticalCenter: parent.verticalCenter
                                fillMode: Image.PreserveAspectFit
                            }

                            Text {
                                text: qsTr("设置")
                                color: Style.text
                                font.pixelSize: 14
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        background: Rectangle {
                            color: settingsMenuItem.hovered ? Style.hover : "transparent"
                            radius: Style.radiusSmall
                        }

                        onTriggered: {
                            showSettings() // 发出显示设置页面的信号
                        }
                    }

                    Menu{
                        id:helpMenu
                        title: qsTr("帮助")
                        width: 180
                        icon.source: Style.isDark ? "qrc:/icons/HelpLight.png" : "qrc:/icons/HelpBlack.png"
                        icon.width: 20
                        icon.height: 20
                        MenuItem{
                            id: tutorialMenuItem
                            text: qsTr("新手教程")
                            onTriggered: {
                                topBar.tutorialRequested()
                            }
                        }

                        MenuItem{
                            id: aboutMenuItem
                            text: qsTr("高级教程")
                            onTriggered: {
                                topBar.advancedTutorialRequested()
                            }
                        }

                        MenuItem{
                            id: shortcutMenuItem
                            text: qsTr("按键详细")
                            onTriggered: {
                                // 打开按键详细信息页面
                                topBar.showkeyDetails();
                            }
                        }
                    }

                    // 分隔线
                    MenuSeparator {
                        contentItem: Rectangle {
                            implicitHeight: 1
                            color: Style.border
                        }
                    }

                    // 添加沉浸式写作模式菜单项
                    MenuItem {
                        id: immersiveModeMenuItem
                        height: 40

                        contentItem: Row {
                            spacing: 10
                            anchors.verticalCenter: parent.verticalCenter

                            Image {
                                source: Style.isDark ? "qrc:/icons/writerLight.png" : "qrc:/icons/writerBlack.png"
                                width: 20
                                height: 20
                                anchors.verticalCenter: parent.verticalCenter
                                fillMode: Image.PreserveAspectFit
                            }

                            Text {
                                text: qsTr("沉浸式写作")
                                color: Style.text
                                font.pixelSize: 14
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        background: Rectangle {
                            color: immersiveModeMenuItem.hovered ? Style.hover : "transparent"
                            radius: Style.radiusSmall
                        }

                        onTriggered: {
                            if (typeof enterImmersiveMode !== 'undefined') {
                                window.showMaximized()
                                enterImmersiveMode()
                            }
                        }
                    }

                    Menu{
                        id:languageMenu
                        title: qsTr("语言")
                        width: 180
                        icon.source: Style.isDark ? "qrc:/icons/languageLight.png" : "qrc:/icons/languageBlack.png"
                        icon.width: 20
                        icon.height: 20
                        MenuItem{
                            id:zhMenuItem
                            text: qsTr("中文")
                            onTriggered: {
                                languageManager.selectLanguage("zh")
                                topBar.languageChanged("zh")
                                // 通知词典控件切换语言
                                var editorArea = findEditorArea()
                                if (editorArea && editorArea.vocabularyHelperPopup) {
                                    editorArea.vocabularyHelperPopup.switchLanguage("zh")
                                }
                            }
                        }

                        MenuItem{
                            id:enMenuItem
                            text: "English"
                            onTriggered: {
                                languageManager.selectLanguage("en")
                                topBar.languageChanged("en")
                                // 通知词典控件切换语言
                                var editorArea = findEditorArea()
                                if (editorArea && editorArea.vocabularyHelperPopup) {
                                    editorArea.vocabularyHelperPopup.switchLanguage("en")
                                }
                            }
                        }

                    }

                    // 分隔线
                    MenuSeparator {
                        contentItem: Rectangle {
                            implicitHeight: 1
                            color: Style.border
                        }
                    }


                    // 切换读者视角菜单项
                    MenuItem {
                        id: readerViewMenuItem
                        height: 40

                        contentItem: Row {
                            spacing: 10
                            anchors.verticalCenter: parent.verticalCenter

                            Image {
                                source: Style.isDark ? "qrc:/icons/readerLight.png" : "qrc:/icons/readerBlack.png"
                                width: 20
                                height: 20
                                anchors.verticalCenter: parent.verticalCenter
                                fillMode: Image.PreserveAspectFit
                            }

                            Text {
                                text: qsTr("切换读者视角")
                                color: Style.text
                                font.pixelSize: 14
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        background: Rectangle {
                            color: readerViewMenuItem.hovered ? Style.hover : "transparent"
                            radius: Style.radiusSmall
                        }

                        onTriggered: {
                            // 发出切换读者视角的信号
                            if (typeof toggleReaderView !== 'undefined') {
                                toggleReaderView()
                            } else {
                                console.log("切换读者视角功能")
                                // 如果没有定义信号，可以在这里直接实现切换逻辑
                            }
                        }
                    }


                    // 分隔线
                    MenuSeparator {
                        contentItem: Rectangle {
                            implicitHeight: 1
                            color: Style.border
                        }
                    }

                    //爱心捐赠
                    MenuItem {
                        id: donateAndSupportMenuItem
                        height: 40

                        contentItem: Row {
                            spacing: 10
                            anchors.verticalCenter: parent.verticalCenter

                            Image {
                                source: Style.isDark ? "qrc:/icons/donateLight.png" : "qrc:/icons/donateBlack.png"
                                width: 20
                                height: 20
                                anchors.verticalCenter: parent.verticalCenter
                                fillMode: Image.PreserveAspectFit
                            }

                            Text {
                                text: qsTr("爱心捐赠")
                                color: Style.text
                                font.pixelSize: 14
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        background: Rectangle {
                            color: donateAndSupportMenuItem.hovered ? Style.hover : "transparent"
                            radius: Style.radiusSmall
                        }

                        onTriggered: {
                            topBar.showDonate()
                        }
                    }
                }
            }

            ToolButton {
                id: themeToggle
                checkable: true;
                checked: Style.isDark
                icon.source: Style.isDark ? "qrc:/icons/lightTheme.png" : "qrc:/icons/darkTheme.png"
                implicitWidth: Style.iconSizeLarge; implicitHeight: Style.topBarHeight
                background: Rectangle {
                    color: themeToggle.hovered ? Style.hover : "transparent"
                    radius: Style.radiusSmall
                    Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
                }
                contentItem: Image {
                    source: themeToggle.icon.source
                    anchors.centerIn: parent
                    width: themeToggle.width
                    height: themeToggle.height
                    fillMode: Image.PreserveAspectFit
                }
                onClicked: {
                    Style.toggleTheme()
                }
                // 监听主题变化以更新按钮状态
                Connections {
                    target: Style
                    function onIsDarkChanged() {
                        themeToggle.checked = Style.isDark
                    }
                }
            }

            ToolButton {
                id: minimizeButton
                //text: "—"
                icon.source: Style.isDark ? "qrc:/icons/minxLight.png" : "qrc:/icons/minxBlack.png"
                implicitWidth: Style.iconSizeLarge
                implicitHeight: Style.topBarHeight
                enabled: topBar.windowAvailable
                background: Rectangle {
                    color: minimizeButton.hovered ? Style.hover : "transparent"
                    radius: Style.radiusSmall
                }
                contentItem: Image {
                    source: minimizeButton.icon.source
                    anchors.centerIn: parent
                    width: minimizeButton.width
                    height: minimizeButton.height
                    fillMode: Image.PreserveAspectFit
                }
                onClicked: {
                    if (topBar.windowAvailable) {
                        window.showMinimized()
                    }
                }
            }

            ToolButton {
                id: maximizeButton
                //text: topBar.isMaximized ? "❐" : "☐"
                icon.source: topBar.isMaximized ? (Style.isDark ? "qrc:/icons/minimisedLight.png" : "qrc:/icons/minimisedBlack.png") : (Style.isDark ? "qrc:/icons/maxxLight.png" : "qrc:/icons/maxxBlack.png")
                implicitWidth: Style.iconSizeLarge
                implicitHeight: Style.topBarHeight
                enabled: topBar.windowAvailable
                background: Rectangle {
                    color: maximizeButton.hovered ? Style.hover : "transparent"
                    radius: Style.radiusSmall
                }
                contentItem: Image {
                    source: maximizeButton.icon.source
                    anchors.centerIn: parent
                    width: maximizeButton.width
                    height: maximizeButton.height
                    fillMode: Image.PreserveAspectFit
                }
                onClicked: {
                    if (topBar.windowAvailable) {
                        if (topBar.isMaximized) {
                            window.showNormal()
                        } else {
                            window.showMaximized()
                        }
                    }
                }
            }

            ToolButton {
                id: closeButton
                icon.source: Style.isDark ? "qrc:/icons/closeLight.png" : "qrc:/icons/closeBlack.png"
                implicitWidth: Style.iconSizeLarge
                implicitHeight: Style.topBarHeight
                enabled: topBar.windowAvailable
                background: Rectangle {
                    color: closeButton.hovered ? Style.error : "transparent"
                    radius: Style.radiusSmall
                }
                contentItem: Image {
                    source: closeButton.icon.source
                    anchors.centerIn: parent
                    width: closeButton.width
                    height: closeButton.height
                    fillMode: Image.PreserveAspectFit
                }
                onClicked: {
                    if (topBar.windowAvailable) {
                        window.close()
                    }
                }
            }
        }
    }

    Rectangle {
        anchors.bottom: parent.bottom; width: parent.width; height: 1
        color: Style.divider; opacity: 0.6
    }

    // 文件对话框
    FileDialog {
        id: fileDialog
        title: qsTr("选择文件")
        fileMode: FileDialog.SaveFile
        nameFilters: ["StoryScience 项目 (*.ssp)"]

        property string operationType: "save" // "save" 或 "load"

        onAccepted: {
            var filePath = currentFile.toString()

            if (filePath.startsWith("file://")) {
                filePath = filePath.substring(7) // 移除 "file://" 前缀
            }

            // Windows路径修复：移除开头多余的斜杠
            if (Qt.platform.os === "windows" && filePath.startsWith("/")) {
                filePath = filePath.substring(1)
            }

            if (!filePath || filePath.length === 0) {
                console.error("错误：文件路径为空")
                return
            }

            // 根据操作类型执行相应的功能
            if (operationType === "save") {
                executeProjectSave(filePath)
            } else if (operationType === "load") {
                executeProjectLoad(filePath)
            }
        }
    }

    // 保存项目函数
    function executeProjectSave(filePath) {
        //console.log("执行保存功能, 文件路径:", filePath)

        try {
            var result = DataManager.saveProject(filePath)
            if (result) {
                // 发出信号更新上次打开的文件路径
                lastOpenedFilePathChanged(filePath)
            } else {
                console.error("项目保存失败")
            }
        } catch (error) {
            console.error("保存过程中发生异常:", error)
        }
    }

    // 加载项目函数
    function executeProjectLoad(filePath) {
        //console.log("执行加载功能, 文件路径:", filePath)

        try {
            var result = DataManager.loadProject(filePath)
            if (result) {
                // 发出信号更新上次打开的文件路径
                lastOpenedFilePathChanged(filePath)
            } else {
                console.error("项目加载失败")
            }
        } catch (error) {
            console.error("加载过程中发生异常:", error)
        }
    }

    // 创建新项目函数
    function createNewProjectWithName(projectName) {
        // 创建新项目
        DataManager.createNewProject()

        // 如果提供了项目名称，则创建一个同名的书籍
        if (projectName && projectName.length > 0) {
            // 获取根索引
            var rootIndex = DataManager.storyModel.index(-1, 0, Qt.invalidModelIndex)
            // 创建新书籍
            DataManager.createStoryItemWithArticle(rootIndex, StoryType.Book, projectName)
        }
    }

    // 项目名称输入对话框
    Dialog {
        id: projectNameDialog
        title: qsTr("新建项目")
        width: 400
        modal: true
        standardButtons: Dialog.Ok | Dialog.Cancel

        ColumnLayout {
            anchors.fill: parent
            spacing: Style.spacing

            Label {
                text: qsTr("请输入项目名称：")
                font: Style.bodyFont
            }

            TextField {
                id: projectNameField
                Layout.fillWidth: true
                placeholderText: qsTr("项目名称")
                font: Style.titleFont
                onAccepted: projectNameDialog.accept()
            }
        }

        onAccepted: {
            createNewProjectWithName(projectNameField.text)
            projectNameField.text = "" // 清空输入框
        }

        onRejected: {
            projectNameField.text = "" // 清空输入框
        }

        // 弹窗打开时，清空输入框并聚焦
        onOpened: {
            projectNameField.text = ""
            projectNameField.forceActiveFocus()
        }
    }
}
