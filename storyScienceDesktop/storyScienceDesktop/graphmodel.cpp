/**
 * @file graphmodel.cpp
 * @brief GraphModel 类的实现
 */

#include "graphmodel.h"
#include <QJsonArray>
#include <QJsonDocument>
#include <QFile>
#include <QFileInfo>
#include <QDateTime>
#include <QDebug>
#include <QRectF>
#include <algorithm>
#include <cmath>

GraphModel::GraphModel(QObject *parent) : QObject(parent), 
    m_scaleFactor(1.0),
    m_minScale(0.1),
    m_maxScale(2.0)
{
}

QVariantList GraphModel::nodes() const {
    QVariantList list;
    for (const auto &node : m_nodes) {
        QVariantMap nodeMap;
        nodeMap["elementId"] = node.elementId.toString();  // 转换为字符串
        nodeMap["position"] = node.position;
        list.append(nodeMap);
    }
    return list;
}

QVariantList GraphModel::edges() const {
    QVariantList list;
    for (const auto &edge : m_edges) {
        QVariantMap edgeMap;
        edgeMap["fromNodeId"] = edge.fromNodeId.toString();  // 转换为字符串
        edgeMap["toNodeId"] = edge.toNodeId.toString();      // 转换为字符串
        edgeMap["label"] = edge.label;
        list.append(edgeMap);
    }
    return list;
}

qreal GraphModel::scaleFactor() const {
    return m_scaleFactor;
}

void GraphModel::setScaleFactor(qreal factor) {
    qreal newFactor = qBound(m_minScale, factor, m_maxScale);
    if (m_scaleFactor != newFactor) {
        m_scaleFactor = newFactor;
        emit scaleFactorChanged();
    }
}

qreal GraphModel::minScale() const {
    return m_minScale;
}

qreal GraphModel::maxScale() const {
    return m_maxScale;
}


void GraphModel::clear() {
    m_nodes.clear();
    m_edges.clear();
    emit nodesChanged();
    emit edgesChanged();
    
    m_scaleFactor = 1.0;
    emit scaleFactorChanged();
    emit contentWidthChanged();
    emit contentHeightChanged();
}

void GraphModel::addNode(const QUuid &elementId, const QPointF &position) {
    // 检查节点是否已存在
    for (const auto &node : m_nodes) {
        if (node.elementId == elementId) {
            return;
        }
    }
    
    m_nodes.append({elementId, position});
    emit nodesChanged();
    adjustCanvasSize();
}

void GraphModel::moveNodeById(const QUuid &nodeId, const QPointF &pos) {
    for (auto &node : m_nodes) {
        if (node.elementId == nodeId) {
            node.position = pos;
            emit nodesChanged();
            
            // 调整画布大小
            adjustCanvasSize();
            return;
        }
    }
}

void GraphModel::addEdgeByNodeIds(const QUuid &fromNodeId, const QUuid &toNodeId, const QString &label) {
    // 检查节点是否存在
    bool fromExists = false, toExists = false;
    for (const auto &node : m_nodes) {
        if (node.elementId == fromNodeId) fromExists = true;
        if (node.elementId == toNodeId) toExists = true;
    }
    
    if (!fromExists || !toExists) return;
    
    // 检查连接是否已存在
    for (const auto &edge : m_edges) {
        if ((edge.fromNodeId == fromNodeId && edge.toNodeId == toNodeId) ||
            (edge.fromNodeId == toNodeId && edge.toNodeId == fromNodeId)) {
            return; // 已存在连接
        }
    }
    
    m_edges.append({fromNodeId, toNodeId, label});
    emit edgesChanged();
}

void GraphModel::removeNodeById(const QUuid &nodeId) {
    for (int i = 0; i < m_nodes.size(); ++i) {
        if (m_nodes[i].elementId == nodeId) {
            m_nodes.removeAt(i);
            break;
        }
    }
    
    // 删除与该节点相关的所有边
    m_edges.erase(std::remove_if(m_edges.begin(), m_edges.end(),
                                 [nodeId](const GraphEdge &edge) {
                                     return edge.fromNodeId == nodeId || edge.toNodeId == nodeId;
                                 }),
                  m_edges.end());
    
    emit nodesChanged();
    emit edgesChanged();
    adjustCanvasSize();
}

void GraphModel::removeEdgeByNodes(const QUuid &fromNodeId, const QUuid &toNodeId) {
    m_edges.erase(std::remove_if(m_edges.begin(), m_edges.end(),
                                 [fromNodeId, toNodeId](const GraphEdge &edge) {
                                     return (edge.fromNodeId == fromNodeId && edge.toNodeId == toNodeId) ||
                                            (edge.fromNodeId == toNodeId && edge.toNodeId == fromNodeId);
                                 }),
                  m_edges.end());
    emit edgesChanged();
}

void GraphModel::updateEdgeLabelByNodes(const QUuid &fromNodeId, const QUuid &toNodeId, const QString &label) {
    for (auto &edge : m_edges) {
        if ((edge.fromNodeId == fromNodeId && edge.toNodeId == toNodeId) ||
            (edge.fromNodeId == toNodeId && edge.toNodeId == fromNodeId)) {
            edge.label = label;
            emit edgesChanged();
            return;
        }
    }
}

