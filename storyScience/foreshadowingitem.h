/**
 * @file foreshadowingitem.h
 * @brief 伏笔项类
 * 
 * ForeshadowingItem 表示一个伏笔项，包含原文片段、描述、状态等信息。
 */

#ifndef FORESHADOWINGITEM_H
#define FORESHADOWINGITEM_H

#include <QObject>
#include <QString>
#include <QDateTime>

/**
 * @class ForeshadowingItem
 * @brief 伏笔项类
 * 
 * 表示一个伏笔项，包含原文片段、描述、创建时间、来源章节等信息。
 * 支持状态管理（已解决/未解决）。
 */
class ForeshadowingItem : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString content READ content CONSTANT)
    Q_PROPERTY(QString id READ id CONSTANT)
    Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged)
    Q_PROPERTY(QDateTime creationDate READ creationDate CONSTANT)
    Q_PROPERTY(QString sourceChapterId READ sourceChapterId CONSTANT)
    Q_PROPERTY(Status status READ status WRITE setStatus NOTIFY statusChanged)
    Q_PROPERTY(QString prefix READ prefix CONSTANT)
    Q_PROPERTY(QString suffix READ suffix CONSTANT)
public:
    /**
     * @enum Status
     * @brief 伏笔状态枚举
     */
    enum Status {
        Unresolved,  ///< 未解决
        Resolved     ///< 已解决
    };
    Q_ENUM(Status)

    ForeshadowingItem(const QString& id, const QString& content, const QString& prefix, const QString& suffix,
                      const QString& description, const QString& sourceChapterId, QObject* parent = nullptr);
    QString id() const;
    QString content() const;
    QString description() const;
    QDateTime creationDate() const;
    QString sourceChapterId() const;
    Status status() const;
    QString prefix() const;
    QString suffix() const;
    
    void setDescription(const QString& description);
    void setStatus(Status status);

signals:
    void descriptionChanged();
    void statusChanged();

private:
    QString m_id;
    QString m_content;
    QString m_description;
    QDateTime m_creationDate;
    QString m_sourceChapterId;
    Status m_status;
    QString m_prefix;
    QString m_suffix;
};



#endif // FORESHADOWINGITEM_H
