// LocationStatusEdit.qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import storyScience 1.0

ColumnLayout {
    id: root
    property var elementStatus: ({})
    // 修改信号名称，避免与属性的默认信号重名
    signal elementStatusUpdated()
    
    // 临时存储界面状态的属性
    property var tempResources: []
    
    // 初始化临时状态
    function initializeTempState() {
        tempResources = (elementStatus.resources || []).slice()
    }
    
    // 同步临时状态到主状态对象
    function syncTempStateToElementStatus() {
        if (!elementStatus) elementStatus = {}
        elementStatus.resources = tempResources.slice()
    }
    
    // 组件加载时初始化临时状态
    Component.onCompleted: {
        initializeTempState()
    }
    
    // 当外部elementStatus更新时，重新初始化临时状态
    onElementStatusChanged: {
        initializeTempState()
    }
    
    // 当临时状态改变时，同步到主状态
    onTempResourcesChanged: syncTempStateToElementStatus()
    
    spacing: Style.spacing
    
    // 标题区域 - 增强视觉效果
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 50
        color: Qt.rgba(Style.primary.r, Style.primary.g, Style.primary.b, 0.15)
        radius: Style.radius
        Layout.bottomMargin: Style.spacing

        // 添加阴影效果
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 2
            radius: 8
            samples: 16
            color: Style.cardShadow
        }

        Label {
            text: qsTr("地点信息编辑")
            font: Style.titleFont
            color: Style.text
            anchors.centerIn: parent
        }
    }

    // 基本信息卡片 - 统一卡片样式
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: childrenRect.height
        color: Style.cardBg
        radius: Style.radius
        Layout.topMargin: Style.spacing
        Layout.bottomMargin: Style.spacing

        // 添加边框和阴影
        border.color: Style.border
        border.width: Style.borderWidth
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 3
            radius: 10
            samples: 16
            color: Style.cardShadow
        }

        ColumnLayout {
            anchors.margins: Style.padding
            width: parent.width
            spacing: Style.spacingMedium

            Label {
                text: qsTr("基本信息")
                font: Style.titleFont
                color: Style.text
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Style.border
            }

            Label {
                text: qsTr("地区:")
                color: Style.text
            }
            TextField {
                text: elementStatus.region || ""
                Layout.fillWidth: true
                color: Style.text
                selectByMouse: true
                background: Rectangle {
                    color: Style.textFieldBg
                    border.color: Style.textFieldBorder
                    border.width: Style.borderWidth
                    radius: Style.textFieldRadius
                }
                onTextChanged: {
                    if (!elementStatus) elementStatus = {}
                    if (elementStatus.region !== text) {
                        elementStatus.region = text
                        elementStatusUpdated()
                    }
                }
            }

            Label {
                text: qsTr("人口:")
                color: Style.text
            }
            TextField {
                text: elementStatus.population || qsTr("100万人")
                Layout.fillWidth: true
                color: Style.text
                selectByMouse: true
                background: Rectangle {
                    color: Style.textFieldBg
                    border.color: Style.textFieldBorder
                    border.width: Style.borderWidth
                    radius: Style.textFieldRadius
                }
                onTextChanged: {
                    if (!elementStatus) elementStatus = {}
                    if (elementStatus.population !== text) {
                        elementStatus.population = text
                        elementStatusUpdated()
                    }
                }
            }

            Label {
                text: qsTr("控制组织ID:")
                color: Style.text
            }
            TextField {
                text: elementStatus.control || ""
                Layout.fillWidth: true
                color: Style.text
                selectByMouse: true
                background: Rectangle {
                    color: Style.textFieldBg
                    border.color: Style.textFieldBorder
                    border.width: Style.borderWidth
                    radius: Style.textFieldRadius
                }
                onTextChanged: {
                    if (!elementStatus) elementStatus = {}
                    if (elementStatus.control !== text) {
                        elementStatus.control = text
                        elementStatusUpdated()
                    }
                }
            }

            Label {
                text: qsTr("重要性:")
                color: Style.text
            }
            TextField {
                text: elementStatus.importance || qsTr("罕见")
                Layout.fillWidth: true
                color: Style.text
                selectByMouse: true
                background: Rectangle {
                    color: Style.textFieldBg
                    border.color: Style.textFieldBorder
                    border.width: Style.borderWidth
                    radius: Style.textFieldRadius
                }
                onTextChanged: {
                    if (!elementStatus) elementStatus = {}
                    if (elementStatus.importance !== text) {
                        elementStatus.importance = text
                        elementStatusUpdated()
                    }
                }
            }

            Label {
                text: qsTr("坐标:")
                color: Style.text
            }
            TextField {
                text: elementStatus.coordinates || ""
                Layout.fillWidth: true
                color: Style.text
                selectByMouse: true
                background: Rectangle {
                    color: Style.textFieldBg
                    border.color: Style.textFieldBorder
                    border.width: Style.borderWidth
                    radius: Style.textFieldRadius
                }
                onTextChanged: {
                    if (!elementStatus) elementStatus = {}
                    if (elementStatus.coordinates !== text) {
                        elementStatus.coordinates = text
                        elementStatusUpdated()
                    }
                }
            }

            Label {
                text: qsTr("气候:")
                color: Style.text
            }
            TextField {
                text: elementStatus.climate || ""
                Layout.fillWidth: true
                color: Style.text
                selectByMouse: true
                background: Rectangle {
                    color: Style.textFieldBg
                    border.color: Style.textFieldBorder
                    border.width: Style.borderWidth
                    radius: Style.textFieldRadius
                }
                onTextChanged: {
                    if (!elementStatus) elementStatus = {}
                    if (elementStatus.climate !== text) {
                        elementStatus.climate = text
                        elementStatusUpdated()
                    }
                }
            }

            Label {
                text: qsTr("可达性:")
                color: Style.text
            }
            TextField {
                text: elementStatus.accessibility || qsTr("不可达")
                Layout.fillWidth: true
                color: Style.text
                selectByMouse: true
                background: Rectangle {
                    color: Style.textFieldBg
                    border.color: Style.textFieldBorder
                    border.width: Style.borderWidth
                    radius: Style.textFieldRadius
                }
                onTextChanged: {
                    if (!elementStatus) elementStatus = {}
                    if (elementStatus.accessibility !== text) {
                        elementStatus.accessibility = text
                        elementStatusUpdated()
                    }
                }
            }
        }
    }

    // 详情卡片
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: childrenRect.height
        color: Style.cardBg
        radius: Style.radius
        Layout.topMargin: Style.spacing
        Layout.bottomMargin: Style.spacing

        // 添加边框和阴影
        border.color: Style.border
        border.width: Style.borderWidth
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 3
            radius: 10
            samples: 16
            color: Style.cardShadow
        }

        ColumnLayout {
            anchors.margins: Style.padding
            width: parent.width
            spacing: Style.spacingMedium

            Label {
                text: qsTr("详情")
                font: Style.titleFont
                color: Style.text
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Style.border
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.preferredHeight: 150

                TextArea {
                    text: elementStatus.details || qsTr("无")
                    font: Style.bodyFont
                    color: Style.text
                    wrapMode: Text.Wrap
                    selectByMouse: true
                    background: Rectangle { color: "transparent" }
                    onTextChanged: {
                        if (!elementStatus) elementStatus = {}
                        if (elementStatus.details !== text) {
                            elementStatus.details = text
                            elementStatusUpdated()
                        }
                    }
                }
            }
        }
    }
    
    // 资源列表卡片
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: childrenRect.height
        color: Style.cardBg
        radius: Style.radius
        Layout.topMargin: Style.spacing
        Layout.bottomMargin: Style.spacing

        // 添加边框和阴影
        border.color: Style.border
        border.width: Style.borderWidth
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 3
            radius: 10
            samples: 16
            color: Style.cardShadow
        }

        ColumnLayout {
            anchors.margins: Style.padding
            width: parent.width
            spacing: Style.spacingMedium

            Label {
                text: qsTr("资源列表")
                font: Style.titleFont
                color: Style.text
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Style.border
            }

            // 资源列表编辑器
            ColumnLayout {
                Layout.fillWidth: true
                spacing: Style.spacingSmall

                // 显示已添加的资源
                Repeater {
                    model: tempResources
                    delegate: Rectangle {
                        required property int index
                        required property string modelData
                        Layout.fillWidth: true
                        height: 60
                        radius: 16
                        color: Qt.rgba(Style.primary.r, Style.primary.g, Style.primary.b, 0.2)

                        RowLayout {
                            anchors.fill: parent
                            spacing: 8

                            Item {
                                width: 8
                            }

                            ScrollView {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 44

                                Layout.alignment: Text.AlignHCenter

                                TextArea {
                                    text: modelData
                                    color: {
                                        let luminance = 0.299 * Style.primary.r +
                                                        0.587 * Style.primary.g +
                                                        0.114 * Style.primary.b;
                                        return luminance > 0.6 ? "black" : "white";
                                    }
                                    font: Style.bodyFont
                                    wrapMode: Text.Wrap
                                    readOnly: true
                                    background: Rectangle { color: "transparent" }
                                }
                            }

                            ToolButton {
                                id: closeResourceButton
                                text: qsTr("×")
                                Layout.alignment: Qt.AlignRight | Qt.AlignHCenter
                                Layout.preferredWidth: 50
                                Layout.topMargin: 8
                                background: Rectangle {
                                    color: closeResourceButton.hovered ? Qt.rgba(0, 0, 0, 0.1) : "transparent"
                                    radius: 12
                                }
                                onClicked: {
                                    var resources = tempResources.slice()
                                    resources.splice(index, 1)
                                    tempResources = resources
                                    parent.elementStatusUpdated()
                                }
                            }

                            Item {
                                width: 8
                            }
                        }
                    }
                }

                // 添加新资源的输入行
                RowLayout {
                    Layout.fillWidth: true
                    spacing: Style.spacingSmall

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 100

                        TextArea {
                            id: newResource
                            placeholderText: qsTr("资源名称")
                            Layout.fillWidth: true
                            wrapMode: Text.Wrap
                            color: Style.text
                            selectByMouse: true
                        }
                    }
                    Button {
                        text: qsTr("添加")
                        font: Style.buttonFont
                        background: Rectangle {
                            color: Style.buttonPrimaryBg
                            border.color: Style.buttonPrimaryBorder
                            border.width: Style.borderWidth
                            radius: Style.buttonRadius
                        }
                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: Style.buttonPrimaryText
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: {
                            if (newResource.text) {
                                var resources = tempResources.slice()
                                resources.push(newResource.text)
                                tempResources = resources
                                newResource.text = ""
                                elementStatusUpdated()
                            }
                        }
                    }
                }
            }
        }
    }
}
