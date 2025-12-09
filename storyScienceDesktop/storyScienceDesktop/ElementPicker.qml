// ElementPicker.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import storyScience 1.0
import ElementType 1.0

Dialog {
    id: root

    // Renamed the signal to avoid conflict with the built-in 'accepted' signal.
    signal elementsSelected(var selectedElementIds)

    property var selections: ({})

    title: qsTr("选择要关联的元素")
    width: 800
    height: 600
    modal: true
    standardButtons: Dialog.Ok | Dialog.Cancel

    onOpened: {
        selections = ({})
    }

    // This is the handler for the Dialog's built-in 'accepted' signal (when OK is clicked).
    onAccepted: {
        // Emit our own custom signal with the data.
        elementsSelected(Object.keys(selections))
    }

    // --- Main Layout ---
    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        TabBar {
            id: tabBar
            Layout.fillWidth: true
            TabButton { text: qsTr("人物") }
            TabButton { text: qsTr("地点") }
            TabButton { text: qsTr("道具") }
            TabButton { text: qsTr("能力") }
            TabButton { text: qsTr("组织") }
            TabButton { text: qsTr("事件") }
        }

        StackLayout {
            id: stackLayout
            Layout.fillWidth: true
            Layout.fillHeight: true
            currentIndex: tabBar.currentIndex

            // View 1: Characters
            GridView {
                model: DataManager.allCharacterModel
                cellWidth: width / 4
                cellHeight: 120
                clip: true
                delegate: gridDelegate
            }

            // View 2: Locations
            GridView {
                model: DataManager.allLocationModel
                cellWidth: width / 4
                cellHeight: 120
                clip: true
                delegate: gridDelegate
            }

            // View 3: Items
            GridView {
                model: DataManager.allItemModel
                cellWidth: width / 4
                cellHeight: 120
                clip: true
                delegate: gridDelegate
            }
            // View 4: Abilities
            GridView {
                model: DataManager.allAbilitiesModel
                cellWidth: width / 4
                cellHeight: 120
                clip: true
                delegate: gridDelegate
            }
            // View 5: origanisation
            GridView {
                model: DataManager.allOriganisationModel
                cellWidth: width / 4
                cellHeight: 120
                clip: true
                delegate: gridDelegate
            }
            // View 6: Events
            GridView {
                model: DataManager.allEventModel
                cellWidth: width / 4
                cellHeight: 120
                clip: true
                delegate: gridDelegate
            }
        }
    }

    // --- Reusable Delegate Component ---
    Component {
        id: gridDelegate
        Frame {
            width: GridView.view.cellWidth - 10
            height: GridView.view.cellHeight - 10
            property bool isSelected: root.selections.hasOwnProperty(model.eid.toString())

            background: Rectangle {
                radius: Style.radiusSmall
                color: isSelected ? Style.gray : Style.white
                border.width: 2
                border.color: isSelected ? Style.primary : "transparent"
                Behavior on color { ColorAnimation { duration: 150 } }
                Behavior on border.color { ColorAnimation { duration: 150 } }
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 8
                Image {
                    source: model.eicon
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 32
                    Layout.preferredHeight: 32
                    fillMode: Image.PreserveAspectFit
                }
                Label {
                    text: model.etitle
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    elide: Text.ElideRight
                    font.bold: true
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    var idStr = model.eid.toString();
                    if (root.selections[idStr]) {
                        delete root.selections[idStr];
                    } else {
                        root.selections[idStr] = true;
                    }
                    root.selections = root.selections;
                }
            }
        }
    }

}
