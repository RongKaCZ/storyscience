// elementstatus.h
#ifndef ELEMENTSTATUS_H
#define ELEMENTSTATUS_H

#include <QObject>
#include <QVariantMap>
#include <QJsonObject>
#include <QJsonArray>
#include <QStringList>
#include <QUuid>
#include "elementtype.h"

// 人物状态结构
struct CharacterStatus {
    QString level = "青铜";
    QString xp = "100/200";
    QString stage = "1级";
    QString details = "无"; // 详情
    QVariantMap attributes; // STR, DEX, INT 等属性
    QStringList abilities;  // 能力ID列表
    QStringList inventory;  // 物品ID列表
    QStringList statusEffects; // 状态效果
    QString biography;      // 传记
    QString portrait;       // 头像路径
    // 序列化方法
    QJsonObject toJson() const;
    static CharacterStatus fromJson(const QJsonObject& obj);
};

// 地点状态结构
struct LocationStatus {
    QString region;// 区域
    QString details = "无"; //详情
    QString population = "100万人";// 人口
    QUuid control;         // 控制组织ID
    QString importance = "罕见";// 重要程度
    QString coordinates; // 坐标
    QStringList resources; // 资源
    QString climate; // 气候
    QString accessibility = "不可达";// 可访问性
    
    // 序列化方法
    QJsonObject toJson() const;
    static LocationStatus fromJson(const QJsonObject& obj);
};

// 道具状态结构
struct ItemStatus {
    QString rarity = "稀有";// 稀有度
    QString details = "无"; //详情
    QString category; //类别
    QString durability = "100"; // 耐久度
    QStringList effects;   // 效果ID列表
    QUuid ownerId;         // 所有者ID
    QString value = "0"; // 价值
    
    // 序列化方法
    QJsonObject toJson() const;
    static ItemStatus fromJson(const QJsonObject& obj);
};

// 能力状态结构
struct AbilityStatus {
    QString details = "无";// 详情
    QString powerCategory = "普通"; // 能力类型
    QString cost = "1"; // 能力消耗
    QString cooldown = "0"; // 冷却时间
    QStringList prerequisites; // 前置条件（能力ID或等级）
    QString rank = "等级"; // 等级
    
    // 序列化方法
    QJsonObject toJson() const;
    static AbilityStatus fromJson(const QJsonObject& obj);
};

// 组织状态结构
struct OrganizationStatus {
    QString details = "无";// 详情
    QVariantList members;  // 成员列表 {id, role}
    QString influence = "0";// 影响力
    QUuid hq;              // 总部地点ID
    QString goals; // 目标
    QStringList resources; // 资源列表 
    
    // 序列化方法
    QJsonObject toJson() const;
    static OrganizationStatus fromJson(const QJsonObject& obj);
};

// 事件状态结构
struct EventStatus {
    QString details = "无"; //详情
    QString datetime = "2025-10-05 12:00:00";      // 日期时间
    QString timelinePos = "时间线"; // 时间线位置
    QStringList participants; // 参与者ID列表
    QUuid locationId;      // 地点ID
    QString status;        // 状态 (计划中、进行中、完成中、已结束)
    QString outcome;       // 结果
    QString impactScore = "0";   // 影响分数
    
    // 序列化方法
    QJsonObject toJson() const;
    static EventStatus fromJson(const QJsonObject& obj);
};

// 元素状态包装类
class ElementStatusWrapper : public QObject {
    Q_OBJECT
public:
    explicit ElementStatusWrapper(QObject *parent = nullptr);
    
    // 根据元素类型获取对应的状态结构
    CharacterStatus& characterStatus() { return m_characterStatus; }
    LocationStatus& locationStatus() { return m_locationStatus; }
    ItemStatus& itemStatus() { return m_itemStatus; }
    AbilityStatus& abilityStatus() { return m_abilityStatus; }
    OrganizationStatus& organizationStatus() { return m_organizationStatus; }
    EventStatus& eventStatus() { return m_eventStatus; }
    
    // 序列化方法
    QJsonObject toJson(ElementTypeWrapper::ElementType type) const;
    void loadFromJson(const QJsonObject& obj, ElementTypeWrapper::ElementType type);
    
private:
    CharacterStatus m_characterStatus;
    LocationStatus m_locationStatus;
    ItemStatus m_itemStatus;
    AbilityStatus m_abilityStatus;
    OrganizationStatus m_organizationStatus;
    EventStatus m_eventStatus;
};

#endif // ELEMENTSTATUS_H
