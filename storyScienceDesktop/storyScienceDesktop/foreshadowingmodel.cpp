/**
 * @file foreshadowingmodel.cpp
 * @brief ForeshadowingModel 类的实现
 */

#include "foreshadowingmodel.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QUuid>

ForeshadowingModel::ForeshadowingModel(QObject *parent) : QAbstractListModel(parent) {}

int ForeshadowingModel::rowCount(const QModelIndex &) const {
    return m_items.count();
}

QVariant ForeshadowingModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid() || index.row() >= m_items.count())
        return QVariant();

    ForeshadowingItem *item = m_items.at(index.row());
    switch (role) {
    case IdRole: return item->id();
    case ContentRole: return item->content();
    case DescriptionRole: return item->description();
    case CreationDateRole: return item->creationDate();
    case SourceChapterIdRole: return item->sourceChapterId();
    case StatusRole: return QVariant::fromValue(item->status());
    default: return QVariant();
    }
}

QHash<int, QByteArray> ForeshadowingModel::roleNames() const {
    return {
        {IdRole, "id"},
        {ContentRole, "content"},
        {DescriptionRole, "description"},
        {CreationDateRole, "creationDate"},
        {SourceChapterIdRole, "sourceChapterId"},
        {StatusRole, "status"}
    };
}

QObject* ForeshadowingModel::get(int index) const {
    if (index >= 0 && index < m_items.count()) {
        return m_items.at(index);
    }
    return nullptr;
}

void ForeshadowingModel::addForeshadowing(const QString &content, const QString &prefix, const QString &suffix, const QString &description, const QString &sourceChapterId)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    QString id = QUuid::createUuid().toString();
    m_items.append(new ForeshadowingItem(id, content, prefix, suffix, description, sourceChapterId, this));
    endInsertRows();
}

void ForeshadowingModel::resolveForeshadowing(const QString &id)
{
    for (int i = 0; i < m_items.count(); ++i) {
        if (m_items.at(i)->id() == id) {
            // Inform the model/view framework that we are about to remove a row.
            beginRemoveRows(QModelIndex(), i, i);

            // Delete the item from memory and remove it from the list.
            delete m_items.takeAt(i);

            // Inform the framework that the removal is complete.
            endRemoveRows();

            // The view (ListView, Connections in QML) will automatically react to this.
            return; // Exit after finding and removing the item.
        }
    }
}

void ForeshadowingModel::updateStatus(const QString& id) {
    resolveForeshadowing(id);
}

QString ForeshadowingModel::getUnresolvedAsJson(const QString& chapterId) const
{
    QJsonArray jsonArray;
    for (const ForeshadowingItem* item : m_items) {
        if (item->status() == ForeshadowingItem::Unresolved && item->sourceChapterId() == chapterId) {
            QJsonObject jsonObj;
            jsonObj["text"] = item->content();
            jsonObj["comment"] = item->description();
            jsonObj["prefix"] = item->prefix(); //
            jsonObj["suffix"] = item->suffix(); //
            jsonArray.append(jsonObj);
        }
    }
    return QString(QJsonDocument(jsonArray).toJson(QJsonDocument::Compact));
}

// 实现序列化函数
QJsonArray ForeshadowingModel::serialize() const
{
    QJsonArray array;
    for(const ForeshadowingItem* item : m_items) {
        QJsonObject obj;
        obj["id"] = item->id();
        obj["content"] = item->content();
        obj["description"] = item->description();
        obj["sourceChapterId"] = item->sourceChapterId();
        obj["creationDate"] = item->creationDate().toString(Qt::ISODate);
        obj["status"] = static_cast<int>(item->status());
        obj["prefix"] = item->prefix();
        obj["suffix"] = item->suffix();
        array.append(obj);
    }
    return array;
}

//  实现反序列化函数
void ForeshadowingModel::deserialize(const QJsonArray &array)
{
    beginResetModel();
    qDeleteAll(m_items);
    m_items.clear();
    for(const QJsonValue& value : array) {
        QJsonObject obj = value.toObject();
        auto* item = new ForeshadowingItem(
            obj["id"].toString(),
            obj["content"].toString(),
            obj["prefix"].toString(),
            obj["suffix"].toString(),
            obj["description"].toString(),
            obj["sourceChapterId"].toString(),
            this
        );
        
        // 恢复状态
        item->setStatus(static_cast<ForeshadowingItem::Status>(obj["status"].toInt()));
        
        // 恢复创建日期
        if (obj.contains("creationDate")) {
            QDateTime creationDate = QDateTime::fromString(obj["creationDate"].toString(), Qt::ISODate);
            if (creationDate.isValid()) {
                // 通过反射设置私有成员变量
                item->setProperty("m_creationDate", creationDate);
            }
        }
        
        m_items.append(item);
    }
    endResetModel();
}

void ForeshadowingModel::clear() {
    beginResetModel();
    qDeleteAll(m_items);
    m_items.clear();
    endResetModel();
}
