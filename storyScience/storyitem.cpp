/**
 * @file storyitem.cpp
 * @brief StoryItem 类的实现
 */

#include "storyitem.h"
#include "storymodel.h"
#include <algorithm>

StoryItem::StoryItem(ItemData data, StoryItem *parent)
    : m_itemData(std::move(data)), m_parentItem(parent)
{}

void StoryItem::appendChild(std::unique_ptr<StoryItem> &&child)
{
    m_childItems.push_back(std::move(child));
}

bool StoryItem::insertChild(int row, std::unique_ptr<StoryItem> &&child)
{
    if (row < 0 || row > childCount())
        return false;

    m_childItems.insert(m_childItems.begin() + row, std::move(child));
    return true;
}

bool StoryItem::removeChild(int row)
{
    if (row < 0 || row >= childCount())
        return false;

    m_childItems.erase(m_childItems.begin() + row);
    return true;
}

const QList<QUuid>& StoryItem::getElementIds() const
{
    return m_itemData.elementIds;
}

QList<QUuid>& StoryItem::getElementIdsForModify()
{
    return m_itemData.elementIds;
}

QUuid StoryItem::getArticleId() const
{
    return m_itemData.articleId;
}

void StoryItem::setArticleId(const QUuid &id)
{
    m_itemData.articleId = id;
}

QString StoryItem::getPrevSummary() const
{
    return m_itemData.prevSummary;
}

void StoryItem::setPrevSummary(const QString &summary)
{
    m_itemData.prevSummary = summary;
}

StoryItem *StoryItem::child(int row)
{
    if (row < 0 || row >= childCount())
        return nullptr;
    return m_childItems.at(row).get();
}

int StoryItem::childCount() const
{
    return static_cast<int>(m_childItems.size());
}

int StoryItem::columnCount() const
{
    return 1;
}

QVariant StoryItem::data(int column) const
{
    if (column == 0)
        return m_itemData.title;
    return QVariant();
}

StoryItem *StoryItem::parentItem()
{
    return m_parentItem;
}

StoryTypeWrapper::StoryType StoryItem::type() const
{
    return m_itemData.type;
}

QString StoryItem::title() const
{
    return m_itemData.title;
}

void StoryItem::setTitle(const QString &title)
{
    m_itemData.title = title;
}

QUuid StoryItem::id() const
{
    return m_itemData.id;
}

int StoryItem::row() const
{
    if (!m_parentItem)
        return 0;

    const auto &parentChildren = m_parentItem->m_childItems;
    const auto it = std::find_if(parentChildren.cbegin(), parentChildren.cend(),
                                 [this](const std::unique_ptr<StoryItem> &item) {
                                     return item.get() == this;
                                 });

    if (it != parentChildren.cend())
        return static_cast<int>(std::distance(parentChildren.cbegin(), it));

    return 0;
}
