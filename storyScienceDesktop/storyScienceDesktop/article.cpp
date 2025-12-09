/**
 * @file article.cpp
 * @brief Article 类的实现
 */

#include "article.h"

#include <QTextDocument>

Article::Article(QObject *parent)
    : QObject(parent), m_id(QUuid::createUuid()), m_title(tr("新章节"))
{}

Article::Article(QUuid id, QString content, QObject *parent)
    : QObject(parent), m_id(id), m_content(std::move(content)), m_title(tr("新章节"))
{}

QUuid Article::id() const
{
    return m_id;
}

QString Article::content() const
{
    return m_content;
}

void Article::setContent(const QString &newContent)
{
    if (m_content == newContent)
        return;
    m_content = newContent;
    emit contentChanged();
}

QString Article::title() const
{
    return m_title;
}

void Article::setTitle(const QString &newTitle)
{
    if (m_title == newTitle)
        return;
    m_title = newTitle;
    emit titleChanged();
}

/**
 * @brief 计算文章字数
 * @return 文章的字数（去除HTML标签后的纯文本长度）
 * 
 * 使用 QTextDocument 解析 HTML 内容，提取纯文本后计算长度。
 */
int Article::wordCount() const
{
    QTextDocument doc;
    doc.setHtml(m_content);
    // 获取纯文本（会自动去掉标签）
    QString plainText = doc.toPlainText();
    int wordCount = plainText.length();
    return wordCount;
}
