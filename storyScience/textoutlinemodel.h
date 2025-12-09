/**
 * @file textoutlinemodel.h
 * @brief 文本大纲模型类
 * 
 * TextOutlineModel 用于管理纯文本形式的大纲内容。
 * 提供简单的文本存储和序列化功能。
 */

#pragma once
#include <QObject>
#include <QString>

/**
 * @class TextOutlineModel
 * @brief 文本大纲模型类
 * 
 * 管理纯文本形式的大纲内容，提供简单的文本读写功能。
 */
class TextOutlineModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString content READ content WRITE setContent NOTIFY contentChanged)

public:
    explicit TextOutlineModel(QObject *parent = nullptr);

    Q_INVOKABLE QString content() const;
    Q_INVOKABLE void setContent(const QString &newContent);

    /// 将内容保存为文本格式
    Q_INVOKABLE QString saveToText() const;
    Q_INVOKABLE void loadFromText(const QString &text);

signals:
    void contentChanged();

private:
    QString m_content;
};