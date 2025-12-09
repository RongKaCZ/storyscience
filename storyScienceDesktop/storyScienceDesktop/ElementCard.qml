// ElementCard.qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import storyScience 1.0

Item {
    id: root

    property string cardTitle: qsTr("加载中...")
    property string cardDescription: ""
    property color typeColor: Style.secondary
    property url iconSource
    property var tags: []
    implicitHeight: mainLayout.implicitHeight
    ColumnLayout {
        id: mainLayout
        anchors.fill: parent
        spacing: Style.spacing

        RowLayout {
            Layout.fillWidth: true
            spacing: Style.spacingSmall
            Image {
                id: icon
                source: root.iconSource
                Layout.preferredWidth: Style.iconSize
                Layout.preferredHeight: Style.iconSize
                Layout.alignment: Qt.AlignTop
                visible: source.toString() !== ""
                fillMode: Image.PreserveAspectFit
                // MultiEffect {
                //     anchors.fill: parent
                //     source: parent
                //     colorization: 1.0
                //     colorizationColor: root.typeColor
                // }
            }
            Label {
                text: root.cardTitle
                color: Style.text
                Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                font: Style.titleFont
            }
        }

        Label {
            text: root.cardDescription
            color: Style.textSecondary
            Behavior on color { ColorAnimation { duration: Style.transitionDuration; easing.type: Style.ease } }
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
            visible: text.length > 0
            font: Style.bodyFont
        }

        Flow {
            id: tagFlow
            Layout.fillWidth: true
            spacing: Style.spacingSmall
            visible: root.tags && root.tags.length > 0
            Repeater {
                model: root.tags
                delegate: Rectangle {
                    height: 24
                    implicitWidth: tagText.implicitWidth + 16
                    color: Qt.rgba(root.typeColor.r, root.typeColor.g, root.typeColor.b, 0.15)
                    radius: Style.radiusSmall
                    required property string modelData
                    Label {
                        id: tagText
                        text: modelData
                        anchors.centerIn: parent
                        color: {
                            let luminance = 0.299 * root.typeColor.r +
                                            0.587 * root.typeColor.g +
                                            0.114 * root.typeColor.b;
                            return luminance > 0.6 ? "black" : "white";
                        }
                        font: Style.captionFont
                    }
                }
            }
        }
    }
}
