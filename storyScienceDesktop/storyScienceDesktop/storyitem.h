/**
 * @file storyitem.h
 * @brief 故事项类，表示故事树结构中的一个节点
 * 
 * StoryItem 用于构建故事树形结构，支持书籍、卷、章节等层级关系。
 * 每个故事项可以关联多个元素和一篇文章。
 */

#ifndef STORYITEM_H
#define STORYITEM_H

#include <QVariant>
#include <vector>
#include <memory>
#include <QString>
#include <QList>   // <-- 确保包含 QList
#include <QUuid>   // <-- 确保包含 QUuid
#include "storytype.h"

/**
 * @struct ItemData
 * @brief 故事项数据结构
 * 
 * 包含故事项的所有数据，包括ID、类型、标题、关联元素等。
 */
struct ItemData {
    QUuid id;                           ///< 唯一标识符
    StoryTypeWrapper::StoryType type;   ///< 故事项类型（书籍/卷/章节等）
    QString title;                      ///< 标题
    QList<QUuid> elementIds;            ///< 关联的元素ID列表
    QUuid articleId;                    ///< 关联的文章ID
    QString prevSummary;                 ///< 前一章的摘要
};

/**
 * @class StoryItem
 * @brief 故事项类
 * 
 * 表示故事树结构中的一个节点，支持父子关系和元素关联。
 * 使用智能指针管理子节点，确保内存安全。
 */
class StoryItem
{
    friend class DataManager;  // 允许DataManager访问私有成员
public:
    explicit StoryItem(ItemData data, StoryItem *parent = nullptr);

    StoryItem(const StoryItem&) = delete;
    StoryItem& operator=(const StoryItem&) = delete;
    StoryItem(StoryItem&&) = delete;
    StoryItem& operator=(StoryItem&&) = delete;

    void appendChild(std::unique_ptr<StoryItem> &&child);
    bool insertChild(int row, std::unique_ptr<StoryItem> &&child);
    bool removeChild(int row);

    const QList<QUuid>& getElementIds() const;
    QList<QUuid>& getElementIdsForModify();

    QUuid getArticleId() const;
    void setArticleId(const QUuid &id);

    QString getPrevSummary() const;
    void setPrevSummary(const QString &summary);

    StoryItem *child(int row);
    int childCount() const;
    int columnCount() const;
    QVariant data(int column) const;
    int row() const;
    StoryItem *parentItem();
    StoryTypeWrapper::StoryType type() const;
    QString title() const;
    void setTitle(const QString &title);
    QUuid id() const;

private:
    std::vector<std::unique_ptr<StoryItem>> m_childItems;
    ItemData m_itemData;
    StoryItem *m_parentItem;
};

#endif // STORYITEM_H
