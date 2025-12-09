/**
 * @file outlinemodel.cpp
 * @brief OutlineModel 类的实现
 */

#include "outlinemodel.h"
#include <QJsonDocument>
#include <QJsonArray>
#include <QDebug>
#include <cmath>

constexpr qreal HORIZONTAL_SPACING = 200.0;
constexpr qreal VERTICAL_SPACING = 60.0;

OutlineModel::OutlineModel(QObject *parent) : QObject(parent)
{
    // 创建根节点
    OutlineNode root;
    root.id = "root";
    root.text = tr("中心主题");
    root.x = 0;
    root.y = 0;
    m_nodes.append(root);
    m_nodeIndexMap[root.id] = 0;
}

QVariantList OutlineModel::nodes() const
{
    QVariantList list;
    for (const auto &node : m_nodes) {
        QVariantMap map;
        map["id"] = node.id;
        map["text"] = node.text;
        map["description"] = node.description;
        map["parentId"] = node.parentId;
        map["isLeftChild"] = node.isLeftChild;
        map["x"] = node.x;
        map["y"] = node.y;
        map["width"] = node.width;
        map["height"] = node.height;
        map["children"] = QVariant::fromValue(node.children);
        list.append(map);
    }
    return list;
}

QString OutlineModel::rootId() const
{
    return m_nodes.isEmpty() ? "" : m_nodes.first().id;
}

QString OutlineModel::addNode(const QString& parentId, const QString& text, bool isLeftChild)
{
    // 1. 首先检查是否允许添加
    if (!canAddChild(parentId, isLeftChild)) {
        qWarning() << "规则限制：无法为节点" << parentId << "添加" << (isLeftChild ? "左" : "右") << "子节点。";
        return QString();
    }

    int parentIndex = findNodeIndex(parentId);
    if (parentIndex == -1) {
        //qWarning() << "Parent node not found:" << parentId;
        return QString();
    }

    OutlineNode newNode(parentId, text, isLeftChild);
    m_nodes.append(newNode);
    m_nodeIndexMap[newNode.id] = m_nodes.size() - 1;
    m_nodes[parentIndex].children.append(newNode.id);

    autoLayout();
    return newNode.id;
}
bool OutlineModel::canAddChild(const QString& nodeId, bool isLeft) const
{
    int nodeIndex = findNodeIndex(nodeId);
    if (nodeIndex == -1) return false; // 节点不存在

    const OutlineNode& node = m_nodes[nodeIndex];

    // 规则 1: 根节点可以添加任意数量的左右子节点
    if (node.parentId.isEmpty()) { // 检查是否为根节点
        return true;
    }

    // 规则 2: 非根节点 (子节点) 只能有一个子节点
    if (!node.children.isEmpty()) {
        return false;
    }

    // 规则 3: 左侧分支的节点只能添加左子节点，右侧同理
    if (node.isLeftChild != isLeft) {
        return false;
    }

    return true;
}
bool OutlineModel::removeNode(const QString &nodeId)
{
    if (nodeId == rootId()) return false;
    int index = findNodeIndex(nodeId);
    if (index == -1) return false;

    QList<QString> toRemove;
    toRemove.append(nodeId);

    // Recursively find all children to remove
    std::function<void(const QString&)> findChildren =
        [&](const QString& currentId) {
        int currentIndex = findNodeIndex(currentId);
        if (currentIndex != -1) {
            for (const QString& childId : m_nodes[currentIndex].children) {
                toRemove.append(childId);
                findChildren(childId);
            }
        }
    };
    findChildren(nodeId);

    // Remove from parent's children list
    QString parentId = m_nodes[index].parentId;
    int parentIndex = findNodeIndex(parentId);
    if (parentIndex != -1) {
        m_nodes[parentIndex].children.removeAll(nodeId);
    }

    // Remove all nodes
    for (const QString& id : toRemove) {
        int idx = findNodeIndex(id);
        if (idx != -1) {
            m_nodeIndexMap.remove(id);
            m_nodes.removeAt(idx);
            // Rebuild index map after each removal
            for (int i = 0; i < m_nodes.size(); ++i) {
                m_nodeIndexMap[m_nodes[i].id] = i;
            }
        }
    }

    autoLayout();
    return true;
}

bool OutlineModel::updateNodeText(const QString &nodeId, const QString &text)
{
    int index = findNodeIndex(nodeId);
    if (index == -1) return false;
    m_nodes[index].text = text;
    emit nodeUpdated(nodeId);
    emit nodesChanged(); // To be safe, can be optimized to a specific dataChanged later
    return true;
}

bool OutlineModel::updateNodeDescription(const QString &nodeId, const QString &description)
{
    int index = findNodeIndex(nodeId);
    if (index == -1) return false;
    m_nodes[index].description = description;
    emit nodeUpdated(nodeId);
    emit nodesChanged(); // To be safe, can be optimized to a specific dataChanged later
    return true;
}

bool OutlineModel::moveNodeWithChildren(const QString &nodeId, const QPointF &delta)
{
    int index = findNodeIndex(nodeId);
    if (index == -1) return false;
    moveNodeRecursive(index, delta);
    emit nodesChanged();
    return true;
}

void OutlineModel::autoLayout()
{
    if (m_nodes.isEmpty()) return;
    layoutTree();
    emit nodesChanged();
}

QVariantMap OutlineModel::getNode(const QString &nodeId) const
{
    int index = findNodeIndex(nodeId);
    if (index == -1) return QVariantMap();
    // Convert node to map manually
    const OutlineNode &node = m_nodes[index];
    QVariantMap map;
    map["id"] = node.id;
    map["text"] = node.text;
    map["description"] = node.description;
    map["parentId"] = node.parentId;
    map["isLeftChild"] = node.isLeftChild;
    map["x"] = node.x;
    map["y"] = node.y;
    map["width"] = node.width;
    map["height"] = node.height;
    map["children"] = QVariant::fromValue(node.children);
    return map;
}

