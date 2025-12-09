#include "datamanager.h"
#include "graphmodel.h"
#include "aicontinuationmanager.h"
#include <QQmlEngine>
#include <QDebug>
#include <QTimer>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QFile>
#include <QFileInfo>
#include <QDir>
#include <QStandardPaths>
#include <QFileDialog>
#include <QApplication>
#include <QSettings>
#include <QDateTime>
#include <vector>
#include <functional>
#include <QTextStream>  // 用于文本流写入
#include <QStringConverter>

// 初始化静态成员变量
DataManager* DataManager::m_instance = nullptr;

DataManager::~DataManager()
{
    
}

DataManager::DataManager(QObject *parent) : QObject(parent)
{
    m_storyModel = new StoryModel(this);
    m_elementModel = new ElementModel(this);
    m_canvasManager = new CanvasManager(this);
    m_textOutlineModel = new TextOutlineModel(this);
    m_mindMapOutlineModel = new OutlineModel(this);
    m_aiContinuationManager = new AIContinuationManager(this);
    m_foreshadowingModel = new ForeshadowingModel(this);

    // 创建三个专门的代理模型实例
    m_characterModel = new ElementFilterProxyModel(ElementTypeWrapper::ElementType::Character,FilterMode::ByAcceptedIds, this);
    m_locationModel = new ElementFilterProxyModel(ElementTypeWrapper::ElementType::Location,FilterMode::ByAcceptedIds, this);
    m_itemModel = new ElementFilterProxyModel(ElementTypeWrapper::ElementType::Item,FilterMode::ByAcceptedIds, this);
    m_origanisationModel = new ElementFilterProxyModel(ElementTypeWrapper::ElementType::Organisation,FilterMode::ByAcceptedIds, this);
    m_eventModel = new ElementFilterProxyModel(ElementTypeWrapper::ElementType::Event,FilterMode::ByAcceptedIds, this);
    m_abilitiesModel = new ElementFilterProxyModel(ElementTypeWrapper::ElementType::Abilities,FilterMode::ByAcceptedIds, this);

    // 为它们设置同一个源
    m_characterModel->setSourceModel(m_elementModel);
    m_locationModel->setSourceModel(m_elementModel);
    m_itemModel->setSourceModel(m_elementModel);
    m_origanisationModel->setSourceModel(m_elementModel);
    m_eventModel->setSourceModel(m_elementModel);
    m_abilitiesModel->setSourceModel(m_elementModel);

    m_allCharacterModel = new ElementFilterProxyModel(ElementTypeWrapper::ElementType::Character,FilterMode::ShowAll, this);
    m_allLocationModel = new ElementFilterProxyModel(ElementTypeWrapper::ElementType::Location,FilterMode::ShowAll, this);
    m_allItemModel = new ElementFilterProxyModel(ElementTypeWrapper::ElementType::Item,FilterMode::ShowAll, this);
    m_allOriganisationModel = new ElementFilterProxyModel(ElementTypeWrapper::ElementType::Organisation,FilterMode::ShowAll, this);
    m_allEventModel = new ElementFilterProxyModel(ElementTypeWrapper::ElementType::Event,FilterMode::ShowAll, this);
    m_allAbilitiesModel = new ElementFilterProxyModel(ElementTypeWrapper::ElementType::Abilities,FilterMode::ShowAll, this);

    m_allCharacterModel->setSourceModel(m_elementModel);
    m_allLocationModel->setSourceModel(m_elementModel);
    m_allItemModel->setSourceModel(m_elementModel);
    m_allOriganisationModel->setSourceModel(m_elementModel);
    m_allEventModel->setSourceModel(m_elementModel);
    m_allAbilitiesModel->setSourceModel(m_elementModel);

    // 监听元素修改
    connect(m_elementModel, &ElementModel::elementModified, this, &DataManager::onElementModified);
    
    // 初始化自动保存定时器（30秒延迟）
    m_autoSaveTimer = new QTimer(this);
    m_autoSaveTimer->setSingleShot(true);
    m_autoSaveTimer->setInterval(30000);
    connect(m_autoSaveTimer, &QTimer::timeout, this, &DataManager::autoSave);
    
    // 监听数据变化以标记未保存状态
    connect(m_storyModel, &StoryModel::dataChanged, this, &DataManager::markProjectDirty);
    connect(m_elementModel, &ElementModel::elementModified, this, &DataManager::markProjectDirty);
    connect(m_canvasManager, &CanvasManager::canvasesChanged, this, &DataManager::markProjectDirty);
    
    QString configPath = QStandardPaths::writableLocation(QStandardPaths::AppConfigLocation);
    m_settingsFilePath = configPath + "/StoryScience/story_science_settings.json";
    QDir().mkpath(QFileInfo(m_settingsFilePath).absolutePath());
    // 加载所有设置
    loadAllSettings();
}

ElementFilterProxyModel* DataManager::characterModel() const { return m_characterModel; }
ElementFilterProxyModel* DataManager::locationModel() const { return m_locationModel; }
ElementFilterProxyModel* DataManager::itemModel() const { return m_itemModel; }
ElementFilterProxyModel *DataManager::origanisationModel() const{ return m_origanisationModel;}
ElementFilterProxyModel *DataManager::eventModel() const { return m_eventModel;}
ElementFilterProxyModel *DataManager::abilitiesModel() const{return m_abilitiesModel;}

ElementFilterProxyModel* DataManager::allCharacterModel() const { return m_allCharacterModel; }
ElementFilterProxyModel* DataManager::allLocationModel() const { return m_allLocationModel; }
ElementFilterProxyModel* DataManager::allItemModel() const { return m_allItemModel; }
ElementFilterProxyModel* DataManager::allOriganisationModel() const{return m_allOriganisationModel;}
ElementFilterProxyModel* DataManager::allEventModel() const{return m_allEventModel;}
ElementFilterProxyModel* DataManager::allAbilitiesModel() const{return m_allAbilitiesModel;}

CanvasManager* DataManager::canvasManager() const { return m_canvasManager; }
TextOutlineModel* DataManager::textOutlineModel() const{ return m_textOutlineModel; }
OutlineModel* DataManager::mindMapOutlineModel() const { return m_mindMapOutlineModel; }
QObject* DataManager::aiContinuationManager() const { return m_aiContinuationManager; }

DataManager* DataManager::instance()
{
    if (!m_instance) {
        m_instance = new DataManager();
    }
    return m_instance;
}

StoryModel* DataManager::storyModel() const {
    return m_storyModel;
}

ElementModel* DataManager::elementModel() const {
    return m_elementModel;
}

void DataManager::associateElementsWithCurrentStoryItem(const QStringList &elementIdStrings)
{
    if (!m_currentStoryIndex.isValid()) return;

    QList<QUuid> uuids;
    for (const QString &idStr : elementIdStrings) {
        uuids.append(QUuid(idStr));
    }

    if (!uuids.isEmpty()) {
        m_storyModel->associateElements(m_currentStoryIndex, uuids);
        // 刷新过滤器以显示新关联的元素
        selectStoryItem(m_currentStoryIndex);
    }
}

void DataManager::updateElementStatus(const QString &id, const QJsonObject &status)
{
    // qDebug() << "DataManager接收到更新元素状态请求:";
    // qDebug() << "元素ID:" << id;
    // qDebug() << "状态对象:" << QJsonDocument(status).toJson(QJsonDocument::Compact);
    
    m_elementModel->updateElementStatus(id, status);
    
    //qDebug() << "DataManager元素状态更新完成";
}

void DataManager::updateElementStatusAndAssociate(const QString &id, const QJsonObject &status)
{
    // 更新元素状态
    m_elementModel->updateElementStatus(id, status);
    
    // 如果有当前选中的故事项，则将元素关联到当前故事项
    if (m_currentStoryIndex.isValid()) {
        QUuid elementId(id);
        m_storyModel->associateElement(m_currentStoryIndex, elementId);
        
        // 刷新过滤器，确保UI更新
        selectStoryItem(m_currentStoryIndex);
    }
}

