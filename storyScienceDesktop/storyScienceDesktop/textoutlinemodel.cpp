/**
 * @file textoutlinemodel.cpp
 * @brief TextOutlineModel 类的实现
 */

#include "textoutlinemodel.h"
TextOutlineModel::TextOutlineModel(QObject *parent) : QObject(parent)
{

}

QString TextOutlineModel::content() const
{
    return m_content;
}
void TextOutlineModel::setContent(const QString &newContent)
{
    if (m_content == newContent)
    return;
    m_content = newContent;
    emit contentChanged();
}
QString TextOutlineModel::saveToText() const
{
    return m_content;
}
void TextOutlineModel::loadFromText(const QString &text)
{
    setContent(text);
}
