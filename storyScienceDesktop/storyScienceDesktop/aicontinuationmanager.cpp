/**
 * @file aicontinuationmanager.cpp
 * @brief AIContinuationManager 类的实现
 */

#include "aicontinuationmanager.h"
#include "datamanager.h"
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QTimer>
#include <QEventLoop>
#include <QUrl>
#include <QUrlQuery>
#include <QTextDocument>

// Worker implementation
AIContinuationWorker::AIContinuationWorker(QObject *parent)
    : QObject(parent)
    , m_networkManager(new QNetworkAccessManager(this))
    , m_currentReply(nullptr)
    , m_apiProvider(AIContinuationManager::DeepSeek)
    , m_streamTimer(new QTimer(this))
    , m_isCancelled(false)
{
    m_streamTimer->setSingleShot(true);
    m_streamTimer->setInterval(60000);  // 60秒超时
    connect(m_streamTimer, &QTimer::timeout, this, &AIContinuationWorker::handleStreamTimeout);
}

void AIContinuationWorker::setApiConfig(const QString &apiUrl, const QString &apiKey, const QString &modelName)
{
    m_apiUrl = apiUrl;
    m_apiKey = apiKey;
    m_modelName = modelName;
}

void AIContinuationWorker::setApiProvider(AIContinuationManager::APIProvider provider)
{
    m_apiProvider = provider;
}

void AIContinuationWorker::setSystemPrompt(const QString &prompt)
{
    m_systemPrompt = prompt;
}

void AIContinuationWorker::processRequest(const QString &prompt, const QString &context)
{
    if (m_currentReply) {
        emit requestError(tr("上一个请求仍在处理中"));
        return;
    }

    m_isCancelled = false;
    m_accumulatedResponse.clear();

    // 过滤HTML格式的内容，提取纯文本
    QTextDocument doc;
    doc.setHtml(context);
    QString cleanContext = doc.toPlainText();

    // 获取用户配置的系统提示
    QString systemPrompt = DataManager::instance()->loadSetting("aiSystemPrompt","").toString();
    
    // 添加控制提示，确保输出格式符合要求
    QString controlPrompt = tr(R"(
        你是一名专业小说续写AI，只负责根据提供的上下文，继续写出故事正文部分。
        【严格要求】：
        1. 只输出故事正文内容，保持文风一致。
        2. 不得输出章节标题、下一章预告、总结、分析或评论。
        3. 不得以“AI视角”发言，不出现“建议”、“可以写成这样”等描述。
        4. 不要重复上下文内容。
        5. 输出时直接续写，不添加说明或额外格式。
    )");

    // 合并用户定义的系统提示和控制提示
    if (!systemPrompt.isEmpty()) {
        systemPrompt = systemPrompt.trimmed() + "\n\n" + controlPrompt;
    } else {
        systemPrompt = controlPrompt;
    }

    QString originalSystemPrompt = m_systemPrompt;
    m_systemPrompt = systemPrompt;


    switch (m_apiProvider) {
    case AIContinuationManager::DeepSeek:
        sendDeepSeekRequest(prompt, cleanContext);
        break;
    case AIContinuationManager::Kimi:
        sendKimiRequest(prompt, cleanContext);
        break;
    case AIContinuationManager::Doubao:
        sendDoubaoRequest(prompt, cleanContext);
        break;
    case AIContinuationManager::OpenRouter:
        sendOpenRouterRequest(prompt, cleanContext);
        break;
    case AIContinuationManager::ChatGPT:
        sendChatGPTRequest(prompt, cleanContext);
        break;
    case AIContinuationManager::Claude:
        sendClaudeRequest(prompt, cleanContext);
        break;
    case AIContinuationManager::Qwen:
        sendQwenRequest(prompt, cleanContext);
        break;
    case AIContinuationManager::Gemini:
        sendGeminiRequest(prompt, cleanContext);
        break;
    }

    m_systemPrompt = originalSystemPrompt;
}

void AIContinuationWorker::processCreateRequest(const QString &description, ElementTypeWrapper::ElementType type)
{
    if (m_currentReply) {
        emit requestError(tr("上一个请求仍在处理中"));
        return;
    }

    //qDebug()<<"AI Provider"<<m_apiProvider;

    m_isCancelled = false;
    m_accumulatedResponse.clear();

    // 构造创建元素的提示
    QString elementTypeStr = processTypeToPrompt(type);

    //  根据类型生成标题提示
    QString titleHint;
    switch (type) {
    case ElementTypeWrapper::Character:
        titleHint = tr("（请生成一个角色名,不能包含称号、代号或前缀）");
        break;
    case ElementTypeWrapper::Location:
        titleHint = tr("（请生成一个地点名,不带前缀或修饰语）");
        break;
    case ElementTypeWrapper::Item:
        titleHint = tr("（请生成一个道具名,不要带修饰词或说明）");
        break;
    case ElementTypeWrapper::Organisation:
        titleHint = tr("（请生成一个组织名,简短且无代号）");
        break;
    case ElementTypeWrapper::Event:
        titleHint = tr("（请生成一个事件名，避免使用诗意或比喻表达）");
        break;
    case ElementTypeWrapper::Abilities:
        titleHint = tr("（请生成一个能力名，不加形容词或句子）");
        break;
    default:
        titleHint = tr("（请生成一个简短、单一的标题名称，不包含修饰词或句子）");
        break;
    }

    QString content = QString(tr("请根据以下描述创建一个%1元素：\n\n%2")).arg(elementTypeStr, description);

    //  强制绑定 icon，根据 type 选择固定图标路径
    QString allowedIcon;
    switch (type) {
    case ElementTypeWrapper::Character:
        allowedIcon = "\"qrc:/icons/people.svg\"";
        break;
    case ElementTypeWrapper::Location:
        allowedIcon = "\"qrc:/icons/location.svg\"";
        break;
    case ElementTypeWrapper::Item:
        allowedIcon = "\"qrc:/icons/prop.svg\"";
        break;
    case ElementTypeWrapper::Abilities:
        allowedIcon = "\"qrc:/icons/power.svg\"";
        break;
    case ElementTypeWrapper::Organisation:
        allowedIcon = "\"qrc:/icons/Organization.svg\"";
        break;
    case ElementTypeWrapper::Event:
        allowedIcon = "\"qrc:/icons/event.svg\"";
        break;
    default:
        allowedIcon = "\"qrc:/icons/people.svg\""; // fallback
        break;
    }

    // 构造严格受限的 Prompt
    // 1. 将需要翻译的静态文本用 tr() 包裹
    QString jsonTemplate = tr(
        "请生成一个符合以下结构的JSON对象（不要包含任何其他内容）：\n"
        "{\n"
        "  \"title\": \"%1\",\n"
        "  \"description\": \"（请生成50字的网文风格描述，带有代入感和特色，简洁易懂）\",\n"
        "  \"color\": \"（请推荐一个符合主题的#RRGGBB颜色代码，随机）\",\n"
        "  \"icon\": %2,  // 必须使用此固定图标路径\n"
        "  \"tags\": [\n"
        "    \"（请根据元素类型生成两个贴切的标签，不要重复，也不要总是相同模式）\"\n"
        "  ]\n"
        "}\n"
        "⚠️ 要求：\n"
        "- 标签必须与 title 类型相关，例如：\n"
        "  - 角色：身份、性格、阵营\n"
        "  - 地点：环境、用途、氛围\n"
        "  - 道具：材质、用途、稀有度\n"
        "  - 组织：规模、理念、权力属性\n"
        "  - 事件：类型、影响、时间背景\n"
        "  - 能力：元素、效果、限制条件\n"
        "- 标签不要固定，总是有变化，保持创意，网文化。"
        );


    // 2. 用 arg() 插入动态值
    QString prompt = jsonTemplate.arg(titleHint, allowedIcon);

    // 加强系统提示，防止 AI 越界
    QString systemPrompt = tr("你是一个创意写作助手，专门用于动态生成故事元素。你必须严格返回合法的JSON对象，不带任何额外内容。"
                           "icon 字段必须使用指定的固定路径，禁止自行推荐、更改或使用其他图标关键词。");

    // 保存原始系统提示
    QString originalSystemPrompt = m_systemPrompt;
    m_systemPrompt = systemPrompt;

    switch (m_apiProvider) {
    case AIContinuationManager::DeepSeek:
        sendDeepSeekRequest(prompt, content);
        break;
    case AIContinuationManager::Kimi:
        sendKimiRequest(prompt, content);
        break;
    case AIContinuationManager::Doubao:
        sendDoubaoRequest(prompt, content);
        break;
    case AIContinuationManager::OpenRouter:
        sendOpenRouterRequest(prompt, content);
        break;
    case AIContinuationManager::ChatGPT:
        sendChatGPTRequest(prompt, content);
        break;
    case AIContinuationManager::Claude:
        sendClaudeRequest(prompt, content);
        break;
    case AIContinuationManager::Qwen:
        sendQwenRequest(prompt, content);
        break;
    case AIContinuationManager::Gemini:
        sendGeminiRequest(prompt, content);
        break;
    }

    // 恢复原始系统提示
    m_systemPrompt = originalSystemPrompt;
}

