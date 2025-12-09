/**
 * @file CarouselCardModel.cpp
 * @brief CarouselCardModel 类的实现
 */

#include "carouselcardmodel.h"
#include "datamanager.h"
#include <QJsonDocument>
#include <QDebug>
#include <QLocale>
#include <QFile>

CarouselCardModel::CarouselCardModel(QObject *parent)
    : QAbstractListModel(parent)
    , m_isFiltered(false)
    , m_autoRefresh(false)
    , m_refreshInterval(30000)  // 30秒默认刷新间隔
    , m_refreshTimer(new QTimer(this))
    , m_isLoaded(false)
{
    connect(m_refreshTimer, &QTimer::timeout, this, &CarouselCardModel::onRefreshTimer);
}

QVariantMap CarouselCardModel::cardDataToMap(const CarouselCardData& card) const
{
    QVariantMap cardMap;
    cardMap.insert("id", card.id);
    cardMap.insert("title", card.title);
    cardMap.insert("description", card.description);
    cardMap.insert("content", card.content);
    cardMap.insert("timestamp", card.timestamp);
    cardMap.insert("category", card.category);
    cardMap.insert("imageUrl", card.imageUrl);
    cardMap.insert("iconName", card.iconName);
    cardMap.insert("metadata", card.metadata);
    cardMap.insert("priority", card.priority);
    cardMap.insert("isActive", card.isActive);
    return cardMap;
}

CarouselCardModel::~CarouselCardModel()
{
    if (m_refreshTimer) {
        m_refreshTimer->stop();
    }
    
    // 析构时自动保存数据
    if(this->m_isLoaded){
        QString projectPath = DataManager::instance()->currentProjectPath();
        if (!projectPath.isEmpty()) {
            QFileInfo fileInfo(projectPath);
            QString dirPath = fileInfo.absolutePath();
            saveToJson(dirPath);
        }
    }
}

int CarouselCardModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_isFiltered ? m_filteredCards.size() : m_cards.size();
}

QVariant CarouselCardModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= rowCount()) {
        return QVariant();
    }

    const CarouselCardData& card = m_isFiltered ? m_filteredCards.at(index.row()) : m_cards.at(index.row());

    switch (role) {
    case IdRole:
        return card.id;
    case TitleRole:
        return card.title;
    case DescriptionRole:
        return card.description;
    case ContentRole:
        return card.content;
    case TimestampRole:
        return card.timestamp;
    case CategoryRole:
        return card.category;
    case ImageUrlRole:
        return card.imageUrl;
    case IconNameRole:
        return card.iconName;
    case MetadataRole:
        return QVariant::fromValue(card.metadata);
    case PriorityRole:
        return card.priority;
    case IsActiveRole:
        return card.isActive;
    case FormattedTimeRole:
        return formatTimestamp(card.timestamp);
    case DisplayTextRole:
        return generateDisplayText(card);
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> CarouselCardModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[TitleRole] = "title";
    roles[DescriptionRole] = "description";
    roles[ContentRole] = "content";
    roles[TimestampRole] = "timestamp";
    roles[CategoryRole] = "category";
    roles[ImageUrlRole] = "imageUrl";
    roles[IconNameRole] = "iconName";
    roles[MetadataRole] = "metadata";
    roles[PriorityRole] = "priority";
    roles[IsActiveRole] = "isActive";
    roles[FormattedTimeRole] = "formattedTime";
    roles[DisplayTextRole] = "displayText";
    return roles;
}

void CarouselCardModel::addCard(const QString& id, const QString& title, const QString& description)
{
    CarouselCardData card(id, title, description);
    addCard(card);
}

void CarouselCardModel::addCard(const CarouselCardData& cardData)
{
    beginInsertRows(QModelIndex(), m_cards.size(), m_cards.size());
    m_cards.append(cardData);
    endInsertRows();

    if (m_isFiltered) {
        applyCurrentFilter();
    }

    emit countChanged();
    emit cardAdded(m_cards.size() - 1);
}

void CarouselCardModel::addCard(const QVariantMap& cardMap)
{
    CarouselCardData card;
    card.id = cardMap.value("id").toString();
    card.title = cardMap.value("title").toString();
    card.description = cardMap.value("description").toString();
    card.content = cardMap.value("content").toString();
    
    // 从Map获取时间戳，如果不存在则使用当前时间
    if (cardMap.contains("timestamp")) {
        const QVariant ts = cardMap.value("timestamp");
        if (ts.canConvert<QDateTime>()) {
            card.timestamp = ts.toDateTime();
        } else {
            card.timestamp = QDateTime::currentDateTime();
        }
    } else {
        card.timestamp = QDateTime::currentDateTime();
    }
    card.category = cardMap.value("category").toString();
    card.imageUrl = QUrl(cardMap.value("imageUrl").toString());
    card.iconName = cardMap.value("iconName").toString();
    card.metadata = cardMap.value("metadata").toJsonObject();
    card.priority = cardMap.value("priority").toInt();
    card.isActive = cardMap.contains("isActive") ? cardMap.value("isActive").toBool() : true;

    addCard(card);
}

