// WorldbuildingView.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import storyScience 1.0

Rectangle {
    id: worldbuildingView
    color: Style.windowBg
    Layout.fillWidth: true
    Layout.fillHeight: true

    // 用于存储每个分类的内容
    property var categoryContents: ({})
    // 当前选中的分类名称
    property string currentCategoryName: ""

    RowLayout {
        anchors.fill: parent
        // 分类列表
        Rectangle {
            Layout.preferredWidth: 200
            Layout.fillHeight: true
            color: Style.panelBg
            objectName: "categoryList"
            ListView {
                id: categoryList
                anchors.fill: parent
                model: ListModel {
                    ListElement { name: qsTr("地理") }
                    ListElement { name: qsTr("历史") }
                    ListElement { name: qsTr("文化") }
                    ListElement { name: qsTr("种族") }
                }

                delegate: Rectangle {
                    id: categoryDelegate
                    height: 40
                    width: parent.width
                    color: ListView.isCurrentItem ? Style.primary : "transparent"

                    Label {
                        anchors.centerIn: parent
                        text: model.name
                        color: ListView.isCurrentItem ? Style.textOnPrimary : Style.text
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            // 保存当前分类的内容
                            if (worldbuildingView.currentCategoryName) {
                                categoryContents[worldbuildingView.currentCategoryName] = contentEditor.text
                            }

                            // 更新当前选中的分类
                            worldbuildingView.currentCategoryName = model.name
                            categoryList.currentIndex = index

                            // 加载新分类的内容
                            if (categoryContents.hasOwnProperty(model.name)) {
                                contentEditor.text = categoryContents[model.name]
                            } else {
                                contentEditor.text = ""
                            }
                        }
                    }
                }
            }

            // 添加自定义分类按钮
            Button {
                objectName: "addCategoryButton"
                id: addCategoryButton
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: Style.padding
                height: Style.buttonHeight
                font: Style.buttonFont
                text: qsTr("+ 添加分类")
                flat: true
                background: Rectangle {
                    radius: Style.radiusLarge
                    color: addCategoryButton.hovered ? Style.buttonPrimaryBgHover : Style.buttonPrimaryBg
                }

                contentItem: Label{
                    text: addCategoryButton.text;
                    font: addCategoryButton.font
                    color: Style.buttonPrimaryText
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    // 这里可以添加添加新分类的逻辑
                    newCategoryDialog.open()
                }
            }
        }

        // 内容编辑区域
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Style.windowBg
            ColumnLayout {
                anchors.fill: parent
                spacing: Style.spacing
                // 标题栏
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight:40
                    color: Style.primary
                    Label {
                        anchors.centerIn: parent
                        text: qsTr("世界观 - ") + (worldbuildingView.currentCategoryName ? worldbuildingView.currentCategoryName : "")
                        color: Style.textOnPrimary
                        font.pixelSize: 18
                    }
                }

                // 内容编辑器
                ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    background: Rectangle {
                        color: Style.windowBg
                        border.color: hoverHandler.hovered ? Style.borderHovered : "transparent" // 始终显示一个边框
                        border.width: 1
                        radius: 6
                    }
                    HoverHandler { id: hoverHandler }
                    TextArea {
                        id: contentEditor
                        color: Style.text
                        font: Style.readingfont
                        background: Rectangle {
                            color: "transparent"
                            border.width: 0 // 确保没有边框
                        }
                        topInset: Style.padding
                        leftInset: Style.padding
                        rightInset: Style.padding
                        bottomInset: Style.padding
                        text: {
                            if (worldbuildingView.currentCategoryName) {
                                return categoryContents.hasOwnProperty(worldbuildingView.currentCategoryName) ?
                                    categoryContents[worldbuildingView.currentCategoryName] : ""
                            }
                            return ""
                        }
                        // Component.onCompleted: {
                        //     if (worldbuildingView.currentCategoryName &&
                        //         categoryContents.hasOwnProperty(worldbuildingView.currentCategoryName)) {
                        //         contentEditor.text = categoryContents[worldbuildingView.currentCategoryName]
                        //     }
                        // }
                        wrapMode: TextArea.Wrap
                        selectByMouse: true
                        onTextChanged: {
                            DataManager.markProjectDirty()
                        }
                    }
                }
            }
        }
    }

    function saveWordBuilding(){
        if(worldbuildingView.currentCategoryName){
            categoryContents[worldbuildingView.currentCategoryName] = contentEditor.text
        }
        var content = JSON.stringify(categoryContents)
        //console.log("保存世界观内容:", content)
        if (content !== undefined && content !== null) {
            // 添加检查确保DataManager可用
            if (typeof DataManager !== 'undefined') {
                DataManager.updateCurrentBookWorldbuilding(content)
            } else {
                console.warn("DataManager不可用，无法保存世界观内容")
            }
        } else {
            console.warn("世界观内容为空，不保存")
        }
    }
    // 监听当前故事项变化，更新编辑器内容
    Connections {
        target: DataManager
        function onCurrentStoryIndexChanged() {
            loadContentFromDataManager()
        }
    }

    // 新增一个函数来从DataManager加载内容
    function loadContentFromDataManager() {
        // 保存当前分类的内容
        if (worldbuildingView.currentCategoryName) {
            categoryContents[worldbuildingView.currentCategoryName] = contentEditor.text
        }

        // 从DataManager加载内容
        var content = DataManager.getCurrentBookWorldbuilding()
        if (content) {
            try {
                categoryContents = JSON.parse(content)
            } catch (e) {
                categoryContents = {}
            }
        } else {
            categoryContents = {}
        }

        // 更新当前分类的内容显示
        if (worldbuildingView.currentCategoryName && categoryContents.hasOwnProperty(worldbuildingView.currentCategoryName)) {
            contentEditor.text = categoryContents[worldbuildingView.currentCategoryName]
        } else {
            contentEditor.text = ""
        }
    }

    // 新建分类对话框
    Dialog {
        id: newCategoryDialog
        title: qsTr("添加新分类")
        modal: true
        standardButtons: Dialog.Ok | Dialog.Cancel
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        ColumnLayout {
            anchors.fill: parent
            spacing: Style.spacing

            Label {
                text: qsTr("请输入新分类名称：")
                font: Style.bodyFont
            }

            TextField {
                id: categoryNameField
                Layout.fillWidth: true
                placeholderText: qsTr("分类名称")
                font: Style.bodyFont
                onAccepted: newCategoryDialog.accept()
            }
        }

        onAccepted: {
            if (categoryNameField.text.trim() !== "") {
                // 添加新分类到模型
                categoryList.model.append({"name": categoryNameField.text.trim()})
                categoryNameField.text = ""
            }
        }

        onRejected: {
            categoryNameField.text = ""
        }
    }

    // 组件初始化时加载内容
    Component.onCompleted: {
        // 设置默认选中的分类
        if (categoryList.model && categoryList.model.count > 0) {
            worldbuildingView.currentCategoryName = categoryList.model.get(0).name
            categoryList.currentIndex = 0
        }

        // 在组件创建时也加载一次内容
        loadContentFromDataManager()
    }
}
