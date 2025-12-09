// elementstatus.cpp
#include "elementstatus.h"

// CharacterStatus 实现
QJsonObject CharacterStatus::toJson() const {
    QJsonObject obj;
    obj["level"] = level;
    obj["xp"] = xp;
    obj["stage"] = stage;
    obj["details"] = details;
    QJsonObject attrObj;
    for (auto it = attributes.constBegin(); it != attributes.constEnd(); ++it) {
        attrObj[it.key()] = it.value().toJsonValue();
    }
    obj["attributes"] = attrObj;
    
    QJsonArray abilitiesArray;
    for (const QString& id : abilities) {
        abilitiesArray.append(id);
    }
    obj["abilities"] = abilitiesArray;
    
    QJsonArray inventoryArray;
    for (const QString& id : inventory) {
        inventoryArray.append(id);
    }
    obj["inventory"] = inventoryArray;
    
    QJsonArray effectsArray;
    for (const QString& effect : statusEffects) {
        effectsArray.append(effect);
    }
    obj["statusEffects"] = effectsArray;
    
    obj["biography"] = biography;
    obj["portrait"] = portrait;
    
    return obj;
}

CharacterStatus CharacterStatus::fromJson(const QJsonObject& obj) {
    CharacterStatus status;
    status.level = obj["level"].toString();
    status.xp = obj["xp"].toString();
    status.stage = obj["stage"].toString();
    status.details = obj["details"].toString();
    
    QJsonObject attrObj = obj["attributes"].toObject();
    for (auto it = attrObj.begin(); it != attrObj.end(); ++it) {
        status.attributes[it.key()] = it.value().toVariant();
    }
    
    QJsonArray abilitiesArray = obj["abilities"].toArray();
    for (const QJsonValue& value : abilitiesArray) {
        status.abilities.append(value.toString());
    }
    
    QJsonArray inventoryArray = obj["inventory"].toArray();
    for (const QJsonValue& value : inventoryArray) {
        status.inventory.append(value.toString());
    }
    
    QJsonArray effectsArray = obj["statusEffects"].toArray();
    for (const QJsonValue& value : effectsArray) {
        status.statusEffects.append(value.toString());
    }
    
    status.biography = obj["biography"].toString();
    status.portrait = obj["portrait"].toString();
    
    return status;
}

// LocationStatus 实现
QJsonObject LocationStatus::toJson() const {
    QJsonObject obj;
    obj["region"] = region;
    obj["population"] = population;
    obj["control"] = control.toString();
    obj["importance"] = importance;
    obj["coordinates"] = coordinates;
    obj["details"] = details;
    QJsonArray resourcesArray;
    for (const QString& resource : resources) {
        resourcesArray.append(resource);
    }
    obj["resources"] = resourcesArray;
    
    obj["climate"] = climate;
    obj["accessibility"] = accessibility;
    
    return obj;
}

LocationStatus LocationStatus::fromJson(const QJsonObject& obj) {
    LocationStatus status;
    status.region = obj["region"].toString();
    status.population = obj["population"].toString();
    status.control = QUuid(obj["control"].toString());
    status.importance = obj["importance"].toString();
    status.coordinates = obj["coordinates"].toString();
    status.details = obj["details"].toString();

    QJsonArray resourcesArray = obj["resources"].toArray();
    for (const QJsonValue& value : resourcesArray) {
        status.resources.append(value.toString());
    }
    
    status.climate = obj["climate"].toString();
    status.accessibility = obj["accessibility"].toString();
    
    return status;
}

// ItemStatus 实现
QJsonObject ItemStatus::toJson() const {
    QJsonObject obj;
    obj["rarity"] = rarity;
    obj["category"] = category;
    obj["durability"] = durability;
    obj["details"] = details;

    QJsonArray effectsArray;
    for (const QString& effect : effects) {
        effectsArray.append(effect);
    }
    obj["effects"] = effectsArray;
    
    obj["ownerId"] = ownerId.toString();
    obj["value"] = value;
    
    return obj;
}

ItemStatus ItemStatus::fromJson(const QJsonObject& obj) {
    ItemStatus status;
    status.rarity = obj["rarity"].toString();
    status.category = obj["category"].toString();
    status.durability = obj["durability"].toString();
    status.details = obj["details"].toString();

    QJsonArray effectsArray = obj["effects"].toArray();
    for (const QJsonValue& value : effectsArray) {
        status.effects.append(value.toString());
    }
    
    status.ownerId = QUuid(obj["ownerId"].toString());
    status.value = obj["value"].toString();
    
    return status;
}

// AbilityStatus 实现
QJsonObject AbilityStatus::toJson() const {
    QJsonObject obj;
    obj["powerCategory"] = powerCategory;
    obj["cost"] = cost;
    obj["cooldown"] = cooldown;
    obj["rank"] = rank;
    obj["details"] = details;
    QJsonArray prereqArray;
    for (const QString& prereq : prerequisites) {
        prereqArray.append(prereq);
    }
    obj["prerequisites"] = prereqArray;
    
    return obj;
}

