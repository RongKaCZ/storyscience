/**
 * @file canvasmanager.h
 * @brief 画布管理器类，管理多个关系图谱画布
 * 
 * CanvasManager 负责管理应用程序中的多个关系图谱画布。
 * 每个画布包含一个独立的 GraphModel，用于存储和展示元素之间的关系。
 */

#ifndef CANVASMANAGER_H
#define CANVASMANAGER_H

#include <graphmodel.h>
#include <QObject>
#include <QUuid>

/**
 * @struct Canvas
 * @brief 画布数据结构
 * 
 * 表示一个关系图谱画布，包含唯一标识符、名称和关联的图谱模型。
 */
struct Canvas {
    QUuid id;
    QString name;
    GraphModel *graphModel;
    
    // 添加默认构造函数
    Canvas() : id(QUuid()), name(QString()), graphModel(nullptr) {}
    Canvas(const QUuid &canvasId, const QString &canvasName) : id(canvasId), name(canvasName), graphModel(nullptr) {}
    Canvas(const QString &canvasName) : id(QUuid::createUuid()), name(canvasName), graphModel(nullptr) {}
};

/**
 * @class CanvasManager
 * @brief 画布管理器类
 * 
 * 管理多个关系图谱画布，支持创建、切换、删除画布等操作。
 * 当前活动的画布通过 currentCanvasIndex 标识。
 */
class CanvasManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(QVariantList canvases READ canvases NOTIFY canvasesChanged)
    Q_PROPERTY(int currentCanvasIndex READ currentCanvasIndex NOTIFY currentCanvasChanged)
    Q_PROPERTY(GraphModel* currentGraphModel READ currentGraphModel NOTIFY currentCanvasChanged)

public:
    explicit CanvasManager(QObject *parent = nullptr);

    QVariantList canvases() const;
    int currentCanvasIndex() const;
    GraphModel* currentGraphModel() const;
    
    // 添加方法来获取指定索引的画布的graphModel
    Q_INVOKABLE GraphModel* getCanvasGraphModel(int index) const;

    Q_INVOKABLE void createCanvas(const QString &name);
    Q_INVOKABLE void switchToCanvas(int index);
    Q_INVOKABLE void removeCanvas(int index);
    Q_INVOKABLE QString getCurrentCanvasName() const;
    Q_INVOKABLE void setCurrentCanvasName(const QString &name);
    
    /// 从序列化数据创建画布（用于项目加载）
    Q_INVOKABLE void createCanvasFromData(const QUuid &id, const QString &name, const QJsonObject &graphData);
    Q_INVOKABLE void clearAllCanvases();

signals:
    void canvasesChanged();
    void currentCanvasChanged();

private:
    QList<Canvas> m_canvases;
    int m_currentCanvasIndex;
};

#endif // CANVASMANAGER_H
