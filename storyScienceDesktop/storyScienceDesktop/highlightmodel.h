/**
 * @file highlightmodel.h
 * @brief 高亮模型类
 * 
 * HighlightModel 用于管理文本中的高亮区域，支持高亮的添加、查询和清除。
 * 每个高亮项包含位置信息、注释文本和上下文信息。
 */

#ifndef HIGHLIGHTMODEL_H
#define HIGHLIGHTMODEL_H

#include <QAbstractListModel>
#include <QRegularExpression>

/**
 * @struct HighlightItem
 * @brief 高亮项数据结构
 * 
 * 表示文本中的一个高亮区域，包含位置、长度、注释和上下文信息。
 */
struct HighlightItem {
    int start;          ///< 起始位置
    int length;          ///< 长度
    QString comment;     ///< 注释文本
    QString text;        ///< 原文片段（用于调试和匹配）
    QString prefix;      ///< 前10个字符的上下文
    QString suffix;      ///< 后10个字符的上下文
};

/**
 * @class HighlightModel
 * @brief 高亮模型类
 * 
 * 继承自 QAbstractListModel，管理文本中的高亮区域列表。
 * 支持高亮的添加、查询和清除操作。
 */
class HighlightModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int count READ rowCount NOTIFY countChanged)

public:
    enum Roles {
        StartRole = Qt::UserRole + 1,
        LengthRole,
        CommentRole,
        TextRole,
        PrefixRole,
        SuffixRole
    };

    explicit HighlightModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex & = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    void addHighlight(int start, int length, const QString &comment, const QString &text, const QString &prefix = "", const QString &suffix = "");
    void clear();
    
    /// 获取指定索引的高亮项数据
    Q_INVOKABLE QVariantMap get(int index) const;

signals:
    void countChanged();

private:
    QList<HighlightItem> m_items;
};

#endif // HIGHLIGHTMODEL_H