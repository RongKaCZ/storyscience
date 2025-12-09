/**
 * @file textanalyzer.h
 * @brief 文本分析器类
 * 
 * TextAnalyzer 用于分析文本内容，解析AI返回的高亮信息，
 * 并将结果存储在 HighlightModel 中供UI显示。
 */

#ifndef TEXTANALYZER_H
#define TEXTANALYZER_H

#include <QObject>
#include <QJsonArray>
#include <QString>
#include "highlightmodel.h"

/**
 * @class TextAnalyzer
 * @brief 文本分析器类
 * 
 * 分析文本内容，解析AI返回的JSON格式高亮信息，
 * 并更新 HighlightModel 以在UI中显示高亮区域。
 */
class TextAnalyzer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(HighlightModel* model READ model CONSTANT)

public:
    explicit TextAnalyzer(QObject *parent = nullptr);
    Q_INVOKABLE void analyzeText(const QString &fullText, const QString &aiResponseJson);
    HighlightModel *model() const { return m_model; }
    Q_INVOKABLE void clear();
private:
    HighlightModel *m_model;
};

#endif // TEXTANALYZER_H
