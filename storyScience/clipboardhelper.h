/**
 * @file clipboardhelper.h
 * @brief 剪贴板辅助类
 * 
 * ClipboardHelper 提供剪贴板操作功能，使用单例模式。
 */

#ifndef CLIPBOARDHELPER_H
#define CLIPBOARDHELPER_H

#include <QClipboard>
#include <QGuiApplication>
#include <QObject>

/**
 * @class ClipboardHelper
 * @brief 剪贴板辅助类
 * 
 * 提供剪贴板复制功能，采用单例模式。
 */
class ClipboardHelper : public QObject
{
    Q_OBJECT
public:
    explicit ClipboardHelper(QObject *parent = nullptr);
    static ClipboardHelper* instance();
    Q_INVOKABLE void copy(const QString &text);
signals:
};

#endif // CLIPBOARDHELPER_H
