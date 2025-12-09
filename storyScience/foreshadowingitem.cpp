/**
 * @file foreshadowingitem.cpp
 * @brief ForeshadowingItem 类的实现
 */

#include "foreshadowingitem.h"

ForeshadowingItem::ForeshadowingItem(const QString &id, const QString &content, const QString &prefix, const QString &suffix, const QString &description, const QString &sourceChapterId, QObject *parent)
    : QObject(parent), m_id(id), m_content(content), m_prefix(prefix), m_suffix(suffix),
    m_description(description), m_creationDate(QDateTime::currentDateTime()),
    m_sourceChapterId(sourceChapterId), m_status(Unresolved)
{}

QString ForeshadowingItem::id() const { return m_id; }

QString ForeshadowingItem::content() const { return m_content; }

QString ForeshadowingItem::description() const { return m_description; }

QDateTime ForeshadowingItem::creationDate() const { return m_creationDate; }

QString ForeshadowingItem::sourceChapterId() const { return m_sourceChapterId; }

ForeshadowingItem::Status ForeshadowingItem::status() const { return m_status; }

QString ForeshadowingItem::prefix() const { return m_prefix; }

QString ForeshadowingItem::suffix() const { return m_suffix; }

void ForeshadowingItem::setDescription(const QString &description) {
    if (m_description != description) {
        m_description = description;
        emit descriptionChanged();
    }
}

void ForeshadowingItem::setStatus(Status status) {
    if (m_status != status) {
        m_status = status;
        emit statusChanged();
    }
}
