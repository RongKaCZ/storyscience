/**
 * @file elementmodel.h
 * @brief 元素模型类，管理故事元素（角色、地点、物品等）
 * 
 * ElementModel 继承自 QAbstractListModel，用于管理所有故事元素。
 * 支持元素的增删改查，以及状态管理和数据持久化。
 */

#pragma once
#include <QAbstractListModel>
#include <QColor>
#include <QStringList>
#include <QUuid>
#include <QJsonObject>
#include "elementtype.h"

/**
 * @struct Element
 * @brief 元素数据结构
 * 
 * 表示一个故事元素（角色、地点、物品、组织、事件、能力等），
 * 包含基本信息和状态数据。
 */
struct Element {
    QUuid id;// 唯一标识符
    ElementTypeWrapper::ElementType type;
    QString etitle;
    QString edescription;
    QColor  ecolor;
    QString eicon;
    QStringList etags;
    QJsonObject status; ///< 元素状态数据（JSON格式）
};

/**
 * @class ElementModel
 * @brief 元素模型类
 * 
 * 管理所有故事元素的列表模型，提供元素的增删改查功能。
 * 支持通过 UUID 查找元素，以及元素的序列化和反序列化。
 */
class ElementModel : public QAbstractListModel {
    Q_OBJECT
public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        TypeRole,
        TitleRole,
        DescriptionRole,
        ColorRole,
        IconRole,
        TagsRole,
        StatusRole
    };
    Q_ENUM(Roles)

    explicit ElementModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    // QML 可调用
    Q_INVOKABLE QUuid addElement(ElementTypeWrapper::ElementType type,
                                 const QString &title,
                                 const QString &description,
                                 const QColor  &color,
                                 const QString &icon,
                                 const QStringList &tags) {
        const int pos = m_items.size();
        const QUuid newId = QUuid::createUuid(); // 创建新ID
        beginInsertRows(QModelIndex(), pos, pos);
        m_items.push_back({newId, type, title, description, color, icon, tags, QJsonObject()});
        endInsertRows();
        return newId; // 返回新ID
    }
    Q_INVOKABLE QVariantMap getByUuid(const QString &uuidStr) const;

    Q_INVOKABLE void removeById(const QString &idStr);
    Q_INVOKABLE QVariantMap get(int row) const;
    Q_INVOKABLE void modifyElementById(
        const QString &id,
        const QString &title,
        const QString &description,
        const QColor &color,
        const QStringList &tags);
    
    Q_INVOKABLE void updateElementStatus(
        const QString &id,
        const QJsonObject &status);
    
    // 数据持久化方法
    QJsonObject serializeElements() const;
    bool loadElementsFromJson(const QJsonObject& obj);
    void clearAllElements();
    
signals:
    void elementModified(const QUuid &id, ElementTypeWrapper::ElementType type);
private:
    QList<Element> m_items;
};
