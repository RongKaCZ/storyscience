/**
 * @file storymodel.cpp
 * @brief StoryModel 类的实现
 */

#include "storymodel.h"
#include <QDebug>

StoryModel::StoryModel(QObject *parent)
    : QAbstractItemModel(parent)
{
    m_rootItem = std::make_unique<StoryItem>(ItemData{QUuid::createUuid(), StoryTypeWrapper::StoryType::Root, "Projects", QList<QUuid>(), QUuid()});
    setupModelData();
}

StoryModel::~StoryModel() = default;

StoryItem* StoryModel::getItem(const QModelIndex &index) const
{
    if (index.isValid()) {
        auto *item = static_cast<StoryItem*>(index.internalPointer());
        if (item)
            return item;
    }
    return m_rootItem.get();
}

QHash<int, QByteArray> StoryModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[DisplayRole] = "display";
    roles[ItemTypeRole] = "itemType";
    roles[TitleRole] = "title";
    roles[PrevSummaryRole] = "prevSummary";
    return roles;
}
bool StoryModel::associateElements(const QModelIndex &index, const QList<QUuid> &elementIds)
{
    if (!index.isValid()) return false;
    StoryItem* item = getItem(index);
    if (!item) return false;

    bool changed = false;
    for (const QUuid &id : elementIds) {
        if (!item->getElementIds().contains(id)) {
            item->getElementIdsForModify().append(id);
            changed = true;
        }
    }

    if (changed) {
        emit dataChanged(index, index, {});
    }
    return true;
}
bool StoryModel::associateElement(const QModelIndex &index, const QUuid &elementId)
{
    if (!index.isValid()) return false;

    StoryItem* item = getItem(index);
    if (!item) return false;

    // 避免重复添加
    if (item->getElementIds().contains(elementId)) {
        return true;
    }

    item->getElementIdsForModify().append(elementId);

    // 发出 dataChanged 信号，虽然我们没有直接显示ID的角色，
    // 但这是通知视图“某些东西变了”的标准做法。
    emit dataChanged(index, index, {ItemTypeRole}); // 用一个现有角色通知即可
    return true;
}

bool StoryModel::disassociateElement(const QModelIndex &index, const QUuid &id)
{
    StoryItem *item = getItem(index);
    if (!item) return false;

    auto &ids = item->getElementIdsForModify();
    int before = ids.size();
    ids.removeAll(id);
    if (ids.size() == before) return false;

    emit dataChanged(index, index);
    return true;
}

bool StoryModel::setArticleIdForItem(const QModelIndex &index, const QUuid &articleId)
{
    if (!index.isValid()) return false;
    StoryItem* item = getItem(index);
    if (!item) return false;

    item->setArticleId(articleId);
    emit dataChanged(index, index, {});
    return true;
}

void StoryModel::purgeElementFromAllItems(const QUuid &id)
{
    for (int row = 0; row < m_rootItem->childCount(); ++row) {
        StoryItem *child = m_rootItem->child(row);
        purgeElementFromItemRecursive(child, id, QModelIndex(), row);
    }
}

void StoryModel::purgeElementFromItemRecursive(StoryItem *item, const QUuid &id,
                                               const QModelIndex &parentIndex, int row)
{
    if (!item) return;

    auto &ids = item->getElementIdsForModify();
    int before = ids.size();
    ids.removeAll(id);

    if (ids.size() != before) {
        // 通知 UI 该节点变了
        QModelIndex idx = createIndex(row, 0, item);
        emit dataChanged(idx, idx);
    }

    // 递归对子节点执行清理
    for (int i = 0; i < item->childCount(); ++i) {
        purgeElementFromItemRecursive(item->child(i), id, createIndex(row, 0, item), i);
    }
}

QVariant StoryModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return {};

    const auto *item = getItem(index);

    switch (role) {
    case DisplayRole: return item->title();
    case ItemTypeRole: return static_cast<int>(item->type());
    case TitleRole: return item->title();
    case PrevSummaryRole: return item->getPrevSummary();
    default: return {};
    }
}

bool StoryModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
   // qDebug()<<"setData"<<index<<value<<role;

    if (!index.isValid())
        return false;

    
    StoryItem *item = getItem(index);
    if (!item)
        return false;

    //qDebug()<<"setData"<<item->title()<<item->id()<<TitleRole;

    bool result = false;
    switch (role) {
    case Qt::DisplayRole:
    case 2: //用于更改标题
    case TitleRole:
        item->setTitle(value.toString());
        //qDebug()<<"setData"<<item->title()<<item->id()<<"TitleRole";
        result = true;
        break;
    case PrevSummaryRole:
        item->setPrevSummary(value.toString());
        result = true;
        break;
    default:
        return false;
    }

    if (result) {
        emit dataChanged(index, index, {Qt::DisplayRole, TitleRole, PrevSummaryRole});
    }

    return result;
}
QModelIndex StoryModel::insertItemAndGetIndex(const QModelIndex &parent, int row, StoryTypeWrapper::StoryType type, const QString &title, const QList<QUuid> &elementIds)
{
    StoryItem *parentItem = getItem(parent);
    if (!parentItem) return QModelIndex();

    if (row < 0 || row > parentItem->childCount())
        row = parentItem->childCount();

    beginInsertRows(parent, row, row);
    // 在创建时就传入 elementIds，并为每个新项创建唯一ID
    auto newItem = std::make_unique<StoryItem>(ItemData{QUuid::createUuid(), type, title, elementIds}, parentItem);
    StoryItem* newItemPtr = newItem.get(); // 保存原始指针
    const bool success = parentItem->insertChild(row, std::move(newItem));
    endInsertRows();

    if (success) {
        return createIndex(row, 0, newItemPtr);
    }
    return QModelIndex();
}

