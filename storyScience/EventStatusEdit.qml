// EventStatusEdit.qml
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
    // 与 AbilityStatusEdit 保持一致：列表使用临时数组管理
    property var tempParticipants: []
    function initializeTempState() {
        tempParticipants = (elementStatus && elementStatus.participants) ? elementStatus.participants.slice() : []
    }
    function syncTempStateToElementStatus() {
        if (!elementStatus) elementStatus = {}
        elementStatus.participants = (tempParticipants || []).slice()
    }
    Component.onCompleted: initializeTempState()
    onElementStatusChanged: initializeTempState()
    onTempParticipantsChanged: syncTempStateToElementStatus()
    
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
            verticalOffset: 2
            radius: 8
            samples: 16
            color: Style.cardShadow
        }

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: Style.spacing
            anchors.rightMargin: Style.spacing

            Label {
                text: qsTr("事件状态编辑")
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
                    id: detailsArea
                    text: (elementStatus && elementStatus.details) ? elementStatus.details : ""
                    font: Style.bodyFont
                    color: Style.text
                    wrapMode: Text.Wrap
                    selectByMouse: true
                    background: Rectangle { color: "transparent" }
                    
                    onTextChanged: {
                        if (elementStatus && elementStatus.details !== text) {
                            elementStatus.details = text
                            elementStatusUpdated()
                        }
                    }
                }
            }
        }
    }
    
    // 事件属性卡片
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
                text: qsTr("事件属性")
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
                    text: qsTr("时间:")
                    color: Style.text
                    font: Style.bodyFont
                }
                
                TextField {
                    id: datetimeField
                    text: (elementStatus && elementStatus.datetime) ? elementStatus.datetime : ""
                    Layout.fillWidth: true
                    color: Style.text
                    font: Style.bodyFont
                    selectByMouse: true
                    background: Rectangle {
                        color: Style.cardBg
                        border.color: Style.border
                        border.width: Style.borderWidth
                        radius: Style.radius
                    }
                    
                    onTextChanged: {
                        if (elementStatus && elementStatus.datetime !== text) {
                            elementStatus.datetime = text
                            elementStatusUpdated()
                        }
                    }
                }
                
                Label {
                    text: qsTr("时间线位置:")
                    color: Style.text
                    font: Style.bodyFont
                }
                
                TextField {
                    id: timelinePosField
                    text: (elementStatus && elementStatus.timelinePos) ? elementStatus.timelinePos : ""
                    Layout.fillWidth: true
                    color: Style.text
                    font: Style.bodyFont
                    selectByMouse: true
                    background: Rectangle {
                        color: Style.cardBg
                        border.color: Style.border
                        border.width: Style.borderWidth
                        radius: Style.radius
                    }
                    
                    onTextChanged: {
                        if (elementStatus && elementStatus.timelinePos !== text) {
                            elementStatus.timelinePos = text
                            elementStatusUpdated()
                        }
                    }
                }
                
                Label {
                    text: qsTr("地点ID:")
                    color: Style.text
                    font: Style.bodyFont
                }
                
                TextField {
                    id: locationIdField
                    text: (elementStatus && elementStatus.locationId) ? elementStatus.locationId : ""
                    Layout.fillWidth: true
                    color: Style.text
                    font: Style.bodyFont
                    selectByMouse: true
                    background: Rectangle {
                        color: Style.cardBg
                        border.color: Style.border
                        border.width: Style.borderWidth
                        radius: Style.radius
                    }
                    
                    onTextChanged: {
                        if (elementStatus && elementStatus.locationId !== text) {
                            elementStatus.locationId = text
                            elementStatusUpdated()
                        }
                    }
                }
                
                Label {
                    text: qsTr("状态:")
                    color: Style.text
                    font: Style.bodyFont
                }
                
                ComboBox {
                    id: statusCombo
                    model: [qsTr("计划中"), qsTr("进行中"), qsTr("完成中"), qsTr("已结束")]
                    currentIndex: {
                        var status = (elementStatus && elementStatus.status) ? elementStatus.status : qsTr("计划中")
                        switch(status) {
                        case qsTr("计划中"): return 0
                        case qsTr("进行中"): return 1
                        case qsTr("完成中"): return 2
                        case qsTr("已结束"): return 3
                        default: return 0
                        }
                    }
                    Layout.fillWidth: true
                    font: Style.bodyFont
                    
                    onCurrentTextChanged: {
                        if (elementStatus && elementStatus.status !== currentText) {
                            elementStatus.status = currentText
                            elementStatusUpdated()
                        }
                    }
                }
                
                Label {
                    text: qsTr("影响分数:")
                    color: Style.text
                    font: Style.bodyFont
                }
                
                TextField {
                    id: impactScoreField
                    text: (elementStatus && elementStatus.impactScore) ? elementStatus.impactScore : ""
                    Layout.fillWidth: true
                    color: Style.text
                    font: Style.bodyFont
                    selectByMouse: true
                    background: Rectangle {
                        color: Style.cardBg
                        border.color: Style.border
                        border.width: Style.borderWidth
                        radius: Style.radius
                    }
                    
                    onTextChanged: {
                        if (elementStatus && elementStatus.impactScore !== text) {
                            elementStatus.impactScore = text
                            elementStatusUpdated()
                        }
                    }
                }
            }
        }
    }
    
    // 结果卡片
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
                text: qsTr("结果")
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
                    id: outcomeArea
                    text: (elementStatus && elementStatus.outcome) ? elementStatus.outcome : ""
                    font: Style.bodyFont
                    color: Style.text
                    wrapMode: Text.Wrap
                    selectByMouse: true
                    background: Rectangle { color: "transparent" }
                    
                    onTextChanged: {
                        if (elementStatus && elementStatus.outcome !== text) {
                            elementStatus.outcome = text
                            elementStatusUpdated()
                        }
                    }
                }
            }
        }
    }
    
    // 参与者列表卡片
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
                text: qsTr("参与者列表")
                font: Style.titleFont
                color: Style.text
            }
            
            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Style.border
            }
            
            // 参与者列表编辑器
            ColumnLayout {
                Layout.fillWidth: true
                spacing: Style.spacingSmall
                
                Repeater {
                    model: tempParticipants
                    delegate: Rectangle {
                        required property int index
                        required property string modelData
                        Layout.fillWidth: true
                        height: 60
                        radius: 16
                        color: Qt.rgba(statusColor.r, statusColor.g, statusColor.b, 0.15)

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
                                        var next = (tempParticipants || []).slice()
                                        if (index >= 0 && index < next.length && next[index] !== text) {
                                            next[index] = text
                                            tempParticipants = next
                                            parent.elementStatusUpdated()
                                        }
                                    }
                                }
                            }
                            
                            ToolButton {
                                id: deleteParticipantBtn
                                text: qsTr("×")
                                Layout.alignment: Qt.AlignRight | Qt.AlignHCenter
                                Layout.preferredWidth: 50
                                Layout.topMargin: 8
                                background: Rectangle {
                                    color: deleteParticipantBtn.hovered ? Qt.rgba(0, 0, 0, 0.1) : "transparent"
                                    radius: 12
                                }
                                onClicked: {
                                    var next = (tempParticipants || []).slice()
                                    if (index >= 0 && index < next.length) {
                                        next.splice(index, 1)
                                        tempParticipants = next
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
                        id: newParticipant
                        placeholderText: qsTr("参与者ID")
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
                            if (newParticipant.text) {
                                var next = (tempParticipants || []).slice()
                                next.push(newParticipant.text)
                                tempParticipants = next
                                newParticipant.text = ""
                                elementStatusUpdated()
                            }
                        }
                    }
                }
            }
        }
    }
}
