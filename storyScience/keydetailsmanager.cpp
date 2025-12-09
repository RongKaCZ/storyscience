/**
 * @file keydetailsmanager.cpp
 * @brief KeyDetailsManager 类的实现
 */

#include "keydetailsmanager.h"
#include <QJsonDocument>
#include <QFile>
#include <QDir>
#include <QStandardPaths>
#include <QDebug>
#include <QJsonArray>

KeyDetailsManager::KeyDetailsManager(QObject *parent)
    : QObject(parent)
{
}

QJsonArray KeyDetailsManager::loadKeyData(const QString &filePath)
{
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << "无法打开文件:" << filePath;
        return QJsonArray();
    }

    QByteArray data = file.readAll();
    file.close();

    QJsonParseError error;
    QJsonDocument doc = QJsonDocument::fromJson(data, &error);
    if (error.error != QJsonParseError::NoError) {
        qDebug() << "JSON解析错误:" << error.errorString();
        return QJsonArray();
    }

    if (doc.isArray()) {
        return doc.array();
    } else if (doc.isObject()) {
        // 单个对象转换为数组
        QJsonArray array;
        array.append(doc.object());
        return array;
    } else {
        qDebug() << "JSON文件格式错误";
        return QJsonArray();
    }
}