int OutlineModel::findNodeIndex(const QString &nodeId) const
{
    return m_nodeIndexMap.value(nodeId, -1);
}

void OutlineModel::moveNodeRecursive(int nodeIndex, const QPointF &delta)
{
    if (nodeIndex < 0 || nodeIndex >= m_nodes.size()) return;
    m_nodes[nodeIndex].x += delta.x();
    m_nodes[nodeIndex].y += delta.y();
    for (const QString &childId : m_nodes[nodeIndex].children) {
        moveNodeRecursive(findNodeIndex(childId), delta);
    }
}

void OutlineModel::layoutTree()
{
    if (m_nodes.isEmpty()) return;
    int rootIndex = findNodeIndex(rootId());
    if (rootIndex == -1) return;

    m_nodes[rootIndex].x = 0;
    m_nodes[rootIndex].y = 0;
    layoutSubtree(rootId(), 0, 0);
}

void OutlineModel::layoutSubtree(const QString &nodeId, qreal parentX, qreal parentY)
{
    int nodeIndex = findNodeIndex(nodeId);
    if (nodeIndex == -1) return;

    QList<QString> leftChildren, rightChildren;
    for (const QString &childId : m_nodes[nodeIndex].children) {
        int childIdx = findNodeIndex(childId);
        if (childIdx != -1) {
            if (m_nodes[childIdx].isLeftChild) {
                leftChildren.append(childId);
            } else {
                rightChildren.append(childId);
            }
        }
    }

    qreal totalLeftHeight = (leftChildren.size() > 0) ? (leftChildren.size() - 1) * VERTICAL_SPACING : 0;
    qreal currentY = m_nodes[nodeIndex].y - totalLeftHeight / 2.0;
    for (const QString &childId : leftChildren) {
        int childIdx = findNodeIndex(childId);
        m_nodes[childIdx].x = m_nodes[nodeIndex].x - HORIZONTAL_SPACING;
        m_nodes[childIdx].y = currentY;
        layoutSubtree(childId, m_nodes[childIdx].x, m_nodes[childIdx].y);
        currentY += VERTICAL_SPACING;
    }

    qreal totalRightHeight = (rightChildren.size() > 0) ? (rightChildren.size() - 1) * VERTICAL_SPACING : 0;
    currentY = m_nodes[nodeIndex].y - totalRightHeight / 2.0;
    for (const QString &childId : rightChildren) {
        int childIdx = findNodeIndex(childId);
        m_nodes[childIdx].x = m_nodes[nodeIndex].x + HORIZONTAL_SPACING;
        m_nodes[childIdx].y = currentY;
        layoutSubtree(childId, m_nodes[childIdx].x, m_nodes[childIdx].y);
        currentY += VERTICAL_SPACING;
    }
}

QJsonObject OutlineModel::saveToJson() const
{
    QJsonArray nodesArray;
    for (const auto &node : m_nodes) {
        QJsonObject nodeObj;
        nodeObj["id"] = node.id;
        nodeObj["text"] = node.text;
        nodeObj["description"] = node.description;
        nodeObj["parentId"] = node.parentId;
        nodeObj["isLeftChild"] = node.isLeftChild;
        nodeObj["x"] = node.x;
        nodeObj["y"] = node.y;
        nodeObj["width"] = node.width;
        nodeObj["height"] = node.height;
        nodeObj["children"] = QJsonArray::fromStringList(node.children);
        nodesArray.append(nodeObj);
    }

    QJsonObject rootObj;
    rootObj["nodes"] = nodesArray;
    return rootObj;
}

bool OutlineModel::loadFromJson(const QJsonObject &jsonObj)
{
    // 清空现有数据
    m_nodes.clear();
    m_nodeIndexMap.clear();
    
    // 如果JSON对象为空或不包含nodes键，则认为是清空操作，直接返回true
    if (jsonObj.isEmpty() || !jsonObj.contains("nodes")) {
        // 添加默认的根节点
        OutlineNode root;
        root.id = "root";
        root.text = tr("中心主题");
        root.x = 0;
        root.y = 0;
        m_nodes.append(root);
        m_nodeIndexMap[root.id] = 0;
        
        emit nodesChanged();
        return true;
    }
    
    if (!jsonObj["nodes"].isArray()) {
        return false;
    }

    QJsonArray nodesArray = jsonObj["nodes"].toArray();
    for (const QJsonValue &val : nodesArray) {
        QJsonObject nodeObj = val.toObject();
        OutlineNode node;
        node.id = nodeObj["id"].toString();
        node.text = nodeObj["text"].toString();
        node.description = nodeObj["description"].toString();
        node.parentId = nodeObj["parentId"].toString();
        node.isLeftChild = nodeObj["isLeftChild"].toBool();
        node.x = nodeObj["x"].toDouble();
        node.y = nodeObj["y"].toDouble();
        node.width = nodeObj["width"].toDouble();
        node.height = nodeObj["height"].toDouble();

        QJsonArray childrenArray = nodeObj["children"].toArray();
        for (const QJsonValue &childVal : childrenArray) {
            node.children.append(childVal.toString());
        }

        m_nodes.append(node);
    }

    // 重建索引映射
    for (int i = 0; i < m_nodes.size(); ++i) {
        m_nodeIndexMap[m_nodes[i].id] = i;
    }

    emit nodesChanged();
    return true;
}
