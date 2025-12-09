import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import storyScience 1.0

Popup {
    id: vocabularyPopup
    width: 600
    height: 500
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    // 词汇字典对象
    VocabularyDictionary {
        id: vocabularyDict
        Component.onCompleted: {
            // 从资源文件加载词汇数据 (注意：路径应为qrc资源路径)
            vocabularyDict.loadFromResource(":/fileDN/StoryScienceDN_zh.json")
            // 默认选中第一个分类
            if (vocabularyDict.categories.length > 0) {
                vocabularyPopup.currentCategory = vocabularyDict.categories[0];
            }
        }
    }

    // 栏目中文翻译映射
    property var categoryTranslations: {
        "Symbols": qsTr("符号"),
        "interjection": qsTr("语气"),
        "action_words": qsTr("动作词"),
        "eye_expression_words": qsTr("眼睛"),
        "psychological_activity_words": qsTr("心理"),
        "environmental_description_words": qsTr("环境"),
        "appearance_description_words": qsTr("外貌"),
        "sound_words": qsTr("声音"),
        "dialogue_verbs": qsTr("对话"),
        "combat_words": qsTr("战斗"),
        "scene_description_words": qsTr("场景"),
        "cultivation_terms": qsTr("修真术语"),
        "character_identity_titles": qsTr("身份头衔"),
        "item_treasure_names": qsTr("物品名"),
        "abstract_concepts_tropes": qsTr("抽象概念"),
        "power_aura_adjectives": qsTr("能量")
    }

    // 当前选中的分栏键名
    property string currentCategory: ""

    // 搜索关键词
    property string searchText: ""

    // 当前语言
    property string currentLanguage: "zh"
    
    // 添加一个属性用于强制刷新模型
    property int modelRefreshTrigger: 0

    // 切换词典语言
    function switchLanguage(languageCode) {
        //console.log("Switching vocabulary language to:", languageCode);
        currentLanguage = languageCode;
        var resourcePath = "";
        if (languageCode === "zh") {
            resourcePath = ":/fileDN/StoryScienceDN_zh.json";
        } else if (languageCode === "en") {
            resourcePath = ":/fileDN/StoryScienceDN_en.json";
        }
        
        if (resourcePath) {
            vocabularyDict.loadFromResource(resourcePath);
            // 重新选中第一个分类
            if (vocabularyDict.categories.length > 0) {
                vocabularyPopup.currentCategory = vocabularyDict.categories[0];
            }
            // 清空搜索
            searchField.text = "";
            // 强制刷新模型
            modelRefreshTrigger++;
        }
    }

    // 过滤后的词汇（根据当前分栏 + 搜索词）
    function getFilteredWords() {
        // 使用触发器确保函数被重新计算
        let _ = modelRefreshTrigger;
        if (!searchText.trim()) {
            return vocabularyDict.getWordsByCategory(currentCategory)
        }
        return vocabularyDict.searchWords(currentCategory, searchText)
    }

    background: Rectangle {
        color: Style.popupBackground
        border.color: Style.popupBorder
        border.width: 1
        radius: Style.popupRadius
    }

    contentItem: ColumnLayout {
        anchors.fill: parent
        spacing: 10
        anchors.margins: 5

        // 标题栏
        Label {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("辅助词汇库")
            font.bold: Style.popupTitleBold
            font.pixelSize: Style.popupTitleFontSize
            color: Style.popupTitleText
            padding: 10
        }

        // 搜索栏
        RowLayout {
            Layout.fillWidth: true
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            spacing: 10

            TextField {
                id: searchField
                Layout.fillWidth: true
                placeholderText: qsTr("搜索当前分类词汇...")
                font.pixelSize: 14
                color:  Style.popupSearchText
                placeholderTextColor: Style.popupSearchPlaceholder
                onTextChanged: vocabularyPopup.searchText = text

                background: Rectangle {
                    color: Style.popupSearchBackground
                    border.color: Style.popupSearchBorder
                    border.width: 1
                    radius: 5
                }
            }

            Button {
                text: qsTr("清空")
                onClicked: {
                    searchField.text = ""
                    searchField.focus = true
                }
                background: Rectangle {
                    color: parent.down ? "#333" : "#444"
                    radius: 5
                    border.color: "#555"
                    border.width: 1
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font: parent.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }

        // 分类选择栏
        ScrollView {
            id: categoryScrollView
            Layout.fillWidth: true
            Layout.preferredHeight: 45
            clip: true
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            ListView {
                id: categoryList
                orientation: ListView.Horizontal
                model: vocabularyDict.categories
                spacing: 8
                height: parent.height
                anchors.left: parent.left
                anchors.leftMargin: 10
                boundsBehavior: Flickable.DragAndOvershootBounds
                flickDeceleration: 4000
                delegate: Button {
                    id: categoryButton
                    property bool isCurrent: vocabularyPopup.currentCategory === modelData
                    text: categoryTranslations[modelData] || modelData.replace(/_/g, " ")
                    padding: 10
                    font.pixelSize: 13

                    background: Rectangle {
                        color: categoryButton.isCurrent ? Style.popupCategoryButtonCurrent :
                                categoryButton.pressed ? Style.popupCategoryButtonPressed :
                                categoryButton.hovered ? Style.popupCategoryButtonHover :
                                Style.popupCategoryButtonBackground
                        radius: 5
                        Behavior on color { ColorAnimation { duration: 200 } }
                    }

                    contentItem: Text {
                        text: parent.text
                        color: categoryButton.isCurrent ? Style.popupCategoryButtonTextCurrent : Style.popupCategoryButtonText
                        font: parent.font
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: {
                        vocabularyPopup.currentCategory = modelData
                        searchField.text = "" // 切换分类时清空搜索
                    }
                }
            }

            MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.NoButton
                    onWheel: (wheel) => {
                        if (categoryList && categoryList.contentWidth > categoryList.width) {
                            let baseSpeed = 8;
                            let velocity = wheel.angleDelta.y * baseSpeed;

                            // 优化触控板/高精度滚轮
                            if (Math.abs(wheel.angleDelta.y) < 10) {
                                velocity *= 5;
                            }

                            categoryList.flick(velocity, 0);
                            wheel.accepted = true;
                        }
                    }
                }
        }

        // 词汇展示区
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            Layout.leftMargin: 10
            Layout.rightMargin: 10

            ListView {
                id: wordList
                model: vocabularyPopup.getFilteredWords()
                width: parent.width // 绑定到ScrollView的宽度
                spacing: 1

                delegate: ItemDelegate {
                    width: wordList.width // 修复: 绑定到ListView的宽度
                    height: 38
                    text: modelData
                    font.pixelSize: 14
                    
                    background: Rectangle {
                        color: parent.hovered ? Style.popupWordItemHover :
                       index % 2 === 0 ? Style.popupWordItemBackgroundEven :
                       Style.popupWordItemBackgroundOdd
                    }

                    contentItem: Text {
                        text: parent.text
                        color: Style.popupWordItemText
                        font: parent.font
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: {
                        clipboard.copy(modelData);
                        // 启动动画
                        if (copyTipAnimation.running) {
                            copyTipAnimation.stop();
                        }
                        copyTipAnimation.start();
                    }
                }
            }
        }

        // 底部关闭按钮
        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            Button {
                anchors.centerIn: parent
                text: qsTr("关闭")
                width: 100
                height: 35
                onClicked: vocabularyPopup.close()

                background: Rectangle {
                    color: parent.down ? Style.popupButtonPressed : Style.popupButtonBackground
                    radius: 5
                    border.color: Style.popupBorder
                    border.width: 1
                }
                contentItem: Text {
                    text: parent.text
                    color: Style.popupButtonText
                    font: parent.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }

    // ========== 复制成功提示层 ==========
    Label {
        id: copyTip
        text: "✅"+qsTr("已复制")
        color: Style.popupButtonText // 使用按钮文字色，确保对比度
        font.pixelSize: 13
        padding: 6
        background: Rectangle {
            radius: 4
            color: Style.shadow // 半透黑背景，通用适配深浅主题
        }
        opacity: 0
        z: 999 // 确保在最上层
        visible: opacity > 0

        // 淡入淡出动画
        SequentialAnimation on opacity {
            id: copyTipAnimation
            running: false
            NumberAnimation { to: 1; duration: 150; easing.type: Easing.OutCubic }
            PauseAnimation { duration: 1200 }
            NumberAnimation { to: 0; duration: 300; easing.type: Easing.InCubic }
        }
    }
}
