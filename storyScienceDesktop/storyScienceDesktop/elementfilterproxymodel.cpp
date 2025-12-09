/**
 * @file elementfilterproxymodel.cpp
 * @brief ElementFilterProxyModel 类的实现
 */

#include "elementfilterproxymodel.h"
#include <QDebug>
ElementFilterProxyModel::ElementFilterProxyModel(ElementTypeWrapper::ElementType filterType,FilterMode mode, QObject *parent)
    : QSortFilterProxyModel(parent), m_filterType(filterType),m_mode(mode)
{}

void ElementFilterProxyModel::setSourceModel(QAbstractItemModel *sourceModel)
{
    // 断开可能存在的旧连接，防止内存泄漏
    if (this->sourceModel()) {
        disconnect(this->sourceModel(), &QAbstractItemModel::dataChanged, this, &ElementFilterProxyModel::onSourceDataChanged);
    }

    QSortFilterProxyModel::setSourceModel(sourceModel);

    // 建立新的连接
    if (sourceModel) {
        connect(sourceModel, &QAbstractItemModel::dataChanged, this, &ElementFilterProxyModel::onSourceDataChanged);
    }
}

void ElementFilterProxyModel::forceRegilter()
{
    invalidateFilter();
}

void ElementFilterProxyModel::refreshElement(const QUuid &id)
{
    for (int i = 0; i < sourceModel()->rowCount(); ++i) {
        QModelIndex sourceIndex = sourceModel()->index(i, 0);
        QUuid elementId = sourceModel()->data(sourceIndex, ElementModel::IdRole).toUuid();
        if (elementId == id) {
            QModelIndex proxyIndex = mapFromSource(sourceIndex);
            if (proxyIndex.isValid()) {
                emit dataChanged(proxyIndex, proxyIndex);
            } else {
                invalidateFilter();
            }
            break;
        }
    }
}
void ElementFilterProxyModel::onSourceDataChanged(const QModelIndex &topLeft, const QModelIndex &bottomRight, const QVector<int> &roles)
{
    // 将源模型的索引范围映射到代理模型的索引范围
    QModelIndex proxyTopLeft = mapFromSource(topLeft);
    QModelIndex proxyBottomRight = mapFromSource(bottomRight);

    if (proxyTopLeft.isValid() || proxyBottomRight.isValid()) {
        emit dataChanged(proxyTopLeft, proxyBottomRight, roles);
    } else {
        // 如果被过滤掉的项数据发生变化，检查是否影响过滤结果
        if (roles.contains(ElementModel::TypeRole)) {
            invalidateFilter();
        }
    }
}
void ElementFilterProxyModel::setAcceptedIds(const QList<QUuid> &ids)
{
    m_acceptedIds = ids;
    invalidateFilter();
}

bool ElementFilterProxyModel::filterAcceptsRow(int source_row, const QModelIndex &source_parent) const
{
    QModelIndex sourceIndex = sourceModel()->index(source_row, 0, source_parent);
    if (!sourceIndex.isValid()) {
        return false;
    }

    // 类型必须匹配
    ElementTypeWrapper::ElementType type = sourceModel()->data(sourceIndex, ElementModel::TypeRole).value<ElementTypeWrapper::ElementType>();
    if (type != m_filterType)
        return false;

    if (m_mode == ShowAll) {
        return true;
    }
    
    if (m_acceptedIds.isEmpty()) {
        return false;
    }

    QUuid id = sourceModel()->data(sourceIndex, ElementModel::IdRole).toUuid();
    return m_acceptedIds.contains(id);
}