QVariantMap DataManager::getElementStatus(const QString &id)
{
    return m_elementModel->getByUuid(id);
}

Article* DataManager::currentArticle() const
{
    return m_currentArticle;
}

QModelIndex DataManager::currentStoryIndex() const
{
    return m_currentStoryIndex;
}

QVariantMap DataManager::articles() const
{
    QVariantMap articleMap;
    for (auto it = m_articles.begin(); it != m_articles.end(); ++it) {
        // 将Article对象注册到QML引擎，使其可以在QML中访问
        QQmlEngine::setObjectOwnership(it.value(), QQmlEngine::CppOwnership);
        articleMap.insert(it.key().toString(), QVariant::fromValue(it.value()));
    }
    return articleMap;
}

ForeshadowingModel *DataManager::foreshadowingModel() const { return m_foreshadowingModel; }

QString DataManager::prevChapterContent() const
{
    return m_prevChapterContent;
}

QString DataManager::getPrevSummary(const QModelIndex &index) const
{
    if(index.isValid()){
        QModelIndex parentIndex = m_storyModel->parent(index);
        if(parentIndex.isValid()){
            int rowCount = m_storyModel->rowCount(parentIndex);
            int currentRow = index.row();
            if(currentRow > 0){
                QModelIndex prevIndex = m_storyModel->index(currentRow -1, 0, parentIndex);
                return m_storyModel->data(prevIndex,StoryModel::ModelRoles::PrevSummaryRole).toString();
            }
        }
    }
    return QString();
}

void DataManager::setPreviousSummary(const QModelIndex &index, const QString &summary)
{
    if(index.isValid()){
        QModelIndex parentIndex = m_storyModel->parent(index);
        if(parentIndex.isValid()){
            int rowCount = m_storyModel->rowCount(parentIndex);
            int currentRow = index.row();
            if(currentRow > 0){
                QModelIndex prevIndex = m_storyModel->index(currentRow -1, 0, parentIndex);
                // 直接通过StoryItem设置，避免触发dataChanged信号导致UI跳转
                StoryItem* prevItem = static_cast<StoryItem*>(prevIndex.internalPointer());
                if (prevItem) {
                    prevItem->setPrevSummary(summary);
                }
            }
        }
    }
}

QString DataManager::getTitleOfPrevChapter(const QModelIndex &index) const
{
    if(index.isValid()){
        QModelIndex parentIndex = m_storyModel->parent(index);
        if(parentIndex.isValid()){
            int rowCount = m_storyModel->rowCount(parentIndex);
            int currentRow = index.row();
            if(currentRow > 0){
                QModelIndex prevIndex = m_storyModel->index(currentRow -1, 0, parentIndex);
                return m_storyModel->data(prevIndex,StoryModel::ModelRoles::TitleRole).toString();
            }
        }
    }
    return QString();
}
void DataManager::updatePrevChapterContent()
{
    QString newPrevChapterContent;
    
    if (m_currentStoryIndex.isValid()) {
        // 获取当前故事项的父节点（上一章）
        QModelIndex parentIndex = m_storyModel->parent(m_currentStoryIndex);
        if (parentIndex.isValid()) {
            // 获取父节点的所有子节点
            int rowCount = m_storyModel->rowCount(parentIndex);
            int currentRow = m_currentStoryIndex.row();
            
            // 如果当前不是第一个子节点，则获取前一个兄弟节点（上一章）
            if (currentRow > 0) {
                QModelIndex prevIndex = m_storyModel->index(currentRow - 1, 0, parentIndex);
                if (prevIndex.isValid()) {
                    // 获取上一章的文章内容
                    Article* prevArticle = getArticleForStoryItem(prevIndex);
                    if (prevArticle) {
                        newPrevChapterContent = prevArticle->content();
                    }
                }
            }
        }
    }
    
    // 只有当内容确实改变时才更新并发射信号
    if (m_prevChapterContent != newPrevChapterContent) {
        m_prevChapterContent = newPrevChapterContent;
        emit prevChapterContentChanged();
    }
}

QUuid DataManager::getCurrentBookId() const
{
    //qDebug() << "获取当前书籍ID，当前索引有效:" << m_currentStoryIndex.isValid();
    if (!m_currentStoryIndex.isValid()) {
        //qDebug() << "当前索引无效，返回空ID";
        return QUuid(); // 无效ID
    }
    
    // 获取当前选中的故事项
    StoryItem* currentItem = static_cast<StoryItem*>(m_currentStoryIndex.internalPointer());
    //qDebug() << "当前项指针:" << currentItem;
    if (!currentItem) {
        qDebug() << "当前项为空，返回空ID";
        return QUuid();
    }
    // 向上遍历直到根节点，找到第一个直接子节点（书籍）
    StoryItem* bookItem = currentItem;
    int level = 0;
    while (bookItem && bookItem->parentItem() != m_storyModel->getRootItem() && level < 10) {
        //qDebug() << "向上遍历 level" << level << "当前项ID:" << bookItem->id().toString();
        bookItem = bookItem->parentItem();
        level++;
    }
    //qDebug() << "找到书籍项:" << (bookItem ? bookItem->id().toString() : "null");
    return bookItem ? bookItem->id() : QUuid();
}

Article* DataManager::createArticleForCurrentStoryItem()
{
    if (!m_currentStoryIndex.isValid()) return nullptr;

    StoryItem* item = static_cast<StoryItem*>(m_currentStoryIndex.internalPointer());
    if (!item) {
        return nullptr;
    }

    // 检查是否已经有关联的文章
    if (!item->getArticleId().isNull()) {
        // 如果已经有关联文章，直接返回已有的文章
        if (m_articles.contains(item->getArticleId())) {
            m_currentArticle = m_articles.value(item->getArticleId());
            emit currentArticleChanged();
            return m_currentArticle;
        }
    }

    // 1. 创建新文章，使用故事项的标题作为默认标题
    auto* newArticle = new Article(this);

    // 获取故事项的标题作为文章标题
    QString storyTitle = m_storyModel->data(m_currentStoryIndex, Qt::DisplayRole).toString();
    newArticle->setTitle(storyTitle.isEmpty() ? tr("新章节") : storyTitle);

    QUuid newId = newArticle->id();

    // 2. 存入文章池
    m_articles.insert(newId, newArticle);

    // 3. 关联到 StoryItem
    m_storyModel->setArticleIdForItem(m_currentStoryIndex, newId);

    // 4. 更新当前文章并发出信号
    m_currentArticle = newArticle;
    emit currentArticleChanged();

    return newArticle;
}

void DataManager::selectStoryItem(const QModelIndex &index)
{
    // 更新当前索引
    if (m_currentStoryIndex != index) {
        m_currentStoryIndex = index;
        emit currentStoryIndexChanged();
        
        // 当currentStoryIndex改变时，更新prevChapterContent
        updatePrevChapterContent();
    }

    Article* selectedArticle = nullptr;
    QList<QUuid> ids;

    if (index.isValid()) {
        if (auto* item = static_cast<StoryItem*>(index.internalPointer())) {
            ids = item->getElementIds();
            QUuid articleId = item->getArticleId();
            if (!articleId.isNull()) {
                if (!m_articles.contains(articleId)) {
                    // 如果文章不存在，创建一个并同步标题
                    auto* newArticle = new Article(articleId, "", this);
                    newArticle->setTitle(item->title());
                    m_articles.insert(articleId, newArticle);
                }
                selectedArticle = m_articles.value(articleId);
            }
        }
    }

    // 更新当前文章
    if (m_currentArticle != selectedArticle) {
        m_currentArticle = selectedArticle;
        emit currentArticleChanged();
    }

    // 更新元素过滤器 (逻辑不变)
    m_characterModel->setAcceptedIds(ids);
    m_locationModel->setAcceptedIds(ids);
    m_itemModel->setAcceptedIds(ids);
    m_origanisationModel->setAcceptedIds(ids);
    m_eventModel->setAcceptedIds(ids);
    m_abilitiesModel->setAcceptedIds(ids);
}

