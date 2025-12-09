// ForeshadowingPopup.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import storyScience 1.0

Popup {
    id: root

    // --- Public API ---
    // 通过这些属性从外部传入必要信息
    property var foreshadowingData: ({})

    function openWith(data) {
       foreshadowingData = data;
       originalContentLabel.text = qsTr("<b>原文：</b>") + data.content;
       descriptionArea.clear();
       root.open();
   }

    // --- Popup基本设置 ---
    width: 450
    // 高度由内容自动决定
    modal: true
    focus: true // 自动获取焦点，以便输入
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    padding: 20
    background: Rectangle {
        color: Style.cardBg
        radius: Style.radiusMedium
        border.color: Style.border
    }
    // --- UI布局 ---
    ColumnLayout {
        anchors.fill: parent
        spacing: 15

        // 1. 标题
        Label {
            text: qsTr("标记伏笔")
            font: Style.titleFont
            color: Style.text
            Layout.alignment: Qt.AlignHCenter
        }

        // 2. 伏笔原文显示区域
        Frame {
            Layout.fillWidth: true
            padding: 10
            background: Rectangle {
                color: Style.panelBgAlt;
                radius: Style.radiusSmall
            }
            clip: true

            Label {
                id: originalContentLabel
                width: parent.availableWidth  // 使用availableWidth
                wrapMode: Text.Wrap
                font.pixelSize: 14
                color: Style.textSecondary
                elide: Text.ElideRight
                maximumLineCount: 2
                clip: true
            }
        }
        // 3. 伏笔描述输入框
        Label { text: qsTr("伏笔描述 (给自己的笔记):"); font: Style.labelFont; color: Style.text }
        TextArea {
            id: descriptionArea
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            placeholderText: qsTr("例如：这把剑的来历，将在主角回忆时揭晓...")
            font.pixelSize: 14
        }

        // 6. 操作按钮区域
        RowLayout {
            Layout.alignment: Qt.AlignRight
            spacing: 10

            Button {
                id: cancelButton
                text: qsTr("取消")
                onClicked: root.close()
            }

            Button {
                id: saveButton
                text: qsTr("保存伏笔")
                highlighted: true // 设为高亮/默认按钮

                onClicked: {
                    // 保存伏笔到数据模型
                    DataManager.foreshadowingModel.addForeshadowing(
                        foreshadowingData.content,
                        foreshadowingData.prefix,
                        foreshadowingData.suffix,
                        descriptionArea.text,
                        foreshadowingData.sourceChapterId
                    );
                    root.close();
                }
            }
        }
    }
}