bool StoryModel::insertItem(const QModelIndex &parent, int row, StoryTypeWrapper::StoryType type, const QString &title, const QList<QUuid> &elementIds)
{
    return insertItemAndGetIndex(parent, row, type, title, elementIds).isValid();
}
bool StoryModel::removeItem(const QModelIndex &index)
{
    if (!index.isValid())
        return false;

    StoryItem *parentItem = getItem(index.parent());
    if (!parentItem)
        return false;

    beginRemoveRows(index.parent(), index.row(), index.row());
    const bool success = parentItem->removeChild(index.row());
    endRemoveRows();

    return success;
}

void StoryModel::forceRefresh()
{
    emit layoutChanged();
}

QVariantMap StoryModel::getItemData(const QModelIndex &index) const
{
    if (!index.isValid())
        return {};

    const StoryItem *item = getItem(index);
    if (!item)
        return {};

    QVariantMap map;
    map.insert("title", item->data(0));
    map.insert("type", QVariant::fromValue(item->type()));
    map.insert("row", item->row());
    map.insert("childCount", item->childCount());
    map.insert("valid", true);
    map.insert("id",item->id());

    return map;
}

Qt::ItemFlags StoryModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;
    return QAbstractItemModel::flags(index);
}

QModelIndex StoryModel::index(int row, int column, const QModelIndex &parent) const
{
    if (!hasIndex(row, column, parent))
        return {};
    StoryItem *parentItem = getItem(parent);
    if (auto *childItem = parentItem->child(row))
        return createIndex(row, column, childItem);
    return {};
}

QModelIndex StoryModel::parent(const QModelIndex &index) const
{
    if (!index.isValid())
        return {};
    auto *childItem = getItem(index);
    StoryItem *parentItem = childItem->parentItem();
    if (parentItem == m_rootItem.get())
        return {};
    return createIndex(parentItem->row(), 0, parentItem);
}

int StoryModel::rowCount(const QModelIndex &parent) const
{
    return getItem(parent)->childCount();
}

int StoryModel::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return 1;
}

void StoryModel::setupModelData()
{

    // // 创建一些示例数据，ROOT
    //auto root_id = std::make_shared<StoryItem>(ItemData{StoryTypeWrapper::StoryType::Root, "故事科学"
    //                                                    , {}, nullptr}),m_rootItem.get()};
    //卷 "第一卷" 包含了角色A、角色B和地点A
    // auto part1 = std::make_unique<StoryItem>(
    //     ItemData{StoryTypeWrapper::StoryType::Part, "第一卷", {charA_id, charB_id, placeA_id}},
    //     m_rootItem.get()
    //     );

    // // 章 "第一章" 只包含了角色A和地点A
    // auto chapter1 = std::make_unique<StoryItem>(
    //     ItemData{StoryTypeWrapper::StoryType::Chapter, "第一章：启程", {charA_id, placeA_id}},
    //     part1.get()
    //     );
    // chapter1->appendChild(std::make_unique<StoryItem>(
    //     ItemData{StoryTypeWrapper::StoryType::Scene, "场景：清晨", {charA_id}}, // 场景只包含角色A
    //     chapter1.get()
    //     ));

    // // 章 "第二章" 只包含了角色B
    // auto chapter2 = std::make_unique<StoryItem>(
    //     ItemData{StoryTypeWrapper::StoryType::Chapter, "第二章：相遇", {charB_id}},
    //     part1.get()
    //     );

    // part1->appendChild(std::move(chapter1));
    // part1->appendChild(std::move(chapter2));

    //m_rootItem->appendChild(std::move(part1));
}

void StoryModel::clearAllItems()
{
    beginResetModel();
    m_rootItem = std::make_unique<StoryItem>(ItemData{QUuid::createUuid(), StoryTypeWrapper::StoryType::Root, "Projects", QList<QUuid>(), QUuid()});
    endResetModel();
}

void StoryModel::resetModel()
{
    beginResetModel();
    endResetModel();
}

QModelIndex StoryModel::getIndexByArticleId(const QUuid &articleId) const
{
    if (articleId.isNull()) {
        return QModelIndex();
    }
    
    // 递归搜索所有项目以找到匹配的文章ID
    std::function<QModelIndex(StoryItem*, const QModelIndex&)> searchItem = 
        [&](StoryItem* item, const QModelIndex& parentIndex) -> QModelIndex {
        if (!item) return QModelIndex();
        
        // 检查当前项目
        if (item->getArticleId() == articleId) {
            return parentIndex;
        }
        
        // 递归检查子项目
        for (int i = 0; i < item->childCount(); ++i) {
            StoryItem* child = item->child(i);
            QModelIndex childIndex = createIndex(i, 0, child);
            QModelIndex result = searchItem(child, childIndex);
            if (result.isValid()) {
                return result;
            }
        }
        
        return QModelIndex();
    };
    
    // 从根项目开始搜索
    for (int i = 0; i < m_rootItem->childCount(); ++i) {
        StoryItem* child = m_rootItem->child(i);
        QModelIndex childIndex = createIndex(i, 0, child);
        QModelIndex result = searchItem(child, childIndex);
        if (result.isValid()) {
            return result;
        }
    }
    
    return QModelIndex();
}
