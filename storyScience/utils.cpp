/**
 * @file utils.cpp
 * @brief Utils 类的实现
 */

#include "utils.h"
#include <QQuickItem>

QQuickItem* Utils::findItemByObjectName(QQuickItem* root, const QString& objectName) const
{
    if (!root || objectName.isEmpty())
        return nullptr;

    if (root->objectName() == objectName)
        return root;

    const QList<QQuickItem*> children = root->childItems();
    for (QQuickItem* child : children) {
        if (QQuickItem* found = findItemByObjectName(child, objectName))
            return found;
    }
    return nullptr;
}
