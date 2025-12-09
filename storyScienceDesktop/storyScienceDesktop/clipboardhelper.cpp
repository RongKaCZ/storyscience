/**
 * @file clipboardhelper.cpp
 * @brief ClipboardHelper 类的实现
 */

#include "clipboardhelper.h"

ClipboardHelper::ClipboardHelper(QObject *parent)
    : QObject{parent}
{

}

ClipboardHelper *ClipboardHelper::instance()
{
    static ClipboardHelper instance;
    return &instance;
}

void ClipboardHelper::copy(const QString &text)
{
    QClipboard *clipboard = QGuiApplication::clipboard();
    clipboard->setText(text);
}
