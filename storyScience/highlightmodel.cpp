/**
 * @file highlightmodel.cpp
 * @brief HighlightModel 类的实现
 */

#include "highlightmodel.h"
#include <QDebug>

HighlightModel::HighlightModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int HighlightModel::rowCount(const QModelIndex &) const
{
    return m_items.size();
}

QVariant HighlightModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_items.size())
        return QVariant();

    const auto &item = m_items.at(index.row());
    switch (role) {
    case StartRole: return item.start;
    case LengthRole: return item.length;
    case CommentRole: return item.comment;
    case TextRole: return item.text;
    case PrefixRole: return item.prefix;
    case SuffixRole: return item.suffix;
    default: return QVariant();
    }
}

QHash<int, QByteArray> HighlightModel::roleNames() const
{
    return {
        {StartRole, "start"},
        {LengthRole, "length"},
        {CommentRole, "comment"},
        {TextRole, "text"},
        {PrefixRole, "prefix"},
        {SuffixRole, "suffix"}
    };
}

void HighlightModel::addHighlight(int start, int length, const QString &comment, const QString &text, const QString &prefix, const QString &suffix)
{
    beginInsertRows(QModelIndex(), m_items.size(), m_items.size());
    m_items.append({start, length, comment, text, prefix, suffix});
    endInsertRows();
    emit countChanged();
}

void HighlightModel::clear()
{
    if (m_items.isEmpty()) return;
    beginResetModel();
    m_items.clear();
    endResetModel();
    emit countChanged();
}

QVariantMap HighlightModel::get(int index) const
{
    QVariantMap map;
    if (index >= 0 && index < m_items.size()) {
        const auto &item = m_items.at(index);
        map.insert("start", item.start);
        map.insert("length", item.length);
        map.insert("comment", item.comment);
        map.insert("text", item.text);
        map.insert("prefix", item.prefix);
        map.insert("suffix", item.suffix);
    }
    return map;
}