void AIContinuationWorker::processOptimizeRequest(const QString &UserPrompt, const QString &optimizationGoal)
{
    if (m_currentReply) {
        emit requestError(tr("上一个请求仍在处理中"));
        return;
    }

    m_isCancelled = false;
    m_accumulatedResponse.clear();

    // 构造优化文章的提示
    QString prompt = UserPrompt;//这里是提示
    
    // // 对于优化文章请求，使用专门的系统提示
    // QString systemPrompt = tr(R"(
    //     你是一名专业的网络小说编辑，熟悉起点、晋江、番茄等网文平台的写作风格。
    //     请对输入的小说文本进行优化和美化，要求如下：
    //     1. 保留原剧情和设定，不改变故事走向和核心爽点。
    //     2. 优化文笔，使语言更加流畅、具有画面感和代入感。
    //     3. 加强人物描写（外貌、动作、心理），避免平铺直叙。
    //     4. 增强环境氛围和细节刻画，营造玄幻感和压迫感。
    //     5. 保持网文常见的节奏与爽点表达（逆袭、打脸、系统奖励等）。
    //     6. 删除或压缩重复、啰嗦的部分，使行文紧凑有力。
    //     7. 结尾增加“钩子”，让读者期待后续剧情。
    //     最终仅输出优化后的小说正文，不要输出任何解释或多余内容。
    //     )");
    // 对于优化文章请求，使用专门的系统提示
    // QString basePrompt = tr(R"(
    //     你是一名专业的网络小说编辑，熟悉起点、晋江、番茄等网文平台的写作风格。
    //     请对输入的小说文本进行优化和美化，要求如下：
    //     1. 保留原剧情和设定，不改变故事走向和核心爽点。
    //     2. 优化文笔，使语言更加流畅、具有画面感和代入感。
    //     3. 加强人物描写（外貌、动作、心理），避免平铺直叙。
    //     4. 增强环境氛围和细节刻画，营造玄幻感和压迫感。
    //     5. 保持网文常见的节奏与爽点表达（逆袭、打脸、系统奖励等）。
    //     6. 删除或压缩重复、啰嗦的部分，使行文紧凑有力。
    //     7. 结尾增加“钩子”，让读者期待后续剧情。
    // )");

    // 从设置中读取用户自定义 systemPrompt
    QString userPrompt = DataManager::instance()->loadSetting("aiOptimizePrompt", "").toString();

    QString controlPrompt = tr(R"(
    【格式与输出要求】：
    - 仅输出优化后的小说正文，不得输出解释、点评、建议、说明、章节标题、格式标签或符号。
    - 不出现“以下为优化结果”“我修改了部分内容”等提示性句子。
    - 不输出JSON、Markdown、XML、HTML等结构化格式。
    - 保持原文的换行与段落结构。
    - 输出内容应为自然语言正文，无需任何说明或标注。
    )");

    // 合并三部分内容（顺序：系统 → 用户 → 限定）
    QString systemPrompt;
    if (!userPrompt.isEmpty()) {
        systemPrompt = controlPrompt.trimmed() + "\n\n" + userPrompt.trimmed();
    } else {
        systemPrompt = controlPrompt.trimmed();
    }

    // 保存原始系统提示
    QString originalSystemPrompt = m_systemPrompt;
    m_systemPrompt = systemPrompt;

    switch (m_apiProvider) {
    case AIContinuationManager::DeepSeek:
        sendDeepSeekRequest(prompt, optimizationGoal);
        break;
    case AIContinuationManager::Kimi:
        sendKimiRequest(prompt, optimizationGoal);
        break;
    case AIContinuationManager::Doubao:
        sendDoubaoRequest(prompt, optimizationGoal);
        break;
    case AIContinuationManager::OpenRouter:
        sendOpenRouterRequest(prompt, optimizationGoal);
        break;
    case AIContinuationManager::ChatGPT:
        sendChatGPTRequest(prompt, optimizationGoal);
        break;
    case AIContinuationManager::Claude:
        sendClaudeRequest(prompt, optimizationGoal);
        break;
    case AIContinuationManager::Qwen:
        sendQwenRequest(prompt, optimizationGoal);
        break;
    case AIContinuationManager::Gemini:
        sendGeminiRequest(prompt, optimizationGoal);
        break;
    }

    // 恢复原始系统提示
    m_systemPrompt = originalSystemPrompt;
}

