// Style.qml
import QtQuick 2.15
pragma Singleton

QtObject {
    id: style
    // --- 主开关 ---
    property bool isDark: false

    // ===================================================================
    //  调色板 (现代蓝色主题)
    // ===================================================================
    // 主色: 现代、专业的蓝色系，用于交互和品牌识别
    property color primary: "#3B82F6"        // 鲜明的蓝色 (Blue-500)
    property color primaryLight: "#60A5FA"   // 较浅的蓝色 (Blue-400)
    property color primaryDark: "#2563EB"    // 较深的蓝色 (Blue-600)

    // 辅色: 使用中性灰色系，用于辅助内容和背景层次
    property color secondary: "#64748B"      // 中性灰 (Slate-500)
    property color secondaryLight: "#94A3B8" // 浅灰 (Slate-400)
    property color secondaryDark: "#334155"  // 深灰 (Slate-700)

    // 强调色: 用于特别需要吸引注意力的元素，如删除操作或限时优惠
    property color accent: "#EC4899"         // 活泼的粉色 (Pink-500)
    property color disabled: "#A0AEC0"       // 禁用状态 (Gray-400)
    property color success: "#22C55E"        // 成功状态 (Green-500)
    property color warning: "#F97316"        // 警告状态 (Orange-500)
    property color error: "#EF4444"          // 错误状态 (Red-500)

    // ===================================================================
    //  动态颜色系统 (根据 isDark 自动切换)
    // ===================================================================
    // 背景色 - 更加清晰的层次感
    property color windowBg: isDark ? "#0F172A" : "#F8FAFC"  // 深邃石板蓝 / 极浅灰
    property color panelBg: isDark ? "#1E293B" : "#FFFFFF"    // 深石板灰 / 纯白
    property color panelBgAlt: isDark ? "#334155" : "#F1F5F9" // 悬停/替代背景 (深/浅)
    property color panelBorder: isDark ? "#475569" : "#E2E8F0" // 面板边框 (深/浅灰)
    property color cardBg: isDark ? "#1E293B" : "#FFFFFF"     // 卡片背景 (同 panelBg)
    property color reverseCardBg: isDark ? "#FFFFFF" : "#1E293B" // 反转卡片背景 (浅色主题专用)
    property color overlayBg: isDark ? "#00000099" : "#00000066" // 叠加层 (更深的遮罩)
    property color transparent: Qt.rgba(0, 0, 0, 0)
    property color gray: "#e0e0e0"          // 中性色灰
    property color white: "#FFFFFF"// 纯白色
    // 添加卡片阴影属性
    property color cardShadow: isDark ? "#00000080" : "#1E293B30"
    // 文本颜色 - 提高对比度和可读性
    property color text: isDark ? "#E2E8F0" : "#0F172A"       // 主要文本 (浅灰 / 深石板蓝)
    property color textSecondary: isDark ? "#94A3B8" : "#64748B" // 次要文本 (中灰)
    property color textDim: isDark ? "#475569" : "#94A3B8"    // 提示/禁用文本 (深/浅灰)
    property color textOnPrimary: "#FFFFFF"                   // 在彩色背景上的文本 (永远是白色)
    property color textLink: isDark ? primaryLight : primary  // 链接颜色

    //读者视角
    property color readerBg: isDark ? "#1a1a1a" : "#f5f5f5"
    property color readerTextSecondary: isDark ? Qt.lighter(text, 1.3) : Qt.darker(text, 1.3)

    // 界面元素
    property color borderHovered: "#E91E63" // 鼠标悬停边框 (粉色)
    property color border: isDark ? "#334155" : "#E2E8F0"     // 边框/分隔线
    property color divider: isDark ? "#334155" : "#E2E8F0"    // 分隔线 (同 border)
    property color shadow: isDark ? "#00000080" : "#1E293B30" // 更柔和、自然的阴影
    property color focusRing: Qt.rgba(primary.r, primary.g, primary.b, 0.5) // 焦点环

    property color separatorLine: "#D5D5D5" // 分隔线颜色
    // 交互状态 - 使用半透明叠加，效果更佳
    property color hover: isDark ? "#80FFFFFF" : "#80000000"
    property color pressed: isDark ? "#FFFFFF33" : "#0000001A"// 按下叠加 (20% 白 / 10% 黑)
    property color selection: Qt.rgba(primary.r, primary.g, primary.b, 0.2) // 选中区域背景

    // 高亮颜色：暗色主题与窗口背景一致，避免遮挡文本
    property color highlight: isDark ? windowBg : primary
    // 高亮悬停：暗色主题也与窗口背景一致，保持一致性
    property color highlightHover: isDark ? windowBg : primaryDark
    property color textHighlight: "#FFFFFF" // 高亮文本颜色 (白色)

    // ============ 菜单专用样式 ============
    property color menuBackground: isDark ? "#1E1E2D" : "#FFFFFF"
    property color menuBorder: isDark ? "#334155" : "#E2E8F0"
    property color menuShadow: isDark ? "#00000080" : "#1E293B30"
    property color menuText: isDark ? "#E2E8F0" : "#1E293B"

    // 菜单项交互状态
    property color menuItemHover: isDark ? Qt.rgba(255, 255, 255, 0.08) : Qt.rgba(0, 0, 0, 0.05)
    property color menuItemPressed: isDark ? Qt.rgba(255, 255, 255, 0.12) : Qt.rgba(0, 0, 0, 0.10)
    property color menuItemHoverBorder: isDark ? "#4A5568" : "#A0AEC0"

    // 分隔符（如果以后加竖线分隔）
    property color menuDivider: isDark ? "#334155" : "#E2E8F0"

    // ========== Vocabulary Helper Popup 专用样式 ==========
    // 弹窗容器
    property color popupBackground: isDark ? "#1E1E2D" : "#FFFFFF"
    property color popupBorder: isDark ? "#334155" : "#E2E8F0"
    property int   popupRadius: 8
    property color popupShadow: isDark ? "#00000066" : "#1E293B20"

    // 标题栏
    property color popupTitleText: isDark ? "#FFFFFF" : "#1E293B"
    property int popupTitleFontSize: 18
    property bool popupTitleBold: true

    // 搜索栏
    property color popupSearchBackground: isDark ? "#2D2D3A" : "#F8FAFC"
    property color popupSearchBorder: isDark ? "#4A5568" : "#CBD5E1"
    property color popupSearchPlaceholder: isDark ? "#94A3B8" : "#94A3B8"
    property color popupSearchText: isDark ? "#E2E8F0" : "#1E293B"

    // 分类按钮
    property color popupCategoryButtonBackground: isDark ? "#2D2D3A" : "#F1F5F9"
    property color popupCategoryButtonHover: isDark ? "#3C3C4A" : "#E2E8F0"
    property color popupCategoryButtonPressed: isDark ? "#4A4A58" : "#CBD5E1"
    property color popupCategoryButtonCurrent: isDark ? "#3B82F6" : "#2563EB" // 选中状态
    property color popupCategoryButtonText: isDark ? "#E2E8F0" : "#1E293B"
    property color popupCategoryButtonTextCurrent: "#FFFFFF"

    // 词汇列表项
    property color popupWordItemBackgroundEven: isDark ? "#1E1E2D" : "#FFFFFF"
    property color popupWordItemBackgroundOdd: isDark ? "#252535" : "#F8FAFC"
    property color popupWordItemHover: isDark ? "#2D2D3A" : "#F1F5F9"
    property color popupWordItemText: isDark ? "#E2E8F0" : "#1E293B"

    // 操作按钮（清空、关闭等）
    property color popupButtonBackground: isDark ? "#2D2D3A" : "#E2E8F0"
    property color popupButtonHover: isDark ? "#3C3C4A" : "#CBD5E1"
    property color popupButtonPressed: isDark ? "#4A4A58" : "#94A3B8"
    property color popupButtonText: isDark ? "#E2E8F0" : "#1E293B"

    // 滚动条（备用）
    property color popupScrollBarBackground: isDark ? "#1A1A25" : "#F1F5F9"
    property color popupScrollBarHandle: isDark ? "#475569" : "#A0AEC0"

    // ========== 系统提示卡片专用样式 ==========
    // 卡片背景
    property color cardBgTop: isDark ? "#2c3e50" : "#f8f9fa"
    property color cardBgBottom: isDark ? "#1a2530" : "#e9ecef"
    property color cardBorder: isDark ? "#34495e" : "#dee2e6"
    
    // 图标背景
    property color iconBg: isDark ? "#3498db" : "#3498db"
    
    // 等级背景
    property color levelBg: isDark ? "#f39c12" : "#f39c12"
    
    // 文本颜色
    property color textPrimary: isDark ? "#ffffff" : "#212529"
    //伏笔高亮色
    property color foreShadowing: isDark ? "#E0E000" : "#FFFF00"

    // ===================================================================
    //  尺寸与间距 (基于 8px 网格系统，更具呼吸感)
    // ===================================================================
    property int padding: 20
    property int paddingSmall: 10
    property int paddingLarge: 32
    property int spacing: 16
    property int spacingSmall: 8
    property int spacingMedium: 12
    property int spacingLarge: 24
    property int marginLarge: 30
    property int radiusSmall: 6
    property int radius: 10
    property int radiusMedium: 14 // 新增一个中间值
    property int radiusLarge: 20
    property int borderWidth: 1
    property int borderWidthFocus: 2
    property int topBarHeight: 56 // 稍微降低高度
    property int iconSize: 20
    property int iconSizeSmall: 16
    property int iconSizeLarge: 28
    property int iconSizeMax: 40
    property int margin: 20
    property int collapsedWidth: 20
    // 添加按钮图标间距属性
    property int buttonIconSpacing: 8
    
    // 添加卡片相关属性
    property int cardRadius: radius
    property int cardPadding: padding
    property int cardHeight: 80  // 添加这个属性
    
    // 添加进度条相关属性
    property int progressBarHeight: 6
    property int progressBarRadius: 3
    property color progressBarBg: isDark ? "#334155" : "#E2E8F0"
    property color progressBarFill: primary
    
    // 添加Slider相关属性
    property int sliderGrooveHeight: 4
    property int sliderHandleSize: 20
    property color sliderGroove: isDark ? "#334155" : "#E2E8F0"
    property color sliderFill: primary
    property color sliderHandle: isDark ? "#E2E8F0" : "#FFFFFF"
    property color sliderHandleHover: isDark ? "#F8FAFC" : "#F1F5F9"
    property color sliderHandlePressed: isDark ? "#FFFFFF" : "#E2E8F0"
    
    // 添加悬停和按下效果相关属性
    property real hoverScale: 1.05
    property real pressedScale: 0.95
    
    // ===================================================================
    //  字体 (优化字重和大小，增强层次感)
    // ===================================================================
    property string fontFamily: {
            switch (Qt.platform.os) {
            case "windows":
                return "Segoe UI";
            case "osx":
                return "SF Pro Display"; // 等效于 -apple-system
            case "ios":
                return "SF Pro Display";
            case "linux":
                return "Noto Sans";
            default:
                return "Inter, sans-serif"; // 兜底
            }
        }
    readonly property font articleFont: Qt.font({ family: style.fontFamily, pointSize: 12, weight: Font.Normal })
    readonly property font bodyFont: Qt.font({ family: style.fontFamily, pointSize: 15, weight: Font.Normal })
    readonly property font titleFont: Qt.font({ family: style.fontFamily, pointSize: 20, weight: Font.DemiBold })
    readonly property font headingFont: Qt.font({ family: style.fontFamily, pointSize: 28, weight: Font.Bold })
    readonly property font captionFont: Qt.font({ family: style.fontFamily, pointSize: 12, weight: Font.Normal })
    readonly property font buttonFont: Qt.font({ family: style.fontFamily, pointSize: 14, weight: Font.Medium })
    readonly property font labelFont: Qt.font({ family: style.fontFamily, pointSize: 12, weight: Font.Normal })
    readonly property font readerFont: Qt.font({ family: style.fontFamily, pointSize: 14, weight: Font.Normal })
    // 添加读者视角专用字体定义
    readonly property font readerBodyFont: Qt.font({ family: style.fontFamily, pointSize: 14, weight: Font.Normal })
    readonly property font readerTitleFont: Qt.font({ family: style.fontFamily, pointSize: 20, weight: Font.DemiBold })
    readonly property font readingfont: Qt.font({ family: style.fontFamily, pointSize: 12, weight: Font.Normal })

    readonly property font textFont: Qt.font({ family: "LXGW WenKai", pointSize: 11, weight: Font.Normal })

    // ===================================================================
    //  动画 & 阴影
    // ===================================================================
    property int transitionDuration: 150 // 加快响应速度
    property int animationDuration: 250
    property var easeInOut: Easing.InOutCubic // 使用 Cubic 曲线，缓动效果更明显
    property int durationShort: 200 // 短动画持续时间
    property int durationFast: 300  // 快动画持续时间
    property int durationMedium: 500 // 中等动画持续时间
    property int durationLong: 1000 // 长动画持续时间
    property var ease: Easing.InOutQuad // 使用 Quad 曲线，平滑过渡
    // 阴影
    property var shadowSmall: [
        { x: 0, y: 1, blur: 2, color: shadow },
        { x: 0, y: 1, blur: 3, color: shadow }
    ]
    property var shadowMedium: [
        { x: 0, y: 4, blur: 6, color: shadow },
        { x: 0, y: 2, blur: 4, color: shadow }
    ]
    property var shadowLarge: [
        { x: 0, y: 10, blur: 15, color: shadow },
        { x: 0, y: 4, blur: 6, color: shadow }
    ]

    // --- 主题切换函数 ---
    function toggleTheme() {
        isDark = !isDark
    }

    property color statusCompleted: "#4CAF50" // Green
    property color statusInProgress: "#FFC107" // Yellow
    property color statusDraft: "#BDBDBD"      // Grey

    // ===================================================================
    //  按钮专属样式 (新增)
    // ===================================================================
    // --- 按钮通用尺寸 ---
    property int buttonHeight: 40
    property int buttonMediumHeight: 50
    property int buttonPaddingHorizontal: 20
    property int buttonRadius: radius // 复用全局圆角

    // --- 主按钮 (Primary Button - 填充) ---
    property color buttonPrimaryBg: primary
    property color buttonPrimaryBgHover: primaryDark
    property color buttonPrimaryBgPressed: Qt.darker(primaryDark, 1.1)
    property color buttonPrimaryText: textOnPrimary
    property color buttonPrimaryBorder: "transparent"

    // --- 次按钮 (Secondary Button - 描边) ---
    property color buttonSecondaryBg: "transparent"
    property color buttonSecondaryBgHover: Qt.rgba(primary.r, primary.g, primary.b, 0.1)
    property color buttonSecondaryBgPressed: Qt.rgba(primary.r, primary.g, primary.b, 0.2)
    property color buttonSecondaryText: primary
    property color buttonSecondaryBorder: isDark ? primaryLight : primary

    // --- 淡色按钮 (Light Button - 浅色填充) ---
    property color buttonLightBg: isDark ? "#475569" : "#F1F5F9"
    property color buttonLightBgHover: isDark ? "#64748B" : "#E2E8F0"
    property color buttonLightBgPressed: isDark ? "#1E293B" : "#CBD5E1"
    property color buttonLightText: isDark ? textPrimary : primaryDark
    property color buttonLightBorder: "transparent"

    // --- 幽灵按钮 (Ghost Button - 文字) ---
    property color buttonGhostBg: "transparent"
    property color buttonGhostBgHover: hover
    property color buttonGhostBgPressed: pressed
    property color buttonGhostText: isDark ? textSecondary : secondaryDark
    property color buttonGhostBorder: "transparent"

    property color buttonSuccessBg: "#10B981"                    // 绿色填充
    property color buttonSuccessBgHover: "#059669"               // 深绿悬停
    property color buttonSuccessBgPressed: Qt.darker("#059669", 1.1)
    property color buttonSuccessText: "#FFFFFF"                  // 白字
    property color buttonSuccessBorder: "transparent"

    // --- 禁用状态 ---
    property color buttonDisabledBg: isDark ? "#334155" : "#E2E8F0"
    property color buttonDisabledText: textDim
    property color buttonDisabledBorder: "transparent"
    
    // --- AI按钮专属样式 ---
    property color buttonAIBg: isDark ? "#8B5CF6" : "#A78BFA" // 紫色系AI按钮
    property color buttonAIBgHover: isDark ? "#7C3AED" : "#8B5CF6"
    property color buttonAIBgPressed: isDark ? "#6D28D9" : "#7C3AED"
    property color buttonAIText: isDark ? "#F3E8FF" : "#4C1D95"
    property color buttonAIBorder: "transparent"
    property color buttonAIShadow: isDark ? "#00000080" : "#1E293B30"

    // ===================================================================
    //  输入控件专属样式 (新增)
    // ===================================================================
    // --- 文本输入框 ---
    property color textFieldBg: panelBg
    property color textFieldBorder: border
    property color textFieldBorderFocus: primary
    property color textFieldText: text
    property color textFieldPlaceholder: textDim
    property int textFieldRadius: radiusSmall

    // --- 下拉选择框 ---
    property color comboBoxBg: panelBg
    property color comboBoxBorder: border
    property color comboBoxBorderFocus: primary
    property color comboBoxText: text
    property color comboBoxPlaceholder: textDim
    property color comboBoxArrow: textSecondary
    property int comboBoxRadius: radiusSmall

    // ===================================================================
    //  TabBar 专属样式 (新增)
    // ===================================================================
    property color tabBarBg: "transparent"
    property color tabButtonBg: "transparent"
    property color tabButtonBgHover: hover
    property color tabButtonBgActive: primary
    property color tabButtonText: text
    property color tabButtonTextActive: textOnPrimary
    property int tabButtonRadius: radiusSmall
    property int tabButtonPadding: paddingSmall

    // ===================================================================
    //  其他组件样式 (新增)
    // ===================================================================
    // --- CheckBox ---
    property color checkBoxBg: panelBg
    property color checkBoxBorder: border
    property color checkBoxBorderChecked: primary
    property color checkBoxCheckMark: textOnPrimary
    property color checkBoxBgChecked: primary

    // --- ScrollBar ---
    property color scrollBarBg: "transparent"
    property color scrollBarHandle: isDark ? "#475569" : "#CBD5E1" // 添加这个属性
    property color scrollBarHandleHover: isDark ? "#64748B" : "#94A3B8"
    property color scrollBarHandlePressed: isDark ? "#475569" : "#64748B"
    property int scrollBarWidth: 12

    // --- ToolTip ---
    property color toolTipBg: panelBg
    property color toolTipText: text
    property color toolTipBorder: border
    
    // ===================================================================
    //  轮播卡片专用样式 (新增)
    // ===================================================================
    // 卡片尺寸
    property int carouselCardWidth: 320
    property int carouselCardHeight: 280
    property int carouselCardSpacing: 24
    property int carouselCardRadius: radiusLarge
    
    // 卡片颜色
    property color carouselCardBg: cardBg
    property color carouselCardBorder: border
    property color carouselCardBorderActive: primary
    property color carouselCardShadow: shadow
    
    // 卡片文本
    property color carouselCardText: text
    property color carouselCardTextSecondary: textSecondary
    property font carouselCardTitleFont: Qt.font({ family: fontFamily, pointSize: 18, weight: Font.DemiBold })
    property font carouselCardContentFont: Qt.font({
        family: "Microsoft YaHei",
        pointSize: 10,
        weight: Font.Normal,
        letterSpacing: 0.5
    })
    property font carouselCardCategoryFont: Qt.font({ family: fontFamily, pointSize: 11, weight: Font.Medium })
    property font carouselCardTimeFont: Qt.font({ family: fontFamily, pointSize: 12, weight: Font.Normal })
    
    // 卡片图标
    property int carouselCardIconSize: 48
    property int carouselCardIconRadius: 12
    property color carouselCardIconBg: primary
    property color carouselCardIconText: textOnPrimary
    
    // 卡片分类标签
    property int carouselCardCategoryHeight: 20
    property int carouselCardCategoryRadius: 10
    property color carouselCardCategoryBg: Qt.rgba(primary.r, primary.g, primary.b, 0.15)
    property color carouselCardCategoryText: primary
    
    // 卡片优先级指示器
    property int carouselCardPrioritySize: 6
    property int carouselCardPriorityRadius: 3
    property color carouselCardPriorityActive: primary
    property color carouselCardPriorityInactive: isDark ? "#334155" : "#E2E8F0"
    
    // 卡片状态指示器
    property int carouselCardStatusSize: 8
    property int carouselCardStatusRadius: 4
    property color carouselCardStatusActive: success
    property color carouselCardStatusInactive: error
    
    // 卡片选中指示器
    property int carouselCardSelectionSize: 24
    property int carouselCardSelectionRadius: 12
    property color carouselCardSelectionBg: primary
    property color carouselCardSelectionText: textOnPrimary
    
    // 轮播视图指示器
    property int carouselIndicatorHeight: 8
    property int carouselIndicatorRadius: 4
    property int carouselIndicatorActiveWidth: 24
    property int carouselIndicatorInactiveWidth: 8
    property color carouselIndicatorActive: primary
    property color carouselIndicatorInactive: isDark ? "#CBD5E1" : "#CBD5E1"
    
    // 轮播视图背景
    property color carouselViewBg: isDark ? "#F8FAFC" : "#F8FAFC"
    property int carouselViewRadius: 16

    // ===================================================================
    //  系统提示卡片样式函数
    // ===================================================================
    // 根据键名返回对应的颜色值
    function c(key) {
        switch(key) {
            // 卡片背景
            case "cardBgTop": return cardBgTop;
            case "cardBgBottom": return cardBgBottom;
            case "cardBorder": return cardBorder;
            
            // 图标背景
            case "iconBg": return iconBg;
            
            // 等级背景
            case "levelBg": return levelBg;
            
            // 文本颜色
            case "textPrimary": return textPrimary;
            case "textSecondary": return textSecondary;
            
            // 默认返回透明色
            default: return "transparent";
        }
    }
}
