/**
 * @file article.h
 * @brief 文章类，表示一个章节或文章的内容
 * 
 * Article 类封装了文章的基本信息，包括标题、内容和字数统计。
 * 支持通过 QML 属性绑定进行双向数据绑定。
 */

#pragma once
#include <QObject>
#include <QString>
#include <QUuid>

/**
 * @enum ArticleEpType
 * @brief 文章导出类型枚举
 */
enum class ArticleEpType{
    TxT,    ///< 纯文本格式
    MD,     ///< Markdown 格式
    HTML,   ///< HTML 格式
    PDF,    ///< PDF 格式
    DOCX    ///< Word 文档格式
};

/**
 * @class Article
 * @brief 文章类
 * 
 * 表示一个章节或文章，包含标题、内容和字数统计。
 * 所有属性都通过 Q_PROPERTY 暴露给 QML，支持双向绑定。
 */
class Article : public QObject
{
    Q_OBJECT
    // 暴露 content 属性给 QML，并设置 NOTIFY 信号
    Q_PROPERTY(QString content READ content WRITE setContent NOTIFY contentChanged)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(QUuid id READ id CONSTANT)
    Q_PROPERTY(int wordCount READ wordCount NOTIFY contentChanged)
    Q_ENUM(ArticleEpType)
public:
    explicit Article(QObject *parent = nullptr);
    explicit Article(QUuid id, QString content, QObject *parent = nullptr);

    QUuid id() const;
    QString content() const;
    void setContent(const QString &newContent);
    
    QString title() const;
    void setTitle(const QString &newTitle);
    
    int wordCount() const;

signals:
    void contentChanged();
    void titleChanged();

private:
    QUuid m_id;
    QString m_content;
    QString m_title;
};
