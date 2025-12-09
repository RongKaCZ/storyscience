// CharacterStatusEdit.qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects
import storyScience 1.0

ColumnLayout {
    id: root
    property var elementStatus: ({})
    // 修改信号名称，避免与属性的默认信号重名
    signal elementStatusUpdated()
    
    // 临时存储界面状态的属性
    property var tempAttributes: ({})
    property var tempAbilities: []
    property var tempInventory: []
    property var tempStatusEffects: []
    
    // 初始化临时状态
    function initializeTempState() {
        tempAttributes = Object.assign({}, elementStatus.attributes || {})
        tempAbilities = (elementStatus.abilities || []).slice()
        tempInventory = (elementStatus.inventory || []).slice()
        tempStatusEffects = (elementStatus.statusEffects || []).slice()
    }
    
    // 同步临时状态到主状态对象
    function syncTempStateToElementStatus() {
        if (!elementStatus) elementStatus = {}
        
        // 同步所有临时状态到主状态对象
        elementStatus.attributes = Object.assign({}, tempAttributes)
        elementStatus.abilities = tempAbilities.slice()
        elementStatus.inventory = tempInventory.slice()
        elementStatus.statusEffects = tempStatusEffects.slice()
        
        // 确保其他字段也存在
        if (!elementStatus.level) elementStatus.level = ""
        if (!elementStatus.xp) elementStatus.xp = ""
        if (!elementStatus.stage) elementStatus.stage = ""
        if (!elementStatus.details) elementStatus.details = ""
        if (!elementStatus.biography) elementStatus.biography = ""
        if (!elementStatus.portrait) elementStatus.portrait = ""
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
    onTempAttributesChanged: syncTempStateToElementStatus()
    onTempAbilitiesChanged: syncTempStateToElementStatus()
    onTempInventoryChanged: syncTempStateToElementStatus()
    onTempStatusEffectsChanged: syncTempStateToElementStatus()
    
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
            text: qsTr("角色信息编辑")
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
                text: qsTr("等级:")
                color: Style.text
            }
            TextField {
                text: elementStatus.level || qsTr("青铜")
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
                    // 避免绑定循环，只在值真正改变时更新
                    if (elementStatus.level !== text) {
                        elementStatus.level = text
                        elementStatusUpdated()  // 发出信号
                    }
                }
            }

            Label {
                text: qsTr("经验值:")
                color: Style.text
            }
            TextField {
                text: elementStatus.xp || "100/200"
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
                    // 避免绑定循环，只在值真正改变时更新
                    if (elementStatus.xp !== text) {
                        elementStatus.xp = text
                        elementStatusUpdated()  // 发出信号
                    }
                }
            }

            Label {
                text: qsTr("阶段:")
                color: Style.text
            }
            TextField {
                text: elementStatus.stage || qsTr("1级")
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
                    // 避免绑定循环，只在值真正改变时更新
                    if (elementStatus.stage !== text) {
                        elementStatus.stage = text
                        elementStatusUpdated()  // 发出信号
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
                        // 避免绑定循环，只在值真正改变时更新
                        if (elementStatus.details !== text) {
                            elementStatus.details = text
                            elementStatusUpdated()  // 发出信号
                        }
                    }
                }
            }
        }
    }

    // 属性卡片
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
                text: qsTr("属性")
                font: Style.titleFont
                color: Style.text
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Style.border
            }

            // 属性编辑器
            ColumnLayout {
                Layout.fillWidth: true
                spacing: Style.spacingSmall

                // 显示已添加的属性
                Repeater {
                    model: Object.keys(tempAttributes)
                    delegate: Rectangle {
                        required property string modelData
                        Layout.fillWidth: true
                        height: 32
                        radius: 16
                        color: Qt.rgba(Style.primary.r, Style.primary.g, Style.primary.b, 0.2)

                        RowLayout {
                            anchors.fill: parent
                            spacing: 8

                            Item {
                                width: 8
                            }

                            Label {
                                text: modelData + ": " + (tempAttributes[modelData] || "")
                                color: {
                                    let luminance = 0.299 * Style.primary.r +
                                                    0.587 * Style.primary.g +
                                                    0.114 * Style.primary.b;
                                    return luminance > 0.6 ? "black" : "white";
                                }
                                Layout.fillWidth: true
                                elide: Text.ElideMiddle
                                horizontalAlignment: Text.AlignLeft | Text.AlignHCenter
                            }

                            ToolButton {
                                id: closeAttributeButton
                                text: qsTr("×")
                                Layout.alignment: Qt.AlignRight | Qt.AlignHCenter
                                Layout.preferredWidth: 50
                                background: Rectangle {
                                    color: closeAttributeButton.hovered ? Qt.rgba(0, 0, 0, 0.1) : "transparent"
                                    radius: 12
                                }
                                onClicked: {
                                    var attrs = Object.assign({}, tempAttributes)
                                    delete attrs[modelData]
                                    tempAttributes = attrs
                                    parent.elementStatusUpdated()
                                }
                            }

                            Item {
                                width: 8
                            }
                        }
                    }
                }

                // 添加新属性的输入行
                RowLayout {
                    Layout.fillWidth: true
                    spacing: Style.spacingSmall

                    TextField {
                        id: newAttrName
                        placeholderText: qsTr("属性名")
                        color: Style.text
                        Layout.fillWidth: true
                        selectByMouse: true
                        background: Rectangle {
                            color: Style.textFieldBg
                            border.color: Style.textFieldBorder
                            border.width: Style.borderWidth
                            radius: Style.textFieldRadius
                        }
                    }
                    TextField {
                        id: newAttrValue
                        color: Style.text
                        placeholderText: qsTr("属性值")
                        Layout.fillWidth: true
                        selectByMouse: true
                        background: Rectangle {
                            color: Style.textFieldBg
                            border.color: Style.textFieldBorder
                            border.width: Style.borderWidth
                            radius: Style.textFieldRadius
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
                            if (newAttrName.text && newAttrValue.text) {
                                // 创建新对象以触发更新
                                var attrs = Object.assign({}, tempAttributes)
                                attrs[newAttrName.text] = newAttrValue.text
                                tempAttributes = attrs
                                newAttrName.text = ""
                                newAttrValue.text = ""
                                elementStatusUpdated()
                            }
                        }
                    }
                }
            }
        }
    }

    // 能力列表卡片
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
                text: qsTr("能力列表")
                font: Style.titleFont
                color: Style.text
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Style.border
            }

            // 能力列表编辑器
            ColumnLayout {
                Layout.fillWidth: true
                spacing: Style.spacingSmall

                // 显示已添加的能力
                Repeater {
                    model: tempAbilities
                    delegate: Rectangle {
                        required property int index
                        required property string modelData
                        Layout.fillWidth: true
                        height: 32
                        radius: 16
                        color: Qt.rgba(Style.primary.r, Style.primary.g, Style.primary.b, 0.2)

                        RowLayout {
                            anchors.fill: parent
                            spacing: 8

                            Item {
                                width: 8
                            }

                            Label {
                                text: modelData
                                color: {
                                    let luminance = 0.299 * Style.primary.r +
                                                    0.587 * Style.primary.g +
                                                    0.114 * Style.primary.b;
                                    return luminance > 0.6 ? "black" : "white";
                                }
                                Layout.fillWidth: true
                                elide: Text.ElideMiddle
                                horizontalAlignment: Text.AlignLeft | Text.AlignHCenter
                            }

                            ToolButton {
                                id: closeAbilityButton
                                text: qsTr("×")
                                Layout.alignment: Qt.AlignRight | Qt.AlignHCenter
                                Layout.preferredWidth: 50
                                background: Rectangle {
                                    color: closeAbilityButton.hovered ? Qt.rgba(0, 0, 0, 0.1) : "transparent"
                                    radius: 12
                                }
                                onClicked: {
                                    var abilities = tempAbilities.slice()
                                    abilities.splice(index, 1)
                                    tempAbilities = abilities
                                    parent.elementStatusUpdated()
                                }
                            }

                            Item {
                                width: 8
                            }
                        }
                    }
                }

                // 添加新能力的输入行
                RowLayout {
                    Layout.fillWidth: true
                    spacing: Style.spacingSmall

                    TextField {
                        id: newAbility
                        placeholderText: qsTr("能力ID")
                        Layout.fillWidth: true
                        color: Style.text
                        selectByMouse: true
                        background: Rectangle {
                            color: Style.textFieldBg
                            border.color: Style.textFieldBorder
                            border.width: Style.borderWidth
                            radius: Style.textFieldRadius
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
                            if (newAbility.text) {
                                var abilities = root.tempAbilities.slice()
                                abilities.push(newAbility.text)
                                root.tempAbilities = abilities
                                newAbility.text = ""
                                parent.elementStatusUpdated()
                            }
                        }
                    }
                }
            }
        }
    }

    // 物品列表卡片
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
                text: qsTr("物品列表")
                font: Style.titleFont
                color: Style.text
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Style.border
            }

            // 物品列表编辑器
            ColumnLayout {
                Layout.fillWidth: true
                spacing: Style.spacingSmall

                // 显示已添加的物品
                Repeater {
                    model: tempInventory
                    delegate: Rectangle {
                        required property int index
                        required property string modelData
                        Layout.fillWidth: true
                        height: 32
                        radius: 16
                        color: Qt.rgba(Style.primary.r, Style.primary.g, Style.primary.b, 0.2)

                        RowLayout {
                            anchors.fill: parent
                            spacing: 8

                            Item {
                                width: 8
                            }

                            Label {
                                text: modelData
                                color: {
                                    let luminance = 0.299 * Style.primary.r +
                                                    0.587 * Style.primary.g +
                                                    0.114 * Style.primary.b;
                                    return luminance > 0.6 ? "black" : "white";
                                }
                                Layout.fillWidth: true
                                elide: Text.ElideMiddle
                                horizontalAlignment: Text.AlignLeft | Text.AlignHCenter
                            }

                            ToolButton {
                                id: closeItemButton
                                text: qsTr("×")
                                Layout.alignment: Qt.AlignRight | Qt.AlignHCenter
                                Layout.preferredWidth: 50
                                background: Rectangle {
                                    color: closeItemButton.hovered ? Qt.rgba(0, 0, 0, 0.1) : "transparent"
                                    radius: 12
                                }
                                onClicked: {
                                    var inventory = tempInventory.slice()
                                    inventory.splice(index, 1)
                                    tempInventory = inventory
                                    parent.elementStatusUpdated()
                                }
                            }

                            Item {
                                width: 8
                            }
                        }
                    }
                }

                // 添加新物品的输入行
                RowLayout {
                    Layout.fillWidth: true
                    spacing: Style.spacingSmall

                    TextField {
                        id: newItem
                        placeholderText: qsTr("物品ID")
                        Layout.fillWidth: true
                        color: Style.text
                        selectByMouse: true
                        background: Rectangle {
                            color: Style.textFieldBg
                            border.color: Style.textFieldBorder
                            border.width: Style.borderWidth
                            radius: Style.textFieldRadius
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
                            if (newItem.text) {
                                var inventory = tempInventory.slice()
                                inventory.push(newItem.text)
                                tempInventory = inventory
                                newItem.text = ""
                                elementStatusUpdated()
                            }
                        }
                    }
                }
            }
        }
    }

    // 状态效果卡片
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
                text: qsTr("状态效果")
                font: Style.titleFont
                color: Style.text
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Style.border
            }

            // 状态效果编辑器
            ColumnLayout {
                Layout.fillWidth: true
                spacing: Style.spacingSmall

                // 显示已添加的状态效果
                Repeater {
                    model: tempStatusEffects
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
                            Layout.alignment: Text.AlignHCenter

                            Item {
                                width: 8
                            }

                            ScrollView {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 44
                                Layout.alignment: Qt.AlignHCenter

                                TextArea {
                                    text: modelData
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignHCenter
                                    color: {
                                        let luminance = 0.299 * Style.primary.r +
                                                        0.587 * Style.primary.g +
                                                        0.114 * Style.primary.b;
                                        return luminance > 0.6 ? "black" : "white";
                                    }
                                    font: Style.bodyFont
                                    wrapMode: Text.Wrap
                                    readOnly: true
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
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
                                    var effects = tempStatusEffects.slice()
                                    effects.splice(index, 1)
                                    tempStatusEffects = effects
                                    parent.elementStatusUpdated();
                                }
                            }

                            Item {
                                width: 8
                            }
                        }

                    }
                }

                // 添加新状态效果的输入行
                RowLayout {
                    Layout.fillWidth: true
                    spacing: Style.spacingSmall

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 100
                        Layout.alignment: Text.AlignHCenter
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
                                var effects = tempStatusEffects.slice()
                                effects.push(newEffect.text)
                                tempStatusEffects = effects
                                newEffect.text = ""
                                elementStatusUpdated()  // 发出信号
                            }
                        }
                    }
                }
            }
        }
    }

    // 传记卡片
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
                text: qsTr("传记")
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
                Layout.preferredHeight: 200

                TextArea {
                    text: elementStatus.biography || ""
                    font: Style.bodyFont
                    color: Style.text
                    wrapMode: Text.Wrap
                    selectByMouse: true
                    background: Rectangle { color: "transparent" }
                    onTextChanged: {
                        if (!elementStatus) elementStatus = {}
                        // 避免绑定循环
                        if (elementStatus.biography !== text) {
                            elementStatus.biography = text
                            elementStatusUpdated()  // 发出信号
                        }
                    }
                }
            }
        }
    }

    // 头像卡片
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: childrenRect.height
        color: Style.cardBg
        radius: Style.radius
        Layout.topMargin: Style.spacing
        Layout.bottomMargin: Style.spacingMedium

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

            RowLayout {
                Layout.fillWidth: true

                Label {
                    text: qsTr("头像")
                    font: Style.titleFont
                    color: Style.text
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: Style.border
                }

                TextField {
                    id: portraitField
                    text: elementStatus.portrait || ""
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
                        // 避免绑定循环
                        if (elementStatus.portrait !== text) {
                            elementStatus.portrait = text
                            elementStatusUpdated()  // 发出信号
                        }
                    }
                }

                Button {
                    text: qsTr("选择")
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
                        fileDialog.open();
                    }
                }
            }
        }
    }

    FileDialog {
        id: fileDialog
        fileMode: FileDialog.OpenFile
        nameFilters: ["Image files (*.png *.jpg *.jpeg *.bmp)", "All files (*.*)"]
        onAccepted: portraitField.text = selectedFile
    }
}
