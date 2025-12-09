/**
 * @file utils.h
 * @brief 工具类
 * 
 * 提供通用的工具函数，用于QML和C++之间的交互。
 */

#ifndef UTILS_H
#define UTILS_H

#include <QObject>
#include <QQuickItem>

/**
 * @class Utils
 * @brief 工具类
 * 
 * 提供QML可调用的工具函数，主要用于UI相关的辅助操作。
 */
class Utils : public QObject
{
    Q_OBJECT
public:
    explicit Utils(QObject *parent = nullptr) : QObject(parent) {}

    Q_INVOKABLE QQuickItem* findItemByObjectName(QQuickItem* root, const QString& objectName) const;
};

#endif // UTILS_H