void DataManager::createElementForCurrentStoryItem(ElementTypeWrapper::ElementType type,const QString &title,
                                                   const QString &description,
                                                   const QColor &color,
                                                   const QString &icon,
                                                   const QStringList &tags)
{
    // 检查是否有选中的故事项
    if (!m_currentStoryIndex.isValid()) {
        // 如果没有选中项，可以选择创建一个"未分类"的元素，或者直接返回
        // 这里我们选择直接在 ElementModel 中创建，但不做任何关联
        m_elementModel->addElement(type,title, description, color, icon, tags);
        return;
    }

    // 在 ElementModel 中创建新元素并获取其ID
    QUuid newElementId = m_elementModel->addElement(type, title, description, color, icon, tags);
    // 将新元素的ID关联到当前选中的故事项
    m_storyModel->associateElement(m_currentStoryIndex, newElementId);

    // 刷新过滤器，让新创建的元素立即显示在右侧面板
    // 重新调用 selectStoryItem 会使用更新后的ID列表来设置正则表达式
    selectStoryItem(m_currentStoryIndex);
}

void DataManager::createElementForCurrentStoryItemWithStatus(ElementTypeWrapper::ElementType type,const QString &title,
                                                   const QString &description,
                                                   const QColor &color,
                                                   const QString &icon,
                                                   const QStringList &tags,
                                                   const QJsonObject &status)
{
    // 检查是否有选中的故事项
    if (!m_currentStoryIndex.isValid()) {
        // 如果没有选中项，创建元素但不关联到任何故事项
        QUuid newElementId = m_elementModel->addElement(type, title, description, color, icon, tags);
        // 更新元素状态
        m_elementModel->updateElementStatus(newElementId.toString(), status);
        return;
    }

    // 在 ElementModel 中创建新元素并获取其ID
    QUuid newElementId = m_elementModel->addElement(type, title, description, color, icon, tags);
    // 更新元素状态
    m_elementModel->updateElementStatus(newElementId.toString(), status);
    // 将新元素的ID关联到当前选中的故事项
    m_storyModel->associateElement(m_currentStoryIndex, newElementId);

    // 刷新过滤器，让新创建的元素立即显示在右侧面板
    selectStoryItem(m_currentStoryIndex);
}

void DataManager::createStoryItem(const QModelIndex &parent,
                                  StoryTypeWrapper::StoryType type,
                                  const QString &title,
                                  const QStringList &elementIdStrings)
{
    QList<QUuid> uuids;
    for (const QString &idStr : elementIdStrings) {
        uuids.append(QUuid(idStr));
    }
    // 调用 StoryModel 中增强后的 insertItem
    m_storyModel->insertItem(parent, -1, type, title, uuids);
}

//已经被弃用
void DataManager::createStoryItem(const QModelIndex &parent,
                                  StoryTypeWrapper::StoryType type,
                                  const QString &title)
{
    createStoryItem(parent, type, title, QStringList());
}

void DataManager::createStoryItemWithArticle(const QModelIndex &parent,
                                             StoryTypeWrapper::StoryType type,
                                             const QString &title)
{
    // 1. 创建故事项并获取索引
    QModelIndex newItemIndex = m_storyModel->insertItemAndGetIndex(parent, -1, type, title, QList<QUuid>());


        if (newItemIndex.isValid()) {
            // 选中新创建的项
            selectStoryItem(newItemIndex);
            // 创建文章
            createArticleForCurrentStoryItem();
        }

}

void DataManager::removeAssociationFromCurrentStoryItem(const QString &idStr)
{
    if (!m_currentStoryIndex.isValid()) return;

    QUuid id(idStr);
    if (m_storyModel->disassociateElement(m_currentStoryIndex, id)) {
        // 重新应用过滤：让右侧所有元素类型的代理模型立刻刷新
        selectStoryItem(m_currentStoryIndex);
    }
}

void DataManager::deleteElementEverywhere(const QString &idStr)
{
    QUuid id(idStr);

    // 先从所有 StoryItem 中清理该元素的关联
    m_storyModel->purgeElementFromAllItems(id);
    // 从全局 ElementModel 中删除元素实体
    m_elementModel->removeById(idStr);
    // 刷新当前过滤器
    if (m_currentStoryIndex.isValid())
        selectStoryItem(m_currentStoryIndex);
}

bool DataManager::removeStoryItem(const QModelIndex &index)
{
    if (!index.isValid()) return false;

    StoryItem* item = static_cast<StoryItem*>(index.internalPointer());
    if (!item) return false;

    // 递归删除所有子项及其关联的文章
    for (int i = item->childCount() - 1; i >= 0; --i) {
        QModelIndex childIndex = m_storyModel->index(i, 0, index);
        removeStoryItem(childIndex);
    }

    QUuid articleId = item->getArticleId();
    bool result = m_storyModel->removeItem(index);
    
    // 如果删除成功且有关联的文章，则从文章池中删除对应的文章
    if (result && !articleId.isNull() && m_articles.contains(articleId)) {
        Article* article = m_articles.take(articleId);
        delete article;
        
        // 如果删除的是当前文章，更新当前文章指针
        if (m_currentArticle && m_currentArticle->id() == articleId) {
            m_currentArticle = nullptr;
            emit currentArticleChanged();
        }
    }
    
    return result;
}

void DataManager::onElementModified(const QUuid &id, ElementTypeWrapper::ElementType type)
{
    // 只刷新相关类型的代理模型，使用更精确的刷新
    switch (type) {
    case ElementTypeWrapper::ElementType::Character:
        m_characterModel->refreshElement(id);
        m_allCharacterModel->refreshElement(id);
        break;
    case ElementTypeWrapper::ElementType::Location:
        m_locationModel->refreshElement(id);
        m_allLocationModel->refreshElement(id);
        break;
    case ElementTypeWrapper::ElementType::Item:
        m_itemModel->refreshElement(id);
        m_allItemModel->refreshElement(id);
        break;
    case ElementTypeWrapper::ElementType::Organisation:
        m_origanisationModel->refreshElement(id);
        m_allOriganisationModel->refreshElement(id);
        break;
    case ElementTypeWrapper::ElementType::Event:
        m_eventModel->refreshElement(id);
        m_allEventModel->refreshElement(id);
        break;
    case ElementTypeWrapper::ElementType::Abilities:
        m_abilitiesModel->refreshElement(id);
        m_allAbilitiesModel->refreshElement(id);
        break;
    }
}

void DataManager::updateCurrentStoryItemTitle(const QString &newTitle)
{
    if (!m_currentStoryIndex.isValid()) return;
    
    // 1. 更新StoryItem的标题
    m_storyModel->setData(m_currentStoryIndex, newTitle, StoryModel::TitleRole);
    
    // 2. 同步更新关联的Article的标题
    if (m_currentArticle) {
        m_currentArticle->setTitle(newTitle);
    }
    
    // 3. 多重强制刷新TreeView以立即显示标题变化
    // 首先发送dataChanged信号
    m_storyModel->dataChanged(m_currentStoryIndex, m_currentStoryIndex, {StoryModel::DisplayRole, StoryModel::TitleRole});
    
    // 然后强制刷新整个模型布局
    QTimer::singleShot(10, [this]() {
        m_storyModel->forceRefresh();
    });
}

void DataManager::forceRefreshTreeView()
{
    // 强制刷新TreeView的多种方法
    
    // 方法1：发送dataChanged信号
    if (m_currentStoryIndex.isValid()) {
        m_storyModel->dataChanged(m_currentStoryIndex, m_currentStoryIndex, {StoryModel::DisplayRole, StoryModel::TitleRole});
    }
    
    // 方法2：强制刷新整个模型
    m_storyModel->forceRefresh();
}

// =============================================================================
// 数据持久化实现
// =============================================================================

