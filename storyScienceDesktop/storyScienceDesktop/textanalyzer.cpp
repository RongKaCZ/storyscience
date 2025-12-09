/**
 * @file textanalyzer.cpp
 * @brief TextAnalyzer 类的实现
 */

#include "textanalyzer.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QDebug>
#include <QRegularExpression>
TextAnalyzer::TextAnalyzer(QObject *parent)
    : QObject(parent)
    , m_model(new HighlightModel(this))
{
}

void TextAnalyzer::analyzeText(const QString &fullText, const QString &aiResponseJson)
{
    static int callCount = 0;
    QString callId = QString("Call-%1-%2").arg(++callCount).arg(QUuid::createUuid().toString(QUuid::WithoutBraces).left(8));

    m_model->clear();

    QJsonParseError error;
    QJsonDocument doc = QJsonDocument::fromJson(aiResponseJson.toUtf8(), &error);
    if (error.error != QJsonParseError::NoError || !doc.isArray()) {
        qWarning() << "[" << callId << "] Invalid AI response JSON:" << error.errorString();
        return;
    }

    QJsonArray array = doc.array();

    // 统一换行符为 \n
    QString normalizedFullText = fullText;
    normalizedFullText.replace("\r\n", "\n").replace("\r", "\n");

    for (const QJsonValue &v : array) {
        if (!v.isObject()) continue;
        QJsonObject obj = v.toObject();
        QString fragment = obj["text"].toString();
        QString comment = obj["comment"].toString();
        QString prefix = obj["prefix"].toString();
        QString suffix = obj["suffix"].toString();

        if (fragment.isEmpty()) continue;

        // 统一换行符格式
        fragment.replace("\\n", "\n").replace("\r\n", "\n").replace("\r", "\n");
        prefix.replace("\\n", "\n").replace("\r\n", "\n").replace("\r", "\n");
        suffix.replace("\\n", "\n").replace("\r\n", "\n").replace("\r", "\n");

        bool found = false;
        int fragStart = -1;
        int fragLength = 0;

        // 策略1：精确字符串匹配（包含前后文）
        QString fullPattern = prefix + fragment + suffix;
        int pos = normalizedFullText.indexOf(fullPattern);
        if (pos != -1) {
            fragStart = pos + prefix.length();
            fragLength = fragment.length();
            found = true;
        }

        // 策略2：换行符和空白容错正则匹配
        if (!found && (!prefix.isEmpty() || !suffix.isEmpty())) {

            QString escPrefix = QRegularExpression::escape(prefix);
            QString escFragment = QRegularExpression::escape(fragment);
            QString escSuffix = QRegularExpression::escape(suffix);

            QString pattern;
            int fragmentGroupIndex = 1;
            if (!prefix.isEmpty()) {
                pattern += "(" + escPrefix + "\\s*)";
                fragmentGroupIndex = 2;
            }
            pattern += "(" + escFragment + ")";
            if (!suffix.isEmpty()) {
                pattern += "(\\s*" + escSuffix + ")";
            }

            QRegularExpression regex(pattern, QRegularExpression::UseUnicodePropertiesOption | QRegularExpression::MultilineOption);
            QRegularExpressionMatch match = regex.match(normalizedFullText);

            if (match.hasMatch()) {
                fragStart = match.capturedStart(fragmentGroupIndex);
                fragLength = match.capturedLength(fragmentGroupIndex);
                found = true;
            }
        }

        // 策略3：仅匹配片段（带空白和换行容错）
        if (!found) {
            QString escFragment = QRegularExpression::escape(fragment);
            QString fragPattern = escFragment.replace(QRegularExpression::escape("\n"), "\\s*");

            QRegularExpression fragRegex(fragPattern, QRegularExpression::UseUnicodePropertiesOption | QRegularExpression::MultilineOption);
            QRegularExpressionMatch fragMatch = fragRegex.match(normalizedFullText);

            if (fragMatch.hasMatch()) {
                fragStart = fragMatch.capturedStart();
                fragLength = fragMatch.capturedLength();
                found = true;
            }
        }

        // 策略4：模糊匹配（去除所有空白后匹配）
        if (!found) {
            QString simplifiedFragment = fragment;
            simplifiedFragment.remove(QRegularExpression("\\s+"));

            QString simplifiedFullText = normalizedFullText;
            simplifiedFullText.remove(QRegularExpression("\\s+"));

            pos = simplifiedFullText.indexOf(simplifiedFragment);
            if (pos != -1) {
                int searchStart = qMax(0, pos - 100);
                int searchEnd = qMin(normalizedFullText.length(), pos + simplifiedFragment.length() + 100);
                QString searchWindow = normalizedFullText.mid(searchStart, searchEnd - searchStart);

                QRegularExpression fragRegex(QRegularExpression::escape(fragment).replace(QRegularExpression::escape("\n"), "\\s*"),
                                             QRegularExpression::UseUnicodePropertiesOption | QRegularExpression::MultilineOption);
                QRegularExpressionMatch fragMatch = fragRegex.match(searchWindow);
                if (fragMatch.hasMatch()) {
                    fragStart = searchStart + fragMatch.capturedStart();
                    fragLength = fragMatch.capturedLength();
                    found = true;
                }
            }
        }

        // 如果找到匹配，添加高亮项
        if (found) {
            m_model->addHighlight(fragStart, fragLength + 1, comment,
                                  normalizedFullText.mid(fragStart, fragLength), prefix, suffix);
        } else {
            qWarning() << "[" << callId << "] 无法在全文中定位片段:" << fragment;
        }
    }
}
void TextAnalyzer::clear()
{
    m_model->clear();
}
