/**
 * @file aicontinuationmanager.h
 * @brief AI续写管理器类
 * 
 * AIContinuationManager 负责管理AI续写、元素创建、文章优化等AI功能。
 * 支持多种AI服务提供商（DeepSeek、Kimi、ChatGPT等），
 * 使用工作线程处理网络请求，避免阻塞UI线程。
 */

#ifndef AICONTINUATIONMANAGER_H
#define AICONTINUATIONMANAGER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QThread>
#include <QTimer>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <elementtype.h>
class AIContinuationWorker;  // 前向声明

/**
 * @class AIContinuationManager
 * @brief AI续写管理器类
 * 
 * 管理AI相关的所有功能，包括续写、元素创建、文章优化等。
 * 使用独立的工作线程处理网络请求，支持流式响应和错误处理。
 */
class AIContinuationManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString apiUrl READ apiUrl WRITE setApiUrl NOTIFY apiUrlChanged)
    Q_PROPERTY(QString apiKey READ apiKey WRITE setApiKey NOTIFY apiKeyChanged)
    Q_PROPERTY(QString modelName READ modelName WRITE setModelName NOTIFY modelNameChanged)
    Q_PROPERTY(QString systemPrompt READ systemPrompt WRITE setSystemPrompt NOTIFY systemPromptChanged)
    Q_PROPERTY(bool isProcessing READ isProcessing NOTIFY isProcessingChanged)

public:
    explicit AIContinuationManager(QObject *parent = nullptr);
    ~AIContinuationManager();

    /**
     * @enum APIProvider
     * @brief AI服务提供商枚举
     */
    enum APIProvider {
        DeepSeek,    ///< DeepSeek AI
        Kimi,        ///< 月之暗面 Kimi
        Doubao,      ///< 字节跳动豆包
        OpenRouter,  ///< OpenRouter
        Qwen,        ///< 通义千问
        ChatGPT,     ///< OpenAI ChatGPT
        Claude,      ///< Anthropic Claude
        Gemini       ///< Google Gemini
    };
    Q_ENUM(APIProvider)

    /**
     * @enum RequestType
     * @brief 请求类型枚举
     */
    enum RequestType {
        Continuation,      // 续写
        CreateElement,     // 创建元素
        OptimizeArticle,    // 优化文章
        AiCommentAnalyze,    // AI评论分析
        AiSummarize         // AI总结
    };
    Q_ENUM(RequestType)

    QString apiUrl() const;
    QString apiKey() const;
    QString modelName() const;
    QString systemPrompt() const;
    bool isProcessing() const;
    Q_INVOKABLE void cancelRequest();
    /// 获取创建元素的系统提示
    QString createElementSystemPrompt() const;

public slots:
    void setApiUrl(const QString &url);
    void setApiKey(const QString &key);
    void setModelName(const QString &name);
    void setSystemPrompt(const QString &prompt);
    void setApiProvider(APIProvider provider);
    void requestContinuation(const QString &prompt, const QString &context);
    void requestCreateElement(const QString &description, ElementTypeWrapper::ElementType type);
    void requestOptimizeArticle(const QString &articleContent, const QString &optimizationGoal);
    void requestAiCommentAnalyze(const QString &fullText);
    void requestAiSummarize(const QString &fullText);
signals:
    // 续写相关信号
    void responseReceived(const QString &response);
    void streamChunkReceived(const QString &chunk);
    void requestFinished();
    void requestError(const QString &error);
    
    // 创建元素相关信号
    void createElementResponseReceived(const QString &response);
    void createElementStreamChunkReceived(const QString &chunk);
    void createElementRequestFinished(const QJsonObject &elementData);
    void createElementRequestError(const QString &error);
    
    // 优化文章相关信号
    void optimizeArticleResponseReceived(const QString &response);
    void optimizeArticleStreamChunkReceived(const QString &chunk);
    void optimizeArticleRequestFinished();
    void optimizeArticleRequestError(const QString &error);
    
    void aiCommentAnalyzeResponseReceived(const QString &response);
    void aiCommentAnalyzeStreamChunkReceived(const QString &chunk);
    void aiCommentAnalyzeRequestFinished();
    void aiCommentAnalyzeRequestError(const QString &error);

    void aiSummarizeResponseReceived(const QString &response);
    void aiSummarizeStreamChunkReceived(const QString &chunk);
    void aiSummarizeRequestFinished();
    void aiSummarizeRequestError(const QString &error);

    void apiUrlChanged();
    void apiKeyChanged();
    void modelNameChanged();
    void systemPromptChanged();
    void isProcessingChanged();
    
