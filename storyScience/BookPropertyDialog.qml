// BookPropertyDialog.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import storyScience 1.0
import StoryType 1.0

Dialog {
    id: bookPropertyDialog

    property var bookIndex: undefined
    property var bookData: bookIndex ? DataManager.storyModel.getItemData(bookIndex) : ({})

    title: qsTr("书籍属性")
    modal: true
    standardButtons: Dialog.Ok
    width: 500
    height: 400
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2

    background: Rectangle {
        color: Style.panelBg
        border.color: Style.panelBorder
        border.width: Style.borderWidth
        radius: Style.radius
    }

    contentWidth: width - 40
    contentHeight: height - 80

    ColumnLayout {
        anchors.fill: parent
        spacing: Style.spacingSmall

        // 书籍基本信息
        GroupBox {
            title: qsTr("基本信息")
            Layout.fillWidth: true
            background: Rectangle {
                color: Style.cardBg
                border.color: Style.border
                radius: Style.radiusSmall
            }

            ColumnLayout {
                anchors.fill: parent
                spacing: Style.spacingSmall

                RowLayout {
                    Label {
                        text: qsTr("书名：")
                        font: Style.labelFont
                        color: Style.text
                    }
                    Label {
                        text: bookData.title || qsTr("未知")
                        font: Style.bodyFont
                        color: Style.text
                        Layout.fillWidth: true
                    }
                }

                RowLayout {
                    Label {
                        text: qsTr("章节数：")
                        font: Style.labelFont
                        color: Style.text
                    }
                    Label {
                        id: chapterCountLabel
                        text: qsTr("计算中...")
                        font: Style.bodyFont
                        color: Style.text
                        Layout.fillWidth: true
                    }
                }

                RowLayout {
                    Label {
                        text: qsTr("总字数：")
                        font: Style.labelFont
                        color: Style.text
                    }
                    Label {
                        id: totalWordCountLabel
                        text: qsTr("计算中...")
                        font: Style.bodyFont
                        color: Style.text
                        Layout.fillWidth: true
                    }
                }
            }
        }

        // 章节列表
        GroupBox {
            title: qsTr("章节列表")
            Layout.fillWidth: true
            Layout.preferredHeight: 120
            background: Rectangle {
                color: Style.cardBg
                border.color: Style.border
                radius: Style.radiusSmall
            }

            ScrollView {
                id: scrollView
                anchors.fill: parent
                clip: true

                ListView {
                    id: chapterListView
                    model: ListModel { id: chapterModel }
                    delegate: Rectangle {
                        width: ListView.view.width
                        height: 40
                        color: Style.panelBg

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: Style.spacingSmall
                            spacing: Style.spacingSmall

                            Label {
                                text: model.index + 1 + "."
                                font: Style.labelFont
                                color: Style.textSecondary
                            }

                            Label {
                                text: model.title
                                font: Style.bodyFont
                                color: Style.text
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }

                            Label {
                                text: model.typeText
                                font: Style.labelFont
                                color: Style.textSecondary
                            }

                            Label {
                                text: model.wordCount + qsTr(" 字")
                                font: Style.labelFont
                                color: Style.textSecondary
                            }
                        }

                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width
                            height: 1
                            color: Style.divider
                        }
                    }
                }

                ScrollBar.vertical: ScrollBar {
                    parent: scrollView
                    x: scrollView.mirrored ? 0 : scrollView.width - width
                    y: scrollView.topPadding
                    height: scrollView.availableHeight
                    active: scrollView.ScrollBar.vertical.pressed
                    contentItem: Rectangle {
                        implicitWidth: Style.scrollBarWidth
                        implicitHeight: 100
                        radius: width / 2
                        color: scrollView.ScrollBar.vertical.pressed ? Style.scrollBarHandlePressed :
                              scrollView.ScrollBar.vertical.hovered ? Style.scrollBarHandleHover : Style.scrollBarHandle
                    }
                }
            }
        }
    }

    // 当对话框打开时加载数据
    onOpened: {
        loadBookProperties()
    }

    function loadBookProperties() {
        if (!bookIndex || !bookIndex.valid) {
            return
        }

        // 清空模型
        chapterModel.clear()

        var totalWordCount = 0
        var chapterCount = 0

        // 将StoryType枚举值转换为可读文本
        function storyTypeToString(type) {
            switch(type) {
                case StoryType.Root:
                    return qsTr("根节点");
                case StoryType.Book:
                    return qsTr("书籍");
                case StoryType.Volume:
                    return qsTr("分卷");
                case StoryType.Chapter:
                    return qsTr("章节");
                case StoryType.Chapter:
                    return qsTr("章节");
                case StoryType.Scene:
                    return qsTr("场景");
                default:
                    return qsTr("未知");
            }
        }

        // 递归遍历所有子项
        function traverseItems(parentIndex, depth) {
            var childCount = DataManager.storyModel.rowCount(parentIndex)
            for (var i = 0; i < childCount; i++) {
                var childIndex = DataManager.storyModel.index(i, 0, parentIndex)
                if (childIndex.valid) {
                    var childData = DataManager.storyModel.getItemData(childIndex)
                    if (childData && childData.valid) {
                        // 获取子项关联的文章
                        var article = DataManager.getArticleForStoryItem(childIndex)
                        var wordCount = 0
                        if (article) {
                            wordCount = article.wordCount
                        }

                        // 只有Chapter及以下级别的项才添加到章节列表中
                        if (childData.type >= StoryType.Chapter) {
                            // 添加到模型，包含类型信息
                            chapterModel.append({
                                "title": childData.title,
                                "wordCount": wordCount,
                                "type": childData.type,
                                "typeText": storyTypeToString(childData.type)  // 添加可读的类型文本
                            })
                            
                            chapterCount++
                            totalWordCount += wordCount
                        }
                        // 递归处理子项的子项
                        traverseItems(childIndex, depth + 1)
                    }
                }
            }
        }

        // 从书籍根节点开始遍历
        traverseItems(bookIndex, 0)

        chapterCountLabel.text = chapterCount
        totalWordCountLabel.text = totalWordCount
    }
}
