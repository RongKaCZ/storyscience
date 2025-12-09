/**
 * @file storymodel.h
 * @brief 故事结构模型类
 * 
 * StoryModel 继承自 QAbstractItemModel，用于管理故事树形结构。
 * 支持书籍、卷、章节等层级结构，并提供元素关联、文章关联等功能。
 */

#ifndef STORYMODEL_H
#define STORYMODEL_H

#include <QAbstractItemModel>
#include <QQmlEngine>
#include "storyitem.h"

/**
 * @class StoryModel
 * @brief 故事结构模型类
 * 
 * 使用树形结构管理故事项（书籍、卷、章节等），
 * 支持元素关联、文章关联，并提供完整的 QAbstractItemModel 接口。
 */
class StoryModel : public QAbstractItemModel
{
    Q_OBJECT
    QML_NAMED_ELEMENT(StoryModel)

public:
    enum ModelRoles {
        DisplayRole  = Qt::UserRole + 1,
        ItemTypeRole,
        TitleRole,
        PrevSummaryRole,
    };

    explicit StoryModel(QObject *parent = nullptr);
    ~StoryModel() override;

    // QAbstractItemModel overrides
    QVariant data(const QModelIndex &index, int role) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;
    Qt::ItemFlags flags(const QModelIndex &index) const override;
    QModelIndex index(int row, int column, const QModelIndex &parent = {}) const override;
    QModelIndex parent(const QModelIndex &index) const override;
    int rowCount(const QModelIndex &parent = {}) const override;
    int columnCount(const QModelIndex &parent = {}) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE bool associateElements(const QModelIndex &index, const QList<QUuid> &elementIds);
    Q_INVOKABLE bool associateElement(const QModelIndex &index, const QUuid &elementId);
    Q_INVOKABLE bool disassociateElement(const QModelIndex &index, const QUuid &id);

    Q_INVOKABLE bool setArticleIdForItem(const QModelIndex &index, const QUuid &articleId);
private:
    void purgeElementFromItemRecursive(StoryItem *item, const QUuid &id, const QModelIndex &parentIndex, int row);
public:
    Q_INVOKABLE void purgeElementFromAllItems(const QUuid &id);
    // QML Invokable API
    Q_INVOKABLE QVariantMap getItemData(const QModelIndex &index) const;
    Q_INVOKABLE QModelIndex insertItemAndGetIndex(const QModelIndex &parent, int row, StoryTypeWrapper::StoryType type, const QString &title, const QList<QUuid> &elementIds = {});
    Q_INVOKABLE bool insertItem(const QModelIndex &parent, int row, StoryTypeWrapper::StoryType type, const QString &title, const QList<QUuid> &elementIds = {});
    Q_INVOKABLE bool removeItem(const QModelIndex &index);
    Q_INVOKABLE QModelIndex getIndexByArticleId(const QUuid &articleId) const;
    Q_INVOKABLE void forceRefresh();
    
    // 数据持久化辅助方法
    Q_INVOKABLE void clearAllItems();
    void resetModel(); // 公共方法调用 beginResetModel/endResetModel
    StoryItem* getRootItem() const { return m_rootItem.get(); }

private:
    StoryItem* getItem(const QModelIndex &index) const;
    void setupModelData();
    std::unique_ptr<StoryItem> m_rootItem;
};

#endif // STORYMODEL_H
