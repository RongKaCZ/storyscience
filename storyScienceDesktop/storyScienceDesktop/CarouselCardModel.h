#ifndef CAROUSELCARDMODEL_H
#define CAROUSELCARDMODEL_H

#include <QAbstractListModel>
#include <QObject>
#include <QString>
#include <QDateTime>
#include <QUrl>
#include <QJsonObject>
#include <QJsonArray>
#include <QTimer>
#include <QVariant>

// 单个卡片数据结构
struct CarouselCardData {
    QString id;
    QString title;
    QString description;
    QString content;
    QDateTime timestamp;
    QString category;
    QUrl imageUrl;
    QString iconName;
    QJsonObject metadata;
    int priority;
    bool isActive;

    CarouselCardData() : priority(0), isActive(true) {}

    CarouselCardData(const QString& id, const QString& title, const QString& desc)
        : id(id), title(title), description(desc), priority(0), isActive(true) {
        timestamp = QDateTime::currentDateTime();
    }

    CarouselCardData(const QString& id, const QString& title, const QString& desc,
                    const QString& cont, const QDateTime& time, const QString& cat,
                    const QUrl& img, const QString& icon, const QJsonObject& meta,
                    int prio, bool active)
        : id(id), title(title), description(desc), content(cont), timestamp(time),
          category(cat), imageUrl(img), iconName(icon), metadata(meta),
          priority(prio), isActive(active) {}
};

Q_DECLARE_METATYPE(CarouselCardData)

class CarouselCardModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int count READ rowCount NOTIFY countChanged)
    Q_PROPERTY(bool autoRefresh READ autoRefresh WRITE setAutoRefresh NOTIFY autoRefreshChanged)
    Q_PROPERTY(int refreshInterval READ refreshInterval WRITE setRefreshInterval NOTIFY refreshIntervalChanged)
    Q_PROPERTY(bool isLoaded READ isLoaded NOTIFY loadedChanged)

public:
    enum CardRoles {
        IdRole = Qt::UserRole + 1,
        TitleRole,
        DescriptionRole,
        ContentRole,
        TimestampRole,
        CategoryRole,
        ImageUrlRole,
        IconNameRole,
        MetadataRole,
        PriorityRole,
        IsActiveRole,
        FormattedTimeRole,
        DisplayTextRole
    };

    explicit CarouselCardModel(QObject *parent = nullptr);
    ~CarouselCardModel();

    // QAbstractListModel interface
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    // 数据操作接口
    Q_INVOKABLE void addCard(const QString& id, const QString& title, const QString& description);
    Q_INVOKABLE void addCard(const CarouselCardData& cardData);
    // 允许从QML以JS对象(Map)的形式添加完整卡片数据
    Q_INVOKABLE void addCard(const QVariantMap& cardMap);
    Q_INVOKABLE void removeCard(int index);
    Q_INVOKABLE void removeCardById(const QString& id);
    Q_INVOKABLE void updateCard(int index, const QVariantMap& cardData);
    //Q_INVOKABLE void updateCardById(const QString& id, const CarouselCardData& cardData);
    Q_INVOKABLE void clearCards();

    // 数据查询接口
    Q_INVOKABLE QVariantMap getCard(int index) const;
    Q_INVOKABLE QVariantMap getCardById(const QString& id) const;
    Q_INVOKABLE int findCardIndex(const QString& id) const;
    Q_INVOKABLE QStringList getCategories() const;
    Q_INVOKABLE QJsonArray toJsonArray() const;

    // 数据过滤和排序
    Q_INVOKABLE void filterByCategory(const QString& category);
    Q_INVOKABLE void filterByActive(bool activeOnly = true);
    Q_INVOKABLE void sortByTimestamp(bool ascending = false);
    Q_INVOKABLE void sortByPriority(bool ascending = false);
    Q_INVOKABLE void resetFilter();

    // 批量操作
    Q_INVOKABLE bool saveToJson(const QString& filePath) const;
    Q_INVOKABLE void loadFromFile(const QString& filePath);
    Q_INVOKABLE void loadFromJson(const QJsonArray& jsonArray);
    Q_INVOKABLE void loadSampleData();
    Q_INVOKABLE void refreshData();
    Q_INVOKABLE void resetLoadedState();

    // 属性访问器
    bool autoRefresh() const { return m_autoRefresh; }
    void setAutoRefresh(bool enabled);

    int refreshInterval() const { return m_refreshInterval; }
    void setRefreshInterval(int interval);

    bool isLoaded() const { return m_isLoaded; }

signals:
    void countChanged();
    void cardAdded(int index);
    void cardRemoved(int index);
    void cardUpdated(int index);
    void dataRefreshed();
    void autoRefreshChanged();
    void refreshIntervalChanged();
    void loadedChanged();

private slots:
    void onRefreshTimer();

private:
    QList<CarouselCardData> m_cards;
    QList<CarouselCardData> m_filteredCards;
    bool m_isFiltered;
    bool m_autoRefresh;
    int m_refreshInterval;
    QTimer* m_refreshTimer;
    bool m_isLoaded;
    
    void applyCurrentFilter();
    QString formatTimestamp(const QDateTime& timestamp) const;
    QString generateDisplayText(const CarouselCardData& card) const;
    QVariantMap cardDataToMap(const CarouselCardData& card) const;  // 添加帮助函数声明
};

#endif // CAROUSELCARDMODEL_H
