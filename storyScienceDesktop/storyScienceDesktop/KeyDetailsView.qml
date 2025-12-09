import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Popup {
    id: keyDetailsPopup
    width: 800
    height: 600
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    // 数据属性
    property var keyDataList: []
    property int currentIndex: 0
    property var currentKeyData: keyDataList.length > 0 && currentIndex < keyDataList.length ? keyDataList[currentIndex] : ({
        "name": qsTr("按键详细信息"),
        "description": "",
        "shortcuts": [],
        "usage": "",
        "notes": ""
    })
        
    // 加载JSON数据的函数（使用C++端传递的数据）
    function loadKeyData(filePath) {
        // 通过C++端加载数据
        var data = keyDetailsManager.loadKeyData(filePath);
        if (data) {
            keyDataList = data;
            currentIndex = 0;
        }
    }

    background: Rectangle {
        radius: 10
        color: Style.popupBackground
        border.color: Style.border
        border.width: 1
    }

    contentItem: Item {
        clip: true
        
        ColumnLayout {
            anchors.fill: parent
            spacing: 10
            
            // 标题区域
            Rectangle {
                Layout.preferredHeight: 40
                Layout.fillWidth: true
                color: Style.primary
                radius: 5
                
                Text {
                    anchors.centerIn: parent
                    text: currentKeyData.name || qsTr("按键名称")
                    font.pixelSize: 18
                    font.bold: true
                    color: "white"
                }
                
                // 为关闭按钮留出空间
                anchors.rightMargin: 70
            }
            
            // 选择器区域
            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                spacing: 10
                
                Text {
                    text: qsTr("选择操作:")
                    font.pixelSize: 12
                    color: Style.text
                }
                
                ComboBox {
                    id: operationSelector
                    Layout.fillWidth: true
                    Layout.preferredHeight: 30
                    model: keyDataList
                    textRole: "name"
                    currentIndex: keyDetailsPopup.currentIndex
                    
                    onCurrentIndexChanged: {
                        keyDetailsPopup.currentIndex = currentIndex;
                    }
                }
            }
            
            // 内容区域
            GridLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                columns: 2
                columnSpacing: 10
                rowSpacing: 10
                
                // 基本信息区域
                GroupBox {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
                    Layout.columnSpan: 2
                    title: qsTr("基本信息")
                    
                    background: Rectangle {
                        color: Style.cardBgTop
                        border.color: Style.border
                        radius: 5
                    }
                    
                    label: Text {
                        text: qsTr("基本信息")
                        color: Style.text
                        font.bold: true
                        font.pixelSize: 12
                    }
                    
                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 5
                        
                        RowLayout {
                            Layout.fillWidth: true
                            
                            Text {
                                text: qsTr("按键名称:")
                                font.pixelSize: 12
                                font.bold: true
                                color: Style.text
                            }
                            
                            Text {
                                Layout.fillWidth: true
                                text: currentKeyData.name || qsTr("未指定")
                                font.pixelSize: 12
                                color: Style.text
                                elide: Text.ElideRight
                                maximumLineCount: 1
                                wrapMode: Text.WordWrap
                            }
                        }
                        
                        RowLayout {
                            Layout.fillWidth: true
                            
                            Text {
                                text: qsTr("按键描述:")
                                font.pixelSize: 12
                                font.bold: true
                                color: Style.text
                            }
                            
                            Text {
                                Layout.fillWidth: true
                                text: currentKeyData.description || qsTr("未指定")
                                font.pixelSize: 12
                                color: Style.text
                                elide: Text.ElideRight
                                maximumLineCount: 2
                                wrapMode: Text.WordWrap
                            }
                        }
                    }
                }
                
                // 快捷键区域
                GroupBox {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 100
                    title: qsTr("快捷键")
                    
                    background: Rectangle {
                        color: Style.cardBgTop
                        border.color: Style.border
                        radius: 5
                    }
                    
                    label: Text {
                        text: qsTr("快捷键")
                        color: Style.text
                        font.bold: true
                        font.pixelSize: 12
                    }
                    
                    ScrollView {
                        anchors.fill: parent
                        clip: true
                        
                        Column {
                            width: parent.width
                            spacing: 3
                            
                            Repeater {
                                model: currentKeyData.shortcuts || []
                                
                                Rectangle {
                                    width: parent.width
                                    height: 20
                                    color: index % 2 === 0 ? Style.cardBgTop : Style.cardBgBottom
                                    
                                    Text {
                                        anchors.left: parent.left
                                        anchors.leftMargin: 5
                                        anchors.right: parent.right
                                        anchors.rightMargin: 5
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: modelData
                                        font.pixelSize: 11
                                        color: Style.text
                                        elide: Text.ElideRight
                                        maximumLineCount: 1
                                    }
                                }
                            }
                        }
                    }
                }
                
                // 使用场景区域
                GroupBox {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 100
                    title: qsTr("使用场景")
                    
                    background: Rectangle {
                        color: Style.cardBgTop
                        border.color: Style.border
                        radius: 5
                    }
                    
                    label: Text {
                        text: qsTr("使用场景")
                        color: Style.text
                        font.bold: true
                        font.pixelSize: 12
                    }
                    
                    ScrollView {
                        anchors.fill: parent
                        clip: true
                        
                        Text {
                            width: parent.width
                            text: currentKeyData.usage || qsTr("未指定")
                            font.pixelSize: 11
                            color: Style.text
                            wrapMode: Text.WordWrap
                            lineHeight: 1.2
                            elide: Text.ElideRight
                            maximumLineCount: 5
                        }
                    }
                }
                
                // 注意事项区域
                GroupBox {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 130
                    Layout.columnSpan: 2
                    title: qsTr("注意事项")
                    
                    background: Rectangle {
                        color: Style.cardBgTop
                        border.color: Style.border
                        radius: 5
                    }
                    
                    label: Text {
                        text: qsTr("注意事项")
                        color: Style.text
                        font.bold: true
                        font.pixelSize: 12
                    }
                    
                    ScrollView {
                        anchors.fill: parent
                        clip: true
                        
                        Text {
                            width: parent.width
                            text: currentKeyData.notes || qsTr("未指定")
                            font.pixelSize: 11
                            color: Style.text
                            wrapMode: Text.WordWrap
                            lineHeight: 1.2
                            elide: Text.ElideRight
                            maximumLineCount: 8
                        }
                    }
                }
            }
        }
    }
    
    // 关闭按钮
    Button {
        id: closeButton
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 5
        width: 60
        height: 40
        text: qsTr("关闭")
        font.pixelSize: 11
        
        background: Rectangle {
            color: closeButton.pressed ? Qt.darker(Style.buttonPrimaryBg, 1.2) : 
                  closeButton.hovered ? Qt.lighter(Style.buttonPrimaryBg, 1.2) : 
                  Style.buttonPrimaryBg
            radius: 3
            border.color: closeButton.hovered ? Qt.lighter(Style.primary, 1.3) : Style.primary
            border.width: closeButton.hovered ? 2 : 1
            
            // 添加按下时的下沉效果
            scale: closeButton.pressed ? 0.95 : 1.0
            Behavior on scale { NumberAnimation { duration: 100 } }
            Behavior on color { ColorAnimation { duration: 150 } }
            Behavior on border.color { ColorAnimation { duration: 150 } }
        }
        
        contentItem: Text {
            text: qsTr("关闭")
            color: Style.buttonPrimaryText
            font.pixelSize: 11
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            
            // 确保文本也跟随按钮缩放
            scale: closeButton.pressed ? 0.95 : 1.0
            Behavior on scale { NumberAnimation { duration: 100 } }
        }
        
        onClicked: keyDetailsPopup.close()
        
        // 确保按钮显示在标题之上
        z: 10
    }
}