void CarouselCardModel::removeCard(int index)
{
    if (index < 0 || index >= rowCount()) {
        return;
    }

    beginRemoveRows(QModelIndex(), index, index);
    if (m_isFiltered) {
        // 从原始数据中移除
        const QString& cardId = m_filteredCards.at(index).id;
        int originalIndex = findCardIndex(cardId);
        if (originalIndex >= 0) {
            m_cards.removeAt(originalIndex);
        }
        m_filteredCards.removeAt(index);
    } else {
        m_cards.removeAt(index);
    }
    endRemoveRows();

    emit countChanged();
    emit cardRemoved(index);
}

void CarouselCardModel::removeCardById(const QString& id)
{
    int index = findCardIndex(id);
    if (index >= 0) {
        removeCard(index);
    }
}

void CarouselCardModel::updateCard(int index, const QVariantMap &cardData)
{
    if (index < 0 || index >= rowCount()) {
        qWarning() << "updateCard: Invalid index" << index;
        return;
    }

    // 获取要更新的卡片（原始数据）
    CarouselCardData &card = m_isFiltered ? m_filteredCards[index] : m_cards[index];

    // 更新字段（仅更新传入的字段，保留未传字段的原值）
    if (cardData.contains("id")) {
        card.id = cardData.value("id").toString();
    }
    if (cardData.contains("title")) {
        card.title = cardData.value("title").toString();
    }
    if (cardData.contains("description")) {
        card.description = cardData.value("description").toString();
    }
    if (cardData.contains("content")) {
        card.content = cardData.value("content").toString();
    }
    if (cardData.contains("category")) {
        card.category = cardData.value("category").toString();
    }
    if (cardData.contains("imageUrl")) {
        card.imageUrl = QUrl(cardData.value("imageUrl").toString());
    }
    if (cardData.contains("iconName")) {
        card.iconName = cardData.value("iconName").toString();
    }
    if (cardData.contains("priority")) {
        card.priority = cardData.value("priority").toInt();
    }
    if (cardData.contains("isActive")) {
        card.isActive = cardData.value("isActive").toBool();
    }
    if (cardData.contains("metadata")) {
        card.metadata = cardData.value("metadata").toJsonObject();
    }
    if (cardData.contains("timestamp")) {
        const QVariant ts = cardData.value("timestamp");
        if (ts.canConvert<QDateTime>()) {
            card.timestamp = ts.toDateTime();
        }
    }

    // 如果处于过滤状态，同步更新原始数据
    if (m_isFiltered) {
        QString cardId = card.id;
        int originalIndex = findCardIndex(cardId);
        if (originalIndex >= 0 && originalIndex < m_cards.size()) {
            m_cards[originalIndex] = card;
        }
    }

    // 通知视图数据已变更
    QModelIndex modelIndex = createIndex(index, 0);
    emit dataChanged(modelIndex, modelIndex);
    emit cardUpdated(index);
}

void CarouselCardModel::clearCards()
{
    beginResetModel();
    m_cards.clear();
    m_filteredCards.clear();
    m_isFiltered = false;
    endResetModel();

    emit countChanged();
}

QVariantMap CarouselCardModel::getCard(int index) const
{
    if (index < 0 || index >= rowCount()) {
        return QVariantMap();
    }

    const CarouselCardData& card = m_isFiltered ? m_filteredCards.at(index) : m_cards.at(index);
    return cardDataToMap(card);
}

QVariantMap CarouselCardModel::getCardById(const QString& id) const
{
    for (const auto& card : m_cards) {
        if (card.id == id) {
            return cardDataToMap(card);
        }
    }
    return QVariantMap();
}

int CarouselCardModel::findCardIndex(const QString& id) const
{
    const auto& searchList = m_isFiltered ? m_filteredCards : m_cards;
    for (int i = 0; i < searchList.size(); ++i) {
        if (searchList.at(i).id == id) {
            return i;
        }
    }
    return -1;
}