bool DataManager::saveProject(const QString& filePath)
{
    QJsonObject projectObj = serializeProject();
    
    QJsonDocument doc(projectObj);
    QFile file(filePath);
    
    if (!file.open(QIODevice::WriteOnly)) {
        qDebug() << "无法打开文件进行写入:" << filePath << "错误:" << file.errorString();
        return false;
    }
    
    QByteArray jsonData = doc.toJson();
    qint64 bytesWritten = file.write(jsonData);
    file.close();
    
    if (bytesWritten != jsonData.size()) {
        qDebug() << "文件写入不完整";
        return false;
    }
    
    m_currentProjectPath = filePath;
    setUnsavedChanges(false);
    
    // 更新lastOpenedFile设置
    saveSetting("lastOpenedFile", filePath);
    
    emit projectSaved(filePath);
    return true;
}

bool DataManager::loadProject(const QString& filePath)
{
    //qDebug()<<"项目:{"<<filePath<<"}";
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << "无法加载项目文件:" << filePath;
        return false;
    }
    
    QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
    file.close();
    
    if (doc.isNull() || !doc.isObject()) {
        qDebug() << "项目文件格式错误:" << filePath;
        return false;
    }
    
    if (!deserializeProject(doc.object())) {
        qDebug() << "项目数据反序列化失败";
        return false;
    }
    
    m_currentProjectPath = filePath;
    setUnsavedChanges(false);
    
    // 更新lastOpenedFile设置
    saveSetting("lastOpenedFile", filePath);
    
    emit projectLoaded(filePath);
    return true;
}

bool DataManager::autoSave()
{
    if (!m_currentProjectPath.isEmpty() && m_hasUnsavedChanges) {
        return saveProject(m_currentProjectPath);
    }
    return false;
}

QString DataManager::currentProjectPath() const
{
    return m_currentProjectPath;
}

bool DataManager::hasUnsavedChanges() const
{
    return m_hasUnsavedChanges;
}

bool DataManager::exportCurrentArticle(const ArticleEpType &type) const
{
    // 安全检查
    if (!m_currentArticle) {
        qWarning() << "尝试导出文章，但没有设置当前文章 (m_currentArticle is null)。";
        return false;
    }

    // 准备文件对话框的参数
    QString dialogTitle;
    QString fileFilter;
    QString defaultSuffix;

    switch (type) {
    case ArticleEpType::TxT:
        dialogTitle = tr("导出为 TXT");
        fileFilter = tr("纯文本文档 (*.txt)");
        defaultSuffix = ".txt";
        break;
    case ArticleEpType::MD:
        dialogTitle = tr("导出为 Markdown");
        fileFilter = tr("Markdown 文档 (*.md)");
        defaultSuffix = ".md";
        break;
    default:
        qWarning() << "不支持的导出类型。";
        return false;
    }

    // 弹出文件保存对话框
    QString filePath = QFileDialog::getSaveFileName(
        nullptr,
        dialogTitle,
        m_currentArticle->title(),
        fileFilter
        );

    // 检查用户是否取消了操作
    if (filePath.isEmpty()) {
        qDebug() << "用户取消了导出操作。";
        return false;
    }

    if (!filePath.endsWith(defaultSuffix, Qt::CaseInsensitive)) {
        filePath += defaultSuffix;
    }

    // 准备写入文件
    QFile file(filePath);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qWarning() << "无法打开文件进行写入:" << filePath << "错误:" << file.errorString();
        return false;
    }

    // 使用 QTextStream 写入内容
    QTextStream out(&file);

    out.setEncoding(QStringConverter::Utf8);
    // -----------------------

    out << m_currentArticle->title() << "\n\n";
    out << m_currentArticle->content();

    //qDebug() << "文章 '" << m_currentArticle->title() << "' 成功导出到" << filePath;

    return true;
}

void DataManager::markProjectDirty()
{
    if (!m_hasUnsavedChanges) {
        setUnsavedChanges(true);
        // 启动延迟自动保存
        if (!m_currentProjectPath.isEmpty()) {
            m_autoSaveTimer->start();
        }
    }
}

void DataManager::setUnsavedChanges(bool hasChanges)
{
    if (m_hasUnsavedChanges != hasChanges) {
        m_hasUnsavedChanges = hasChanges;
        emit unsavedChangesChanged(hasChanges);
    }

}

void DataManager::createNewProject()
{
    // 清空故事模型
    m_storyModel->clearAllItems();
    
    // 清空元素模型
    m_elementModel->clearAllElements();
    
    // 清空文章池
    qDeleteAll(m_articles);
    m_articles.clear();
    
    // 清空图谱模型
    m_canvasManager->clearAllCanvases();
    
    // 清空大纲模型
    m_textOutlineModel->setContent("");
    m_mindMapOutlineModel->loadFromJson(QJsonObject()); // 传入空对象来清空
    
    // 清空书籍大纲和世界观数据
    m_bookOutlines.clear();
    m_bookWorldbuildings.clear();
    
    // 重置当前选中项
    m_currentStoryIndex = QModelIndex();
    m_currentArticle = nullptr;
    emit currentArticleChanged();
    emit currentStoryIndexChanged();
    
    // 清空项目路径
    m_currentProjectPath.clear();
    
    // 清空前一章内容
    if (!m_prevChapterContent.isEmpty()) {
        m_prevChapterContent.clear();
        emit prevChapterContentChanged();
    }
    
    // 重置未保存状态
    setUnsavedChanges(false);
}

void DataManager::createTestData()
{
    // 创建一些测试元素
    QUuid charId = m_elementModel->addElement(
        ElementTypeWrapper::ElementType::Character,
        tr("主角"),
        tr("故事的主要人物"),
        QColor("#FF6B6B"),
        "qrc:/icons/user.png",
        QStringList() << tr("主角") << tr("英雄")
    );
    
    QUuid locId = m_elementModel->addElement(
        ElementTypeWrapper::ElementType::Location,
        tr("魔法世界"),
        tr("一个充满奇幻的世界"),
        QColor("#4ECDC4"),
        "qrc:/icons/place.png",
        QStringList() << tr("奇幻") << tr("魔法")
    );
    
    // 创建一个测试故事项
    QModelIndex rootIndex = QModelIndex(); // 根节点
    
    createStoryItemWithArticle(
        rootIndex,
        StoryTypeWrapper::StoryType::Book,
        tr("测试小说")
    );
}

// =============================================================================
// 序列化方法
// =============================================================================

QJsonObject DataManager::serializeProject() const
{
    QJsonObject project;
    
    // 序列化故事结构
    project["story_structure"] = serializeStoryStructure();
    
    // 序列化文章
    project["articles"] = serializeArticles();
    
    // 序列化元素
    project["elements"] = serializeElements();
    
    // 序列化关联关系
    project["associations"] = serializeAssociations();
    
    // 序列化图谱数据
    project["canvases"] = serializeCanvases();
    
    // 序列化文本大纲数据
    project["text_outline"] = serializeTextOutlineModel();
    
    // 序列化思维导图大纲数据
    project["mindmap_outline"] = serializeMindMapOutlineModel();
    
    // 序列化伏笔
    project["foreshadowing"] = m_foreshadowingModel->serialize();
    // 序列化书籍世界观
    QJsonObject bookWorldbuildings;
    for (auto it = m_bookWorldbuildings.begin(); it != m_bookWorldbuildings.end(); ++it) {
        bookWorldbuildings[it.key().toString()] = it.value();
    }
    project["book_worldbuildings"] = bookWorldbuildings;
    
    //project["prevSummary"] = m_prevSummary;

    return project;
}

