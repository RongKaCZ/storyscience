// LeftPanel.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects
import storyScience 1.0
import ElementType 1.0
import StoryType 1.0
import ArticleEpType 1.0
pragma ComponentBehavior: Bound

Frame {
    id: root

    property bool isCollapsed: false
    property int expandedWidth: 200
    property int collapsedWidth: collapseButton.width
    property int extendedWidth: 200  // 记录当前扩展后的宽度
    property bool isExtended: false  // 是否处于扩展状态

    signal switchReadView() //转到阅读视图
    signal deleteRootBook() //删除根书籍
    Layout.preferredWidth: isCollapsed ? collapsedWidth : expandedWidth
    Behavior on Layout.preferredWidth {
        NumberAnimation { duration: Style.durationFast; easing.type: Style.ease }
    }

    background: Rectangle {
        color: Style.panelBg
    }
    padding: 0
    clip: true

    function connectElement(){
        elementPicker.open()
    }

    function pauseTreeView(value){
        treeViewContainer.enabled = value
    }

    ElementPicker {
       id: elementPicker
        onElementsSelected: (selectedElementIds) => {
           DataManager.associateElementsWithCurrentStoryItem(selectedElementIds)
        }
    }

    CreateStoryItemDialog {
        id: createDialog
        onCreationRequested: (parentIndex, itemType, title) => {
            //DataManager.createStoryItem(parentIndex, itemType, title)
            DataManager.createStoryItemWithArticle(parentIndex, itemType, title)

            // 延迟处理，确保新项已经创建并添加到模型中
            Qt.callLater(function() {
                // 获取当前选中的索引（应该是新创建的项）
                var currentIndex = treeView.selectionModel.currentIndex
                if (currentIndex.valid) {
                    // 确保新创建的项在TreeView中可见
                    treeView.expand(currentIndex)

                    // 强制刷新布局
                    treeView.forceLayout()

                    // 使用TreeView的滚动方法 - 通过设置选中项来触发滚动
                    treeView.selectionModel.setCurrentIndex(currentIndex, ItemSelectionModel.Select)
                }
            })
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // --- Header ---
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: Style.topBarHeight
            color: Style.panelBg
            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: root.isCollapsed ? 0 : Style.spacingSmall
                anchors.rightMargin: Style.spacing
                // 添加间距以改善按钮布局
                spacing: Style.spacingSmall

                ToolButton {
                    id: collapseButton
                    icon.source: "qrc:/icons/Left.png"
                    icon.color: Style.text
                    rotation: root.isCollapsed ? 180 : 0
                    Behavior on rotation { RotationAnimation { duration: Style.durationFast; easing.type: Style.ease } }
                    onClicked: root.isCollapsed = !root.isCollapsed
                    background: Rectangle {
                        color: collapseButton.hovered ? Style.menuItemHover : "transparent"
                        radius: Style.radiusMedium
                    }
                }

                Label {
                    text: qsTr("书管理")
                    font: Style.titleFont
                    color: Style.text
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                    opacity: root.isCollapsed ? 0 : 1
                    Behavior on opacity { NumberAnimation { duration: Style.durationShort } }
                }

                ToolButton {
                    id: extendButton
                    icon.source: root.isExtended ? "qrc:/icons/Left.png" : "qrc:/icons/Right.png"
                    icon.color: Style.text
                    opacity: root.isCollapsed ? 0 : 1
                    Behavior on opacity { NumberAnimation { duration: Style.durationShort } }
                    onClicked: {
                        if (root.isExtended) {
                            // 缩小到原始宽度
                            root.expandedWidth = 200
                            root.isExtended = false
                        } else {
                            // 扩展宽度
                            root.expandedWidth = Math.min(root.expandedWidth + 50, 300)
                            root.isExtended = root.expandedWidth >= 300
                        }
                    }
                    background: Rectangle { color: "transparent" }
                    // 添加以下属性以改善按钮的点击区域和位置
                    Layout.alignment: Qt.AlignVCenter
                    implicitWidth: 30
                    implicitHeight: 30
                }
            }

            // 点击Header区域清除选择
            TapHandler {
                acceptedButtons: Qt.LeftButton
                onTapped: {
                    treeView.selectionModel.clearCurrentIndex()
                }
            }
        }

        // --- TreeView Container ---
        Rectangle {
            id: treeViewContainer
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"

            TreeView {
                id: treeView
                objectName: "bookTreeView"
                anchors.fill: parent
                clip: true
                model: DataManager.storyModel // <-- 使用DataManager的模型

                // 保存滚动位置的属性
                property real savedVerticalScrollPosition: 0

                // 定义一个强制刷新方法
                function forceRefreshItem(index) {
                    if (!index.valid) return

                    // 方法1：直接刷新布局
                    forceLayout()

                    // 方法2：如果有父节点，尝试快速展开/收缩父节点来刷新
                    var parentIndex = DataManager.storyModel.parent(index)
                    if (parentIndex.valid) {
                        var wasExpanded = isExpanded(parentIndex)
                        if (wasExpanded) {
                            // 先收缩再展开
                            collapse(parentIndex)
                            Qt.callLater(function() {
                                expand(parentIndex)
                                // 恢复选中状态
                                selectionModel.setCurrentIndex(index, ItemSelectionModel.Select)
                            })
                        }
                    }
                }

                // 保存当前滚动位置
                function saveScrollPosition() {
                    savedVerticalScrollPosition = ScrollBar.vertical.position
                }

                // 恢复滚动位置
                function restoreScrollPosition() {
                    ScrollBar.vertical.position = savedVerticalScrollPosition
                }

                // 监听模型变化，强制刷新
                Connections {
                    target: DataManager.storyModel
                    function onLayoutChanged() {
                        // 保存当前位置
                        treeView.saveScrollPosition()

                        treeView.forceLayout()

                        // 在下一帧恢复位置
                        Qt.callLater(function() {
                            treeView.restoreScrollPosition()
                        })
                    }

                    function onDataChanged(topLeft, bottomRight, roles) {
                        // 保存当前位置
                        treeView.saveScrollPosition()

                        // 使用我们的强制刷新方法
                        if (topLeft.valid) {
                            treeView.forceRefreshItem(topLeft)
                        } else {
                            treeView.forceLayout()
                        }

                        // 在下一帧恢复位置
                        Qt.callLater(function() {
                            treeView.restoreScrollPosition()
                        })
                    }
                }
                selectionModel: ItemSelectionModel {
                    // 当选中项改变时，通知DataManager
                    onCurrentChanged: (current, previous) => {
                        DataManager.selectStoryItem(current)
                    }
                }
                rowSpacing:15
                opacity: root.isCollapsed ? 0 : 1
                visible: !root.isCollapsed
                Behavior on opacity { NumberAnimation { duration: Style.durationShort } }

                delegate: StoryTreeDelegate {
                    id: delegate
                    treeViewRef: treeView
                    contextMenuRef: contextMenu
                }

                ScrollBar.vertical: ScrollBar {
                    policy: ScrollBar.AsNeeded
                }

            }

        }

        // --- Footer ---
        Rectangle {
            id: footer
            Layout.fillWidth: true
            Layout.preferredHeight: newButton.implicitHeight + Style.spacing * 2
            color: Style.panelBg
            opacity: root.isCollapsed ? 0 : 1
            visible: !root.isCollapsed
            Behavior on opacity { NumberAnimation { duration: Style.durationShort } }

            Button {
                id: newButton
                objectName: "newBtn"
                anchors.fill: parent
                anchors.margins: Style.spacing
                text: {
                    var currentIndex = treeView.selectionModel.currentIndex
                    // 获取根节点下的书籍数量
                    var bookCount = DataManager.storyModel.rowCount(treeView.rootIndex)

                    // 如果没有书籍，则显示创建新书的选项
                    if (bookCount === 0) {
                        return qsTr("+ 创建新书")
                    }

                    // 如果当前选中项无效，则不显示创建按钮
                    if (!currentIndex.valid) {
                        return ""
                    }

                    var itemData = DataManager.storyModel.getItemData(currentIndex)
                    if (!itemData || !itemData.valid) {
                        return ""
                    }

                    // 只能在书籍及其子项下创建内容
                    switch(itemData.type) {
                        case StoryType.Book:
                            return qsTr("+ 新建分卷")
                        case StoryType.Volume:
                            return qsTr("+ 新建章节")
                        case StoryType.Chapter:
                            return qsTr("+ 新建章节")
                        default:
                            return ""
                    }
                }
                height: Style.buttonHeight
                font: Style.buttonFont
                background: Rectangle {
                    color: newButton.down ? Style.buttonPrimaryBg : (newButton.hovered ? Style.buttonPrimaryBgHover : Style.buttonPrimaryBg)
                    radius: Style.radiusLarge
                }
                contentItem: Label {
                    text: newButton.text
                    font: newButton.font
                    color: Style.buttonPrimaryText
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                // 只有当按钮文本不为空时才启用
                enabled: newButton.text !== ""
                onClicked: {
                    var currentIndex = treeView.selectionModel.currentIndex
                    var parentIndex = treeView.rootIndex
                    var newType = StoryType.Book
                    var newTitle = qsTr("新书")
                    // 获取根节点下的书籍数量
                    var bookCount = DataManager.storyModel.rowCount(treeView.rootIndex)

                    // 如果没有书籍，创建新书
                    if (bookCount === 0) {
                        parentIndex = treeView.rootIndex
                        newType = StoryType.Book
                        newTitle = qsTr("新书")
                    } else {
                        // 否则按照原有逻辑在当前选中项下创建子项
                        if (currentIndex.valid) {
                            var itemData = DataManager.storyModel.getItemData(currentIndex)
                            if (itemData && itemData.valid) {
                                switch(itemData.type) {
                                    case StoryType.Book:
                                        parentIndex = currentIndex
                                        newType = StoryType.Volume
                                        newTitle = qsTr("新分卷")
                                        break;
                                    case StoryType.Volume:
                                        parentIndex = currentIndex
                                        newType = StoryType.Chapter
                                        newTitle = qsTr("新章节")
                                        break;
                                    // 如果当前是章节，则在父级（卷）下创建新章节
                                    case StoryType.Chapter:
                                        parentIndex = DataManager.storyModel.parent(currentIndex)
                                        newType = StoryType.Chapter
                                        newTitle = qsTr("新章节")
                                        break;
                                    // 注释掉场景相关逻辑
                                    // case StoryType.Scene:
                                    //     parentIndex = DataManager.storyModel.parent(currentIndex)
                                    //     newType = StoryType.Scene
                                    //     newTitle = qsTr("新场景")
                                    //     break;
                                    default:
                                        return
                                }
                            }
                        } else {
                            return
                        }
                    }

                    // 设置对话框参数并打开
                    createDialog.parentIndex = parentIndex
                    createDialog.itemTypeName = newTitle
                    createDialog.itemType = newType
                    createDialog.open()
                }
            }
        }
    }

    Menu {
        id: contextMenu
        property var currentItemType

        MenuItem {
            id: createMenuItem
            text: {
                switch (contextMenu.currentItemType) {
                    case StoryType.Book:
                        createDialog.itemType = contextMenu.currentItemType + 1
                        return qsTr("创建新分卷...")
                    case StoryType.Volume:
                        createDialog.itemType = contextMenu.currentItemType + 1
                        return qsTr("创建新章节...")
                    case StoryType.Chapter:
                        createDialog.itemType = contextMenu.currentItemType
                        return qsTr("创建新章节...")
                    default:
                        return ""
                }
            }
            visible: text !== ""
            onTriggered: {
                createDialog.parentIndex = treeView.selectionModel.currentIndex
                createDialog.itemTypeName = text
                createDialog.open()
            }
        }

        MenuSeparator { visible: createMenuItem.visible }

        MenuItem {
            text: qsTr("关联已有元素...")
            enabled: treeView.selectionModel.currentIndex.valid
            onTriggered: elementPicker.open()
        }

        // 二级 + 三级菜单写法
        Menu {
            title: qsTr("导出章节文本")
            //visible: DataManager.currentArticle !== ""
            enabled: DataManager.currentArticle !== null && DataManager.currentArticle !== ""

            MenuItem {
                text: "TXT"
                onTriggered: DataManager.exportCurrentArticle(ArticleEpType.TxT)
            }
            MenuItem {
                text: "MD"
                onTriggered: DataManager.exportCurrentArticle(ArticleEpType.MD)
            }

            // // 三级菜单
            // Menu {
            //     title: "高级导出"

            //     MenuItem {
            //         text: "PDF"
            //         onTriggered: DataManager.exportCurrentArticle(ArticleEpType.PDF)
            //     }
            //     MenuItem {
            //         text: "HTML"
            //         onTriggered: DataManager.exportCurrentArticle(ArticleEpType.HTML)
            //     }
            // }
        }

        MenuSeparator {}

        MenuItem{
            text: qsTr("查看全书属性")
            enabled: treeView.selectionModel.currentIndex.valid && DataManager.storyModel.getItemData(treeView.selectionModel.currentIndex).type === StoryType.Book
            onTriggered: bookPropertyDialog.open()
        }

        MenuItem{
            text:qsTr("转到AI读者视角")
            enabled: treeView.selectionModel.currentIndex.valid
            onTriggered: {
                root.switchReadView()
            }
        }


        MenuItem {
            text: qsTr("删除")
            enabled: treeView.selectionModel.currentIndex.valid
            onTriggered: {
                if(contextMenu.currentItemType == StoryType.Book){ root.deleteRootBook() }
                else deleteDialog.open()
            }
        }
    }

    MessageBox {
        id: deleteDialog
        title: qsTr("确认删除")
        content: {
            var currentIndex = treeView.selectionModel.currentIndex
            if (currentIndex.valid) {
                var itemData = DataManager.storyModel.getItemData(currentIndex)
                return qsTr("确定要删除 \"" + (itemData && itemData.valid ? itemData.title : "未知项目") + "\" 吗？")
            }
            return qsTr("确定要删除该项目吗？")
        }
        confirmText: qsTr("删除")
        cancelText: qsTr("取消")
        popupPosition: 1 // 右侧弹出
        //offsetX: 10 // 右侧偏移10像素

        onConfirmed: {
            DataManager.removeStoryItem(treeView.selectionModel.currentIndex)
            DataManager.markProjectDirty()
        }
    }

    BookPropertyDialog {
        id: bookPropertyDialog
        bookIndex: treeView.selectionModel.currentIndex
    }

    Connections{
        target: DataManager
        function onProjectLoaded(file){
            Qt.callLater(function(){
                var bookCount = DataManager.storyModel.rowCount(treeView.rootIndex)
                if (bookCount > 0) {
                    // 选择第一个书籍节点
                    var firstBookIndex = DataManager.storyModel.index(0, 0, treeView.rootIndex)
                    if (firstBookIndex.valid) {
                        treeView.selectionModel.setCurrentIndex(firstBookIndex, ItemSelectionModel.Select)
                    }
                }
            })
        }
    }
}