QStringList CarouselCardModel::getCategories() const
{
    QStringList categories;
    for (const auto& card : m_cards) {
        if (!card.category.isEmpty() && !categories.contains(card.category)) {
            categories.append(card.category);
        }
    }
    categories.sort();
    return categories;
}

QJsonArray CarouselCardModel::toJsonArray() const
{
    QJsonArray jsonArray;
    for (const auto& card : m_cards) {
        QJsonObject cardObj;
        cardObj["id"] = card.id;
        cardObj["title"] = card.title;
        cardObj["description"] = card.description;
        cardObj["content"] = card.content;
        cardObj["timestamp"] = card.timestamp.toString(Qt::ISODate);
        cardObj["category"] = card.category;
        cardObj["imageUrl"] = card.imageUrl.toString();
        cardObj["iconName"] = card.iconName;
        cardObj["metadata"] = card.metadata;
        cardObj["priority"] = card.priority;
        cardObj["isActive"] = card.isActive;
        jsonArray.append(cardObj);
    }
    return jsonArray;
}

void CarouselCardModel::filterByCategory(const QString& category)
{
    beginResetModel();
    m_filteredCards.clear();

    if (category.isEmpty()) {
        m_isFiltered = false;
    } else {
        m_isFiltered = true;
        for (const auto& card : m_cards) {
            if (card.category == category) {
                m_filteredCards.append(card);
            }
        }
    }

    endResetModel();
    emit countChanged();
}

void CarouselCardModel::filterByActive(bool activeOnly)
{
    beginResetModel();
    m_filteredCards.clear();

    if (!activeOnly) {
        m_isFiltered = false;
    } else {
        m_isFiltered = true;
        for (const auto& card : m_cards) {
            if (card.isActive) {
                m_filteredCards.append(card);
            }
        }
    }

    endResetModel();
    emit countChanged();
}

void CarouselCardModel::sortByTimestamp(bool ascending)
{
    beginResetModel();

    auto& targetList = m_isFiltered ? m_filteredCards : m_cards;
    std::sort(targetList.begin(), targetList.end(), [ascending](const CarouselCardData& a, const CarouselCardData& b) {
        return ascending ? a.timestamp < b.timestamp : a.timestamp > b.timestamp;
    });

    endResetModel();
}

void CarouselCardModel::sortByPriority(bool ascending)
{
    beginResetModel();

    auto& targetList = m_isFiltered ? m_filteredCards : m_cards;
    std::sort(targetList.begin(), targetList.end(), [ascending](const CarouselCardData& a, const CarouselCardData& b) {
        return ascending ? a.priority < b.priority : a.priority > b.priority;
    });

    endResetModel();
}

void CarouselCardModel::resetFilter()
{
    if (m_isFiltered) {
        beginResetModel();
        m_isFiltered = false;
        m_filteredCards.clear();
        endResetModel();
        emit countChanged();
    }
}

bool CarouselCardModel::saveToJson(const QString &filePath) const
{
    QString dirPath = filePath + "/Notes";
    QDir dir(dirPath);
    if (!dir.exists()) {
        if (!dir.mkpath(".")) { // 或者 dir.mkpath(dirPath)
            qWarning() << "Failed to create directory:" << dirPath;
            return false;
        }
    }

    QString filePathFull = dirPath + "/notes_carousel_cards.json";
    QFile file(filePathFull);
    if (!file.open(QIODevice::WriteOnly)) {
        qWarning() << "Failed to open file for writing:" << file.errorString();
        return false;
    }
    QJsonArray jsonArray = toJsonArray();
    QJsonDocument jsonDoc(jsonArray);
    file.write(jsonDoc.toJson());
    file.close();
    return true;
}

void CarouselCardModel::loadFromFile(const QString &filePath)
{
    QString path = filePath + "/Notes/notes_carousel_cards.json";
    QFile file(path);
    if (!file.open(QIODevice::ReadOnly)) {
        // 文件不存在时仍设置为已加载状态，以允许后续保存
        m_isLoaded = true;
        emit loadedChanged();
        emit dataRefreshed();
        return;
    }
    QByteArray data = file.readAll();
    file.close();

    QJsonDocument jsonDoc = QJsonDocument::fromJson(data);
    if (jsonDoc.isArray()) {
        loadFromJson(jsonDoc.array());
    } else {
        // JSON格式不正确时仍设置为已加载状态，以允许后续保存
        m_isLoaded = true;
        emit loadedChanged();
        emit dataRefreshed();
    }
}