QJsonObject DataManager::serializeStoryStructure() const
{
    QJsonObject structure;
    QJsonArray items;
    
    // 递归序列化故事树
    std::function<void(const QModelIndex&)> serializeItem = [&](const QModelIndex& index) {
        if (!index.isValid()) {
            // 序列化根节点的子节点
            int childCount = m_storyModel->rowCount(index);
            for (int i = 0; i < childCount; ++i) {
                QModelIndex childIndex = m_storyModel->index(i, 0, index);
                serializeItem(childIndex);
            }
            return;
        }
        
        auto itemData = m_storyModel->getItemData(index);
        if (!itemData.value("valid").toBool()) return;
        
        QJsonObject item;
        
        // 基本信息
        if (auto* storyItem = static_cast<StoryItem*>(index.internalPointer())) {
            item["id"] = storyItem->id().toString();
            item["type"] = static_cast<int>(itemData.value("type").value<StoryTypeWrapper::StoryType>());
            item["title"] = itemData.value("title").toString();
            
            // 父节点ID
            QModelIndex parentIndex = m_storyModel->parent(index);
            if (parentIndex.isValid()) {
                if (auto* parentItem = static_cast<StoryItem*>(parentIndex.internalPointer())) {
                    item["parent_id"] = parentItem->id().toString();
                }
            } else {
                item["parent_id"] = QJsonValue::Null;
            }
            
            // 文章ID
            QUuid articleId = storyItem->getArticleId();
            if (!articleId.isNull()) {
                item["article_id"] = articleId.toString();
            } else {
                item["article_id"] = QJsonValue::Null;
            }
            
            // 子节点ID列表
            QJsonArray children;
            int childCount = m_storyModel->rowCount(index);
            for (int i = 0; i < childCount; ++i) {
                QModelIndex childIndex = m_storyModel->index(i, 0, index);
                if (auto* childItem = static_cast<StoryItem*>(childIndex.internalPointer())) {
                    children.append(childItem->id().toString());
                }
            }
            item["children"] = children;

            QString prevSummary = storyItem->getPrevSummary();
            item["prev_summary"] = prevSummary;
        }
        
        items.append(item);
        
        // 递归处理子节点
        int childCount = m_storyModel->rowCount(index);
        for (int i = 0; i < childCount; ++i) {
            QModelIndex childIndex = m_storyModel->index(i, 0, index);
            serializeItem(childIndex);
        }
    };
    
    serializeItem(QModelIndex()); // 从根节点开始
    
    structure["items"] = items;
    return structure;
}

QJsonObject DataManager::serializeArticles() const
{
    QJsonObject articles;
    
    for (auto it = m_articles.begin(); it != m_articles.end(); ++it) {
        const Article* article = it.value();
        if (!article) continue;
        
        QJsonObject articleObj;
        articleObj["id"] = article->id().toString();
        articleObj["title"] = article->title();
        articleObj["content"] = article->content();
        articleObj["word_count"] = article->wordCount();
        
        articles[article->id().toString()] = articleObj;
    }
    
    return articles;
}

QJsonObject DataManager::serializeElements() const
{
    return m_elementModel->serializeElements();
}

QJsonObject DataManager::serializeAssociations() const
{
    QJsonObject associations;
    
    // 递归遍历所有 StoryItem，导出关联关系
    std::function<void(const QModelIndex&)> collectAssociations = [&](const QModelIndex& index) {
        if (index.isValid()) {
            if (auto* storyItem = static_cast<StoryItem*>(index.internalPointer())) {
                const QList<QUuid>& elementIds = storyItem->getElementIds();
                if (!elementIds.isEmpty()) {
                    QJsonArray elementArray;
                    for (const QUuid& id : elementIds) {
                        elementArray.append(id.toString());
                    }
                    associations[storyItem->id().toString()] = elementArray;
                }
            }
        }
        
        // 递归处理子节点
        int childCount = m_storyModel->rowCount(index);
        for (int i = 0; i < childCount; ++i) {
            QModelIndex childIndex = m_storyModel->index(i, 0, index);
            collectAssociations(childIndex);
        }
    };
    
    collectAssociations(QModelIndex());
    
    return associations;
}

QJsonObject DataManager::serializeCanvases() const
{
    QJsonObject canvasesObj;
    QJsonArray canvasesArray;
    
    // 遍历所有画布并序列化
    for (int i = 0; i < m_canvasManager->canvases().size(); ++i) {
        QJsonObject canvasObj;
        
        // 从CanvasManager获取画布信息（QVariantMap格式）
        QVariant canvasVariant = m_canvasManager->canvases().at(i);
        QVariantMap canvasMap = canvasVariant.toMap();
        
        QString id = canvasMap["id"].toString();
        QString name = canvasMap["name"].toString();
        
        GraphModel* graphModel = m_canvasManager->getCanvasGraphModel(i);
        
        canvasObj["id"] = id;
        canvasObj["name"] = name;
        if (graphModel) {
            canvasObj["graphData"] = graphModel->saveToJson();
        }
        
        canvasesArray.append(canvasObj);
    }
    
    canvasesObj["canvases"] = canvasesArray;
    canvasesObj["currentCanvasIndex"] = m_canvasManager->currentCanvasIndex();
    
    return canvasesObj;
}

QJsonObject DataManager::serializeTextOutlineModel() const
{
    QJsonObject textOutlineObj;
    textOutlineObj["content"] = m_textOutlineModel->saveToText();
    return textOutlineObj;
}

QJsonObject DataManager::serializeMindMapOutlineModel() const
{
    QJsonObject mindMapOutlineObj;
    mindMapOutlineObj["data"] = m_mindMapOutlineModel->saveToJson();
    return mindMapOutlineObj;
}

// =============================================================================
// 反序列化方法 (基础框架)
// =============================================================================

bool DataManager::deserializeProject(const QJsonObject& obj)
{
    // 清空现有数据
    m_storyModel->clearAllItems();
    m_elementModel->clearAllElements();
    m_canvasManager->clearAllCanvases();
    m_bookOutlines.clear();
    m_bookMindMapOutlines.clear();
    m_bookWorldbuildings.clear();
    // 清空文章数据
    qDeleteAll(m_articles);
    m_articles.clear();
    
    // 加载故事结构
    if (obj.contains("story_structure")) {
        if (!deserializeStoryStructure(obj["story_structure"].toObject())) {
            return false;
        }
    }
    
    // 加载文章
    if (obj.contains("articles")) {
        if (!deserializeArticles(obj["articles"].toObject())) {
            return false;
        }
    }
    
    // 加载元素
    if (obj.contains("elements")) {
        if (!deserializeElements(obj["elements"].toObject())) {
            return false;
        }
    }
    
    // 加载关联关系
    if (obj.contains("associations")) {
        if (!deserializeAssociations(obj["associations"].toObject())) {
            return false;
        }
    }
    
    // 加载图谱数据
    if (obj.contains("canvases")) {
        if (!deserializeCanvases(obj["canvases"].toObject())) {
            return false;
        }
    }
    
    // 加载文本大纲数据
    if (obj.contains("text_outline")) {
        if (!deserializeTextOutlineModel(obj["text_outline"].toObject())) {
            return false;
        }
    }
    
    // 加载思维导图大纲数据
    if (obj.contains("mindmap_outline")) {
        if (!deserializeMindMapOutlineModel(obj["mindmap_outline"].toObject())) {
            return false;
        }
    }
    
    // 加载书籍世界观
    if (obj.contains("book_worldbuildings")) {
        QJsonObject bookWorldbuildingsObj = obj["book_worldbuildings"].toObject();
        for (auto it = bookWorldbuildingsObj.begin(); it != bookWorldbuildingsObj.end(); ++it) {
            m_bookWorldbuildings[QUuid(it.key())] = it.value().toString();
        }
    }
    
    if (obj.contains("foreshadowing")) {
        m_foreshadowingModel->deserialize(obj["foreshadowing"].toArray());
    }

    // if(obj.contains("prevSummary")) {
    //     m_prevSummary = obj["prevSummary"].toString();
    //     emit prevSummaryChanged();
    // }

    //必须调用次方法，否则无法刷新显示左边栏视图
    m_storyModel->resetModel();
    
    // 项目加载完成后，更新prevChapterContent
    updatePrevChapterContent();
    
    return true;
}

