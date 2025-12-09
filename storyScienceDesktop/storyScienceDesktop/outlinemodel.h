/**
 * @file outlinemodel.h
 * @brief 思维导图大纲模型类
 * 
 * OutlineModel 用于管理思维导图形式的大纲，支持节点的添加、删除、移动等操作。
 * 提供自动布局功能，支持左右分支结构。
 */

#ifndef OUTLINEMODEL_H
#define OUTLINEMODEL_H

#include <QObject>
#include <QVariantList>
#include <QHash>
#include <QJsonObject>
#include <QPointF>
#include "outlinenode.h"

/**
 * @class OutlineModel
 * @brief 思维导图大纲模型类
 * 
 * 管理思维导图节点，支持节点的增删改查、移动和自动布局。
 * 节点以树形结构组织，支持左右分支。
 */
class OutlineModel : public QObject {
    Q_OBJECT
    Q_PROPERTY(QVariantList nodes READ nodes NOTIFY nodesChanged)
    Q_PROPERTY(QString rootId READ rootId CONSTANT)

public:
    explicit OutlineModel(QObject *parent = nullptr);

    QVariantList nodes() const;
    QString rootId() const;

    Q_INVOKABLE QString addNode(const QString &parentId, const QString &text, bool isLeftChild);
    Q_INVOKABLE bool removeNode(const QString &nodeId);
    Q_INVOKABLE bool updateNodeText(const QString &nodeId, const QString &text);
    Q_INVOKABLE bool updateNodeDescription(const QString &nodeId, const QString &description);
    Q_INVOKABLE bool moveNodeWithChildren(const QString &nodeId, const QPointF &delta);
    Q_INVOKABLE void autoLayout();
    Q_INVOKABLE QVariantMap getNode(const QString &nodeId) const;
    /// 检查指定节点是否可以添加子节点
    Q_INVOKABLE bool canAddChild(const QString& nodeId, bool isLeft) const;

    Q_INVOKABLE QJsonObject saveToJson() const;
    Q_INVOKABLE bool loadFromJson(const QJsonObject &jsonObj);

signals:
    void nodesChanged();
    void nodeUpdated(const QString &nodeId);

private:
    QList<OutlineNode> m_nodes;
    QHash<QString, int> m_nodeIndexMap;

    int findNodeIndex(const QString &nodeId) const;
    void layoutTree();
    void layoutSubtree(const QString &nodeId, qreal parentX, qreal parentY);
    void moveNodeRecursive(int nodeIndex, const QPointF &delta);
};

#endif // OUTLINEMODEL_H
