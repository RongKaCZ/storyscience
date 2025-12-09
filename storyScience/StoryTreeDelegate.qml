// StoryTreeDelegate.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import storyScience 1.0
import StoryType 1.0

TreeViewDelegate {
    id: delegate

    property var treeViewRef: undefined
    property var contextMenuRef: undefined

    width: treeViewRef ? treeViewRef.width : 200
    height: 30
    padding: 4
    indentation: 20

    required property int itemType

    scale: hovered ? 1.02 : 1.0
    Behavior on scale { NumberAnimation { duration: Style.durationShort; easing.type: Easing.InOutQuad } }

    NodeEditDialog {
        id: nodeEditDialog
        onTextAccepted: (nodeId, newTitle) => {
            delegate.treeViewRef.model.setData(treeViewRef.selectionModel.currentIndex, newTitle, Qt.UserRole + 3)
        }
    }

    indicator: Item {
        x: delegate.padding + (delegate.depth * delegate.indentation)
        width: 18; height: 18
        anchors.verticalCenter: parent.verticalCenter
        visible: delegate.isTreeNode && delegate.hasChildren

        Rectangle {
            anchors.centerIn: parent
            width: 18; height: 18; radius: 9
            color: {
                if (delegate.selected) return Qt.darker(Style.primary, 1.3)
                if (delegate.hovered) return Qt.darker(Style.primary, 1.1)
                return Qt.lighter(Style.primary, 1.3)
            }
            opacity: delegate.hovered ? 1 : 0.9
            scale: delegate.hovered ? 1.1 : 1.0
            Behavior on scale { NumberAnimation { duration: Style.durationShort; easing.type: Easing.InOutQuad } }

            Image {
                id: arrowIcon
                anchors.centerIn: parent
                width: 15; height: 15;
                source: "qrc:/icons/Right.png"
                rotation: delegate.expanded ? 90 : 0
                opacity: delegate.selected ? 1 : 0.8
                Behavior on rotation { NumberAnimation { duration: Style.durationShort; easing.type: Easing.InOutQuad } }
                Behavior on opacity { NumberAnimation { duration: Style.durationShort; easing.type: Easing.InOutQuad } }
            }
        }
        TapHandler { onTapped: if (treeViewRef) treeViewRef.toggleExpanded(row) }
    }

    contentItem: RowLayout {
        anchors.verticalCenter: parent.verticalCenter
        spacing: 5

        Image {
            Layout.preferredWidth: 16
            Layout.preferredHeight: 16
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            source: {
                switch(delegate.itemType) {
                    case StoryType.Book: return "qrc:/icons/Book.svg"
                    case StoryType.Volume: return "qrc:/icons/Volume.svg"
                    case StoryType.Chapter: return "qrc:/icons/Chapter.svg"
                    case StoryType.Scene: return "qrc:/icons/Scene.svg"
                    default: return "qrc:/icons/Root.png"
                }
            }
            opacity: delegate.selected ? 1 : 0.7
            Behavior on opacity { NumberAnimation { duration: Style.durationShort; easing.type: Easing.InOutQuad } }
        }
        
        // 保留文本注释作为参考
        // Label {
        //     text: {
        //         switch(delegate.itemType) {
        //             case StoryType.Book: return "书:"
        //             case StoryType.Volume: return "卷:"
        //             case StoryType.Chapter: return "章:"
        //             case StoryType.Scene: return "场景:"
        //             default: return ""
        //         }
        //     }
        //     horizontalAlignment: Text.AlignLeft
        //     color: delegate.selected ? Style.textHighlight : Style.text
        //     font: Style.articleFont
        //     opacity: delegate.selected ? 1 : 0.7
        //     Behavior on opacity { NumberAnimation { duration: Style.durationShort; easing.type: Easing.InOutQuad } }
        //     Behavior on color { ColorAnimation { duration: Style.durationShort; easing.type: Easing.InOutQuad } }
        // }

        Label {
            text: model.display
            elide: Text.ElideNone  // 修改为不截断文本
            
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignLeft
            wrapMode: Text.NoWrap  // 保持单行显示
            
            color: {
                if (delegate.selected) return Style.textHighlight
                if (delegate.hovered) return Qt.darker(Style.text, 1.1)
                return Style.text
            }
            font: Style.articleFont
            layer.enabled: delegate.selected
            layer.effect: DropShadow {
                horizontalOffset: 0; verticalOffset: 0; radius: 2.0; samples: 4
                color: delegate.selected ? Qt.rgba(0, 0, 0, 0.3) : "transparent"
            }
            Behavior on color { ColorAnimation { duration: Style.durationShort; easing.type: Easing.InOutQuad } }
        }
    }

    background: Rectangle {
        id: backgroundRect
        radius: Style.radiusSmall
        border.width: 1; border.color: "transparent"
        gradient: Gradient {
            GradientStop {
                position: 0.0;
                color: {
                    if (delegate.selected) return Qt.lighter(Style.highlight, 1.2)
                    if (delegate.hovered) return Qt.lighter(Style.highlightHover, 1.3)
                    return "transparent"
                }
            }
            GradientStop {
                position: 1.0;
                color: {
                    if (delegate.selected) return Style.highlight
                    if (delegate.hovered) return Style.highlightHover
                    return "transparent"
                }
            }
        }
        Rectangle {
            anchors.fill: parent; radius: parent.radius; color: "transparent"
            border.width: 2; border.color: delegate.hovered ? Qt.rgba(Style.primary.r, Style.primary.g, Style.primary.b, 0.3) : "transparent"
            opacity: delegate.hovered ? 1 : 0
            Behavior on opacity { NumberAnimation { duration: Style.durationShort; easing.type: Easing.InOutQuad } }
            Behavior on border.color { ColorAnimation { duration: Style.durationShort; easing.type: Easing.InOutQuad } }
        }
        Rectangle {
            anchors.fill: parent; radius: parent.radius; color: "transparent"
            border.width: delegate.selected ? 2 : 0; border.color: delegate.selected ? Style.textHighlight : "transparent"
            opacity: delegate.selected ? 0.7 : 0
            Behavior on border.width { NumberAnimation { duration: Style.durationShort; easing.type: Easing.InOutQuad } }
            Behavior on opacity { NumberAnimation { duration: Style.durationShort; easing.type: Easing.InOutQuad } }
        }
        layer.enabled: delegate.selected
        layer.effect: DropShadow {
            horizontalOffset: 0; verticalOffset: 1; radius: 4.0; samples: 12
            color: Style.shadow; cached: true
        }
        Behavior on gradient { PropertyAnimation { duration: Style.durationShort; easing.type: Easing.InOutQuad } }
        Behavior on border.color { ColorAnimation { duration: Style.durationShort; easing.type: Easing.InOutQuad } }
    }

    TapHandler {
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onTapped: (eventPoint, button)=> {
            if(button == Qt.RightButton && contextMenuRef){
                contextMenuRef.currentItemType = delegate.itemType
                contextMenuRef.open()
            }
        }
        onDoubleTapped:{
            nodeEditDialog.currentText = model.display
            nodeEditDialog.open();
        }
    }

    onDoubleClicked: {
        if (treeViewRef) {
            var data = DataManager.storyModel.getItemData(treeViewRef.selectionModel.currentIndex)
        }
    }
}
