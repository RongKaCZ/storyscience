// OrganizationStatusEdit.qml
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
    property color statusColor : Style.primary
    // 列表使用临时数组
    property var tempResources: []
    property var tempMembers: []
    function initializeTempState() {
        tempResources = (elementStatus.resources || []).slice()
        tempMembers = (elementStatus.members || []).slice()
    }
    function syncTempStateToElementStatus() {
        if (!elementStatus) elementStatus = {}
        elementStatus.resources = (tempResources || []).slice()
        elementStatus.members = (tempMembers || []).slice()
    }
    Component.onCompleted: initializeTempState()
    onElementStatusChanged: initializeTempState()
    onTempResourcesChanged: syncTempStateToElementStatus()
    onTempMembersChanged: syncTempStateToElementStatus()
    
    spacing: Style.spacing
    
    // 标题区域 - 增强视觉效果
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 50
        color: Qt.rgba(statusColor.r, statusColor.g, statusColor.b, 0.15)
        radius: Style.radius
        Layout.bottomMargin: Style.spacing

        // 添加阴影效果
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 3
            radius: 10
            samples: 16
            color: Style.cardShadow
        }

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: Style.spacing
            anchors.rightMargin: Style.spacing

            Label {
                text: qsTr("组织状态编辑")
                font: Style.titleFont
                color: Style.text
                Layout.alignment: Qt.AlignVCenter
            }

            Item { Layout.fillWidth: true }
        }
    }
    
    // 基本信息卡片
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: childrenRect.height
        color: Style.cardBg
        radius: Style.radius
        Layout.topMargin: Style.spacing
        Layout.bottomMargin: Style.spacing

        // 添加边框和阴影
        border.color: Style.border
        border.width: 1
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
            
            ScrollView {
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                
                TextArea {
                    text: elementStatus.details || qsTr("无")
                    font: Style.bodyFont
                    color: Style.text
                    wrapMode: Text.Wrap
                    selectByMouse: true
                    background: Rectangle {
                        color: "transparent"
                    }
                    
                    onTextChanged: {
                        if (!elementStatus) elementStatus = {}
                        if ((elementStatus.details || "") !== text) {
                            // 创建一个新的elementStatus对象来触发QML的响应式更新
                            var newElementStatus = {}
                            for (var prop in elementStatus) {
                                newElementStatus[prop] = elementStatus[prop]
                            }
                            newElementStatus.details = text
                            elementStatus = newElementStatus
                            elementStatusUpdated()
                        }
                    }
                }
            }
        }
    }
    
    // 组织属性卡片
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: childrenRect.height
        color: Style.cardBg
        radius: Style.radius
        Layout.topMargin: Style.spacing
        Layout.bottomMargin: Style.spacing

        // 添加边框和阴影
        border.color: Style.border
        border.width: 1
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
                text: qsTr("组织属性")
                font: Style.titleFont
                color: Style.text
            }
            
            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Style.border
            }
            
            GridLayout {
                Layout.fillWidth: true
                columns: 2
                columnSpacing: Style.spacingMedium
                rowSpacing: Style.spacingSmall
                
                Label {
                    text: qsTr("影响力:")
                    color: Style.text
                    font: Style.bodyFont
                }
                
                TextField {
                    text: elementStatus.influence || "0"
                    Layout.fillWidth: true
                    color: Style.text
                    font: Style.bodyFont
                    selectByMouse: true
                    background: Rectangle {
                        color: Style.cardBg
                        border.color: Style.border
                        border.width: Style.borderWidth || 1
                        radius: Style.radius
                    }
                    
                    onTextChanged: {
                        if (!elementStatus) elementStatus = {}
                        if ((elementStatus.influence || "") !== text) {
                            elementStatus.influence = text
                            elementStatusUpdated()
                        }
                    }
                }
                
                Label {
                    text: qsTr("总部地点ID:")
                    color: Style.text
                    font: Style.bodyFont
                }
                
                TextField {
                    text: elementStatus.hq || ""
                    Layout.fillWidth: true
                    color: Style.text
                    font: Style.bodyFont
                    selectByMouse: true
                    background: Rectangle {
                        color: Style.cardBg
                        border.color: Style.border
                        border.width: Style.borderWidth || 1
                        radius: Style.radius
                    }
                    
                    onTextChanged: {
                        if (!elementStatus) elementStatus = {}
                        if ((elementStatus.hq || "") !== text) {
                            elementStatus.hq = text
                            elementStatusUpdated()
                        }
                    }
                }
                
                Label {
                    text: qsTr("目标:")
                    color: Style.text
                    font: Style.bodyFont
                }
                
                Item {
                    Layout.fillWidth: true
                    height: 80
                    
                    ScrollView {
                        anchors.fill: parent
                        
                        TextArea {
                            text: elementStatus.goals || ""
                            font: Style.bodyFont
                            color: Style.text
                            wrapMode: Text.Wrap
                            selectByMouse: true
                            background: Rectangle {
                                color: "transparent"
                            }
                            
                            onTextChanged: {
                                if (!elementStatus) elementStatus = {}
                                if ((elementStatus.goals || "") !== text) {
                                    elementStatus.goals = text
                                    elementStatusUpdated()
                                }
                            }
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
        border.width: 1
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 2
            radius: 8
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
                
                Repeater {
                    model: tempResources
                    delegate: Rectangle {
                        required property int index
                        required property string modelData
                        Layout.fillWidth: true
                        height: 60
                        radius: 16
                        color: Qt.rgba(statusColor.r, statusColor.g, statusColor.b, 0.2)

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
                                    color: Style.text
                                    font: Style.bodyFont
                                    wrapMode: Text.Wrap
                                    selectByMouse: true
                                    background: Rectangle { color: "transparent" }
                                    onTextChanged: {
                                        var next = (tempResources || []).slice()
                                        if (index >= 0 && index < next.length && next[index] !== text) {
                                            next[index] = text
                                            tempResources = next
                                            parent.elementStatusUpdated()
                                        }
                                    }
                                }
                            }
                            
                            ToolButton {
                                id: deleteResourceBtn
                                text: qsTr("×")
                                Layout.alignment: Qt.AlignRight | Qt.AlignHCenter
                                Layout.preferredWidth: 50
                                Layout.topMargin: 8
                                background: Rectangle {
                                    color: deleteResourceBtn.hovered ? Qt.rgba(0, 0, 0, 0.1) : "transparent"
                                    radius: 12
                                }
                                onClicked: {
                                    var next = (tempResources || []).slice()
                                    if (index >= 0 && index < next.length) {
                                        next.splice(index, 1)
                                        tempResources = next
                                        parent.elementStatusUpdated()
                                    }
                                }
                            }
                        }
                    }
                }
                
                RowLayout {
                    Layout.fillWidth: true
                    spacing: Style.spacingSmall
                    
                    TextField {
                        id: newOrgResource
                        placeholderText: qsTr("资源名称")
                        Layout.fillWidth: true
                        color: Style.text
                        font: Style.bodyFont
                        selectByMouse: true
                        background: Rectangle {
                            color: Style.textFieldBg || "transparent"
                            border.color: Style.textFieldBorder || Style.border
                            border.width: 1
                            radius: Style.textFieldRadius || 4
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
                            if (newOrgResource.text) {
                                var next = (tempResources || []).slice()
                                next.push(newOrgResource.text)
                                tempResources = next
                                newOrgResource.text = ""
                                elementStatusUpdated()
                            }
                        }
                    }
                }
            }
        }
    }
    
    // 成员列表卡片
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: childrenRect.height
        color: Style.cardBg
        radius: Style.radius
        Layout.topMargin: Style.spacing
        Layout.bottomMargin: Style.spacing

        // 添加边框和阴影
        border.color: Style.border
        border.width: 1
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 2
            radius: 8
            samples: 16
            color: Style.cardShadow
        }
        
        ColumnLayout {
            anchors.margins: Style.padding
            width: parent.width
            spacing: Style.spacingMedium
            
            Label { 
                text: qsTr("成员列表")
                font: Style.titleFont
                color: Style.text
            }
            
            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Style.border
            }
            
            // 成员列表编辑器
            ColumnLayout {
                Layout.fillWidth: true
                spacing: Style.spacingSmall
                
                Repeater {
                    model: tempMembers
                    delegate: Rectangle {
                        required property int index
                        required property var modelData
                        Layout.fillWidth: true
                        height: 80
                        radius: 16
                        color: Qt.rgba(statusColor.r, statusColor.g, statusColor.b, 0.2)

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 8
                            spacing: 8
                            Layout.alignment: Text.AlignHCenter
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 8
                                Layout.alignment: Text.AlignHCenter
                                // 成员ID输入框
                                TextField {
                                    Layout.fillWidth: true
                                    Layout.preferredWidth: 120
                                    text: modelData.id || ""
                                    placeholderText: qsTr("成员ID")
                                    color: Style.text
                                    font: Style.bodyFont
                                    selectByMouse: true
                                    background: Rectangle { color: "transparent" }
                                    onTextChanged: {
                                        var next = (tempMembers || []).slice()
                                        if (!next[index]) next[index] = {}
                                        if ((next[index].id || "") !== text) {
                                            var updatedMember = {
                                                index: next[index],
                                                id: text
                                            }
                                            next[index] = updatedMember
                                            tempMembers = next
                                            parent.elementStatusUpdated()
                                        }
                                    }
                                }

                                // 角色输入框
                                TextField {
                                    Layout.fillWidth: true
                                    Layout.preferredWidth: 120
                                    text: modelData.role || ""
                                    placeholderText: qsTr("角色")
                                    color: Style.text
                                    font: Style.bodyFont
                                    selectByMouse: true
                                    background: Rectangle { color: "transparent" }
                                    onTextChanged: {
                                        var next = (tempMembers || []).slice()
                                        if (!next[index]) next[index] = {}
                                        if ((next[index].role || "") !== text) {
                                            var updatedMember = {
                                                index:next[index],
                                                role: text
                                            }
                                            next[index] = updatedMember
                                            tempMembers = next
                                            parent.elementStatusUpdated()
                                        }
                                    }
                                }
                            }

                            
                            ToolButton {
                                id: deleteMemberBtn
                                text: qsTr("×")
                                Layout.alignment: Qt.AlignRight | Qt.AlignHCenter
                                Layout.preferredWidth: 50
                                Layout.topMargin: 8
                                background: Rectangle {
                                    color: deleteMemberBtn.hovered ? Qt.rgba(0, 0, 0, 0.1) : "transparent"
                                    radius: 12
                                }
                                onClicked: {
                                    var next = (tempMembers || []).slice()
                                    if (index >= 0 && index < next.length) {
                                        next.splice(index, 1)
                                        tempMembers = next
                                        parent.elementStatusUpdated()
                                    }
                                }
                            }
                        }
                    }
                }
                
                RowLayout {
                    Layout.fillWidth: true
                    spacing: Style.spacingSmall
                    
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: Style.spacingSmall
                        
                        TextField {
                            id: newMemberId
                            placeholderText: qsTr("成员ID")
                            Layout.fillWidth: true
                            color: Style.text
                            font: Style.bodyFont
                            selectByMouse: true
                            background: Rectangle {
                                color: Style.textFieldBg || "transparent"
                                border.color: Style.textFieldBorder || Style.border
                                border.width: 1
                                radius: Style.textFieldRadius || 4
                            }
                        }
                        
                        TextField {
                            id: newMemberRole
                            placeholderText: qsTr("角色")
                            Layout.fillWidth: true
                            color: Style.text
                            font: Style.bodyFont
                            selectByMouse: true
                            background: Rectangle {
                                color: Style.textFieldBg || "transparent"
                                border.color: Style.textFieldBorder || Style.border
                                border.width: 1
                                radius: Style.textFieldRadius || 4
                            }
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
                            if(newMemberId.text && !newMemberRole.text) {
                                newMemberRole.focus = true
                                return;
                            }

                            if(newMemberRole.text && !newMemberId.text) {
                                newMemberId.focus = true
                                return;
                            }

                            if (newMemberId.text && newMemberRole.text) {
                                var next = (tempMembers || []).slice()
                                next.push({ id: newMemberId.text, role: newMemberRole.text || "" })
                                tempMembers = next
                                newMemberId.text = ""
                                newMemberRole.text = ""
                                elementStatusUpdated()
                            }
                        }
                    }
                }
            }
        }
    }
}
