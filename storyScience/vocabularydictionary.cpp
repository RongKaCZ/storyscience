/**
 * @file vocabularydictionary.cpp
 * @brief VocabularyDictionary 类的实现
 */

#include "vocabularydictionary.h"
#include <QFile>
#include <QJsonDocument>
#include <QJsonArray>
#include <QDir>
#include <QDebug>

VocabularyDictionary::VocabularyDictionary(QObject *parent)
    : QObject(parent)
{
    // 初始化默认的词汇分类列表
    m_categories << "interjection"
                 << "action_words"
                 << "eye_expression_words"
                 << "psychological_activity_words"
                 << "environmental_description_words"
                 << "appearance_description_words"
                 << "sound_words"
                 << "dialogue_verbs"
                 << "combat_words"
                 << "cultivation_terms"
                 << "character_identity_titles"
                 << "item_treasure_names"
                 << "abstract_concepts_tropes"
                 << "power_aura_adjectives";
}

bool VocabularyDictionary::loadFromFile(const QString &filePath)
{
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning() << "无法打开文件:" << filePath;
        return false;
    }

    QByteArray jsonData = file.readAll();
    file.close();

    QJsonParseError parseError;
    QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonData, &parseError);
    
    if (parseError.error != QJsonParseError::NoError) {
        qWarning() << "JSON解析错误:" << parseError.errorString();
        return false;
    }

    if (!jsonDoc.isObject()) {
        qWarning() << "JSON数据不是对象格式";
        return false;
    }

    m_vocabularyData = jsonDoc.object();
    parseCategories();
    
    emit vocabularyDataChanged();
    return true;
}

bool VocabularyDictionary::loadFromResource(const QString &resourcePath)
{
    QFile file(resourcePath);
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning() << "无法打开资源文件:" << resourcePath;
        return false;
    }

    QByteArray jsonData = file.readAll();
    file.close();

    QJsonParseError parseError;
    QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonData, &parseError);
    
    if (parseError.error != QJsonParseError::NoError) {
        qWarning() << "JSON解析错误:" << parseError.errorString();
        return false;
    }

    if (!jsonDoc.isObject()) {
        qWarning() << "JSON数据不是对象格式";
        return false;
    }

    m_vocabularyData = jsonDoc.object();
    parseCategories();
    
    emit vocabularyDataChanged();
    return true;
}

QStringList VocabularyDictionary::getWordsByCategory(const QString &category) const
{
    if (!m_vocabularyData.contains(category)) {
        return QStringList();
    }

    QJsonValue categoryValue = m_vocabularyData.value(category);
    if (!categoryValue.isArray()) {
        return QStringList();
    }

    QJsonArray wordArray = categoryValue.toArray();
    QStringList words;
    
    for (const QJsonValue &value : wordArray) {
        if (value.isString()) {
            words << value.toString();
        }
    }
    
    return words;
}

QStringList VocabularyDictionary::searchWords(const QString &category, const QString &searchText) const
{
    QStringList allWords = getWordsByCategory(category);
    if (searchText.trimmed().isEmpty()) {
        return allWords;
    }

    QStringList filteredWords;
    for (const QString &word : allWords) {
        if (word.contains(searchText, Qt::CaseInsensitive)) {
            filteredWords << word;
        }
    }
    
    return filteredWords;
}

const QJsonObject& VocabularyDictionary::vocabularyData() const
{
    return m_vocabularyData;
}

QStringList VocabularyDictionary::categories() const
{
    return m_categories;
}

void VocabularyDictionary::parseCategories()
{
    m_categories.clear();
    for (auto it = m_vocabularyData.begin(); it != m_vocabularyData.end(); ++it) {
        m_categories.append(it.key());
    }
}