void GraphModel::adjustCanvasSize() {
    updateCanvasSize();
}

QRectF GraphModel::getCanvasBounds() const {
    if (m_nodes.isEmpty()) {
        return QRectF(0, 0, 1000, 1000); // 默认大小
    }
    
    qreal minX = std::numeric_limits<qreal>::max();
    qreal minY = std::numeric_limits<qreal>::max();
    qreal maxX = std::numeric_limits<qreal>::lowest();
    qreal maxY = std::numeric_limits<qreal>::lowest();
    
    for (const auto &node : m_nodes) {
        minX = qMin(minX, node.position.x());
        minY = qMin(minY, node.position.y());
        maxX = qMax(maxX, node.position.x());
        maxY = qMax(maxY, node.position.y());
    }
    
    const qreal buffer = 50;  // 边界缓冲区
    minX -= buffer;
    minY -= buffer;
    maxX += buffer;
    maxY += buffer;
    
    return QRectF(minX, minY, maxX - minX, maxY - minY);
}

void GraphModel::updateCanvasSize() {
    QRectF bounds = getCanvasBounds();

    m_contentWidth = std::ceil(bounds.width());
    m_contentHeight = std::ceil(bounds.height());

    emit contentWidthChanged();
    emit contentHeightChanged();
}

QJsonObject GraphModel::saveToJson() const {
    QJsonObject graphObj;
    
    QJsonArray nodesArray;
    for (const auto &node : m_nodes) {
        QJsonObject nodeObj;
        nodeObj["elementId"] = node.elementId.toString();
        nodeObj["x"] = node.position.x();
        nodeObj["y"] = node.position.y();
        nodesArray.append(nodeObj);
    }
    graphObj["nodes"] = nodesArray;
    
    QJsonArray edgesArray;
    for (const auto &edge : m_edges) {
        QJsonObject edgeObj;
        edgeObj["fromNodeId"] = edge.fromNodeId.toString();
        edgeObj["toNodeId"] = edge.toNodeId.toString();
        edgeObj["label"] = edge.label;
        edgesArray.append(edgeObj);
    }
    graphObj["edges"] = edgesArray;
    
    graphObj["scaleFactor"] = m_scaleFactor;
    graphObj["contentWidth"] = m_contentWidth;
    graphObj["contentHeight"] = m_contentHeight;
    
    graphObj["version"] = "1.0";
    graphObj["timestamp"] = QDateTime::currentDateTime().toString(Qt::ISODate);
    
    return graphObj;
}

bool GraphModel::loadFromJson(const QJsonObject &jsonObj) {
    clear();
    
    QString version = jsonObj["version"].toString();
    if (version != "1.0") {
        qWarning() << "不支持的图谱文件版本:" << version;
        return false;
    }
    
    QJsonArray nodesArray = jsonObj["nodes"].toArray();
    for (const auto &nodeValue : nodesArray) {
        QJsonObject nodeObj = nodeValue.toObject();
        QUuid elementId = QUuid::fromString(nodeObj["elementId"].toString());
        double x = nodeObj["x"].toDouble();
        double y = nodeObj["y"].toDouble();
        
        if (!elementId.isNull()) {
            addNode(elementId, QPointF(x, y));
        }
    }
    
    QJsonArray edgesArray = jsonObj["edges"].toArray();
    for (const auto &edgeValue : edgesArray) {
        QJsonObject edgeObj = edgeValue.toObject();
        QUuid fromNodeId = QUuid::fromString(edgeObj["fromNodeId"].toString());
        QUuid toNodeId = QUuid::fromString(edgeObj["toNodeId"].toString());
        QString label = edgeObj["label"].toString();
        
        if (!fromNodeId.isNull() && !toNodeId.isNull()) {
            addEdgeByNodeIds(fromNodeId, toNodeId, label);
        }
    }
    
    if (jsonObj.contains("scaleFactor")) {
        setScaleFactor(jsonObj["scaleFactor"].toDouble(1.0));
    }
    
    if (jsonObj.contains("contentWidth")) {
        m_contentWidth = jsonObj["contentWidth"].toDouble(4000);
        emit contentWidthChanged();
    }
    
    if (jsonObj.contains("contentHeight")) {
        m_contentHeight = jsonObj["contentHeight"].toDouble(4000);
        emit contentHeightChanged();
    }
    
    return true;
}

bool GraphModel::saveToFile(const QString &filePath) const {
    QJsonObject graphData = saveToJson();
    QJsonDocument doc(graphData);
    
    QFile file(filePath);
    if (!file.open(QIODevice::WriteOnly)) {
        qWarning() << "无法写入文件:" << filePath;
        return false;
    }
    
    file.write(doc.toJson());
    file.close();
    return true;
}

bool GraphModel::loadFromFile(const QString &filePath) {
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning() << "无法读取文件:" << filePath;
        return false;
    }
    
    QByteArray data = file.readAll();
    file.close();
    
    QJsonParseError error;
    QJsonDocument doc = QJsonDocument::fromJson(data, &error);
    
    if (error.error != QJsonParseError::NoError) {
        qWarning() << "JSON解析错误:" << error.errorString();
        return false;
    }
    
    return loadFromJson(doc.object());
}
