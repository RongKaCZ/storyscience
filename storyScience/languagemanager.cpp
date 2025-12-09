/**
 * @file languagemanager.cpp
 * @brief LanguageManager 类的实现
 */

#include "languagemanager.h"
#include <QGuiApplication>
#include <QDebug>

LanguageManager* LanguageManager::instance()
{
    static LanguageManager inst;
    return &inst;
}

LanguageManager::LanguageManager(QObject *parent) : QObject(parent)
{
}

void LanguageManager::setQmlEngine(QQmlEngine *engine)
{
    m_qmlEngine = engine;
}

void LanguageManager::selectLanguage(const QString& languageCode)
{
    if (!m_qmlEngine) {
        qWarning() << "QML engine has not been set in LanguageManager!";
        return;
    }

    // 移除旧的翻译器
    qApp->removeTranslator(&m_translator);

    // 加载新的翻译文件（格式：storyScience_zh.qm 或 storyScience_en.qm）
    QString qmPath = ":/i18n/storyScience_" + languageCode + ".qm";

    if (m_translator.load(qmPath)) {
        qApp->installTranslator(&m_translator);
    } else {
        qWarning() << "Failed to load translation file:" << qmPath;
    }

    // 通知 QML 引擎刷新所有翻译绑定
    m_qmlEngine->retranslate();
}