AbilityStatus AbilityStatus::fromJson(const QJsonObject& obj) {
    AbilityStatus status;
    status.powerCategory = obj["powerCategory"].toString();
    status.cost = obj["cost"].toString();
    status.cooldown = obj["cooldown"].toString();
    status.rank = obj["rank"].toString();
    status.details = obj["details"].toString();
    
    QJsonArray prereqArray = obj["prerequisites"].toArray();
    for (const QJsonValue& value : prereqArray) {
        status.prerequisites.append(value.toString());
    }
    
    return status;
}

// OrganizationStatus 实现
QJsonObject OrganizationStatus::toJson() const {
    QJsonObject obj;
    obj["influence"] = influence;
    obj["hq"] = hq.toString();
    obj["goals"] = goals;
    obj["details"] = details;
    QJsonArray membersArray;
    for (const QVariant& member : members) {
        membersArray.append(QJsonValue::fromVariant(member));
    }
    obj["members"] = membersArray;
    
    QJsonArray resourcesArray;
    for (const QString& resource : resources) {
        resourcesArray.append(resource);
    }
    obj["resources"] = resourcesArray;
    
    return obj;
}

OrganizationStatus OrganizationStatus::fromJson(const QJsonObject& obj) {
    OrganizationStatus status;
    status.influence = obj["influence"].toString();
    status.hq = QUuid(obj["hq"].toString());
    status.goals = obj["goals"].toString();
    status.details = obj["details"].toString();

    QJsonArray membersArray = obj["members"].toArray();
    for (const QJsonValue& value : membersArray) {
        status.members.append(value.toVariant());
    }
    
    QJsonArray resourcesArray = obj["resources"].toArray();
    for (const QJsonValue& value : resourcesArray) {
        status.resources.append(value.toString());
    }
    
    return status;
}

// EventStatus 实现
QJsonObject EventStatus::toJson() const {
    QJsonObject obj;
    obj["datetime"] = datetime;
    obj["timelinePos"] = timelinePos;
    obj["locationId"] = locationId.toString();
    obj["status"] = status;
    obj["outcome"] = outcome;
    obj["impactScore"] = impactScore;
    obj["details"] = details;

    QJsonArray participantsArray;
    for (const QString& participant : participants) {
        participantsArray.append(participant);
    }
    obj["participants"] = participantsArray;
    
    return obj;
}

EventStatus EventStatus::fromJson(const QJsonObject& obj) {
    EventStatus status;
    status.datetime = obj["datetime"].toString();
    status.timelinePos = obj["timelinePos"].toString();
    status.locationId = QUuid(obj["locationId"].toString());
    status.status = obj["status"].toString("计划中");
    status.outcome = obj["outcome"].toString();
    status.impactScore = obj["impactScore"].toString();
    status.details = obj["details"].toString();
    
    QJsonArray participantsArray = obj["participants"].toArray();
    for (const QJsonValue& value : participantsArray) {
        status.participants.append(value.toString());
    }
    
    return status;
}

// ElementStatusWrapper 实现
ElementStatusWrapper::ElementStatusWrapper(QObject *parent)
    : QObject(parent)
{
}

QJsonObject ElementStatusWrapper::toJson(ElementTypeWrapper::ElementType type) const {
    QJsonObject obj;
    switch (type) {
    case ElementTypeWrapper::Character:
        obj = m_characterStatus.toJson();
        break;
    case ElementTypeWrapper::Location:
        obj = m_locationStatus.toJson();
        break;
    case ElementTypeWrapper::Item:
        obj = m_itemStatus.toJson();
        break;
    case ElementTypeWrapper::Abilities:
        obj = m_abilityStatus.toJson();
        break;
    case ElementTypeWrapper::Organisation:
        obj = m_organizationStatus.toJson();
        break;
    case ElementTypeWrapper::Event:
        obj = m_eventStatus.toJson();
        break;
    }
    return obj;
}

void ElementStatusWrapper::loadFromJson(const QJsonObject& obj, ElementTypeWrapper::ElementType type) {
    switch (type) {
    case ElementTypeWrapper::Character:
        m_characterStatus = CharacterStatus::fromJson(obj);
        break;
    case ElementTypeWrapper::Location:
        m_locationStatus = LocationStatus::fromJson(obj);
        break;
    case ElementTypeWrapper::Item:
        m_itemStatus = ItemStatus::fromJson(obj);
        break;
    case ElementTypeWrapper::Abilities:
        m_abilityStatus = AbilityStatus::fromJson(obj);
        break;
    case ElementTypeWrapper::Organisation:
        m_organizationStatus = OrganizationStatus::fromJson(obj);
        break;
    case ElementTypeWrapper::Event:
        m_eventStatus = EventStatus::fromJson(obj);
        break;
    }
}