void CarouselCardModel::loadFromJson(const QJsonArray& jsonArray)
{
    beginResetModel();
    m_cards.clear();
    m_filteredCards.clear();
    m_isFiltered = false;

    for (const auto& value : jsonArray) {
        if (value.isObject()) {
            QJsonObject cardObj = value.toObject();
            CarouselCardData card;
            card.id = cardObj["id"].toString();
            card.title = cardObj["title"].toString();
            card.description = cardObj["description"].toString();
            card.content = cardObj["content"].toString();
            card.timestamp = QDateTime::fromString(cardObj["timestamp"].toString(), Qt::ISODate);
            card.category = cardObj["category"].toString();
            card.imageUrl = QUrl(cardObj["imageUrl"].toString());
            card.iconName = cardObj["iconName"].toString();
            card.metadata = cardObj["metadata"].toObject();
            card.priority = cardObj["priority"].toInt();
            card.isActive = cardObj["isActive"].toBool();
            m_cards.append(card);
        }
    }
    
    m_isLoaded = true;
    emit loadedChanged();

    endResetModel();
    emit countChanged();
    emit dataRefreshed();
}

void CarouselCardModel::loadSampleData()
{
    beginResetModel();
    m_cards.clear();
    m_filteredCards.clear();
    m_isFiltered = false;

    // 创建示例数据
    QList<CarouselCardData> sampleCards = {
        {"card1", "创意灵感", "记录突然涌现的创意想法", "今天在咖啡店里突然想到一个很棒的故事情节...", QDateTime::currentDateTime().addDays(-2), "创作", QUrl(), "lightbulb", QJsonObject(), 5, true},
        {"card2", "技术笔记", "学习新技术的心得体会", "Qt6的新特性真的很强大，特别是QML的性能提升...", QDateTime::currentDateTime().addDays(-1), "学习", QUrl(), "code", QJsonObject(), 4, true},
        {"card3", "生活感悟", "日常生活中的思考", "今天看到夕阳西下，突然明白了什么叫做岁月静好...", QDateTime::currentDateTime(), "生活", QUrl(), "heart", QJsonObject(), 3, true},
        {"card4", "项目规划", "下一个项目的构思", "考虑开发一个更智能的笔记应用，集成AI助手...", QDateTime::currentDateTime().addSecs(-3*3600), "工作", QUrl(), "project", QJsonObject(), 5, true},
        {"card5", "读书笔记", "最近阅读的书籍摘要", "《设计模式》这本书让我对软件架构有了新的理解...", QDateTime::currentDateTime().addSecs(-6*3600), "学习", QUrl(), "book", QJsonObject(), 4, true}
    };

    m_cards = sampleCards;
    endResetModel();

    emit countChanged();
    emit dataRefreshed();
}

void CarouselCardModel::refreshData()
{
    emit dataRefreshed();
}

void CarouselCardModel::resetLoadedState()
{
    m_isLoaded = false;
    emit loadedChanged();
}

void CarouselCardModel::setAutoRefresh(bool enabled)
{
    if (m_autoRefresh != enabled) {
        m_autoRefresh = enabled;

        if (enabled) {
            m_refreshTimer->start(m_refreshInterval);
        } else {
            m_refreshTimer->stop();
        }

        emit autoRefreshChanged();
    }
}

void CarouselCardModel::setRefreshInterval(int interval)
{
    if (m_refreshInterval != interval && interval > 0) {
        m_refreshInterval = interval;

        if (m_autoRefresh) {
            m_refreshTimer->stop();
            m_refreshTimer->start(m_refreshInterval);
        }

        emit refreshIntervalChanged();
    }
}

void CarouselCardModel::onRefreshTimer()
{
    refreshData();
}

void CarouselCardModel::applyCurrentFilter()
{
    // 重新应用当前的过滤条件
}

QString CarouselCardModel::formatTimestamp(const QDateTime& timestamp) const
{
    QDateTime now = QDateTime::currentDateTime();
    qint64 secondsAgo = timestamp.secsTo(now);

    if (secondsAgo < 60) {
        return tr("刚刚");
    } else if (secondsAgo < 3600) {
        return QString(tr("%1分钟前")).arg(secondsAgo / 60);
    } else if (secondsAgo < 86400) {
        return QString(tr("%1小时前")).arg(secondsAgo / 3600);
    } else if (secondsAgo < 604800) {
        return QString(tr("%1天前")).arg(secondsAgo / 86400);
    } else {
        return timestamp.toString("yyyy-MM-dd");
    }
}

QString CarouselCardModel::generateDisplayText(const CarouselCardData& card) const
{
    QString displayText = card.title;
    if (!card.category.isEmpty()) {
        displayText += QString(" [%1]").arg(card.category);
    }
    return displayText;
}
