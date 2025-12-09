/**
 * @file keydetailsmanager.h
 * @brief 关键细节管理器类
 * 
 * KeyDetailsManager 负责加载和管理关键细节数据，
 * 从JSON文件中读取关键信息。
 */

#ifndef KEYDETAILSMANAGER_H
#define KEYDETAILSMANAGER_H

#include <QObject>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonDocument>
#include <QFile>
#include <QDir>
#include <QStandardPaths>
#include <QDebug>

/**
 * @class KeyDetailsManager
 * @brief 关键细节管理器类
 * 
 * 负责从JSON文件中加载关键细节数据，并提供给QML使用。
 */
class KeyDetailsManager : public QObject
{
    Q_OBJECT

public:
    explicit KeyDetailsManager(QObject *parent = nullptr);

    Q_INVOKABLE QJsonArray loadKeyData(const QString &filePath);

signals:
    void keyDataLoaded(const QJsonArray &data);
};

#endif // KEYDETAILSMANAGER_H