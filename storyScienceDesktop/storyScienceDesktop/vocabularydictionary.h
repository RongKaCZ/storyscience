/**
 * @file vocabularydictionary.h
 * @brief 词汇字典类
 * 
 * VocabularyDictionary 用于管理词汇数据，支持从文件或资源加载，
 * 提供分类查询和搜索功能。
 */

#ifndef VOCABULARYDICTIONARY_H
#define VOCABULARYDICTIONARY_H

#include <QObject>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QFile>
#include <QDir>
#include <QDebug>

/**
 * @class VocabularyDictionary
 * @brief 词汇字典类
 * 
 * 管理词汇数据，支持从JSON文件或资源加载，
 * 提供按分类查询和搜索功能。
 */
class VocabularyDictionary : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QJsonObject vocabularyData READ vocabularyData NOTIFY vocabularyDataChanged)
    Q_PROPERTY(QStringList categories READ categories NOTIFY vocabularyDataChanged)

public:
    explicit VocabularyDictionary(QObject *parent = nullptr);

    Q_INVOKABLE bool loadFromFile(const QString &filePath);
    Q_INVOKABLE bool loadFromResource(const QString &resourcePath);
    Q_INVOKABLE QStringList getWordsByCategory(const QString &category) const;
    Q_INVOKABLE QStringList searchWords(const QString &category, const QString &searchText) const;
    
    const QJsonObject& vocabularyData() const;
    QStringList categories() const;

signals:
    void vocabularyDataChanged();

private:
    QJsonObject m_vocabularyData;
    QStringList m_categories;
    void parseCategories();
};

#endif // VOCABULARYDICTIONARY_H