bool DataManager::deserializeStoryStructure(const QJsonObject& obj)
{
    // 清空现有的故事结构
    m_storyModel->clearAllItems();

    const QJsonArray items = obj["items"].toArray();
    if (items.isEmpty()) {
        return true; // 空项目也是有效的
    }

    // 保存 item 顺序的容器
    QVector<QJsonObject> itemList;
    QHash<QString, StoryItem*> itemMap;
    std::vector<std::unique_ptr<StoryItem>> allItems;

    // 第一步：先把所有节点建好（顺序和 JSON 一样）
    for (const QJsonValue& value : items) {
        const QJsonObject itemObj = value.toObject();
        QString itemId = itemObj["id"].toString();

        ItemData data;
        data.id = QUuid(itemId);
        data.type = static_cast<StoryTypeWrapper::StoryType>(itemObj["type"].toInt());
        data.title = itemObj["title"].toString();
        data.prevSummary = itemObj["prev_summary"].toString();  // 修复键名错误
        if (!itemObj["article_id"].isNull()) {
            data.articleId = QUuid(itemObj["article_id"].toString());
        }

        auto item = std::make_unique<StoryItem>(data, nullptr);
        StoryItem* itemPtr = item.get();

        itemMap[itemId] = itemPtr;
        allItems.push_back(std::move(item));
        itemList.append(itemObj); // 保留 JSON 顺序
    }

    // 第二步：按照顺序构建层次结构
    for (const QJsonObject& itemObj : itemList) {
        QString itemId = itemObj["id"].toString();
        QString parentId = itemObj["parent_id"].toString();

        StoryItem* item = itemMap[itemId];
        if (parentId.isEmpty()) {
            // 顶级节点
            item->m_parentItem = m_storyModel->getRootItem();

            // 从 allItems 移动到根节点
            for (auto it = allItems.begin(); it != allItems.end(); ++it) {
                if (it->get() == item) {
                    m_storyModel->getRootItem()->m_childItems.push_back(std::move(*it));
                    allItems.erase(it);
                    break;
                }
            }
        } else {
            // 子节点，找到父节点
            if (itemMap.contains(parentId)) {
                StoryItem* parent = itemMap[parentId];
                item->m_parentItem = parent;

                // 从 allItems 移动到父节点
                for (auto it = allItems.begin(); it != allItems.end(); ++it) {
                    if (it->get() == item) {
                        parent->m_childItems.push_back(std::move(*it));
                        allItems.erase(it);
                        break;
                    }
                }
            }
        }
    }

    return true;
}

bool DataManager::deserializeArticles(const QJsonObject& obj)
{
    // 清空现有文章
    qDeleteAll(m_articles);
    m_articles.clear();
    
    // 加载文章数据
    for (auto it = obj.begin(); it != obj.end(); ++it) {
        const QJsonObject articleObj = it.value().toObject();
        
        QUuid articleId = QUuid(articleObj["id"].toString());
        QString title = articleObj["title"].toString();
        QString content = articleObj["content"].toString();
        
        auto* article = new Article(articleId, content, this);
        article->setTitle(title);
        
        m_articles.insert(articleId, article);
    }
    
    return true;
}

bool DataManager::deserializeElements(const QJsonObject& obj)
{
    return m_elementModel->loadElementsFromJson(obj);
}

bool DataManager::deserializeAssociations(const QJsonObject& obj)
{
    // 为每个故事项恢复元素关联
    for (auto it = obj.begin(); it != obj.end(); ++it) {
        QString storyItemId = it.key();
        const QJsonArray elementArray = it.value().toArray();
        
        // 找到对应的StoryItem
        std::function<StoryItem*(StoryItem*, const QString&)> findItem = 
            [&](StoryItem* root, const QString& id) -> StoryItem* {
            if (root->id().toString() == id) {
                return root;
            }
            for (auto& childPtr : root->m_childItems) {
                if (auto* found = findItem(childPtr.get(), id)) {
                    return found;
                }
            }
            return nullptr;
        };
        
        StoryItem* item = findItem(m_storyModel->getRootItem(), storyItemId);
        if (item) {
            // 清空现有关联并加载新关联
            item->m_itemData.elementIds.clear();
            
            for (const QJsonValue& value : elementArray) {
                QUuid elementId = QUuid(value.toString());
                item->m_itemData.elementIds.append(elementId);
            }
        }
    }
    
    return true;
}

// =============================================================================
// 图谱数据序列化和反序列化
// =============================================================================

bool DataManager::deserializeCanvases(const QJsonObject& obj)
{
    if (!obj.contains("canvases")) {
        return true; // 没有画布数据也是有效的
    }
    
    // 清空现有画布
    m_canvasManager->clearAllCanvases();
    
    QJsonArray canvasesArray = obj["canvases"].toArray();
    
    // 创建画布并加载数据
    for (const auto &canvasValue : canvasesArray) {
        QJsonObject canvasObj = canvasValue.toObject();
        
        QString name = canvasObj["name"].toString();
        QString id = canvasObj["id"].toString();
        QJsonObject graphData = canvasObj["graphData"].toObject();
        
        m_canvasManager->createCanvasFromData(QUuid(id), name, graphData);
    }
    
    // 设置当前画布索引
    int currentIndex = obj["currentCanvasIndex"].toInt(0);
    m_canvasManager->switchToCanvas(currentIndex);
    
    return true;
}

bool DataManager::deserializeTextOutlineModel(const QJsonObject& obj)
{
    if (obj.contains("content") && obj["content"].isString()) {
        m_textOutlineModel->loadFromText(obj["content"].toString());
    }
    return true;
}

bool DataManager::deserializeMindMapOutlineModel(const QJsonObject& obj)
{
    if (obj.contains("data") && obj["data"].isObject()) {
        m_mindMapOutlineModel->loadFromJson(obj["data"].toObject());
    }
    return true;
}

// =============================================================================
// 设置管理功能
// =============================================================================

QVariantMap DataManager::getDefaultSettings()
{
    QVariantMap defaultSettings;
    
    // 界面设置
    defaultSettings["autoSaveEnabled"] = true;
    defaultSettings["autoSaveInterval"] = 30;
    defaultSettings["darkThemeEnabled"] = false;
    defaultSettings["fontSize"] = 16;
    defaultSettings["enableSyntaxHighlight"] = true;
    defaultSettings["defaultFileLocation"] = "";
    defaultSettings["language"] = "zh";
    defaultSettings["firstRun"] = true;
    
    // AI设置
    defaultSettings["aiProvider"] = "DeepSeek";
    defaultSettings["aiApiUrl"] = "https://api.deepseek.com/v1/chat/completions";
    defaultSettings["aiApiKey"] = "";
    defaultSettings["aiModelName"] = "deepseek-chat";
    defaultSettings["aiSystemPrompt"] = "你是一名专业的网络小说续写助手，熟悉起点、晋江等网文平台的写作风格。请根据用户提供的上下文和提示进行续写，要求：1. 保持原有剧情设定和人物性格，不要偏离故事走向。2. 语言要生动流畅，符合网文的阅读习惯，注意节奏感。3. 增强人物的动作、心理和环境描写，增加画面感和代入感。4. 合理制造矛盾、悬念或爽点，吸引读者继续阅读。5. 避免与前文重复或矛盾，保证承接自然。最终输出优化后的小说续写内容。";
    // AI优化提示默认值
    defaultSettings["aiOptimizePrompt"] = "你是一名专业的网络小说编辑，熟悉起点、晋江、番茄等平台的文风与读者偏好。请对输入文本进行润色与优化，要求：1. 保留原剧情与设定，不改变故事走向与核心爽点。2. 优化文笔，使语言更流畅、有画面感与代入感。3. 加强人物外貌、动作、心理与环境氛围的描写，避免平铺直叙。4. 删除或压缩重复、啰嗦内容，使行文紧凑；合理断句与分段。5. 保持网文常见节奏与爽点表达（反转、升级、悬念、情感冲突等）。6. 仅输出优化后的小说正文，不输出解释、点评或标题。";
    defaultSettings["aiProviderIndex"] = 0;
    
    // AI提供商配置
    QJsonObject aiProviderConfigs;
    QJsonObject deepseekConfig;
    deepseekConfig["apiKey"] = "";
    deepseekConfig["modelName"] = "deepseek-chat";
    deepseekConfig["apiUrl"] = "https://api.deepseek.com/v1/chat/completions";
    deepseekConfig["models"] = QJsonArray::fromStringList({"deepseek-chat", "deepseek-reasoner"});
    aiProviderConfigs["DeepSeek"] = deepseekConfig;
    
    // 其他AI提供商配置...
    defaultSettings["aiProviderConfigs"] = QJsonDocument(aiProviderConfigs).toJson();
    
    // 项目设置
    defaultSettings["lastOpenedFile"] = "";
    defaultSettings["settingsVersion"] = "1.0.0";
    
    return defaultSettings;
}

