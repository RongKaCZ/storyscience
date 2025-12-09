// ElementDelegate.qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Effects
import storyScience 1.0
import ElementType 1.0
Item {
    id: root

    // 移除了所有中间属性，如 cardtitle, cardDescription 等。
    // 我们将直接在需要的地方使用 model.<roleName>。

    implicitHeight: cardContent.implicitHeight + padding * 2
    property int padding: Style.spacingMedium

    readonly property bool isHovered: mouseArea.containsMouse || toolBarMouseArea.containsMouse

    // 1. 背景、边框和阴影
    Rectangle {
        id: background
        anchors.fill: parent
        color: Style.cardBg
        radius: Style.radius

        border.width: 1
        // 直接绑定到 model.ecolor
        border.color: root.isHovered ? model.ecolor : Style.border
        Behavior on border.color { ColorAnimation { duration: Style.transitionDuration } }

        MultiEffect {
            anchors.fill: background
            source: background
            shadowEnabled: true
            shadowColor: Style.shadow
            shadowBlur: root.isHovered ? 12 : 8
            shadowVerticalOffset: root.isHovered ? 4 : 2
            Behavior on shadowBlur { NumberAnimation { duration: Style.transitionDuration } }
            Behavior on shadowVerticalOffset { NumberAnimation { duration: Style.transitionDuration } }
        }
    }

    // 2. 左侧的彩色装饰条
    Rectangle {
        width: 4
        height: root.height
        // 直接绑定到 model.ecolor
        color: model.ecolor
        radius: background.radius
        anchors.left: parent.left
    }

    ElementCard {
        id: cardContent
        anchors.fill: parent
        anchors.leftMargin: 4 + root.padding
        anchors.rightMargin: root.padding
        anchors.topMargin: root.padding
        anchors.bottomMargin: root.padding

        // 将 model 的角色直接传递给 ElementCard
        cardTitle: model.etitle
        cardDescription: model.edescription
        typeColor: model.ecolor
        tags: model.etags
        iconSource: model.eicon
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        // 单击事件现在只负责打开/关闭工具栏，不再管理选中状态
        onClicked: (mouse) => {
            if (!toolBar.contains(toolBar.mapFromItem(root, mouse.x, mouse.y))) {
                // 可以在这里处理单击事件，例如导航到详情页
            }
        }
    }

    // 5. 操作菜单
    ToolBar {
        id: toolBar
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: Style.spacingSmall
        anchors.rightMargin: Style.spacingSmall
        background: Rectangle { color: "transparent" }

        opacity: root.isHovered ? 1 : 0
        enabled: opacity === 1
        Behavior on opacity { NumberAnimation { duration: Style.transitionDuration } }

        ToolButton {
            text: "⋮"
            font.pixelSize: 20
            ToolTip.text: qsTr("更多操作")
            contentItem: Text {
                text: parent.text
                font: parent.font
                color: Style.text
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            MouseArea {
                id: toolBarMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: (mouse) => { contextMenu.open() }
            }
        }
    }

    Menu {
        id: contextMenu

        MenuItem {
            text: qsTr("编辑")
            onTriggered: editPopup.prepareAndOpen()
        }
        MenuItem {
            text: qsTr("查看状态")
            onTriggered: statusViewPopup.prepareAndOpen()
        }
        MenuItem {
            text: qsTr("编辑状态")
            onTriggered: statusEditPopup.prepareAndOpen()
        }
        MenuItem {
            text: qsTr("从当前项移除")
            onTriggered: {
                DataManager.removeAssociationFromCurrentStoryItem(model.eid.toString())
            }
        }
        MenuItem {
            text: qsTr("彻底删除元素")
            onTriggered: {
                DataManager.deleteElementEverywhere(model.eid.toString())
            }
        }
    }

    // 6. 用于编辑内容的弹窗
    Popup {
        id: editPopup
        width: 400
        height: 500
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        anchors.centerIn: Overlay.overlay

        property color editColor
        property var editTags
        property string cardId;

        background: Rectangle {
           color: Style.panelBg
        }

        function prepareAndOpen() {
            cardId = model.eid.toString()
            titleField.text = model.etitle
            descField.text = model.edescription
            editColor = model.ecolor
            editTags = model.etags.slice() // 克隆一份
            colorDialog.selectedColor = editColor

            open()
            titleField.forceActiveFocus()
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: Style.spacing
            spacing: Style.spacing

            TextField {
                id: titleField;
                Layout.fillWidth: true;
                placeholderText: qsTr("标题")
                color:Style.text
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.preferredHeight: Math.min(descField.implicitHeight, 200) // 最大高度200
                clip: true

                TextArea {
                    id: descField
                    width: parent.width
                    placeholderText: qsTr("描述...")
                    wrapMode: Text.Wrap
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 8
                Label {
                    text: qsTr("颜色:")
                    color:Style.text
                }
                Rectangle {
                    width: 32;
                    height: 32;
                    radius: 16
                    color: editPopup.editColor
                    border.color: "black"
                    MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: colorDialog.open() }
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 6
                Label {
                    text: qsTr("标签:")
                    color:Style.text
                }

                Flow {
                    Layout.fillWidth: true
                    spacing: 6
                    Repeater {
                        model: editPopup.editTags
                        delegate: Rectangle {
                            required property int index
                            required property string modelData
                            height: 32; radius: 16
                            implicitWidth: tagLayout.implicitWidth
                            color: Qt.rgba(editPopup.editColor.r, editPopup.editColor.g, editPopup.editColor.b, 0.2)
                            RowLayout {
                                id: tagLayout
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left; anchors.right: parent.right
                                anchors.leftMargin: 8; anchors.rightMargin: 4
                                spacing: 4
                                Label {
                                    text: modelData
                                    color: {
                                        let lum = 0.299*editPopup.editColor.r + 0.587*editPopup.editColor.g + 0.114*editPopup.editColor.b
                                        return lum > 0.6 ? "black" : "white"
                                    }
                                }
                                ToolButton {
                                    text: "×"
                                    onClicked: {
                                        var newTags = editPopup.editTags.slice()
                                        newTags.splice(index, 1)
                                        editPopup.editTags = newTags
                                    }
                                }
                            }
                        }
                    }
                }
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 6
                    TextField {
                        id: tagInput
                        Layout.fillWidth: true
                        placeholderText: qsTr("输入新标签后按 Enter")
                        color:Style.text
                        onAccepted: {
                            let t = tagInput.text.trim()
                                    if (t !== "" && editPopup.editTags.indexOf(t) === -1) {
                                        editPopup.editTags = editPopup.editTags.concat([t])
                                        tagInput.text = ""
                                    }
                        }
                    }
                    Button {
                        text: qsTr("添加")
                        Layout.preferredWidth: 80
                        onClicked: {
                            let t = tagInput.text.trim()
                                    if (t !== "" && editPopup.editTags.indexOf(t) === -1) {
                                        editPopup.editTags = editPopup.editTags.concat([t])
                                        tagInput.text = ""
                                    }
                        }
                    }

                }
            }

            Item { Layout.fillHeight: true }

            RowLayout {
                Layout.fillWidth: true
                spacing: 10
                Button {
                    text: qsTr("保存")
                    Layout.fillWidth: true
                    highlighted: true
                    onClicked: {
                        // 获取正确的源模型索引
                        ElementModel.modifyElementById(
                            editPopup.cardId,
                            titleField.text,
                            descField.text,
                            editPopup.editColor,
                            editPopup.editTags
                        )
                        editPopup.close()
                    }
                }
                Button {
                    text: qsTr("取消")
                    Layout.fillWidth: true
                    onClicked: editPopup.close()
                }
            }
        }

        ColorDialog {
            id: colorDialog
            onAccepted: editPopup.editColor = colorDialog.selectedColor
        }
    }

    // 状态查看弹窗
    Popup {
        id: statusViewPopup
        width: 500
        height: 600
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        anchors.centerIn: Overlay.overlay

        property var elementStatus: ({})  // 存储元素状态数据

        background: Rectangle {
           color: Style.panelBg
        }

        function prepareAndOpen() {
            // 获取元素状态数据
            var elementData = DataManager.getElementStatus(model.eid.toString())
            elementStatus = elementData.estatus || {}
            //console.log("查看弹窗 - 元素ID:", model.eid.toString(), "状态数据:", JSON.stringify(elementStatus))
            open()
            
            // 确保状态数据传递给查看组件
            if (statusViewer.item) {
                statusViewer.item.statusColor = model.ecolor
                statusViewer.item.elementStatus = elementStatus
            }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: Style.spacing
            spacing: Style.spacing

            Label {
                text: qsTr("元素状态 - ") + model.etitle
                font: Style.titleFont
                Layout.alignment: Qt.AlignHCenter
                color:Style.text
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                ColumnLayout {
                    width: parent.width
                    spacing: Style.spacing

                    // 根据元素类型显示不同的状态信息
                    Loader {
                        id: statusViewer
                        Layout.fillWidth: true
                        source: {
                            switch(model.etype) {
                            case ElementType.Character:
                                return "CharacterStatusView.qml"
                            case ElementType.Location:
                                return "LocationStatusView.qml"
                            case ElementType.Item:
                                return "ItemStatusView.qml"
                            case ElementType.Abilities:
                                return "AbilityStatusView.qml"
                            case ElementType.Organisation:
                                return "OrganizationStatusView.qml"
                            case ElementType.Event:
                                return "EventStatusView.qml"
                            default:
                                return ""
                            }
                        }
                        onLoaded: {
                            if (item) {
                                // 确保状态数据正确传递给查看组件
                                item.elementStatus = statusViewPopup.elementStatus
                                // 检查item是否有statusColor属性再赋值
                                if (item.hasOwnProperty("statusColor")) {
                                    item.statusColor = model.ecolor
                                }
                            }
                        }
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 10
                Button {
                    text: qsTr("关闭")
                    Layout.fillWidth: true
                    onClicked: statusViewPopup.close()
                }
            }
        }
    }

    // 状态编辑弹窗
    Popup {
        id: statusEditPopup
        width: 500
        height: 600
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        anchors.centerIn: Overlay.overlay

        property var elementStatus: ({})  // 存储元素状态数据

        background: Rectangle {
           color: Style.panelBg
        }

        function prepareAndOpen() {
            // 获取元素状态数据
            var elementData = DataManager.getElementStatus(model.eid.toString())
            elementStatus = elementData.estatus || {}
            //console.log("编辑弹窗 - 元素ID:", model.eid.toString(), "状态数据:", JSON.stringify(elementStatus))
            open()
            
            // 确保状态数据传递给编辑组件
            if (statusEditor.item) {
                statusEditor.item.elementStatus = elementStatus
            }
        }

        // 添加一个方法来刷新编辑器显示
        function refreshEditorDisplay() {
            if (statusEditor.item) {
                statusEditor.item.elementStatus = elementStatus
            }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: Style.spacing
            spacing: Style.spacing

            Label {
                text: qsTr("编辑元素状态 - ") + model.etitle
                font: Style.titleFont
                Layout.alignment: Qt.AlignHCenter
                color:Style.text
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                ColumnLayout {
                    width: parent.width
                    spacing: Style.spacing

                    // 根据元素类型显示不同的编辑表单
                    Loader {
                        id: statusEditor
                        Layout.fillWidth: true
                        source: {
                            switch(model.etype) {
                            case ElementType.Character:
                                return "CharacterStatusEdit.qml"
                            case ElementType.Location:
                                return "LocationStatusEdit.qml"
                            case ElementType.Item:
                                return "ItemStatusEdit.qml"
                            case ElementType.Abilities:
                                return "AbilityStatusEdit.qml"
                            case ElementType.Organisation:
                                return "OrganizationStatusEdit.qml"
                            case ElementType.Event:
                                return "EventStatusEdit.qml"
                            default:
                                return ""
                            }
                        }
                        onLoaded: {
                            if (item) {
                                item.elementStatus = statusEditPopup.elementStatus
                                // 检查item是否有statusColor属性再赋值
                                if (item.hasOwnProperty("statusColor")) {
                                    item.statusColor = model.ecolor
                                }
                                // 建立双向绑定，确保子组件的修改能反映到父组件
                                item.onElementStatusUpdated.connect(function() {
                                    statusEditPopup.elementStatus = item.elementStatus
                                })
                            }
                        }
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 10
                Button {
                    text: qsTr("保存")
                    Layout.fillWidth: true
                    highlighted: true
                    onClicked: {
                        // 确保状态编辑器同步临时状态数据
                        if (statusEditor.item && statusEditor.item.hasOwnProperty("syncTempStateToElementStatus")) {
                            statusEditor.item.syncTempStateToElementStatus()
                        }
                        
                        // 保存状态数据并关联到当前故事项
                        DataManager.updateElementStatusAndAssociate(model.eid.toString(), statusEditPopup.elementStatus)
                        statusEditPopup.close()
                    }
                }
                Button {
                    text: qsTr("取消")
                    Layout.fillWidth: true
                    onClicked: statusEditPopup.close()
                }
            }
        }
    }
}