void AIContinuationWorker::processAiCommentRequest(const QString &fullText)
{
    qDebug() << "processAiCommentRequest called with fullText:";

    if (m_currentReply) {
        emit requestError(tr("上一个请求仍在处理中"));
        return;
    }

    m_isCancelled = false;
    m_accumulatedResponse.clear();

    QString prompt = tr("点评一下这个小说片段：");

    QString systemPrompt = tr(R"(
        ## 角色与人设 (ROLE & PERSONA) ##
        你是站在网文鄙视链顶端的神级编辑，是阅文无数、在起点、番茄、飞卢等平台杀伐决断的"人形算法"。你代表着最挑剔的95后/00后读者，说话自带弹幕，精通玩梗，且对一切"尬文"都生理性不适。

        ## 核心任务 (CORE TASK) ##
        分析下方提供的小说片段。精准地找出其中 4 到 5 个最值得吐槽的亮点、槽点或爽点，并为每一处配上你那标志性的"毒舌"点评。

        ## ⚠️ 至关重要的核心规则：逐字复制 ⚠️ ##
        1.  **"text"字段的内容是本任务的最高优先级。它必须是、也只能是原文中一个不多一字、不少一字、不改一字的【连续片段】。
        2.  **【严禁】进行任何形式的总结、概括、拼接、改写或二次创作。你的任务是"复制-粘贴"，而不是"理解-重述"。
        3.  **【错误示范】**: 如果原文是 `王德发逃跑了。林天一关上了门。` 你的"text"字段【绝对不能】是 `"王德发逃跑后，林天一关上了门。"` (这是拼接和改写，是错误的！)
        4.  **【正确示范】**: 你应该选择其中一句，例如 `{"text": "王德发逃跑了。", "comment": "..."}` 或者 `{"text": "林天一关上了门。", "comment": "..."}`。

        ## 前后文定位规则 ##
        为了更精确地定位点评位置，请为每个点评添加"prefix"和"suffix"字段：
        - "prefix": 点评文本前10个字符的上下文内容（如果在开头则为空）
        - "suffix": 点评文本后10个字符的上下文内容（如果在结尾则为空）
        - 如果"text"字段在原文开头，则"prefix"为空字符串
        - 如果"text"字段在原文结尾，则"suffix"为空字符串

        ## 其他输出规则 ##
        - **风格语气:** 犀利、简洁、幽默。自然地使用网络热梗。
        - **严格的JSON格式:** **必须且只能**返回一个可被直接解析的、原始的JSON数组。禁止包含任何介绍性文字、说明或```

        ## 格式与范例 ##
        [
          {
            "text": "原文中的一个片段，必须一字不差地复制。",
            "comment": "你犀利、幽默、一针见血的吐槽放在这里。",
            "prefix": "前10个字符的上下文内容",
            "suffix": "后10个字符的上下文内容"
          },
          {
            "text": "原文中的另一个片段，同样是精准复制。",
            "comment": "从另一个角度切入的毒舌点评。",
            "prefix": "前10个字符的上下文内容",
            "suffix": "后10个字符的上下文内容"
          }
        ]
    )");




    QString originalSystemPrompt = m_systemPrompt;
    m_systemPrompt = systemPrompt;

    switch (m_apiProvider) {
    case AIContinuationManager::DeepSeek:
        sendDeepSeekRequest(prompt, fullText);
        break;
    case AIContinuationManager::Kimi:
        sendKimiRequest(prompt, fullText);
        break;
    case AIContinuationManager::Doubao:
        sendDoubaoRequest(prompt, fullText);
        break;
    case AIContinuationManager::OpenRouter:
        sendOpenRouterRequest(prompt, fullText);
        break;
    case AIContinuationManager::ChatGPT:
        sendChatGPTRequest(prompt, fullText);
        break;
    case AIContinuationManager::Claude:
        sendClaudeRequest(prompt, fullText);
        break;
    case AIContinuationManager::Qwen:
        sendQwenRequest(prompt, fullText);
        break;
    case AIContinuationManager::Gemini:
        sendGeminiRequest(prompt, fullText);
        break;
    }

    // 恢复原始系统提示
    m_systemPrompt = originalSystemPrompt;
}

void AIContinuationWorker::processAiSummarizeRequest(const QString &fullText)
{
    if (m_currentReply) {
        emit requestError(tr("上一个请求仍在处理中"));
        return;
    }

    m_isCancelled = false;
    m_accumulatedResponse.clear();

    QString prompt = R"(
        请用语文课总结课文的方式，简明扼要地概括本章内容：交代清楚时间、地点、主要人物，以及他们做了什么或发生了什么事。
    )";

    // 为AI总结创建专门的系统提示
    QString summarizeSystemPrompt = R"(
        - 采用叙述性语言，语句通顺，逻辑连贯。
        - 仅复述本章实际发生的情节，不添加推测、评价或额外信息。
        - 内容控制在300字以内，结构清晰，可适当分段。
    )";

    QString originalSystemPrompt = m_systemPrompt;
    m_systemPrompt = summarizeSystemPrompt;

    //qDebug()<<"总结文章:"<< fullText;

    switch (m_apiProvider) {
    case AIContinuationManager::DeepSeek:
        sendDeepSeekRequest(prompt, fullText);
        break;
    case AIContinuationManager::Kimi:
        sendKimiRequest(prompt, fullText);
        break;
    case AIContinuationManager::Doubao:
        sendDoubaoRequest(prompt, fullText);
        break;
    case AIContinuationManager::OpenRouter:
        sendOpenRouterRequest(prompt, fullText);
        break;
    case AIContinuationManager::ChatGPT:
        sendChatGPTRequest(prompt, fullText);
        break;
    case AIContinuationManager::Claude:
        sendClaudeRequest(prompt, fullText);
        break;
    case AIContinuationManager::Qwen:
        sendQwenRequest(prompt, fullText);
        break;
    case AIContinuationManager::Gemini:
        sendGeminiRequest(prompt, fullText);
        break;
    }

    m_systemPrompt = originalSystemPrompt;
}

void AIContinuationWorker::cancelRequest()
{
    m_isCancelled = true;
    if (m_currentReply) {
        m_currentReply->abort();
        m_currentReply->deleteLater();
        m_currentReply = nullptr;
    }
    emit requestFinished();
}

//AI创建元素的API
QString AIContinuationWorker::processTypeToPrompt(ElementTypeWrapper::ElementType type)
{
    switch (type) {
    case ElementTypeWrapper::Character:
        return tr("角色");
    case ElementTypeWrapper::Location:
        return tr("地点");
    case ElementTypeWrapper::Item:
        return tr("道具");
    case ElementTypeWrapper::Organisation:
        return tr("组织");
    case ElementTypeWrapper::Event:
        return tr("事件");
    case ElementTypeWrapper::Abilities:
        return tr("能力");
    default:
        return tr("元素");
    }
}

void AIContinuationWorker::sendDeepSeekRequest(const QString &prompt, const QString &context)
{
    QNetworkRequest request;
    request.setUrl(QUrl(m_apiUrl));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Authorization", QString("Bearer %1").arg(m_apiKey).toUtf8());

    QJsonObject payload = createDeepSeekPayload(prompt, context);
    QJsonDocument doc(payload);

    m_currentReply = m_networkManager->post(request, doc.toJson(QJsonDocument::Compact));
    connect(m_currentReply, &QNetworkReply::readyRead, this, &AIContinuationWorker::handleNetworkReply);
    connect(m_currentReply, &QNetworkReply::finished, this, &AIContinuationWorker::handleNetworkReply);
    m_streamTimer->start();
}

void AIContinuationWorker::sendKimiRequest(const QString &prompt, const QString &context)
{
    //qDebug() << "Sending Kimi request";

    QNetworkRequest request;
    request.setUrl(QUrl(m_apiUrl));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Authorization", QString("Bearer %1").arg(m_apiKey).toUtf8());

    QJsonObject payload = createKimiPayload(prompt, context);
    //qDebug() << "Kimi Payload:" << QJsonDocument(payload).toJson(QJsonDocument::Compact);
    QJsonDocument doc(payload);

    m_currentReply = m_networkManager->post(request, doc.toJson(QJsonDocument::Compact));
    connect(m_currentReply, &QNetworkReply::readyRead, this, &AIContinuationWorker::handleNetworkReply);
    connect(m_currentReply, &QNetworkReply::finished, this, &AIContinuationWorker::handleNetworkReply);
    m_streamTimer->start();
}

void AIContinuationWorker::sendDoubaoRequest(const QString &prompt, const QString &context)
{
    QNetworkRequest request;
    request.setUrl(QUrl(m_apiUrl));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Authorization", QString("Bearer %1").arg(m_apiKey).toUtf8());

    QJsonObject payload = createDoubaoPayload(prompt, context);
    QJsonDocument doc(payload);

    m_currentReply = m_networkManager->post(request, doc.toJson(QJsonDocument::Compact));
    connect(m_currentReply, &QNetworkReply::readyRead, this, &AIContinuationWorker::handleNetworkReply);
    connect(m_currentReply, &QNetworkReply::finished, this, &AIContinuationWorker::handleNetworkReply);
    m_streamTimer->start();
}

void AIContinuationWorker::sendOpenRouterRequest(const QString &prompt, const QString &context)
{
    QNetworkRequest request;
    request.setUrl(QUrl(m_apiUrl));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Authorization", QString("Bearer %1").arg(m_apiKey).toUtf8());
    request.setRawHeader("HTTP-Referer", "https://storyscience.app");
    request.setRawHeader("X-Title", "StoryScience");

    QJsonObject payload = createOpenRouterPayload(prompt, context);
    QJsonDocument doc(payload);

    m_currentReply = m_networkManager->post(request, doc.toJson(QJsonDocument::Compact));
    connect(m_currentReply, &QNetworkReply::readyRead, this, &AIContinuationWorker::handleNetworkReply);
    connect(m_currentReply, &QNetworkReply::finished, this, &AIContinuationWorker::handleNetworkReply);
    m_streamTimer->start();
}

void AIContinuationWorker::sendChatGPTRequest(const QString &prompt, const QString &context)
{
    QNetworkRequest request;
    request.setUrl(QUrl(m_apiUrl));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Authorization", QString("Bearer %1").arg(m_apiKey).toUtf8());

    QJsonObject payload = createChatGPTPayload(prompt, context);
    QJsonDocument doc(payload);

    m_currentReply = m_networkManager->post(request, doc.toJson(QJsonDocument::Compact));
    connect(m_currentReply, &QNetworkReply::readyRead, this, &AIContinuationWorker::handleNetworkReply);
    connect(m_currentReply, &QNetworkReply::finished, this, &AIContinuationWorker::handleNetworkReply);
    m_streamTimer->start();
}

void AIContinuationWorker::sendClaudeRequest(const QString &prompt, const QString &context)
{
    QNetworkRequest request;
    request.setUrl(QUrl(m_apiUrl));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Authorization", QString("Bearer %1").arg(m_apiKey).toUtf8());
    request.setRawHeader("anthropic-version", "2023-06-01");

    QJsonObject payload = createClaudePayload(prompt, context);
    QJsonDocument doc(payload);

    m_currentReply = m_networkManager->post(request, doc.toJson(QJsonDocument::Compact));
    connect(m_currentReply, &QNetworkReply::readyRead, this, &AIContinuationWorker::handleNetworkReply);
    connect(m_currentReply, &QNetworkReply::finished, this, &AIContinuationWorker::handleNetworkReply);
    m_streamTimer->start();
}

void AIContinuationWorker::sendQwenRequest(const QString &prompt, const QString &context)
{
    // qDebug() << "=== 发送Qwen请求 ===";
    // qDebug() << "API URL:" << m_apiUrl;
    // qDebug() << "API Key长度:" << m_apiKey.length();
    // qDebug() << "模型名称:" << m_modelName;
    //qDebug() << "Prompt:" << prompt;
    //qDebug() << "Context:" << context;

    QNetworkRequest request;
    request.setUrl(QUrl(m_apiUrl));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Authorization", QString("Bearer %1").arg(m_apiKey).toUtf8());

    QJsonObject payload = createQwenPayload(prompt, context);
    QJsonDocument doc(payload);

    m_currentReply = m_networkManager->post(request, doc.toJson(QJsonDocument::Compact));
    connect(m_currentReply, &QNetworkReply::readyRead, this, &AIContinuationWorker::handleNetworkReply);
    connect(m_currentReply, &QNetworkReply::finished, this, &AIContinuationWorker::handleNetworkReply);
    connect(m_currentReply, &QNetworkReply::errorOccurred, this, [this](QNetworkReply::NetworkError code){
        qDebug() << "网络错误代码:" << code;
    });

    m_streamTimer->start();
}

void AIContinuationWorker::sendGeminiRequest(const QString &prompt, const QString &context)
{
    QNetworkRequest request;
    request.setUrl(QUrl(m_apiUrl));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Authorization", QString("Bearer %1").arg(m_apiKey).toUtf8());

    QJsonObject payload = createGeminiPayload(prompt, context);
    QJsonDocument doc(payload);

    m_currentReply = m_networkManager->post(request, doc.toJson(QJsonDocument::Compact));
    connect(m_currentReply, &QNetworkReply::readyRead, this, &AIContinuationWorker::handleNetworkReply);
    connect(m_currentReply, &QNetworkReply::finished, this, &AIContinuationWorker::handleNetworkReply);
    m_streamTimer->start();
}

QJsonObject AIContinuationWorker::createDeepSeekPayload(const QString &prompt, const QString &context)
{
    QJsonArray messages;
    
    // 添加系统提示（如果存在）
    if (!m_systemPrompt.isEmpty()) {
        QJsonObject systemMessage;
        systemMessage["role"] = "system";
        systemMessage["content"] = m_systemPrompt;
        messages.append(systemMessage);
    }

    QJsonObject message;
    message["role"] = "user";

    QString fullPrompt = context.isEmpty() ? prompt : QString("%1\n\n%2").arg(context, prompt);
    message["content"] = fullPrompt;

    messages.append(message);

    QJsonObject payload;
    payload["model"] = m_modelName.isEmpty() ? "deepseek-chat" : m_modelName;
    payload["messages"] = messages;
    payload["stream"] = true;

    return payload;
}

QJsonObject AIContinuationWorker::createKimiPayload(const QString &prompt, const QString &context)
{
    QJsonArray messages;
    
    // 添加系统提示（如果存在）
    if (!m_systemPrompt.isEmpty()) {
        QJsonObject systemMessage;
        systemMessage["role"] = "system";
        systemMessage["content"] = m_systemPrompt;
        messages.append(systemMessage);
    }

    QJsonObject message;
    message["role"] = "user";

    QString fullPrompt = context.isEmpty() ? prompt : QString("%1\n\n%2").arg(context, prompt);
    message["content"] = fullPrompt;

    messages.append(message);

    QJsonObject payload;
    payload["model"] = m_modelName.isEmpty() ? "moonshot-v1-8k" : m_modelName;
    payload["messages"] = messages;
    payload["stream"] = true;

    return payload;
}

QJsonObject AIContinuationWorker::createDoubaoPayload(const QString &prompt, const QString &context)
{
    QJsonArray messages;
    
    // 添加系统提示（如果存在）
    if (!m_systemPrompt.isEmpty()) {
        QJsonObject systemMessage;
        systemMessage["role"] = "system";
        systemMessage["content"] = m_systemPrompt;
        messages.append(systemMessage);
    }

    QJsonObject message;
    message["role"] = "user";

    QString fullPrompt = context.isEmpty() ? prompt : QString("%1\n\n%2").arg(context, prompt);
    message["content"] = fullPrompt;

    messages.append(message);

    QJsonObject payload;
    payload["model"] = m_modelName.isEmpty() ? "doubao-lite-4k" : m_modelName;
    payload["messages"] = messages;
    payload["stream"] = true;

    return payload;
}

QJsonObject AIContinuationWorker::createOpenRouterPayload(const QString &prompt, const QString &context)
{
    QJsonArray messages;
    
    // 添加系统提示（如果存在）
    if (!m_systemPrompt.isEmpty()) {
        QJsonObject systemMessage;
        systemMessage["role"] = "system";
        systemMessage["content"] = m_systemPrompt;
        messages.append(systemMessage);
    }

    QJsonObject message;
    message["role"] = "user";

    QString fullPrompt = context.isEmpty() ? prompt : QString("%1\n\n%2").arg(context, prompt);
    message["content"] = fullPrompt;

    messages.append(message);

    QJsonObject payload;
    // 使用正确的DeepSeek模型名称
    payload["model"] = m_modelName.isEmpty() ? "deepseek/deepseek-chat-v3.1:free" : m_modelName;
    payload["messages"] = messages;
    payload["stream"] = true;

    return payload;
}

QJsonObject AIContinuationWorker::createChatGPTPayload(const QString &prompt, const QString &context)
{
    QJsonArray messages;
    
    // 添加系统提示（如果存在）
    if (!m_systemPrompt.isEmpty()) {
        QJsonObject systemMessage;
        systemMessage["role"] = "system";
        systemMessage["content"] = m_systemPrompt;
        messages.append(systemMessage);
    }

    QJsonObject message;
    message["role"] = "user";

    QString fullPrompt = context.isEmpty() ? prompt : QString("%1\n\n%2").arg(context, prompt);
    message["content"] = fullPrompt;

    messages.append(message);

    QJsonObject payload;
    payload["model"] = m_modelName.isEmpty() ? "gpt-3.5-turbo" : m_modelName;
    payload["messages"] = messages;
    payload["stream"] = true;

    return payload;
}

QJsonObject AIContinuationWorker::createClaudePayload(const QString &prompt, const QString &context)
{
    QJsonArray messages;
    
    // 添加系统提示（如果存在）
    if (!m_systemPrompt.isEmpty()) {
        QJsonObject systemMessage;
        systemMessage["role"] = "system";
        systemMessage["content"] = m_systemPrompt;
        messages.append(systemMessage);
    }

    QJsonObject message;
    message["role"] = "user";

    QString fullPrompt = context.isEmpty() ? prompt : QString("%1\n\n%2").arg(context, prompt);
    message["content"] = fullPrompt;

    messages.append(message);

    QJsonObject payload;
    payload["model"] = m_modelName.isEmpty() ? "claude-3-haiku-20240307" : m_modelName;
    payload["messages"] = messages;
    payload["stream"] = true;
    // 添加max_tokens以兼容Claude
    payload["max_tokens"] = 4096;

    return payload;
}

QJsonObject AIContinuationWorker::createQwenPayload(const QString &prompt, const QString &context)
{
    QJsonArray messages;
    
    // 添加系统提示（如果存在）
    if (!m_systemPrompt.isEmpty()) {
        QJsonObject systemMessage;
        systemMessage["role"] = "system";
        systemMessage["content"] = m_systemPrompt;
        messages.append(systemMessage);
    }

    QJsonObject message;
    message["role"] = "user";

    QString fullPrompt = context.isEmpty() ? prompt : QString("%1\n\n%2").arg(context, prompt);
    message["content"] = fullPrompt;

    messages.append(message);

    QJsonObject payload;
    payload["model"] = m_modelName.isEmpty() ? "qwen3-max-preview" : m_modelName;
    payload["messages"] = messages;
    payload["stream"] = true;
    // 添加stream_options以兼容通义千问
    QJsonObject streamOptions;
    streamOptions["include_usage"] = true;
    payload["stream_options"] = streamOptions;

    return payload;
}

QJsonObject AIContinuationWorker::createGeminiPayload(const QString &prompt, const QString &context)
{
    QJsonArray messages;
    
    // 添加系统提示（如果存在）
    if (!m_systemPrompt.isEmpty()) {
        QJsonObject systemMessage;
        systemMessage["role"] = "system";
        systemMessage["content"] = m_systemPrompt;
        messages.append(systemMessage);
    }

    QJsonObject message;
    message["role"] = "user";

    QString fullPrompt = context.isEmpty() ? prompt : QString("%1\n\n%2").arg(context, prompt);
    message["content"] = fullPrompt;

    messages.append(message);

    QJsonObject payload;
    payload["model"] = m_modelName.isEmpty() ? "gemini-2.5-flash" : m_modelName;
    payload["messages"] = messages;
    payload["stream"] = true;

    return payload;
}

void AIContinuationWorker::handleNetworkReply()
{
    if (!m_currentReply || m_isCancelled) {
        return;
    }

    if (m_currentReply->error() != QNetworkReply::NoError) {
        qDebug() << "=== 网络请求错误 ===";
        qDebug() << "错误代码:" << m_currentReply->error();
        qDebug() << "错误信息:" << m_currentReply->errorString();
        // 即使是操作取消错误，也应该通知上层，以便正确清理状态
        emit requestError(m_currentReply->errorString());
        m_currentReply->deleteLater();
        m_currentReply = nullptr;
        m_streamTimer->stop();
        emit requestFinished();
        return;
    }

    //qDebug() << "=== 接收到网络响应 ===";
    //qDebug() << "HTTP状态码:" << m_currentReply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    //qDebug() << "可用字节数:" << m_currentReply->bytesAvailable();

    // 处理流式数据
    while (m_currentReply->bytesAvailable() && !m_isCancelled) {
        QByteArray data = m_currentReply->readLine();
        if (!data.isEmpty()) {
            //qDebug() << "接收到的数据行:" << data;
            processStreamChunk(data);
        }
    }

    // 请求完成
    if (m_currentReply->isFinished()) {
        //qDebug() << "=== 请求完成 ===";
        //qDebug() << "累积响应:" << m_accumulatedResponse;
        m_streamTimer->stop();
        m_currentReply->deleteLater();
        m_currentReply = nullptr;
        emit requestFinished();
    }
}

void AIContinuationWorker::processStreamChunk(const QByteArray &data)
{
    //qDebug() << "=== 处理流式数据块 ===";
    //qDebug() << "原始数据:" << data;

    // 处理SSE格式的数据
    QString line = QString::fromUtf8(data).trimmed();
    //qDebug() << "处理后的行:" << line;

    // 跳过空行和注释
    if (line.isEmpty() || line.startsWith(":")) {
        //qDebug() << "跳过空行或注释";
        return;
    }

    // 处理data: 前缀
    if (line.startsWith("data:")) {
        QString jsonData = line.mid(5).trimmed(); // 移除 "data:" 前缀
        //qDebug() << "JSON数据:" << jsonData;

        // 检查是否是结束标记
        if (jsonData == "[DONE]") {
            //qDebug() << "接收到结束标记，累积响应:" << m_accumulatedResponse;
            emit responseReceived(m_accumulatedResponse);
            return;
        }

        // 解析JSON数据
        QJsonDocument doc = QJsonDocument::fromJson(jsonData.toUtf8());
        if (!doc.isNull() && doc.isObject()) {
            QJsonObject obj = doc.object();
            //qDebug() << "JSON对象:" << QJsonDocument(obj).toJson(QJsonDocument::Compact);

            // 提取内容（根据不同的API格式调整）
            QString content;
            if (obj.contains("choices")) {
                QJsonArray choices = obj["choices"].toArray();
                //qDebug() << "Choices数组大小:" << choices.size();
                if (!choices.isEmpty()) {
                    QJsonObject choice = choices.first().toObject();
                    //qDebug() << "Choice对象:" << QJsonDocument(choice).toJson(QJsonDocument::Compact);
                    if (choice.contains("delta")) {
                        QJsonObject delta = choice["delta"].toObject();
                        //qDebug() << "Delta对象:" << QJsonDocument(delta).toJson(QJsonDocument::Compact);
                        if (delta.contains("content")) {
                            content = delta["content"].toString();
                            //qDebug() << "提取到内容:" << content;
                        }
                    }
                }
            } else if (obj.contains("delta")) {
                // 处理Claude的响应格式
                QJsonObject delta = obj["delta"].toObject();
                if (delta.contains("text")) {
                    content = delta["text"].toString();
                }
            }

            if (!content.isEmpty()) {
                m_accumulatedResponse += content;
                emit streamChunkReceived(content);
            } else {
                //qDebug() << "未提取到有效内容";
            }
        } else {
            //qDebug() << "JSON解析失败或不是对象";
        }
    } else {
        //qDebug() << "不是data:前缀的数据";
    }
}

void AIContinuationWorker::handleStreamTimeout()
{
    // if (m_currentReply) {
    //     m_currentReply->abort();
    //     emit requestError("请求超时");
    // }
}

// Manager implementation
AIContinuationManager::AIContinuationManager(QObject *parent)
    : QObject(parent)
    , m_workerThread(new QThread(this))
    , m_worker(new AIContinuationWorker())
    , m_apiProvider(DeepSeek)
    , m_isProcessing(false)
    , m_createThread(new QThread(this))
    , m_createWorker(new AIContinuationWorker())
    , m_optimizeThread(new QThread(this))
    , m_optimizeWorker(new AIContinuationWorker())
    , m_aiCommentThread(new QThread(this))
    , m_aiCommentWorker(new AIContinuationWorker())
    , m_aiSummarizeThread(new QThread(this))
    , m_aiSummarizeWorker(new AIContinuationWorker())
    , m_currentRequestType(Continuation)
{
    // 初始化续写工作线程
    m_worker->moveToThread(m_workerThread);

    connect(m_worker, &AIContinuationWorker::responseReceived, this, &AIContinuationManager::onWorkerResponseReceived);
    connect(m_worker, &AIContinuationWorker::streamChunkReceived, this, &AIContinuationManager::onWorkerStreamChunkReceived);
    connect(m_worker, &AIContinuationWorker::requestFinished, this, &AIContinuationManager::onWorkerRequestFinished);
    connect(m_worker, &AIContinuationWorker::requestError, this, &AIContinuationManager::onWorkerRequestError);

    connect(this, &AIContinuationManager::apiUrlChanged, this, &AIContinuationManager::isProcessingChanged);
    connect(this, &AIContinuationManager::apiKeyChanged, this, &AIContinuationManager::isProcessingChanged);
    connect(this, &AIContinuationManager::systemPromptChanged, this, &AIContinuationManager::isProcessingChanged);

    // 初始化时将API提供商设置传递给worker
    QMetaObject::invokeMethod(m_worker, "setApiProvider", Qt::QueuedConnection,
                              Q_ARG(AIContinuationManager::APIProvider, m_apiProvider));

    m_workerThread->start();

    // 初始化创建元素工作线程
    m_createWorker->moveToThread(m_createThread);
    connect(m_createWorker, &AIContinuationWorker::responseReceived, this, &AIContinuationManager::onCreateWorkerResponseReceived);
    connect(m_createWorker, &AIContinuationWorker::streamChunkReceived, this, &AIContinuationManager::onCreateWorkerStreamChunkReceived);
    connect(m_createWorker, &AIContinuationWorker::requestFinished, this, &AIContinuationManager::onCreateWorkerRequestFinished);
    connect(m_createWorker, &AIContinuationWorker::requestError, this, &AIContinuationManager::onCreateWorkerRequestError);

    m_createThread->start();
    
    // 初始化优化文章工作线程
    m_optimizeWorker->moveToThread(m_optimizeThread);
    connect(m_optimizeWorker, &AIContinuationWorker::responseReceived, this, &AIContinuationManager::onOptimizeWorkerResponseReceived);
    connect(m_optimizeWorker, &AIContinuationWorker::streamChunkReceived, this, &AIContinuationManager::onOptimizeWorkerStreamChunkReceived);
    connect(m_optimizeWorker, &AIContinuationWorker::requestFinished, this, &AIContinuationManager::onOptimizeWorkerRequestFinished);
    connect(m_optimizeWorker, &AIContinuationWorker::requestError, this, &AIContinuationManager::onOptimizeWorkerRequestError);

    m_optimizeThread->start();
    
    // 初始化创建元素的系统提示
    m_createElementSystemPrompt = tr("你是一个创意写作助手，专门用于创建故事元素。请严格按照指定的JSON格式返回结果。");

    //AI点评
    m_aiCommentWorker->moveToThread(m_aiCommentThread);
    connect(m_aiCommentWorker, &AIContinuationWorker::responseReceived, this, &AIContinuationManager::onAiCommentWorkerResponseReceived);
    connect(m_aiCommentWorker, &AIContinuationWorker::streamChunkReceived, this, &AIContinuationManager::onAiCommentWorkerStreamChunkReceived);
    connect(m_aiCommentWorker, &AIContinuationWorker::requestFinished, this, &AIContinuationManager::onAiCommentWorkerRequestFinished);
    connect(m_aiCommentWorker, &AIContinuationWorker::requestError, this, &AIContinuationManager::onAiCommentWorkerRequestError);
    
    // 启动AI点评线程
    m_aiCommentThread->start();

    //AI总结
    m_aiSummarizeWorker->moveToThread(m_aiSummarizeThread);
    connect(m_aiSummarizeWorker, &AIContinuationWorker::responseReceived, this, &AIContinuationManager::onAiSummarizeWorkerResponseReceived);
    connect(m_aiSummarizeWorker, &AIContinuationWorker::streamChunkReceived, this, &AIContinuationManager::onAiSummarizeWorkerStreamChunkReceived);
    connect(m_aiSummarizeWorker, &AIContinuationWorker::requestFinished, this, &AIContinuationManager::onAiSummarizeWorkerRequestFinished);
    connect(m_aiSummarizeWorker, &AIContinuationWorker::requestError, this, &AIContinuationManager::onAiSummarizeWorkerRequestError);
    // 启动AI总结线程
    m_aiSummarizeThread->start();
}

AIContinuationManager::~AIContinuationManager()
{
    if (m_workerThread->isRunning()) {
        m_workerThread->quit();
        m_workerThread->wait();
    }
    
    if (m_createThread->isRunning()) {
        m_createThread->quit();
        m_createThread->wait();
    }
    
    if (m_optimizeThread->isRunning()) {
        m_optimizeThread->quit();
        m_optimizeThread->wait();
    }

    if (m_aiCommentThread->isRunning()) {
        m_aiCommentThread->quit();
        m_aiCommentThread->wait();
    }
}

QString AIContinuationManager::apiUrl() const
{
    return m_apiUrl;
}

QString AIContinuationManager::apiKey() const
{
    return m_apiKey;
}

QString AIContinuationManager::modelName() const
{
    return m_modelName;
}

QString AIContinuationManager::systemPrompt() const
{
    return m_systemPrompt;
}

bool AIContinuationManager::isProcessing() const
{
    return m_isProcessing;
}

QString AIContinuationManager::createElementSystemPrompt() const
{
    return m_createElementSystemPrompt;
}

void AIContinuationManager::requestContinuation(const QString &prompt, const QString &context)
{
    //qDebug() << "=== AI续写请求 ===";
    //qDebug() << "API提供商:" << m_apiProvider;
    //qDebug() << "API URL:" << m_apiUrl;
    //qDebug() << "API Key是否为空:" << m_apiKey.isEmpty();
    //qDebug() << "模型名称:" << m_modelName;
    //qDebug() << "Prompt:" << prompt;
    //qDebug() << "Context长度:" << context.length();

    if (m_apiUrl.isEmpty() || m_apiKey.isEmpty()) {
        qDebug() << "错误: API URL或API Key未设置";
        emit requestError("API URL或API Key未设置");
        return;
    }

    m_isProcessing = true;
    emit isProcessingChanged();

    // 调用worker处理请求
    QMetaObject::invokeMethod(m_worker, "processRequest", Qt::QueuedConnection,
                              Q_ARG(QString, prompt),
                              Q_ARG(QString, context));
}

void AIContinuationManager::requestCreateElement(const QString &description, ElementTypeWrapper::ElementType type)
{
    if (m_apiUrl.isEmpty() || m_apiKey.isEmpty()) {
        qDebug() << "错误: API URL或API Key未设置";
        emit createElementRequestError("API URL或API Key未设置");
        return;
    }

    m_currentRequestType = CreateElement;
    m_isProcessing = true;
    emit isProcessingChanged();

    // 调用创建元素worker处理请求
    QMetaObject::invokeMethod(m_createWorker, "processCreateRequest", Qt::QueuedConnection,
                              Q_ARG(QString, description),
                              Q_ARG(ElementTypeWrapper::ElementType, type));
}

void AIContinuationManager::requestOptimizeArticle(const QString &userPrompt, const QString &optimizationGoal)
{
    if (m_apiUrl.isEmpty() || m_apiKey.isEmpty()) {
        qDebug() << "错误: API URL或API Key未设置";
        emit optimizeArticleRequestError("API URL或API Key未设置");
        return;
    }

    m_currentRequestType = OptimizeArticle;
    m_isProcessing = true;
    emit isProcessingChanged();

    // 调用优化文章worker处理请求
    QMetaObject::invokeMethod(m_optimizeWorker, "processOptimizeRequest", Qt::QueuedConnection,
                              Q_ARG(QString, userPrompt),
                              Q_ARG(QString, optimizationGoal));
}

void AIContinuationManager::requestAiCommentAnalyze(const QString &fullText)
{
    if (m_apiUrl.isEmpty() || m_apiKey.isEmpty()) {
        qDebug() << "错误: API URL或API Key未设置";
        emit aiCommentAnalyzeRequestError("错误: API URL或API Key未设置");
        return;
    }

    m_currentRequestType = AiCommentAnalyze;
    m_isProcessing = true;
    emit isProcessingChanged();

    qDebug() << "=== AI点评请求 ===";

    // 调用AI点评worker处理请求
    QMetaObject::invokeMethod(m_aiCommentWorker, "processAiCommentRequest", Qt::QueuedConnection,
                              Q_ARG(QString, fullText));
}

void AIContinuationManager::requestAiSummarize(const QString &fullText)
{
    if(m_apiUrl.isEmpty() || m_apiKey.isEmpty()){
        qDebug() << "错误: API URL或API Key未设置";
        emit aiSummarizeRequestError("错误: API URL或API Key未设置");
        return;
    }

    m_currentRequestType = AiSummarize;
    m_isProcessing = true;
    emit isProcessingChanged();

    //qDebug() << "=== AI总结请求 ===";
    // 调用AI点评worker处理请求
    QMetaObject::invokeMethod(m_aiSummarizeWorker, "processAiSummarizeRequest", Qt::QueuedConnection,
                              Q_ARG(QString, fullText));
}

void AIContinuationManager::setApiUrl(const QString &url)
{
    if (m_apiUrl != url) {
        m_apiUrl = url;
        emit apiUrlChanged();
        // 更新worker配置
        QMetaObject::invokeMethod(m_worker, "setApiConfig", Qt::QueuedConnection,
                                  Q_ARG(QString, m_apiUrl),
                                  Q_ARG(QString, m_apiKey),
                                  Q_ARG(QString, m_modelName));
        QMetaObject::invokeMethod(m_createWorker, "setApiConfig", Qt::QueuedConnection,
                                  Q_ARG(QString, m_apiUrl),
                                  Q_ARG(QString, m_apiKey),
                                  Q_ARG(QString, m_modelName));
        QMetaObject::invokeMethod(m_optimizeWorker, "setApiConfig", Qt::QueuedConnection,
                                  Q_ARG(QString, m_apiUrl),
                                  Q_ARG(QString, m_apiKey),
                                  Q_ARG(QString, m_modelName));
        QMetaObject::invokeMethod(m_aiCommentWorker, "setApiConfig", Qt::QueuedConnection,
                                  Q_ARG(QString, m_apiUrl),
                                  Q_ARG(QString, m_apiKey),
                                  Q_ARG(QString, m_modelName));
        QMetaObject::invokeMethod(m_aiSummarizeWorker, "setApiConfig", Qt::QueuedConnection,
                                  Q_ARG(QString, m_apiUrl),
                                  Q_ARG(QString, m_apiKey),
                                  Q_ARG(QString, m_modelName));
    }
}

void AIContinuationManager::setApiKey(const QString &key)
{
    if (m_apiKey != key) {
        m_apiKey = key;
        emit apiKeyChanged();
        // 更新worker配置
        QMetaObject::invokeMethod(m_worker, "setApiConfig", Qt::QueuedConnection,
                                  Q_ARG(QString, m_apiUrl),
                                  Q_ARG(QString, m_apiKey),
                                  Q_ARG(QString, m_modelName));
        QMetaObject::invokeMethod(m_createWorker, "setApiConfig", Qt::QueuedConnection,
                                  Q_ARG(QString, m_apiUrl),
                                  Q_ARG(QString, m_apiKey),
                                  Q_ARG(QString, m_modelName));
        QMetaObject::invokeMethod(m_optimizeWorker, "setApiConfig", Qt::QueuedConnection,
                                  Q_ARG(QString, m_apiUrl),
                                  Q_ARG(QString, m_apiKey),
                                  Q_ARG(QString, m_modelName));
        QMetaObject::invokeMethod(m_aiCommentWorker, "setApiConfig", Qt::QueuedConnection,
                                  Q_ARG(QString, m_apiUrl),
                                  Q_ARG(QString, m_apiKey),
                                  Q_ARG(QString, m_modelName));
        QMetaObject::invokeMethod(m_aiSummarizeWorker, "setApiConfig", Qt::QueuedConnection,
                                  Q_ARG(QString, m_apiUrl),
                                  Q_ARG(QString, m_apiKey),
                                  Q_ARG(QString, m_modelName));
    }
}

void AIContinuationManager::setModelName(const QString &name)
{
    if (m_modelName != name) {
        m_modelName = name;
        emit modelNameChanged();
        // 更新worker配置
        QMetaObject::invokeMethod(m_worker, "setApiConfig", Qt::QueuedConnection,
                                  Q_ARG(QString, m_apiUrl),
                                  Q_ARG(QString, m_apiKey),
                                  Q_ARG(QString, m_modelName));
        QMetaObject::invokeMethod(m_createWorker, "setApiConfig", Qt::QueuedConnection,
                                  Q_ARG(QString, m_apiUrl),
                                  Q_ARG(QString, m_apiKey),
                                  Q_ARG(QString, m_modelName));
        QMetaObject::invokeMethod(m_optimizeWorker, "setApiConfig", Qt::QueuedConnection,
                                  Q_ARG(QString, m_apiUrl),
                                  Q_ARG(QString, m_apiKey),
                                  Q_ARG(QString, m_modelName));
        QMetaObject::invokeMethod(m_aiCommentWorker, "setApiConfig", Qt::QueuedConnection,
                                  Q_ARG(QString, m_apiUrl),
                                  Q_ARG(QString, m_apiKey),
                                  Q_ARG(QString, m_modelName));
        // 添加AI总结工作线程的API配置更新
        QMetaObject::invokeMethod(m_aiSummarizeWorker, "setApiConfig", Qt::QueuedConnection,
                                  Q_ARG(QString, m_apiUrl),
                                  Q_ARG(QString, m_apiKey),
                                  Q_ARG(QString, m_modelName));
    }
}

void AIContinuationManager::setSystemPrompt(const QString &prompt)
{
    if (m_systemPrompt != prompt) {
        m_systemPrompt = prompt;
        emit systemPromptChanged();
        // 更新worker配置
        QMetaObject::invokeMethod(m_worker, "setSystemPrompt", Qt::QueuedConnection,
                                  Q_ARG(QString, m_systemPrompt));
    }
}

void AIContinuationManager::setApiProvider(APIProvider provider)
{
    m_apiProvider = provider;
    // 更新worker中的API提供商
    QMetaObject::invokeMethod(m_worker, "setApiProvider", Qt::QueuedConnection,
                              Q_ARG(AIContinuationManager::APIProvider, provider));
    QMetaObject::invokeMethod(m_createWorker, "setApiProvider", Qt::QueuedConnection,
                              Q_ARG(AIContinuationManager::APIProvider, provider));
    QMetaObject::invokeMethod(m_optimizeWorker, "setApiProvider", Qt::QueuedConnection,
                              Q_ARG(AIContinuationManager::APIProvider, provider));
    QMetaObject::invokeMethod(m_aiCommentWorker, "setApiProvider", Qt::QueuedConnection,
                              Q_ARG(AIContinuationManager::APIProvider, provider));
    // 添加AI总结工作线程的API提供商更新
    QMetaObject::invokeMethod(m_aiSummarizeWorker, "setApiProvider", Qt::QueuedConnection,
                              Q_ARG(AIContinuationManager::APIProvider, provider));
}

void AIContinuationManager::cancelRequest()
{
    QMetaObject::invokeMethod(m_worker, "cancelRequest", Qt::QueuedConnection);
}

void AIContinuationManager::onWorkerResponseReceived(const QString &response)
{
    emit responseReceived(response);
}

void AIContinuationManager::onWorkerStreamChunkReceived(const QString &chunk)
{
    //qDebug()<<"续写流数据块:"<<chunk;//保持原始格式
    emit streamChunkReceived(chunk);//保持原始格式，不要trimmed
}

void AIContinuationManager::onWorkerRequestFinished()
{
    m_isProcessing = false;
    emit isProcessingChanged();
    emit requestFinished();
}

void AIContinuationManager::onWorkerRequestError(const QString &error)
{
    m_isProcessing = false;
    emit isProcessingChanged();
    emit requestError(error);
}

// 创建元素相关槽函数实现
void AIContinuationManager::onCreateWorkerResponseReceived(const QString &response)
{
    emit createElementResponseReceived(response);
}

void AIContinuationManager::onCreateWorkerStreamChunkReceived(const QString &chunk)
{
    emit createElementStreamChunkReceived(chunk);
}

void AIContinuationManager::onCreateWorkerRequestFinished()
{
    m_isProcessing = false;
    emit isProcessingChanged();
    
    // 尝试解析响应为JSON格式的元素数据
    QJsonDocument doc = QJsonDocument::fromJson(m_createWorker->m_accumulatedResponse.toUtf8());
    if (!doc.isNull() && doc.isObject()) {
        QJsonObject elementData = doc.object();
        emit createElementRequestFinished(elementData);
    } else {
        // 如果不是有效的JSON，仍然发送完成信号
        emit createElementRequestFinished(QJsonObject());
    }
}

void AIContinuationManager::onCreateWorkerRequestError(const QString &error)
{
    m_isProcessing = false;
    emit isProcessingChanged();
    emit createElementRequestError(error);
}

// 优化文章相关槽函数实现
void AIContinuationManager::onOptimizeWorkerResponseReceived(const QString &response)
{
    emit optimizeArticleResponseReceived(response);
}

void AIContinuationManager::onOptimizeWorkerStreamChunkReceived(const QString &chunk)
{
    emit optimizeArticleStreamChunkReceived(chunk);
}

void AIContinuationManager::onOptimizeWorkerRequestFinished()
{
    m_isProcessing = false;
    emit isProcessingChanged();
    emit optimizeArticleRequestFinished();
}

void AIContinuationManager::onOptimizeWorkerRequestError(const QString &error)
{
    m_isProcessing = false;
    emit isProcessingChanged();
    emit optimizeArticleRequestError(error);
}

void AIContinuationManager::onAiCommentWorkerResponseReceived(const QString &response)
{
    //qDebug()<<"AI评论响应原Json:"<<response;
    emit aiCommentAnalyzeResponseReceived(response);
}

void AIContinuationManager::onAiCommentWorkerStreamChunkReceived(const QString &chunk)
{
    emit aiCommentAnalyzeStreamChunkReceived(chunk);
}

void AIContinuationManager::onAiCommentWorkerRequestFinished()
{
    m_isProcessing = false;
    emit isProcessingChanged();
    emit aiCommentAnalyzeRequestFinished();
}

void AIContinuationManager::onAiCommentWorkerRequestError(const QString &error)
{
    m_isProcessing = false;
    emit isProcessingChanged();
    emit aiCommentAnalyzeRequestError(error);
}

void AIContinuationManager::onAiSummarizeWorkerResponseReceived(const QString &response)
{
    m_isProcessing = false;
    emit isProcessingChanged();
    emit aiSummarizeResponseReceived(response);
}

void AIContinuationManager::onAiSummarizeWorkerStreamChunkReceived(const QString &chunk)
{
    //qDebug()<<"AI总结流数据块:"<<chunk;
    m_isProcessing = false;
    emit isProcessingChanged();
    emit aiSummarizeStreamChunkReceived(chunk);
}

void AIContinuationManager::onAiSummarizeWorkerRequestFinished()
{
    m_isProcessing = false;
    emit isProcessingChanged();
    emit aiSummarizeRequestFinished();
}

void AIContinuationManager::onAiSummarizeWorkerRequestError(const QString &error)
{
    m_isProcessing = false;
    emit isProcessingChanged();
    emit aiSummarizeRequestError(error);
}