private slots:
    void onWorkerResponseReceived(const QString &response);
    void onWorkerStreamChunkReceived(const QString &chunk);
    void onWorkerRequestFinished();
    void onWorkerRequestError(const QString &error);
    
    void onCreateWorkerResponseReceived(const QString &response);
    void onCreateWorkerStreamChunkReceived(const QString &chunk);
    void onCreateWorkerRequestFinished();
    void onCreateWorkerRequestError(const QString &error);
    
    void onOptimizeWorkerResponseReceived(const QString &response);
    void onOptimizeWorkerStreamChunkReceived(const QString &chunk);
    void onOptimizeWorkerRequestFinished();
    void onOptimizeWorkerRequestError(const QString &error);
    
    void onAiCommentWorkerResponseReceived(const QString &response);
    void onAiCommentWorkerStreamChunkReceived(const QString &chunk);
    void onAiCommentWorkerRequestFinished();
    void onAiCommentWorkerRequestError(const QString &error);

    void onAiSummarizeWorkerResponseReceived(const QString &response);
    void onAiSummarizeWorkerStreamChunkReceived(const QString &chunk);
    void onAiSummarizeWorkerRequestFinished();
    void onAiSummarizeWorkerRequestError(const QString &error);

private:
    QThread *m_workerThread;
    AIContinuationWorker *m_worker;
    QThread *m_createThread;
    AIContinuationWorker *m_createWorker;
    QThread *m_optimizeThread;
    AIContinuationWorker *m_optimizeWorker;
    QThread *m_aiCommentThread;
    AIContinuationWorker *m_aiCommentWorker;
    QThread *m_aiSummarizeThread;
    AIContinuationWorker *m_aiSummarizeWorker;

    QString m_apiUrl;
    QString m_apiKey;
    QString m_modelName;
    QString m_systemPrompt;
    QString m_createElementSystemPrompt;
    APIProvider m_apiProvider;
    bool m_isProcessing;
    RequestType m_currentRequestType;  ///< 当前请求类型
};

/**
 * @class AIContinuationWorker
 * @brief AI续写工作线程类
 * 
 * 在工作线程中处理AI网络请求，避免阻塞UI线程。
 * 支持流式响应处理和请求取消功能。
 */
class AIContinuationWorker : public QObject
{
    Q_OBJECT

public:
    explicit AIContinuationWorker(QObject *parent = nullptr);
    
    QString m_accumulatedResponse;  ///< 累积的响应内容（用于流式响应）

public slots:
    void setApiConfig(const QString &apiUrl, const QString &apiKey, const QString &modelName);
    void setApiProvider(AIContinuationManager::APIProvider provider);
    void setSystemPrompt(const QString &prompt);
    void processRequest(const QString &prompt, const QString &context);
    void cancelRequest();
    void processCreateRequest(const QString &description, ElementTypeWrapper::ElementType type);
    void processOptimizeRequest(const QString &articleContent, const QString &optimizationGoal);
    void processAiCommentRequest(const QString &fullText);
    void processAiSummarizeRequest(const QString &fullText);
signals:
    void responseReceived(const QString &response);
    void streamChunkReceived(const QString &chunk);
    void requestFinished();
    void requestError(const QString &error);

private slots:
    void handleNetworkReply();
    void handleStreamTimeout();

private:
    QNetworkAccessManager *m_networkManager;
    QNetworkReply *m_currentReply;
    QString m_apiUrl;
    QString m_apiKey;
    QString m_modelName;
    QString m_systemPrompt;
    AIContinuationManager::APIProvider m_apiProvider;
    QTimer *m_streamTimer;
    bool m_isCancelled;

    void sendDeepSeekRequest(const QString &prompt, const QString &context);
    void sendKimiRequest(const QString &prompt, const QString &context);
    void sendDoubaoRequest(const QString &prompt, const QString &context);
    void sendOpenRouterRequest(const QString &prompt, const QString &context);
    void sendChatGPTRequest(const QString &prompt, const QString &context);
    void sendClaudeRequest(const QString &prompt, const QString &context);
    void sendQwenRequest(const QString &prompt, const QString &context);
    void sendGeminiRequest(const QString &prompt, const QString &context);

    QJsonObject createDeepSeekPayload(const QString &prompt, const QString &context);
    QJsonObject createKimiPayload(const QString &prompt, const QString &context);
    QJsonObject createDoubaoPayload(const QString &prompt, const QString &context);
    QJsonObject createOpenRouterPayload(const QString &prompt, const QString &context);
    QJsonObject createChatGPTPayload(const QString &prompt, const QString &context);
    QJsonObject createClaudePayload(const QString &prompt, const QString &context);
    QJsonObject createQwenPayload(const QString &prompt, const QString &context);
    QJsonObject createGeminiPayload(const QString &prompt, const QString &context);

    void processStreamChunk(const QByteArray &data);
    
    // 处理元素类型到提示的转换
    QString processTypeToPrompt(const ElementTypeWrapper &type);
    QString processTypeToPrompt(ElementTypeWrapper::ElementType type);
};

#endif // AICONTINUATIONMANAGER_H
