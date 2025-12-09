import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ComboBox {
    id: comboBox

    // 主题与样式
    property bool isDark: Style.isDark
    property color primaryColor: Style.primary
    property color textColor: Style.text
    property color backgroundColor: Style.popupBackground
    property color hoverColor: Style.hover
    property color borderColor: Style.border
    property color selectedBgColor: primaryColor
    property color selectedTextColor: Style.text

    // 自定义显示文字逻辑
    property string currentLabel: {
        if (comboBox.model && comboBox.currentIndex >= 0) {
            var item = comboBox.model[comboBox.currentIndex]
            if (item && typeof item === "object" && item.name)
                return item.name
            return item
        }
        return ""
    }

    // 下拉项代理
    delegate: ItemDelegate {
        width: comboBox.width
        highlighted: comboBox.highlightedIndex === index
        hoverEnabled: true

        background: Rectangle {
            anchors.fill: parent
            color: highlighted
                   ? comboBox.selectedBgColor
                   : (hoverHandler.hovered ? comboBox.hoverColor : "transparent")
            Behavior on color { ColorAnimation { duration: 120 } }
        }

        HoverHandler { id: hoverHandler }

        contentItem: Row {
            spacing: 6
            anchors.verticalCenter: parent.verticalCenter

            Image {
                source: modelData.icon ? modelData.icon : ""
                width: 20
                height: 20
                visible: !!modelData.icon
                fillMode: Image.PreserveAspectFit
            }

            Text {
                text: modelData.name ? modelData.name : modelData
                color: highlighted ? comboBox.selectedTextColor : comboBox.textColor
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    // 当前选中项显示
    contentItem: Row {
        spacing: 6
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.rightMargin: 24

        Image {
            source: comboBox.currentIndex >= 0 &&
                    comboBox.model[comboBox.currentIndex] &&
                    comboBox.model[comboBox.currentIndex].icon
                    ? comboBox.model[comboBox.currentIndex].icon
                    : ""
            width: 30
            height: 30
            visible: comboBox.currentIndex >= 0 &&
                     comboBox.model[comboBox.currentIndex] &&
                     !!comboBox.model[comboBox.currentIndex].icon
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: comboBox.currentLabel   //currentLabel
            color: comboBox.enabled ? comboBox.textColor : "#999"
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
            height: 20
            font.pixelSize: 14
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    // 下拉箭头
    indicator: Canvas {
        id: arrow
        width: 12
        height: 12
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        rotation: comboBox.popup.opened ? 180 : 0
        Behavior on rotation { NumberAnimation { duration: 150 } }

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            ctx.strokeStyle = comboBox.textColor;
            ctx.lineWidth = 2;
            ctx.beginPath();
            ctx.moveTo(2, 4);
            ctx.lineTo(width / 2, height - 3);
            ctx.lineTo(width - 2, 4);
            ctx.stroke();
        }
    }

    // 背景
    background: Rectangle {
        radius: 6
        color: comboBox.backgroundColor
        border.color: comboBox.borderColor
        border.width: comboBox.visualFocus ? 2 : 1
        Behavior on border.color { ColorAnimation { duration: 100 } }
    }

    // 下拉菜单
    popup: Popup {
        y: comboBox.height - 1
        width: comboBox.width
        implicitHeight: contentItem.implicitHeight
        background: Rectangle {
            radius: 6
            color: comboBox.backgroundColor
            border.color: comboBox.borderColor
        }

        contentItem: ListView {
            model: comboBox.delegateModel
            implicitHeight: contentHeight
            currentIndex: comboBox.highlightedIndex
            clip: true
        }
    }
}