void DataManager::checkAndRemoveDeprecatedSettings(QVariantMap& settings)
{
    // 废弃的设置项列表
    QStringList deprecatedSettings = {
        "showWordCount",        // 已废弃的字数统计设置
        "enableDebugMode",      // 已废弃的调试模式设置
        "enableSpellCheck",     // 已废弃的拼写检查设置
        "confirmBeforeDelete",   // 已废弃的删除确认设置
        "enableBackups",        // 已废弃的备份设置
        "maxRecentFiles"        // 已废弃的最近文件设置
    };
    
    int removedCount = 0;
    for (const QString& deprecatedKey : deprecatedSettings) {
        if (settings.contains(deprecatedKey)) {
            settings.remove(deprecatedKey);
            removedCount++;
            qDebug() << "移除废弃的设置项:" << deprecatedKey;
        }
    }
    
    // 检查设置版本，进行版本迁移
    QString currentVersion = "1.0.0";
    QString loadedVersion = settings.value("settingsVersion", "0.0.0").toString();
    
    if (loadedVersion != currentVersion) {
        qDebug() << "检测到设置版本迁移:" << loadedVersion << "->" << currentVersion;
        
        // 版本迁移逻辑
        if (loadedVersion == "0.0.0") {
            // 从无版本信息迁移到1.0.0
            qDebug() << "执行版本0.0.0到1.0.0的迁移";
        }
        
        // 更新版本号
        settings["settingsVersion"] = currentVersion;
        qDebug() << "设置版本已更新为:" << currentVersion;
    }
    
    if (removedCount > 0) {
        qDebug() << "共移除" << removedCount << "个废弃设置项";
    }
}

void DataManager::saveSetting(const QString& key, const QVariant& value)
{
    m_settings[key] = value;
    // 处理特殊设置
    if (key == "autoSaveEnabled" && value.toBool()) {
        int interval = m_settings.value("autoSaveInterval", 30).toInt();
        setAutoSaveInterval(interval);
    } else if (key == "autoSaveEnabled" && !value.toBool()) {
        m_autoSaveTimer->stop();
    }
}

QVariant DataManager::loadSetting(const QString& key, const QVariant& defaultValue) const
{
    QVariant value = m_settings.value(key, defaultValue);
    //qDebug() << "加载设置:" << key << "=" << value << "(默认值:" << defaultValue << ")";
    
    // 特殊处理布尔类型设置，确保字符串"false"正确转换为bool false
    if (value.typeId() == QMetaType::QString && defaultValue.typeId() == QMetaType::Bool) {
        QString strValue = value.toString();
        if (strValue == "true") {
            return QVariant(true);
        } else if (strValue == "false") {
            return QVariant(false);
        }
    }
    
    return value;
}

void DataManager::setAutoSaveEnabled(bool enabled)
{
    // 在初始化时不触发保存操作
    m_settings["autoSaveEnabled"] = enabled;
    
    if (enabled) {
        int interval = loadSetting("autoSaveInterval", 30).toInt();
        setAutoSaveInterval(interval);
    } else {
        m_autoSaveTimer->stop();
    }
}

void DataManager::setAutoSaveInterval(int seconds)
{
    // 在初始化时不触发保存操作
    m_settings["autoSaveInterval"] = seconds;
    
    bool enabled = loadSetting("autoSaveEnabled", true).toBool();
    if (enabled) {
        m_autoSaveTimer->setInterval(seconds * 1000);
        if (m_hasUnsavedChanges) {
            m_autoSaveTimer->start();
        }
    }
}

void DataManager::exportSettings(const QString& content)
{
    QString filePath = QFileDialog::getSaveFileName(
        nullptr,
        tr("导出设置"),
        QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/story_science_settings.json",
        "JSON Files (*.json)"
    );
    
    if (!filePath.isEmpty()) {
        QFile file(filePath);
        if (file.open(QIODevice::WriteOnly | QIODevice::Text)) {
            file.write(content.toUtf8());
            file.close();
            //qDebug() << "设置已导出到:" << filePath;
        } else {
            qDebug() << "无法导出设置到:" << filePath;
        }
    }
}

void DataManager::importSettings()
{
    QString filePath = QFileDialog::getOpenFileName(
        nullptr,
        tr("导入设置"),
        QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation),
        "JSON Files (*.json)"
    );
    
    if (!filePath.isEmpty()) {
        QFile file(filePath);
        if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
            QByteArray data = file.readAll();
            file.close();
            
            QJsonParseError error;
            QJsonDocument doc = QJsonDocument::fromJson(data, &error);
            
            if (error.error == QJsonParseError::NoError && doc.isObject()) {
                QJsonObject obj = doc.object();
                
                // 导入所有设置
                for (auto it = obj.begin(); it != obj.end(); ++it) {
                    m_settings[it.key()] = it.value().toVariant();
                }
            } else {
                qDebug() << "无效的设置文件格式:" << error.errorString();
            }
        } else {
            qDebug() << "无法读取设置文件:" << filePath;
        }
    }
}

QString DataManager::selectFolder()
{
    return QFileDialog::getExistingDirectory(
        nullptr,
        tr("选择文件夹"),
        QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation)
    );
}

void DataManager::loadAllSettings()
{
    //qDebug() << "=== 开始加载设置文件 ===";
    //qDebug() << "设置文件路径:" << m_settingsFilePath;
    
    // 第一步：加载默认配置
    QVariantMap defaultSettings = getDefaultSettings();
    
    // 第二步：如果设置文件存在，加载用户配置并覆盖默认配置
    QFile file(m_settingsFilePath);
    if (file.exists()) {
        if (!file.open(QIODevice::ReadOnly)) {
            //qDebug() << "无法打开设置文件进行读取:" << m_settingsFilePath;
            //qDebug() << "错误信息:" << file.errorString();
            // 使用默认设置
            m_settings.clear();
            for (auto it = defaultSettings.begin(); it != defaultSettings.end(); ++it) {
                m_settings[it.key()] = it.value();
            }
            return;
        }
        
        QByteArray data = file.readAll();
        file.close();
        
        //qDebug() << "成功读取设置文件，文件大小:" << data.size() << "字节";
        
        QJsonParseError error;
        QJsonDocument doc = QJsonDocument::fromJson(data, &error);
        if (error.error != QJsonParseError::NoError) {
            qDebug() << "设置文件格式错误:" << error.errorString();
            qDebug() << "错误位置:" << error.offset << "字节";
            // JSON解析失败时，使用默认设置
            m_settings.clear();
            for (auto it = defaultSettings.begin(); it != defaultSettings.end(); ++it) {
                m_settings[it.key()] = it.value();
            }
            return;
        }
        
        if (!doc.isObject()) {
            qDebug() << "设置文件不是有效的JSON对象";
            // JSON对象无效时，使用默认设置
            m_settings.clear();
            for (auto it = defaultSettings.begin(); it != defaultSettings.end(); ++it) {
                m_settings[it.key()] = it.value();
            }
            return;
        }
        
        QJsonObject obj = doc.object();
        //qDebug() << "JSON解析成功，包含" << obj.size() << "个设置项";
        
        // 从JSON对象加载用户设置，覆盖默认设置
        int loadedCount = 0;
        for (auto it = obj.begin(); it != obj.end(); ++it) {
            QString key = it.key();
            QVariant value = it.value().toVariant();
            
            // 特殊处理布尔值类型转换
            if (defaultSettings.contains(key) && 
                defaultSettings[key].typeId() == QMetaType::Bool &&
                value.typeId() == QMetaType::QString) {
                QString strValue = value.toString();
                if (strValue == "true") {
                    value = QVariant(true);
                } else if (strValue == "false") {
                    value = QVariant(false);
                }
            }
            
            defaultSettings[key] = value;
            loadedCount++;
        }
        
        //qDebug() << "已加载" << loadedCount << "个用户设置项";
        
        // 检查是否有废弃的设置项
        checkAndRemoveDeprecatedSettings(defaultSettings);
        
        // 将QVariantMap转换为QHash<QString, QVariant>
        m_settings.clear();
        for (auto it = defaultSettings.begin(); it != defaultSettings.end(); ++it) {
            m_settings[it.key()] = it.value();
        }
    } else {
        qDebug() << "设置文件不存在，使用默认设置";
        // 将QVariantMap转换为QHash<QString, QVariant>
        m_settings.clear();
        for (auto it = defaultSettings.begin(); it != defaultSettings.end(); ++it) {
            m_settings[it.key()] = it.value();
        }
        // 保存默认设置到文件
        saveAllSettings();
    }
    
    //qDebug() << "设置加载完成，共" << m_settings.size() << "个设置项";
   // qDebug() << "=== 设置文件加载结束 ===";
}

