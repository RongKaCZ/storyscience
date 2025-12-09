import QtQuick

Item {
    id: systemCardManager
    
    // 存储所有系统提示的列表
    property var systemInfos: []
    
    // 当前显示的卡片数量，用于计算新卡片的垂直位置
    property int displayedCards: 0
    
    // 添加系统提示到列表
    function addSystemInfo(title, description, level, icon) {
        systemInfos.push({
            "title": title,
            "description": description,
            "level": level,
            "icon": icon
        });
    }
    
    // 显示系统提示卡片
    function showSystemInfos(title, description, level, icon) {
        // 创建系统提示卡片组件
        var component = Qt.createComponent("SystemCard.qml");
        if (component.status === Component.Ready) {
            var card = component.createObject(systemCardManager.parent, {
                "title": title,
                "description": description,
                "level": level,
                "iconSource": icon
            });
            
            // 设置位置在右上角
            card.anchors.right = systemCardManager.parent.right
            card.anchors.rightMargin = 20
            card.y = 50 + (displayedCards * 120) // 根据已显示的卡片调整垂直位置
            
            // 增加显示卡片计数
            displayedCards++
            
            // 监听卡片销毁事件，减少计数
            card.Component.destruction.connect(function() {
                displayedCards--
            })
            
            // 显示卡片
            card.show();
        } else {
            console.log("Error loading component:", component.errorString());
        }
    }
}
