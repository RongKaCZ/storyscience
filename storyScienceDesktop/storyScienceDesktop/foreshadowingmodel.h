/**
 * @file foreshadowingmodel.h
 * @brief 伏笔管理模型类
 * 
 * ForeshadowingModel 用于管理故事中的伏笔，支持伏笔的添加、状态更新和序列化。
 * 伏笔可以关联到特定的章节，并跟踪其解决状态。
 */

#ifndef FORESHADOWINGMODEL_H
#define FORESHADOWINGMODEL_H

#include <QAbstractListModel>
#include "foreshadowingitem.h" // 引入我们刚创建的类
#include <QJsonArray>

/**
 * @class ForeshadowingModel
 * @brief 伏笔管理模型类
 * 
 * 继承自 QAbstractListModel，提供伏笔的列表管理功能。
 * 支持伏笔的添加、状态更新、查询和序列化。
 */
class ForeshadowingModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        // 从ForeshadowingItem的属性中生成Roles
        IdRole = Qt::UserRole + 1,
        ContentRole,
        DescriptionRole,
        CreationDateRole,
        SourceChapterIdRole,
        StatusRole
    };

    explicit ForeshadowingModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE QObject* get(int index) const;
    Q_INVOKABLE void addForeshadowing(const QString& content, const QString& prefix, const QString& suffix, const QString& description, const QString& sourceChapterId);
    Q_INVOKABLE void updateStatus(const QString& id);
    void resolveForeshadowing(const QString &id);
    Q_INVOKABLE QString getUnresolvedAsJson(const QString& chapterId) const;

    QJsonArray serialize() const;
    void deserialize(const QJsonArray& array);

    void clear();
private:
    QList<ForeshadowingItem*> m_items;
};

#endif // FORESHADOWINGMODEL_H
