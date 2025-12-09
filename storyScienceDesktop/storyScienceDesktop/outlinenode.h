/**
 * @file outlinenode.h
 * @brief 大纲节点数据结构
 * 
 * 定义思维导图大纲节点的数据结构。
 */

#ifndef OUTLINENODE_H
#define OUTLINENODE_H

#include <QString>
#include <QList>
#include <QVariantMap>
#include <QUuid>

/**
 * @struct OutlineNode
 * @brief 大纲节点数据结构
 * 
 * 表示思维导图中的一个节点，包含文本、位置、父子关系等信息。
 */
struct OutlineNode {
    QString id;              ///< 节点唯一标识符
    QString text;            ///< 节点文本
    QString description;      ///< 节点描述
    QString parentId;        ///< 父节点ID
    QList<QString> children;  ///< 子节点ID列表
    bool isLeftChild;         ///< 是否为左子节点
    qreal x, y;               ///< 节点位置坐标
    qreal width, height;       ///< 节点尺寸
    QVariantMap meta;         ///< 元数据

    OutlineNode() : id(QUuid::createUuid().toString(QUuid::WithoutBraces)), text(""), description(""), parentId(""),
                   isLeftChild(false), x(0), y(0), width(160), height(40) {}

    OutlineNode(const QString& pId, const QString& txt, bool left)
        : id(QUuid::createUuid().toString(QUuid::WithoutBraces)), text(txt), description(""), parentId(pId),
          isLeftChild(left), x(0), y(0), width(160), height(40) {}
};

#endif // OUTLINENODE_H