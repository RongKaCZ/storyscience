/**
 * @file elementfilterproxymodel.h
 * @brief 元素过滤代理模型类
 * 
 * ElementFilterProxyModel 用于对 ElementModel 进行过滤，
 * 可以根据元素类型和ID列表进行过滤，支持两种过滤模式。
 */

#pragma once
#include <QSortFilterProxyModel>
#include <QList>
#include <QUuid>
#include "elementmodel.h"
#include "elementtype.h"

/**
 * @enum FilterMode
 * @brief 过滤模式枚举
 */
enum FilterMode {
    ByAcceptedIds,  ///< 仅显示在 m_acceptedIds 列表中的元素
    ShowAll         ///< 显示所有元素（不受ID列表限制）
};

/**
 * @class ElementFilterProxyModel
 * @brief 元素过滤代理模型类
 * 
 * 继承自 QSortFilterProxyModel，用于对 ElementModel 进行过滤。
 * 支持按元素类型和ID列表进行过滤，提供两种过滤模式。
 */
class ElementFilterProxyModel : public QSortFilterProxyModel
{
    Q_OBJECT
public:
    explicit ElementFilterProxyModel(ElementTypeWrapper::ElementType filterType,FilterMode mode, QObject *parent = nullptr);

    void setAcceptedIds(const QList<QUuid> &ids);

    void setSourceModel(QAbstractItemModel *sourceModel) override;
public slots:
    void forceRegilter();
    /// 刷新指定元素（用于元素更新后刷新显示）
    void refreshElement(const QUuid &id);
protected:
    bool filterAcceptsRow(int source_row, const QModelIndex &source_parent) const override;
private slots:
    void onSourceDataChanged(const QModelIndex &topLeft, const QModelIndex &bottomRight, const QVector<int> &roles);
private:
    ElementTypeWrapper::ElementType m_filterType;
    FilterMode m_mode;
    QList<QUuid> m_acceptedIds;
};
