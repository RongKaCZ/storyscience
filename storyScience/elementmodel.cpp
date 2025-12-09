/**
 * @file elementmodel.cpp
 * @brief ElementModel 类的实现
 */

#include "elementmodel.h"
#include "storymodel.h"
#include <QJsonObject>
#include <QJsonArray>
#include <QDebug>
#include <QJsonDocument>

ElementModel::ElementModel(QObject *parent) : QAbstractListModel(parent) {
    beginInsertRows(QModelIndex(), 0, 2);

    endInsertRows();
}

int ElementModel::rowCount(const QModelIndex &parent) const {
    if (parent.isValid()) return 0;
    return m_items.size();
}
QVariantMap ElementModel::getByUuid(const QString &uuidStr) const {
    QUuid id(uuidStr);
    for (const auto &item : m_items) {
        if (item.id == id) {
            QVariantMap m;
            m["eid"] = item.id;
            m["etype"] = QVariant::fromValue(item.type);
            m["etitle"] = item.etitle;
            m["edescription"] = item.edescription;
            m["ecolor"] = item.ecolor;
            m["eicon"] = item.eicon;
            m["etags"] = item.etags;
            m["estatus"] = item.status;
            return m;
        }
    }
    return QVariantMap();
}
QVariant ElementModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid() || index.row() < 0 || index.row() >= m_items.size())
        return {};
    const Element &e = m_items.at(index.row());
    switch (role) {
    case IdRole:          return e.id;
    case TypeRole:        return QVariant::fromValue(e.type);
    case TitleRole:       return e.etitle;
    case DescriptionRole: return e.edescription;
    case ColorRole:       return e.ecolor;
    case IconRole:        return e.eicon;
    case TagsRole:        return e.etags;
    case StatusRole:      return e.status;
    default:              return {};
    }
}

QHash<int, QByteArray> ElementModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[IdRole]          = "eid";
    roles[TypeRole]        = "etype";
    roles[TitleRole]       = "etitle";
    roles[DescriptionRole] = "edescription";
    roles[ColorRole]       = "ecolor";
    roles[IconRole]        = "eicon";
    roles[TagsRole]        = "etags";
    roles[StatusRole]      = "estatus";
    return roles;
}

void ElementModel::removeById(const QString &idStr)
{
    QUuid id(idStr);
    for (int i = 0; i < m_items.size(); ++i) {
        if (m_items[i].id == id) {
            beginRemoveRows(QModelIndex(), i, i);
            m_items.removeAt(i);
            endRemoveRows();
            return;
        }
    }
}

QVariantMap ElementModel::get(int row) const {
    QVariantMap m;
    if (row < 0 || row >= m_items.size()) return m;
    const Element &e = m_items.at(row);
    m["eid"]          = e.id;
    m["etitle"]       = e.etitle;
    m["edescription"] = e.edescription;
    m["ecolor"]       = e.ecolor;
    m["eicon"]        = e.eicon;
    m["etags"]        = e.etags;
    m["estatus"]      = e.status;
    return m;
}

void ElementModel::modifyElementById(
    const QString &id,
    const QString &title,
    const QString &description,
    const QColor &color,
    const QStringList &tags)
{
    for (int i = 0; i < m_items.size(); ++i) {
        if (m_items[i].id.toString() == id) {
            Element &e = m_items[i];
            if (!title.isEmpty()) e.etitle = title;
            if (!description.isEmpty()) e.edescription = description;
            if (color.isValid()) e.ecolor = color;
            if (!tags.isEmpty()) e.etags = tags;

            QModelIndex idx = index(i, 0);
            emit dataChanged(idx, idx, {TitleRole, DescriptionRole, ColorRole, TagsRole});
            emit elementModified(e.id, e.type);
            break;
        }
    }
}

void ElementModel::updateElementStatus(
    const QString &id,
    const QJsonObject &status)
{
    for (int i = 0; i < m_items.size(); ++i) {
        if (m_items[i].id.toString() == id) {
            Element &e = m_items[i];
            e.status = status;

            QModelIndex idx = index(i, 0);
            emit dataChanged(idx, idx, {StatusRole});
            emit elementModified(e.id, e.type);
            break;
        }
    }
}

// =============================================================================
// 数据持久化方法
// =============================================================================

QJsonObject ElementModel::serializeElements() const
{
    QJsonObject elements;
    
    for (const Element& element : m_items) {
        QJsonObject elementObj;
        elementObj["id"] = element.id.toString();
        elementObj["type"] = static_cast<int>(element.type);
        elementObj["title"] = element.etitle;
        elementObj["description"] = element.edescription;
        elementObj["color"] = element.ecolor.name(); // 保存为十六进制颜色值
        elementObj["icon"] = element.eicon;
        
        // 将标签列表保存为JSON数组
        QJsonArray tagsArray;
        for (const QString& tag : element.etags) {
            tagsArray.append(tag);
        }
        elementObj["tags"] = tagsArray;
        
        // 保存状态数据
        elementObj["status"] = element.status;
        
        elements[element.id.toString()] = elementObj;
    }
    
    return elements;
}

bool ElementModel::loadElementsFromJson(const QJsonObject& obj)
{
    // 清空现有数据
    clearAllElements();
    
    // 加载新数据
    QList<Element> newElements;
    
    for (auto it = obj.begin(); it != obj.end(); ++it) {
        const QJsonObject elementObj = it.value().toObject();
        
        Element element;
        element.id = QUuid(elementObj["id"].toString());
        element.type = static_cast<ElementTypeWrapper::ElementType>(elementObj["type"].toInt());
        element.etitle = elementObj["title"].toString();
        element.edescription = elementObj["description"].toString();
        element.ecolor = QColor(elementObj["color"].toString());
        element.eicon = elementObj["icon"].toString();
        
        // 加载标签列表
        const QJsonArray tagsArray = elementObj["tags"].toArray();
        element.etags.clear();
        for (const QJsonValue& value : tagsArray) {
            element.etags.append(value.toString());
        }
        
        // 加载状态数据
        if (elementObj.contains("status")) {
            element.status = elementObj["status"].toObject();
        }
        
        newElements.append(element);
    }
    
    if (!newElements.isEmpty()) {
        beginInsertRows(QModelIndex(), 0, newElements.size() - 1);
        m_items = newElements;
        endInsertRows();
    }
    
    return true;
}

void ElementModel::clearAllElements()
{
    if (!m_items.isEmpty()) {
        beginRemoveRows(QModelIndex(), 0, m_items.size() - 1);
        m_items.clear();
        endRemoveRows();
    }
}