void DataManager::saveAllSettings()
{
    // 使用JSON格式保存设置
    QJsonObject obj;
    
    // 将所有设置转换为JSON对象并打印调试信息
    for (auto it = m_settings.begin(); it != m_settings.end(); ++it) {
        obj[it.key()] = QJsonValue::fromVariant(it.value());
    }

    QJsonDocument doc(obj);
    
    QFile file(m_settingsFilePath);
    if (!file.open(QIODevice::WriteOnly)) {
        return;
    }
    
    // 使用UTF-8编码写入文件，确保中文字符正确保存
    qint64 bytesWritten = file.write(doc.toJson(QJsonDocument::Indented));
    file.close();

    if (bytesWritten > 0) {
    } else {
        qDebug() << "\n❌ 保存失败: 写入字节数为0";
    }
}



void DataManager::resetAllSettingsToDefault()
{
    qDebug() << "开始重置所有设置为默认值";
    
    // 保存当前的lastOpenedFile值
    QString currentLastOpenedFile = m_settings.value("lastOpenedFile", "").toString();
    qDebug() << "保存的lastOpenedFile值:" << currentLastOpenedFile;
    
    // 获取默认设置
    QVariantMap defaultSettings = getDefaultSettings();
    // 将QVariantMap转换为QHash<QString, QVariant>
    m_settings.clear();
    for (auto it = defaultSettings.begin(); it != defaultSettings.end(); ++it) {
        m_settings[it.key()] = it.value();
    }
    
    // 恢复之前保存的lastOpenedFile值
    m_settings["lastOpenedFile"] = currentLastOpenedFile;
    
    qDebug() << "已设置所有默认值";
    qDebug() << "lastOpenedFile恢复为:" << m_settings["lastOpenedFile"];
    
    // 保存设置
    saveAllSettings();
    
    qDebug() << "所有设置已重置为默认值并保存";
}

void DataManager::updateCurrentBookOutline(const QString &content)
{
    //qDebug() << "尝试保存大纲内容，长度:" << content.length();
    if (content.isEmpty()) {
        qDebug() << "警告：尝试保存空的大纲内容";
    }
    
    QUuid bookId = getCurrentBookId();
    //qDebug() << "当前书籍ID:" << bookId.toString();
    if (bookId.isNull()) {
        qDebug() << "书籍ID无效，无法保存大纲内容";
        return;
    }
    
    m_bookOutlines[bookId] = content;
    //qDebug() << "大纲内容已保存，书籍ID:" << bookId.toString() << "内容:" << content.left(100) << (content.length() > 100 ? "..." : "");
    markProjectDirty(); // 标记项目有未保存的更改
}

void DataManager::updateCurrentBookMindMapOutline(const QString &content)
{
    //qDebug() << "尝试保存思维导图大纲内容，长度:" << content.length();
    if (content.isEmpty()) {
        qDebug() << "警告：尝试保存空的思维导图大纲内容";
    }
    
    QUuid bookId = getCurrentBookId();
    //qDebug() << "当前书籍ID:" << bookId.toString();
    if (bookId.isNull()) {
        qDebug() << "书籍ID无效，无法保存思维导图大纲内容";
        return;
    }
    
    m_bookMindMapOutlines[bookId] = content;
    //qDebug() << "思维导图大纲内容已保存，书籍ID:" << bookId.toString() << "内容:" << content.left(100) << (content.length() > 100 ? "..." : "");
    markProjectDirty(); // 标记项目有未保存的更改
}

void DataManager::updateCurrentBookWorldbuilding(const QString &content)
{
    //qDebug() << "尝试保存世界观内容，长度:" << content.length();
    if (content.isEmpty()) {
        qDebug() << "警告：尝试保存空的世界观内容";
    }
    
    QUuid bookId = getCurrentBookId();
    //qDebug() << "当前书籍ID:" << bookId.toString();
    if (bookId.isNull()) {
        qDebug() << "书籍ID无效，无法保存世界观内容";
        return;
    }
    
    m_bookWorldbuildings[bookId] = content;
    //qDebug() << "世界观内容已保存，书籍ID:" << bookId.toString() << "内容:" << content.left(100) << (content.length() > 100 ? "..." : "");
    markProjectDirty(); // 标记项目有未保存的更改
}

QString DataManager::getCurrentBookOutline() const
{
    QUuid bookId = getCurrentBookId();
    if (bookId.isNull()) {
        return QString();
    }
    
    return m_bookOutlines.value(bookId, QString());
}

QString DataManager::getCurrentBookMindMapOutline() const
{
    QUuid bookId = getCurrentBookId();
    if (bookId.isNull()) {
        return QString();
    }
    
    return m_bookMindMapOutlines.value(bookId, QString());
}

QString DataManager::getCurrentBookWorldbuilding() const
{
    QUuid bookId = getCurrentBookId();
    if (bookId.isNull()) {
        return QString();
    }
    
    return m_bookWorldbuildings.value(bookId, QString());
}

Article* DataManager::getArticleForStoryItem(const QModelIndex &index) const
{
    if (!index.isValid()) {
        return nullptr;
    }
    
    if (auto* item = static_cast<StoryItem*>(index.internalPointer())) {
        QUuid articleId = item->getArticleId();
        if (!articleId.isNull() && m_articles.contains(articleId)) {
            return m_articles.value(articleId);
        }
    }
    
    return nullptr;
}

Article* DataManager::getArticleForStoryItemByChapterId(const QString &chapterId) const
{
    if (chapterId.isEmpty()) {
        return nullptr;
    }
    
    // 遍历文章池来查找
    for(auto it = m_articles.constBegin(); it != m_articles.constEnd(); ++it) {
        if(it.key().toString() == chapterId) {
            return it.value();
        }
    }
    return nullptr;
}

QModelIndex DataManager::getStoryIndexByChapterId(const QString& chapterId) const
{
    if (chapterId.isEmpty()) {
        return QModelIndex();
    }
    
    // 遍历故事模型来查找匹配的文章ID
    return m_storyModel->getIndexByArticleId(QUuid(chapterId));
}

QString DataManager::getChapterTitleById(const QString &chapterId) const
{
    if (chapterId.isEmpty()) return tr("未知章节");

    // 遍历文章池来查找
    for(Article* article : m_articles) {
        if(article && article->id().toString() == chapterId) {
            return article->title();
        }
    }
    return tr("未知章节");
}

// =============================================================================
// 设置管理功能
// =============================================================================
