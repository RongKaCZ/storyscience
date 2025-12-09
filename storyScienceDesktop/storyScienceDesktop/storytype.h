// StoryType.h
#ifndef STORYTYPE_H
#define STORYTYPE_H

#include <QObject>

class StoryTypeWrapper : public QObject {
    Q_OBJECT
public:
    enum StoryType {
        Root,//0
        Book,//1
        Volume,//2
        Chapter,//3
        Scene//4
    };
    Q_ENUM(StoryType)  // 注册到 Qt 元对象系统
};

#endif // STORYTYPE_H
