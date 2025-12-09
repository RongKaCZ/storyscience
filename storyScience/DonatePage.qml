// DonatePage.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Popup {
    id: donatePage
    width: Math.min(500, parent.width * 0.9)  // 响应式宽度
    height: Math.min(700, parent.height * 0.9) // 增加高度适应多语言
    padding: 0
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    enum DonationMethod {
        Alipay = 0,
        WeChat = 1,
        PayPal = 2
    }

    property int currentMethod: DonatePage.DonationMethod.Alipay

    background: Rectangle {
        color: Style.panelBg
        border.color: Style.border
        border.width: 1
        radius: Style.radius
        layer.enabled: true
        layer.effect: DropShadow {
            radius: 8
            samples: 16
            color: Style.shadow
            verticalOffset: 3
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 0
        spacing: 0

        // 标题栏
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            color: Style.primary
            radius: Style.radius

            RowLayout {
                anchors.fill: parent
                anchors.margins: Style.paddingSmall
                spacing: Style.spacing

                Text {
                    Layout.fillWidth: true
                    Layout.leftMargin: Style.padding
                    text: qsTr("爱心捐赠")
                    color: Style.textOnPrimary
                    font: Style.titleFont
                    horizontalAlignment: Text.AlignHCenter
                    elide: Text.ElideRight
                }

                ToolButton {
                    id: closeButton
                    Layout.preferredWidth: 30
                    Layout.preferredHeight: 30
                    text: "✕"
                    font.pixelSize: 16
                    onClicked: donatePage.close()

                    background: Rectangle {
                        color: closeButton.hovered ? Qt.rgba(255, 255, 255, 0.2) : "transparent"
                        radius: Style.radiusSmall
                    }

                    contentItem: Text {
                        text: closeButton.text
                        color: Style.textOnPrimary
                        font: closeButton.font
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }

        // 内容区域
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            
            // 感谢文本
            Text {
                Layout.fillWidth: true
                Layout.maximumWidth: 400
                Layout.alignment: Qt.AlignHCenter
                text: qsTr("感谢您对 Story Science 的支持！您的捐赠将帮助我们持续改进产品，为您提供更好的写作体验。")
                color: Style.text
                font: Style.bodyFont
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
            }

            // 捐赠方式选择标签
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: qsTr("选择捐赠方式：")
                color: Style.text
                font: Style.bodyFont
                horizontalAlignment: Text.AlignHCenter
            }

            // Tab 栏 - 修复多语言布局
            RowLayout {
                id: methodTabs
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                spacing: Style.spacingSmall

                Repeater {
                    model: ListModel {
                        ListElement { name: qsTr("支付宝"); method: DonatePage.DonationMethod.Alipay }
                        ListElement { name: qsTr("微信支付"); method: DonatePage.DonationMethod.WeChat }
                        ListElement { name: qsTr("PayPal"); method: DonatePage.DonationMethod.PayPal }
                    }

                    delegate: Rectangle {
                        id: tabDelegate
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40
                        color: donatePage.currentMethod === model.method ? Style.primary : Style.panelBgAlt
                        border.color: donatePage.currentMethod === model.method ? Style.primary : Style.border
                        border.width: 1
                        radius: Style.radiusSmall

                        Text {
                            id: tabText
                            anchors.centerIn: parent
                            anchors.margins: Style.paddingSmall
                            text: model.name
                            color: donatePage.currentMethod === model.method ? Style.textOnPrimary : Style.text
                            font.pixelSize: 12
                            fontSizeMode: Text.Fit
                            minimumPixelSize: 10
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            width: Math.min(implicitWidth, parent.width - 20)
                            elide: Text.ElideRight
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: donatePage.currentMethod = model.method
                            cursorShape: Qt.PointingHandCursor
                        }
                    }
                }
            }

            // 捐赠内容展示区域
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumHeight: 300
                Layout.alignment: Qt.AlignHCenter
                
                StackLayout {
                    id: contentStack
                    anchors.centerIn: parent
                    currentIndex: donatePage.currentMethod

                    // 支付宝捐赠
                    ColumnLayout {
                        spacing: Style.spacing
                        width: parent.width

                        Rectangle {
                            Layout.preferredWidth: 250
                            Layout.preferredHeight: 250
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            color: "#f5f5f5"
                            border.color: "#ddd"
                            border.width: 1
                            radius: Style.radiusSmall

                            ColumnLayout {
                                anchors.fill: parent
                                anchors.margins: Style.padding
                                spacing: Style.spacingSmall


                                Image {
                                    Layout.preferredWidth: 200
                                    Layout.preferredHeight: 200
                                    Layout.alignment: Qt.AlignHCenter
                                    source: Style.isDark ? "qrc:/icons/aliPay.jpg" : "qrc:/icons/aliPay.jpg"
                                    fillMode: Image.PreserveAspectFit
                                }

                                Text {
                                    Layout.alignment: Qt.AlignHCenter
                                    text: qsTr("支付宝二维码")
                                    color: "#666"
                                    font.pixelSize: 12
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }
                        }
                    }

                    // 微信支付捐赠
                    ColumnLayout {
                        spacing: Style.spacing
                        width: parent.width

                        Rectangle {
                            Layout.preferredWidth: 250
                            Layout.preferredHeight: 250
                            Layout.alignment: Qt.AlignHCenter
                            color: "#f5f5f5"
                            border.color: "#ddd"
                            border.width: 1
                            radius: Style.radiusSmall

                            ColumnLayout {
                                anchors.fill: parent
                                anchors.margins: Style.padding
                                spacing: Style.spacingSmall

                                Image {
                                    Layout.preferredWidth: 200
                                    Layout.preferredHeight: 200
                                    Layout.alignment: Qt.AlignHCenter
                                    source: Style.isDark ? "qrc:/icons/wechatPay.jpg" : "qrc:/icons/wechatPay.jpg"
                                    fillMode: Image.PreserveAspectFit
                                }

                                Text {
                                    Layout.alignment: Qt.AlignHCenter
                                    text: qsTr("微信支付二维码")
                                    color: "#666"
                                    font.pixelSize: 12
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }
                        }
                    }

                    // PayPal捐赠
                    ColumnLayout {
                        spacing: Style.spacing
                        width: parent.width

                        Rectangle {
                            Layout.preferredWidth: 250
                            Layout.preferredHeight: 250
                            Layout.alignment: Qt.AlignHCenter
                            color: "#f5f5f5"
                            border.color: "#ddd"
                            border.width: 1
                            radius: Style.radiusSmall

                            ColumnLayout {
                                anchors.fill: parent
                                anchors.margins: Style.padding
                                spacing: Style.spacingSmall

                                Image {
                                    Layout.preferredWidth: 200
                                    Layout.preferredHeight: 200
                                    Layout.alignment: Qt.AlignHCenter
                                    source: "qrc:/icons/Paypal.png"
                                    fillMode: Image.PreserveAspectFit
                                }

                                Text {
                                    Layout.alignment: Qt.AlignHCenter
                                    text: qsTr("PayPal捐赠")
                                    color: "#666"
                                    font.pixelSize: 12
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: Qt.openUrlExternally("https://paypal.me/RongKa")
                            }
                        }

                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            Layout.topMargin: Style.paddingSmall
                            text: qsTr("点击图片跳转到PayPal捐赠页面")
                            color: Style.text
                            font.pixelSize: 12
                            wrapMode: Text.Wrap
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }
            }

            // 捐赠说明
            Text {
                Layout.fillWidth: true
                Layout.bottomMargin: Style.paddingSmall
                Layout.leftMargin: Style.padding
                text: qsTr("- 捐赠是完全自愿的，不会获得任何特殊权益\n- 捐赠金额将用于项目改进开发、维护等")
                color: Style.textSecondary
                font: Style.captionFont
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
}
