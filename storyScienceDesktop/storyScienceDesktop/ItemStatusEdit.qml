// ItemStatusEdit.qml
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
    property var tempEffects: []
    
    // 初始化临时状态
    function initializeTempState() {
        tempEffects = (elementStatus.effects || []).slice()
    }
    
    // 同步临时状态到主状态对象
    function syncTempStateToElementStatus() {
        if (!elementStatus) elementStatus = {}
        elementStatus.effects = tempEffects.slice()
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
    onTempEffectsChanged: syncTempStateToElementStatus()
    
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
            text: qsTr("物品信息编辑")
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
                text: qsTr("稀有度:")
                color: Style.text
            }
            TextField {
                text: elementStatus.rarity || qsTr("稀有")
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
                    if (elementStatus.rarity !== text) {
                        elementStatus.rarity = text
                        elementStatusUpdated()
                    }
                }
            }

            Label {
                text: qsTr("类别:")
                color: Style.text
            }
            TextField {
                text: elementStatus.category || ""
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
                    if (elementStatus.category !== text) {
                        elementStatus.category = text
                        elementStatusUpdated()
                    }
                }
            }

            Label {
                text: qsTr("耐久度:")
                color: Style.text
            }
            TextField {
                text: elementStatus.durability || "100"
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
                    if (elementStatus.durability !== text) {
                        elementStatus.durability = text
                        elementStatusUpdated()
                    }
                }
            }

            Label {
                text: qsTr("价值:")
                color: Style.text
            }
            TextField {
                text: elementStatus.value || "0"
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
                    if (elementStatus.value !== text) {
                        elementStatus.value = text
                        elementStatusUpdated()
                    }
                }
            }

            Label {
                text: qsTr("所有者ID:")
                color: Style.text
            }
            TextField {
                text: elementStatus.ownerId || ""
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
                    if (elementStatus.ownerId !== text) {
                        elementStatus.ownerId = text
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

    // 效果列表卡片
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
                text: qsTr("效果列表")
                font: Style.titleFont
                color: Style.text
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Style.border
            }

            // 效果列表编辑器
            ColumnLayout {
                Layout.fillWidth: true
                spacing: Style.spacingSmall

                // 显示已添加的效果
                Repeater {
                    model: tempEffects
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
                                id: closeEffectButton
                                text: qsTr("×")
                                Layout.alignment: Qt.AlignRight | Qt.AlignHCenter
                                Layout.preferredWidth: 50
                                Layout.topMargin: 8
                                background: Rectangle {
                                    color: closeEffectButton.hovered ? Qt.rgba(0, 0, 0, 0.1) : "transparent"
                                    radius: 12
                                }
                                onClicked: {
                                    var effects = tempEffects.slice()
                                    effects.splice(index, 1)
                                    tempEffects = effects
                                    parent.elementStatusUpdated()
                                }
                            }

                            Item {
                                width: 8
                            }
                        }
                    }
                }

                // 添加新效果的输入行
                RowLayout {
                    Layout.fillWidth: true
                    spacing: Style.spacingSmall

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 100

                        TextArea {
                            id: newEffect
                            placeholderText: qsTr("效果名称")
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
                            if (newEffect.text) {
                                var effects = tempEffects.slice()
                                effects.push(newEffect.text)
                                tempEffects = effects
                                newEffect.text = ""
                                elementStatusUpdated()
                            }
                        }
                    }
                }
            }
        }
    }
}
