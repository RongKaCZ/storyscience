// ElementType.h
#ifndef ELEMENTTYPE_H
#define ELEMENTTYPE_H

#include <QObject>

class ElementTypeWrapper : public QObject {
    Q_OBJECT
public:
    enum ElementType {
        Character,
        Location,
        Item,
        Organisation,
        Event,
        Abilities
    };
    Q_ENUM(ElementType)  // 注册到 Qt 元对象系统
};

#endif // ELEMENTTYPE_H
