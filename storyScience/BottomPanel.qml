// SettingsPopup.qml - 设置弹出页面
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import storyScience 1.0

Popup {
    id: settingsPopup
    width: 800
    height: 600
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    // 设置项属性
    property bool isSliding: false
    property bool autoSaveEnabled: true
    property int autoSaveInterval: 30  // 自动保存间隔（秒）
    property bool darkThemeEnabled: false
    property int fontSize: 16 // 16以匹配EditorArea
    property bool enableSyntaxHighlight: true
    property string defaultFileLocation: ""
    property string lastOpenedFile: DataManager.loadSetting("lastOpenedFile", "")  // 上次打开的文件路径
    property string aiProvider: "DeepSeek"
    property string aiApiUrl: "https://api.deepseek.com/v1/chat/completions"
    property string aiApiKey: ""
    property string aiModelName: "deepseek-chat"
    property string aiSystemPrompt: qsTr(`你是一名经验丰富的网络小说作者，熟悉起点、晋江、番茄等主流平台的写作节奏与读者心理。
                                         请根据提供的小说片段进行续写，要求如下：
                                         1. 保持原文的世界观、人物设定与语气风格一致，不要脱离已有剧情逻辑。
                                         2. 续写部分需自然衔接上文，承接情绪与节奏，避免突兀跳转。
                                         3. 保留网文常见的爽点与节奏，如反转、升级、悬念、情感冲突等。
                                         4. 加强画面感与代入感，注重人物心理变化与场景描写。
                                         5. 语言要流畅、生动、有张力，避免流水账或空洞叙述。
                                         6. 续写字数适中，保证剧情有推进或转折。
                                         7. 结尾应留有“悬念”或“伏笔”，让读者期待下一章。
                                         最终仅输出续写的小说正文，不要输出任何分析、解释或标题。`)
    // 新增：优化提示（用于润色与美化的系统提示）
    property string aiOptimizePrompt: qsTr(`你是一名专业的网络小说编辑，熟悉起点、晋江、番茄等平台的文风与读者偏好。
                                           请对输入文本进行润色与优化，要求如下：
                                           1. 保留原剧情与设定，不改变故事走向与核心爽点。
                                           2. 优化文笔，使语言更流畅、有画面感与代入感。
                                           3. 加强人物外貌、动作、心理与环境氛围的描写，避免平铺直叙。
                                           4. 删除或压缩重复、啰嗦内容，使行文紧凑；合理断句与分段。
                                           5. 保持网文常见节奏与爽点表达（反转、升级、悬念、情感冲突等）。
                                           6. 仅输出优化后的小说正文，不输出解释、点评或标题。`)
    property int aiProviderIndex: 0
    property string language : "zh"
    property bool firstRun: true  // 是否首次运行
    
    // 为每个AI提供商维护独立的API密钥和模型
    property var aiProviderConfigs: ({
        "DeepSeek": {
            "apiKey": "",
            "modelName": "deepseek-chat",
            "apiUrl": "https://api.deepseek.com/v1/chat/completions",
            "models": [
                "deepseek-chat",
                "deepseek-reasoner"
            ]
        },
        "Kimi": {
            "apiKey": "",
            "modelName": "kimi-k2-0905-preview",
            "apiUrl": "https://api.moonshot.cn/v1/chat/completions",
            "models": [
                "kimi-k2-0905-preview",
                "kimi-k2-turbo-preview",
                "kimi-k2-0711-preview",
                "moonshot-v1-128k",
                "kimi-thinking-preview"
            ]
        },
        "Doubao": {
            "apiKey": "",
            "modelName": "doubao-seed-1-6-250615",
            "apiUrl": "https://ark.cn-beijing.volces.com/api/v3/chat/completions",
            "models": [
                "doubao-seed-1-6-250615",
                "doubao-1-5-pro-32k-250115",
                "doubao-seed-1-6-thinking-250715",
                "doubao-seed-1-6-flash-250828"
            ]
        },
        "Qwen": {
            "apiKey": "",
            "modelName": "qwen3-max",
            "apiUrl": "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions",
            "models": [
                "qwen3-max",
                "qwen3-max-preview",
                "qwen3-plus",
                "qwen3-turbo",
                "qwen-flash",
            ]
        },
        "OpenRouter": {
            "apiKey": "",
            "modelName": "gpt-4o-mini",
            "apiUrl": "https://openrouter.ai/api/v1/chat/completions",
            "models": [
                "deepseek/deepseek-chat-v3-0324:free",
                "tngtech/deepseek-r1t2-chimera:free",
                "z-ai/glm-4.5-air:free",
                "tngtech/deepseek-r1t-chimera:free",
                "deepseek/deepseek-r1-0528:free",
                "qwen/qwen3-235b-a22b:free",
                "google/gemini-2.0-flash-exp:free",
                "x-ai/grok-code-fast-1",
                "anthropic/claude-sonnet-4.5",
                "google/gemini-2.5-flash",
                "anthropic/claude-sonnet-4",
                "x-ai/grok-4-fast",
                "openai/gpt-4.1-mini",
                "google/gemini-2.5-pro",
                "openai/gpt-5",
                "meta-llama/llama-4-maverick",
                "openai/gpt-4.1",
                "openai/gpt-4.1-mini"
            ]
        },
        "ChatGPT": {
            "apiKey": "",
            "modelName": "gpt-4o",
            "apiUrl": "https://api.openai.com/v1/chat/completions",
            "models": [
                "gpt-4o",
                "gpt-4o-mini",
                "gpt-4.1",
                "gpt-5",
                "gpt-5-mini"
            ]
        },
        "Claude": {
            "apiKey": "",
            "modelName": "claude-3-5-haiku-latest",
            "apiUrl": "https://api.anthropic.com/v1/messages",
            "models": [
                "claude-3-5-haiku-latest",
                 "claude-3-7-sonnet-latest",
                "claude-opus-4-0",
                "claude-opus-4-1",
                "claude-sonnet-4-0",
                "claude-sonnet-4-5"
            ]
        },
        "Gemini": {
            "apiKey": "",
            "modelName": "gemini-2.5-flash",
            "apiUrl": "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions",
            "models": [
                "gemini-2.5-flash",
                "gemini-2.5-pro",
                "gemini-2.0-flash"
            ]
        }
    })

    
    // 加载时读取数据
    Component.onCompleted: {
        loadSettings()
        syncSettingsToUI()
    }

    // 关闭时保存数据
    onClosed: saveSettings()

    background: Rectangle {
        color: Style.panelBg
        border.color: Style.border
        border.width: 1
        radius: Style.radius
        opacity: settingsPopup.isSliding ? 0.05 : 1.0
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Style.spacing
        spacing: Style.spacing

        // 标题栏
        RowLayout {
            Layout.fillWidth: true
            spacing: Style.spacing

            Label {
                text: qsTr("设置")
                font.bold: true
                font.pixelSize: 20
                color: Style.text
                Layout.fillWidth: true
                opacity: settingsPopup.isSliding ? 0.05 : 1.0
            }

            Button {
                id: saveAndCloseButton
                text: qsTr("保存并关闭")
                onClicked: {
                    saveSettings()
                    settingsPopup.close()
                    //重新加载设置
                    DataManager.loadAllSettings();
                    settingsPopup.loadSettings();
                }

                background: Rectangle {
                    color: saveAndCloseButton.hovered ? Style.buttonPrimaryBgHover : Style.buttonPrimaryBg
                    border.color: Style.border
                    border.width: 1
                    radius: Style.radius
                    opacity: settingsPopup.isSliding ? 0.05 : 1.0
                }

                contentItem: Text {
                    text: saveAndCloseButton.text
                    font: Style.buttonFont
                    color: Style.buttonPrimaryText
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    opacity: settingsPopup.isSliding ? 0.05 : 1.0
                }
            }

            Button {
                id: closeButton
                text: qsTr("关闭")
                onClicked: settingsPopup.close()

                background: Rectangle {
                    color: closeButton.hovered ? Style.buttonSecondaryBgHover : Style.buttonSecondaryBg
                    border.color: Style.border
                    border.width: 1
                    radius: Style.radius
                    opacity: settingsPopup.isSliding ? 0.05 : 1.0
                }

                contentItem: Text {
                    text: closeButton.text
                    font: Style.buttonFont
                    color: Style.buttonSecondaryText
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    opacity: settingsPopup.isSliding ? 0.05 : 1.0
                }
            }
        }

        // 设置内容区
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ColumnLayout {
                width: parent.parent.width
                spacing: Style.spacing

                // 界面设置
                GroupBox {
                    title: qsTr("界面设置")
                    Layout.fillWidth: true
                    ColumnLayout {
                        anchors.fill: parent
                        spacing: Style.spacingSmall

                        RowLayout {
                            Layout.fillWidth: true

                            // CheckBox {
                            //     text: qsTr("显示字数统计")
                            //     checked: settingsPopup.showWordCount
                            //     opacity: settingsPopup.isSliding ? 0.05 : 1.0
                            //     onCheckedChanged: settingsPopup.showWordCount = checked
                            // }

                            // Item { Layout.fillWidth: true }

                            CheckBox {
                                id: darkThemeCheckBox
                                text: qsTr("深色主题")
                                checked: settingsPopup.darkThemeEnabled
                                opacity: settingsPopup.isSliding ? 0.05 : 1.0
                                // 监听主题变化以更新复选框状态
                                Connections {
                                    target: Style
                                    function onIsDarkChanged() {
                                        darkThemeCheckBox.checked = Style.isDark
                                    }
                                }

                                // 复选框状态变化时更新主题
                                onCheckedChanged: {
                                    if (darkThemeCheckBox.checked !== Style.isDark) {
                                        Style.isDark = darkThemeCheckBox.checked
                                        settingsPopup.darkThemeEnabled = darkThemeCheckBox.checked
                                    }
                                }
                            }
                        }

                        // 添加字体大小设置
                        RowLayout {
                            Layout.fillWidth: true

                            Label {
                                text: qsTr("字体大小:")
                                opacity: settingsPopup.isSliding ? 0.05 : 1.0
                            }

                            Slider {
                                id: fontSizeSlider
                                Layout.fillWidth: true
                                from: 12
                                to: 24
                                stepSize: 1
                                value: settingsPopup.fontSize
                                onValueChanged: {
                                    settingsPopup.fontSize = Math.round(value)
                                    //settingsPopup.isSliding = true
                                    // 不再手动发出信号，QML会自动触发fontSizeChanged
                                }

                                onPressedChanged:{
                                    settingsPopup.isSliding = pressed
                                }
                            }

                            SpinBox {
                                id: fontSizeSpinBox
                                from: 12
                                to: 24
                                value: settingsPopup.fontSize
                                onValueChanged: {
                                    settingsPopup.fontSize = value
                                    //settingsPopup.isSliding = true
                                    // 不再手动发出信号，QML会自动触发fontSizeChanged
                                }

                                textFromValue: function(value) {
                                    return value + "px"
                                }

                                valueFromText: function(text) {
                                    return parseInt(text.replace("px", ""))
                                }
                            }

                            // 同步Slider和SpinBox的值
                            Connections {
                                target: fontSizeSlider
                                function onValueChanged() {
                                    fontSizeSpinBox.value = Math.round(fontSizeSlider.value)
                                }
                            }

                            Connections {
                                target: fontSizeSpinBox
                                function onValueChanged() {
                                    fontSizeSlider.value = fontSizeSpinBox.value
                                }
                            }
                        }
                    }
                }

                // 文件管理设置
                GroupBox {
                    title: qsTr("文件管理")
                    Layout.fillWidth: true
                    opacity: settingsPopup.isSliding ? 0.05 : 1.0
                    ColumnLayout {
                        anchors.fill: parent
                        spacing: Style.spacingSmall

                        // RowLayout {
                        //     Layout.fillWidth: true

                        //     CheckBox {
                        //         text: qsTr("删除前确认")
                        //         opacity: settingsPopup.isSliding ? 0.05 : 1.0
                        //         checked: settingsPopup.confirmBeforeDelete
                        //         onCheckedChanged: settingsPopup.confirmBeforeDelete = checked
                        //     }

                        //     Item { Layout.fillWidth: true }

                        //     CheckBox {
                        //         text: qsTr("启用备份")
                        //         opacity: settingsPopup.isSliding ? 0.05 : 1.0
                        //         checked: settingsPopup.enableBackups
                        //         onCheckedChanged: settingsPopup.enableBackups = checked
                        //     }
                        // }

                        RowLayout {
                            Layout.fillWidth: true

                            Label {
                                text: qsTr("文件默认保存位置:")
                                opacity: settingsPopup.isSliding ? 0.05 : 1.0
                            }

                            TextField {
                                Layout.fillWidth: true
                                text: settingsPopup.defaultFileLocation
                                color: Style.text
                                placeholderText: qsTr("选择默认文件保存位置")
                                opacity: settingsPopup.isSliding ? 0.05 : 1.0
                                onEditingFinished: settingsPopup.defaultFileLocation = text
                            }

                            Button {
                                text: qsTr("浏览...")
                                opacity: settingsPopup.isSliding ? 0.05 : 1.0
                                onClicked: {
                                    // 打开文件夹选择对话框
                                    selectDefaultLocation()
                                }
                            }
                        }
                    }
                }

                // AI续写设置
                GroupBox {
                    title: qsTr("AI续写设置")
                    Layout.fillWidth: true
                    opacity: settingsPopup.isSliding ? 0.05 : 1.0

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: Style.spacingSmall

                        RowLayout {
                            Layout.fillWidth: true

                            Label {
                                text: qsTr("AI提供商:")
                                opacity: settingsPopup.isSliding ? 0.05 : 1.0
                            }

                            CustomComboBox {
                                id: aiProviderCombo
                                Layout.fillWidth: true
                                opacity: settingsPopup.isSliding ? 0.05 : 1.0
                                model: [
                                    { icon: "qrc:/icons/deepseek.png", name: "DeepSeek" },
                                    { icon: "qrc:/icons/kimi.png", name: "Kimi" },
                                    { icon: "qrc:/icons/doubao.png", name: "Doubao" },
                                    { icon: "qrc:/icons/openrouter.png", name: "OpenRouter" },
                                    { icon: "qrc:/icons/qwen.png", name: "Qwen" },
                                    { icon: "qrc:/icons/chatgpt.png", name: "ChatGPT" },
                                    { icon: "qrc:/icons/claude.png", name: "Claude" },
                                    { icon: "qrc:/icons/gemini.png", name: "Gemini" },
                                ]

                                // ▼ 逻辑部分
                                onCurrentIndexChanged: {
                                    settingsPopup.aiProviderIndex = currentIndex
                                    var providerName = model[currentIndex].name
                                    settingsPopup.aiProvider = providerName
                                    
                                    // 更新当前提供商的配置
                                    var config = settingsPopup.aiProviderConfigs[providerName]
                                    if (config) {
                                        settingsPopup.aiApiUrl = config.apiUrl
                                        settingsPopup.aiApiKey = config.apiKey
                                        settingsPopup.aiModelName = config.modelName
                                        aiApiUrlField.text = settingsPopup.aiApiUrl
                                        aiApiKeyField.text = settingsPopup.aiApiKey
                                        // 更新模型选择框
                                        updateModelComboBox(config.models)
                                    }
                                }
                            }
                        }

                        RowLayout {
                            Layout.fillWidth: true

                            Label {
                                text: "API URL:"
                                opacity: settingsPopup.isSliding ? 0.05 : 1.0

                            }

                            TextField {
                                id: aiApiUrlField
                                Layout.fillWidth: true
                                opacity: settingsPopup.isSliding ? 0.05 : 1.0
                                text: settingsPopup.aiApiUrl
                                placeholderText: qsTr("请输入API URL")
                                onEditingFinished: settingsPopup.aiApiUrl = text
                            }
                        }

                        RowLayout {
                            Layout.fillWidth: true

                            Label {
                                text: "API Key:"
                                opacity: settingsPopup.isSliding ? 0.05 : 1.0
                            }

                            TextField {
                                id: aiApiKeyField
                                Layout.fillWidth: true
                                opacity: settingsPopup.isSliding ? 0.05 : 1.0
                                text: settingsPopup.aiApiKey
                                placeholderText: qsTr("请输入API密钥")
                                echoMode: TextInput.Password
                                onEditingFinished: {
                                    settingsPopup.aiApiKey = text
                                    // 同时更新当前提供商的API密钥
                                    var config = settingsPopup.aiProviderConfigs[settingsPopup.aiProvider]
                                    if (config) {
                                        config.apiKey = text
                                    }
                                }
                            }
                        }

                        RowLayout {
                            Layout.fillWidth: true

                            Label {
                                text: qsTr("模型名称:")
                                opacity: settingsPopup.isSliding ? 0.05 : 1.0
                            }

                            ComboBox {
                                id: aiModelNameCombo
                                Layout.fillWidth: true
                                opacity: settingsPopup.isSliding ? 0.05 : 1.0
                                // 模型列表会根据提供商动态更新
                                model: settingsPopup.aiProviderConfigs[settingsPopup.aiProvider] ? 
                                       settingsPopup.aiProviderConfigs[settingsPopup.aiProvider].models : []
                                onCurrentIndexChanged: {
                                    if (currentIndex >= 0 && model.length > 0) {
                                        settingsPopup.aiModelName = model[currentIndex]
                                        // 同时更新当前提供商的模型名称
                                        var config = settingsPopup.aiProviderConfigs[settingsPopup.aiProvider]
                                        if (config) {
                                            config.modelName = settingsPopup.aiModelName
                                        }
                                    }
                                }
                            }
                        }

                        RowLayout {
                            Layout.fillWidth: true

                            Label {
                                text: qsTr("系统提示:")
                                opacity: settingsPopup.isSliding ? 0.05 : 1.0
                                Layout.alignment: Qt.AlignTop
                            }

                            ScrollView {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 120
                                clip: true

                                TextArea {
                                    id: aiSystemPromptField
                                    wrapMode: Text.Wrap
                                    text: settingsPopup.aiSystemPrompt
                                    opacity: settingsPopup.isSliding ? 0.05 : 1.0
                                    placeholderText: qsTr("请输入系统提示，如'你是一个小说续写助手'")
                                    onTextChanged: settingsPopup.aiSystemPrompt = text
                                }
                            }
                        }

                        // 优化提示（位于系统提示之后）
                        RowLayout {
                            Layout.fillWidth: true

                            Label {
                                text: qsTr("优化提示:")
                                opacity: settingsPopup.isSliding ? 0.05 : 1.0
                                Layout.alignment: Qt.AlignTop
                            }

                            ScrollView {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 120
                                clip: true

                                TextArea {
                                    id: aiOptimizePromptField
                                    wrapMode: Text.Wrap
                                    text: settingsPopup.aiOptimizePrompt
                                    opacity: settingsPopup.isSliding ? 0.05 : 1.0
                                    placeholderText: qsTr("请输入优化提示，如'润色增强画面感与代入感'等")
                                    onTextChanged: settingsPopup.aiOptimizePrompt = text
                                }
                            }
                        }
                    }
                }

                // 高级设置
                GroupBox {
                    title: qsTr("高级设置")
                    Layout.fillWidth: true

                    RowLayout {
                        Layout.fillWidth: true

                        Button {
                            text: qsTr("导出设置")
                            opacity: settingsPopup.isSliding ? 0.05 : 1.0
                            onClicked: {
                                exportSettings()
                            }
                        }

                        Button {
                            text: qsTr("导入设置")
                            opacity: settingsPopup.isSliding ? 0.05 : 1.0
                            onClicked: {
                                importSettings()
                            }
                        }

                        Button {
                            text: qsTr("显示设置路径")
                            opacity: settingsPopup.isSliding ? 0.05 : 1.0
                            onClicked: {
                                showSettingsPath()
                            }
                        }

                        Item { Layout.fillWidth: true }
                    }
                }

                // 底部间隙
                Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Style.spacing
                }
            }
        }
    }

    // 更新模型选择框
    function updateModelComboBox(models) {
        aiModelNameCombo.model = models
        // 设置当前选中的模型
        var currentModel = settingsPopup.aiModelName
        var index = models.indexOf(currentModel)
        if (index >= 0) {
            aiModelNameCombo.currentIndex = index
        } else {
            // 如果当前模型不在列表中，默认选择第一个
            aiModelNameCombo.currentIndex = 0
            if (models.length > 0) {
                settingsPopup.aiModelName = models[0]
            }
        }
    }

    // 同步设置到UI控件
    function syncSettingsToUI() {
        // 延迟执行以确保UI控件已创建
        Qt.callLater(function() {
            if (typeof aiApiUrlField !== 'undefined') {
                aiApiUrlField.text = aiApiUrl
            }
            if (typeof aiApiKeyField !== 'undefined') {
                aiApiKeyField.text = aiApiKey
            }
            // 同步ComboBox索引
            if (typeof aiProviderCombo !== 'undefined') {
                aiProviderCombo.currentIndex = aiProviderIndex
            }
            // 更新模型选择框
            if (typeof aiModelNameCombo !== 'undefined') {
                var config = settingsPopup.aiProviderConfigs[settingsPopup.aiProvider]
                if (config) {
                    updateModelComboBox(config.models)
                }
            }
        })
    }

    function saveSettings() {
       if (typeof DataManager !== 'undefined' && DataManager.saveSetting) {
            // 在保存前，根据ComboBox索引更新aiProvider值
            switch(aiProviderIndex) {
                case 0:
                    aiProvider = "DeepSeek"
                    break
                case 1:
                    aiProvider = "Kimi"
                    break
                case 2:
                    aiProvider = "Doubao"
                    break
                case 3:
                    aiProvider = "OpenRouter"
                    break
                case 4:
                    aiProvider = "Qwen"
                    break
                case 5:
                    aiProvider = "ChatGPT"
                    break
                case 6:
                    aiProvider = "Claude"
                    break
                case 7:
                    aiProvider = "Gemini"
                    break
            }

            // 保存在成员变量列表里面
            DataManager.saveSetting("autoSaveEnabled", autoSaveEnabled)
            DataManager.saveSetting("autoSaveInterval", autoSaveInterval)
            DataManager.saveSetting("darkThemeEnabled", Style.isDark)
            DataManager.saveSetting("fontSize", fontSize)
            DataManager.saveSetting("enableSyntaxHighlight", enableSyntaxHighlight)
            DataManager.saveSetting("defaultFileLocation", defaultFileLocation)
            DataManager.saveSetting("lastOpenedFile", lastOpenedFile)
            DataManager.saveSetting("language",language);
            DataManager.saveSetting("firstRun",firstRun);
            // 保存AI续写设置
            DataManager.saveSetting("aiProvider", aiProvider)
            DataManager.saveSetting("aiApiUrl", aiApiUrl)
            DataManager.saveSetting("aiApiKey", aiApiKey)
            DataManager.saveSetting("aiModelName", aiModelName)
            DataManager.saveSetting("aiSystemPrompt", aiSystemPrompt)
            DataManager.saveSetting("aiOptimizePrompt", aiOptimizePrompt)
            DataManager.saveSetting("aiProviderIndex", aiProviderIndex)
            
            // 保存每个提供商的配置
            DataManager.saveSetting("aiProviderConfigs", JSON.stringify(aiProviderConfigs))

            // 保存进设置文件里面
            if (typeof DataManager.saveAllSettings === 'function') {
                DataManager.saveAllSettings();
            }

            // 同步AI设置到C++端的AI续写管理器
            syncAISettingsToManager()
        }
    }

    // 添加一个函数来同步AI设置到C++端的AI续写管理器
    function syncAISettingsToManager() {
        if (typeof DataManager !== 'undefined' && DataManager.aiContinuationManager) {
            var aiManager = DataManager.aiContinuationManager;
            aiManager.setApiUrl(aiApiUrl);
            aiManager.setApiKey(aiApiKey);
            aiManager.setModelName(aiModelName);
            aiManager.setSystemPrompt(aiSystemPrompt);

            // 设置API提供商
            if (aiProvider === "DeepSeek") {
                aiManager.setApiProvider(0); // DeepSeek
            } else if (aiProvider === "Kimi") {
                aiManager.setApiProvider(1); // Kimi
            } else if (aiProvider === "Doubao") {
                aiManager.setApiProvider(2); // Doubao
            } else if (aiProvider === "OpenRouter") {
                aiManager.setApiProvider(3); // OpenRouter
            } else if (aiProvider === "Qwen") {
                aiManager.setApiProvider(4); // Qwen
            } else if (aiProvider === "ChatGPT"){
                aiManager.setApiProvider(5); // ChatGPT
            } else if (aiProvider === "Claude") {
                aiManager.setApiProvider(6); // Claude
            } else if (aiProvider === "Gemini") {
                aiManager.setApiProvider(7); // Gemini
            }

        }
    }

    // 从后端DataManager中加载设置
    function loadSettings() {
        if (typeof DataManager !== 'undefined' && DataManager.loadSetting) {
            autoSaveEnabled = DataManager.loadSetting("autoSaveEnabled", true)
            autoSaveInterval = DataManager.loadSetting("autoSaveInterval", 30)
            darkThemeEnabled = DataManager.loadSetting("darkThemeEnabled", false)
            // 确保布尔值正确转换
            if (typeof darkThemeEnabled === 'string') {
                darkThemeEnabled = (darkThemeEnabled === "true");
            }
            fontSize = DataManager.loadSetting("fontSize", 16) // 修改默认值为16以匹配EditorArea
            enableSyntaxHighlight = DataManager.loadSetting("enableSyntaxHighlight", true)
            // 确保布尔值正确转换
            if (typeof enableSyntaxHighlight === 'string') {
                enableSyntaxHighlight = (enableSyntaxHighlight === "true");
            }
            defaultFileLocation = DataManager.loadSetting("defaultFileLocation", "")
            lastOpenedFile = DataManager.loadSetting("lastOpenedFile", "")
            language = DataManager.loadSetting("language", "zh")

            // 加载AI续写设置
            aiProvider = DataManager.loadSetting("aiProvider", "DeepSeek")
            aiApiUrl = DataManager.loadSetting("aiApiUrl", "https://api.deepseek.com/v1/chat/completions")
            aiApiKey = DataManager.loadSetting("aiApiKey", "")
            aiModelName = DataManager.loadSetting("aiModelName", "deepseek-chat")
            aiSystemPrompt = DataManager.loadSetting("aiSystemPrompt", qsTr(`你是一名经验丰富的网络小说作者，熟悉起点、晋江、番茄等主流平台的写作节奏与读者心理。
                                                                            请根据提供的小说片段进行续写，要求如下：
                                                                            1. 保持原文的世界观、人物设定与语气风格一致，不要脱离已有剧情逻辑。
                                                                            2. 续写部分需自然衔接上文，承接情绪与节奏，避免突兀跳转。
                                                                            3. 保留网文常见的爽点与节奏，如反转、升级、悬念、情感冲突等。
                                                                            4. 加强画面感与代入感，注重人物心理变化与场景描写。
                                                                            5. 语言要流畅、生动、有张力，避免流水账或空洞叙述。
                                                                            6. 续写字数适中，保证剧情有推进或转折。
                                                                            7. 结尾应留有“悬念”或“伏笔”，让读者期待下一章。
                                                                            最终仅输出续写的小说正文，不要输出任何分析、解释或标题。`))
            aiOptimizePrompt = DataManager.loadSetting("aiOptimizePrompt", qsTr(`你是一名专业的网络小说编辑，熟悉起点、晋江、番茄等平台的文风与读者偏好。
                                                                                请对输入文本进行润色与优化，要求如下：
                                                                                1. 保留原剧情与设定，不改变故事走向与核心爽点。
                                                                                2. 优化文笔，使语言更流畅、有画面感与代入感。
                                                                                3. 加强人物外貌、动作、心理与环境氛围的描写，避免平铺直叙。
                                                                                4. 删除或压缩重复、啰嗦内容，使行文紧凑；合理断句与分段。
                                                                                5. 保持网文常见节奏与爽点表达（反转、升级、悬念、情感冲突等）。
                                                                                6. 仅输出优化后的小说正文，不输出解释、点评或标题。`))
            // 加载ComboBox索引
            aiProviderIndex = DataManager.loadSetting("aiProviderIndex", 0)
            
            // 加载每个提供商的配置
            var configsStr = DataManager.loadSetting("aiProviderConfigs", "{}")
            try {
                var loadedConfigs = JSON.parse(configsStr)
                // 合并默认配置和加载的配置
                for (var provider in aiProviderConfigs) {
                    if (loadedConfigs[provider]) {
                        // 更新API密钥
                        if (loadedConfigs[provider].apiKey) {
                            aiProviderConfigs[provider].apiKey = loadedConfigs[provider].apiKey
                        }
                        // 更新模型名称
                        if (loadedConfigs[provider].modelName) {
                            aiProviderConfigs[provider].modelName = loadedConfigs[provider].modelName
                        }
                        // 更新模型列表（如果存在）
                        if (loadedConfigs[provider].models) {
                            aiProviderConfigs[provider].models = loadedConfigs[provider].models
                        }
                    }
                }
            } catch (e) {
                console.warn("加载AI提供商配置时出错:", e)
            }

            firstRun = DataManager.loadSetting("firstRun", true)

            // 同步主题设置到 Style
            Style.isDark = darkThemeEnabled
            // 更新UI控件状态
            syncSettingsToUI()

            syncAISettingsToManager()
        }
    }

    // 导出当前设置为JSON文件
    function exportSettings() {
        var settings = {
            autoSaveEnabled: autoSaveEnabled,
            autoSaveInterval: autoSaveInterval,
            darkThemeEnabled: darkThemeEnabled,
            fontSize: fontSize,
            enableSyntaxHighlight: enableSyntaxHighlight,
            defaultFileLocation: defaultFileLocation,
            lastOpenedFile: lastOpenedFile,
            language: language,
            firstRun: firstRun,
            // 导出AI续写设置
            aiProvider: aiProvider,
            aiApiUrl: aiApiUrl,
            aiApiKey: aiApiKey,
            aiModelName: aiModelName,
            aiSystemPrompt: aiSystemPrompt,
            aiOptimizePrompt: aiOptimizePrompt,
            // 导出ComboBox索引
            aiProviderIndex: aiProviderIndex,
            // 导出提供商配置
            aiProviderConfigs: aiProviderConfigs
        }

        if (typeof DataManager !== 'undefined' && DataManager.exportSettings) {
            DataManager.exportSettings(JSON.stringify(settings, null, 2))
        }
    }

    // 从JSON文件导入设置
    function importSettings() {
        if (typeof DataManager !== 'undefined' && DataManager.importSettings) {
            DataManager.importSettings()
        }
    }

    // 显示设置文件路径
    function showSettingsPath() {
        if (typeof DataManager !== 'undefined' && DataManager.getSettingsPath) {
            var path = DataManager.getSettingsPath()
            showPathDialog(path)
        }
    }

    // 显示路径对话框的模拟函数
    function showPathDialog(path) {
        // 创建并显示一个弹窗来显示路径
        pathPopup.pathText = path;
        pathPopup.open();
    }

    // 添加弹窗组件来显示路径
    Popup {
        id: pathPopup
        width: 400
        height: 150
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        property string pathText: ""

        background: Rectangle {
            color: Style.panelBg
            border.color: Style.border
            border.width: 1
            radius: Style.radius
        }

        contentItem: ColumnLayout {
            spacing: Style.spacing

            Label {
                text: qsTr("设置文件路径")
                font.bold: true
                color: Style.text
            }

            TextField {
                Layout.fillWidth: true
                text: pathPopup.pathText
                readOnly: true
                selectByMouse: true
                color: Style.text
            }

            RowLayout {
                Layout.alignment: Qt.AlignRight

                Button {
                    text: qsTr("复制")
                    onClicked: {
                        // 复制路径到剪贴板
                        clipboard.copy(pathPopup.pathText);
                    }
                }

                Button {
                    text: qsTr("确定")
                    onClicked: pathPopup.close()
                }
            }
        }
    }

    // 选择默认文件夹
    function selectDefaultLocation() {
        if (typeof DataManager !== 'undefined' && DataManager.selectFolder) {
            var folder = DataManager.selectFolder()
            if (folder) {
                defaultFileLocation = folder
            }
        }
    }
}
