/**
 * @file canvasmanager.cpp
 * @brief CanvasManager 类的实现
 */

#include "canvasmanager.h"
#include <QDebug>

CanvasManager::CanvasManager(QObject *parent) : QObject(parent), m_currentCanvasIndex(-1) {}

QVariantList CanvasManager::canvases() const {
    QVariantList list;
    for (const Canvas &canvas : m_canvases) {
        QVariantMap map;
        map["id"] = canvas.id.toString();
        map["name"] = canvas.name;
        list.append(map);
    }
    return list;
}

int CanvasManager::currentCanvasIndex() const {
    return m_currentCanvasIndex;
}

GraphModel* CanvasManager::currentGraphModel() const {
    if (m_currentCanvasIndex >= 0 && m_currentCanvasIndex < m_canvases.size()) {
        return m_canvases[m_currentCanvasIndex].graphModel;
    }
    return nullptr;
}

GraphModel* CanvasManager::getCanvasGraphModel(int index) const {
    if (index >= 0 && index < m_canvases.size()) {
        return m_canvases[index].graphModel;
    }
    return nullptr;
}

void CanvasManager::createCanvas(const QString &name) {
    Canvas newCanvas(name);
    newCanvas.graphModel = new GraphModel(this);
    m_canvases.append(newCanvas);
    
    // 如果这是第一个画布，设置为当前画布
    if (m_canvases.size() == 1) {
        m_currentCanvasIndex = 0;
        emit currentCanvasChanged();
    }
    
    emit canvasesChanged();
}

void CanvasManager::switchToCanvas(int index) {
    if (index >= 0 && index < m_canvases.size()) {
        m_currentCanvasIndex = index;
        emit currentCanvasChanged();
    }
}

void CanvasManager::removeCanvas(int index) {
    if (index >= 0 && index < m_canvases.size() && m_canvases.size() > 1) {
        // 删除画布及其关联的图谱模型
        delete m_canvases[index].graphModel;
        m_canvases.removeAt(index);
        
        // 调整当前索引
        if (m_currentCanvasIndex >= m_canvases.size()) {
            m_currentCanvasIndex = m_canvases.size() - 1;
        } else if (m_currentCanvasIndex > index) {
            m_currentCanvasIndex--;
        }
        
        emit canvasesChanged();
        emit currentCanvasChanged();
    }
}

QString CanvasManager::getCurrentCanvasName() const {
    if (m_currentCanvasIndex >= 0 && m_currentCanvasIndex < m_canvases.size()) {
        return m_canvases[m_currentCanvasIndex].name;
    }
    return QString();
}

void CanvasManager::setCurrentCanvasName(const QString &name) {
    if (m_currentCanvasIndex >= 0 && m_currentCanvasIndex < m_canvases.size()) {
        m_canvases[m_currentCanvasIndex].name = name;
        emit canvasesChanged();
    }
}

void CanvasManager::createCanvasFromData(const QUuid &id, const QString &name, const QJsonObject &graphData) {
    Canvas newCanvas(id, name);
    newCanvas.graphModel = new GraphModel(this);
    newCanvas.graphModel->loadFromJson(graphData);
    m_canvases.append(newCanvas);
    
    // 如果这是第一个画布，设置为当前画布
    if (m_canvases.size() == 1) {
        m_currentCanvasIndex = 0;
        emit currentCanvasChanged();
    }
    
    emit canvasesChanged();
}

void CanvasManager::clearAllCanvases() {
    // 删除所有画布及其关联的图谱模型
    for (Canvas &canvas : m_canvases) {
        delete canvas.graphModel;
    }
    m_canvases.clear();
    m_currentCanvasIndex = -1;
    
    emit canvasesChanged();
    emit currentCanvasChanged();
}