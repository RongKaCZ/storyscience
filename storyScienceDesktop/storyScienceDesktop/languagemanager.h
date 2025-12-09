/**
 * @file languagemanager.h
 * @brief 语言管理器类
 * 
 * LanguageManager 负责管理应用程序的多语言支持，
 * 使用单例模式，支持动态切换语言。
 */

#pragma once

#include <QObject>
#include <QTranslator>
#include <QQmlEngine>

/**
 * @class LanguageManager
 * @brief 语言管理器类
 * 
 * 管理应用程序的多语言支持，使用 QTranslator 加载翻译文件。
 * 采用单例模式，确保全局只有一个语言管理器实例。
 */
class LanguageManager : public QObject
{
    Q_OBJECT
public:
    /// 获取单例实例
    static LanguageManager* instance();

    /// 设置 QML 引擎，必须在加载 QML 之前调用
    void setQmlEngine(QQmlEngine *engine);

    /// 选择语言（"en" 或 "zh"）
    Q_INVOKABLE void selectLanguage(const QString& languageCode);

private:
    explicit LanguageManager(QObject *parent = nullptr);
    ~LanguageManager() = default;

    QQmlEngine* m_qmlEngine = nullptr;
    QTranslator m_translator;
};
