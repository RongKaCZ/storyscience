/**
 * @file graphmodel.h
 * @brief 关系图谱模型类
 * 
 * GraphModel 用于管理元素之间的关系图谱，支持节点和边的增删改查。
 * 提供缩放、画布大小调整等功能，并支持数据的序列化和反序列化。
 */

#pragma once
#include <QObject>
#include <QVariantList>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QUuid>
#include <QPointF>
#include <QFile>
#include <QFileInfo>
#include <QDebug>

/**
 * @struct GraphNode
 * @brief 图谱节点数据结构
 * 
 * 表示关系图谱中的一个节点，包含元素ID和位置信息。
 */
struct GraphNode {
    QUuid elementId;
    QPointF position;
};
Q_DECLARE_METATYPE(GraphNode)

/**
 * @struct GraphEdge
 * @brief 图谱边数据结构
 * 
 * 表示关系图谱中的一条边（连接），包含起始节点ID、目标节点ID和标签。
 */
struct GraphEdge {
    QUuid fromNodeId;  ///< 起始节点ID
    QUuid toNodeId;    ///< 目标节点ID
    QString label;     ///< 边的标签
};
Q_DECLARE_METATYPE(GraphEdge)

/**
 * @class GraphModel
 * @brief 关系图谱模型类
 * 
 * 管理元素之间的关系图谱，支持节点的添加、移动、删除，
 * 以及边的创建、更新、删除。提供缩放和画布大小管理功能。
 */
class GraphModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList nodes READ nodes NOTIFY nodesChanged)
    Q_PROPERTY(QVariantList edges READ edges NOTIFY edgesChanged)
    Q_PROPERTY(qreal scaleFactor READ scaleFactor WRITE setScaleFactor NOTIFY scaleFactorChanged)
    Q_PROPERTY(qreal minScale READ minScale CONSTANT)
    Q_PROPERTY(qreal maxScale READ maxScale CONSTANT)
    Q_PROPERTY(qreal contentWidth READ contentWidth NOTIFY contentWidthChanged)
    Q_PROPERTY(qreal contentHeight READ contentHeight NOTIFY contentHeightChanged)

public:
    explicit GraphModel(QObject *parent = nullptr);

    QVariantList nodes() const;
    QVariantList edges() const;
    
    // 缩放和画布大小相关方法
    Q_INVOKABLE qreal scaleFactor() const;
    Q_INVOKABLE void setScaleFactor(qreal factor);
    Q_INVOKABLE qreal minScale() const;
    Q_INVOKABLE qreal maxScale() const;
    Q_INVOKABLE qreal contentWidth() const { return m_contentWidth; }
    Q_INVOKABLE qreal contentHeight() const { return m_contentHeight; }
    
    // 基于节点ID的新方法
    Q_INVOKABLE void addNode(const QUuid &elementId, const QPointF &position);
    Q_INVOKABLE void moveNodeById(const QUuid &nodeId, const QPointF &pos);
    Q_INVOKABLE void addEdgeByNodeIds(const QUuid &fromNodeId, const QUuid &toNodeId, const QString &label = "");
    Q_INVOKABLE void removeNodeById(const QUuid &nodeId);
    Q_INVOKABLE void removeEdgeByNodes(const QUuid &fromNodeId, const QUuid &toNodeId);
    Q_INVOKABLE void updateEdgeLabelByNodes(const QUuid &fromNodeId, const QUuid &toNodeId, const QString &label);

    Q_INVOKABLE void clear();
    
    /// 调整画布大小以适应所有节点
    Q_INVOKABLE void adjustCanvasSize();
    Q_INVOKABLE QRectF getCanvasBounds() const;
    
    // 序列化功能
    Q_INVOKABLE QJsonObject saveToJson() const;
    Q_INVOKABLE bool loadFromJson(const QJsonObject &jsonObj);
    Q_INVOKABLE bool saveToFile(const QString &filePath) const;
    Q_INVOKABLE bool loadFromFile(const QString &filePath);

signals:
    void nodesChanged();
    void edgesChanged();
    void scaleFactorChanged();
    void contentWidthChanged();
    void contentHeightChanged();

private:
    QList<GraphNode> m_nodes;      ///< 节点列表
    QList<GraphEdge> m_edges;      ///< 边列表
    
    qreal m_scaleFactor;           ///< 当前缩放因子
    qreal m_minScale;               ///< 最小缩放比例
    qreal m_maxScale;               ///< 最大缩放比例
    qreal m_contentWidth;           ///< 画布内容宽度
    qreal m_contentHeight;          ///< 画布内容高度
    
    /// 更新画布大小
    void updateCanvasSize();
};
