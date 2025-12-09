/**
 * @file datamanager.h
 * @brief 数据管理器类，负责管理项目的所有数据
 * 
 * DataManager 是应用程序的核心数据管理类，采用单例模式。
 * 负责管理故事结构、元素、文章、画布、大纲等所有项目数据，
 * 并提供数据持久化、设置管理等功能。
 */

#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QSortFilterProxyModel>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QTimer>
#include <QHash>
#include <QVariant>
#include <QStandardPaths>
#include <QFileDialog>
#include <foreshadowingmodel.h>
#include "storymodel.h"
#include "elementmodel.h"
#include "elementfilterproxymodel.h"
#include "elementtype.h"
#include "article.h"
#include "graphmodel.h"
#include "canvasmanager.h"
#include "outlinemodel.h"
#include "textoutlinemodel.h"
#include "aicontinuationmanager.h"

/**
 * @class DataManager
 * @brief 数据管理器类
 * 
 * 采用单例模式，管理整个应用程序的数据，包括：
 * - 故事结构（StoryModel）
 * - 元素数据（ElementModel）
 * - 文章内容（Article）
 * - 画布数据（CanvasManager）
 * - 大纲数据（OutlineModel）
 * - 项目设置和持久化
 */
class DataManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(StoryModel* storyModel READ storyModel CONSTANT)
    Q_PROPERTY(ElementModel* elementModel READ elementModel CONSTANT)
    Q_PROPERTY(ElementFilterProxyModel* characterModel READ characterModel CONSTANT)
    Q_PROPERTY(ElementFilterProxyModel* locationModel READ locationModel CONSTANT)
    Q_PROPERTY(ElementFilterProxyModel* itemModel READ itemModel CONSTANT)
    Q_PROPERTY(ElementFilterProxyModel* origanisationModel READ origanisationModel CONSTANT)
    Q_PROPERTY(ElementFilterProxyModel* eventModel READ eventModel CONSTANT)
    Q_PROPERTY(ElementFilterProxyModel* abilitiesModel READ abilitiesModel CONSTANT)

    Q_PROPERTY(ElementFilterProxyModel* allCharacterModel READ allCharacterModel CONSTANT)
    Q_PROPERTY(ElementFilterProxyModel* allLocationModel READ allLocationModel CONSTANT)
    Q_PROPERTY(ElementFilterProxyModel* allItemModel READ allItemModel CONSTANT)
    Q_PROPERTY(ElementFilterProxyModel* allOriganisationModel READ allOriganisationModel CONSTANT)
    Q_PROPERTY(ElementFilterProxyModel* allEventModel READ allEventModel CONSTANT)
    Q_PROPERTY(ElementFilterProxyModel* allAbilitiesModel READ allAbilitiesModel CONSTANT)

    Q_PROPERTY(Article* currentArticle READ currentArticle NOTIFY currentArticleChanged)
    Q_PROPERTY(QModelIndex currentStoryIndex READ currentStoryIndex NOTIFY currentStoryIndexChanged)
    Q_PROPERTY(bool hasUnsavedChanges READ hasUnsavedChanges NOTIFY unsavedChangesChanged)
    Q_PROPERTY(CanvasManager* canvasManager READ canvasManager CONSTANT)
    Q_PROPERTY(TextOutlineModel* textOutlineModel READ textOutlineModel CONSTANT)
    Q_PROPERTY(OutlineModel* mindMapOutlineModel READ mindMapOutlineModel CONSTANT)
    Q_PROPERTY(QObject* aiContinuationManager READ aiContinuationManager CONSTANT)
    Q_PROPERTY(QVariantMap articles READ articles NOTIFY articlesChanged)
    
    Q_PROPERTY(ForeshadowingModel* foreshadowingModel READ foreshadowingModel CONSTANT)

    Q_PROPERTY(QString prevChapterContent READ prevChapterContent NOTIFY prevChapterContentChanged)

public:
    static DataManager* instance();
    ~DataManager();

    StoryModel* storyModel() const;
    Article* currentArticle() const;
    QModelIndex currentStoryIndex() const;
    ElementModel* elementModel() const;
    ElementFilterProxyModel* characterModel() const;
    ElementFilterProxyModel* locationModel() const;
    ElementFilterProxyModel* itemModel() const;
    ElementFilterProxyModel* origanisationModel() const;
    ElementFilterProxyModel* eventModel() const;
    ElementFilterProxyModel* abilitiesModel() const;

    ElementFilterProxyModel* allCharacterModel() const;
    ElementFilterProxyModel* allLocationModel() const;
    ElementFilterProxyModel* allItemModel() const;
    ElementFilterProxyModel* allOriganisationModel() const;
    ElementFilterProxyModel* allEventModel() const;
    ElementFilterProxyModel* allAbilitiesModel() const;
    
    CanvasManager* canvasManager() const;
    TextOutlineModel* textOutlineModel() const;
    OutlineModel* mindMapOutlineModel() const;
    QObject* aiContinuationManager() const;
    QVariantMap articles() const;
    
    ForeshadowingModel* foreshadowingModel() const;

    QString prevChapterContent() const;

    Q_INVOKABLE QString getPrevSummary(const QModelIndex &index) const;
    Q_INVOKABLE void setPreviousSummary(const QModelIndex &index, const QString &summary);
    Q_INVOKABLE QString getTitleOfPrevChapter(const QModelIndex &index) const;
    // 大纲和世界观内容管理方法
    // 更新方法签名以反映新的项目级管理方式
    Q_INVOKABLE void updateCurrentBookOutline(const QString &content);
    Q_INVOKABLE void updateCurrentBookMindMapOutline(const QString &content);
    Q_INVOKABLE void updateCurrentBookWorldbuilding(const QString &content);
    Q_INVOKABLE QString getCurrentBookOutline() const;
    Q_INVOKABLE QString getCurrentBookMindMapOutline() const;
    Q_INVOKABLE QString getCurrentBookWorldbuilding() const;
    
    /// 获取指定故事项关联的文章
    Q_INVOKABLE Article* getArticleForStoryItem(const QModelIndex &index) const;
    Q_INVOKABLE Article* getArticleForStoryItemByChapterId(const QString &chapterId) const;
    Q_INVOKABLE QString getChapterTitleById(const QString& chapterId) const;
    Q_INVOKABLE QModelIndex getStoryIndexByChapterId(const QString& chapterId) const;
public slots:
    void selectStoryItem(const QModelIndex &index);
    Q_INVOKABLE void associateElementsWithCurrentStoryItem(const QStringList &elementIdStrings);
    // QML 可调用的核心业务逻辑方法
    Q_INVOKABLE void createElementForCurrentStoryItem(ElementTypeWrapper::ElementType type,const QString &title,
                                                      const QString &description,
                                                      const QColor  &color,
                                                      const QString &icon,
                                                      const QStringList &tags);
    Q_INVOKABLE void createElementForCurrentStoryItemWithStatus(ElementTypeWrapper::ElementType type,const QString &title,
                                                      const QString &description,
                                                      const QColor  &color,
                                                      const QString &icon,
                                                      const QStringList &tags,
                                                      const QJsonObject &status);
    Q_INVOKABLE void updateElementStatus(const QString &id, const QJsonObject &status);
    Q_INVOKABLE void updateElementStatusAndAssociate(const QString &id, const QJsonObject &status);
    Q_INVOKABLE QVariantMap getElementStatus(const QString &id);
    Q_INVOKABLE void createStoryItem(const QModelIndex &parent,
                                     StoryTypeWrapper::StoryType type,
                                     const QString &title,
                                     const QStringList &elementIdStrings);
    Q_INVOKABLE void createStoryItem(const QModelIndex &parent,
                                     StoryTypeWrapper::StoryType type,
                                     const QString &title);
    Q_INVOKABLE void createStoryItemWithArticle(const QModelIndex &parent,
                                                 StoryTypeWrapper::StoryType type,
                                                 const QString &title);
    Q_INVOKABLE void removeAssociationFromCurrentStoryItem(const QString &idStr);
    Q_INVOKABLE void deleteElementEverywhere(const QString &idStr);
    /// 删除故事项并同步删除关联的文章
    Q_INVOKABLE bool removeStoryItem(const QModelIndex &index);

    /// 为当前选中的故事项创建文章
    Q_INVOKABLE Article* createArticleForCurrentStoryItem();
    /// 更新当前选中项的标题
    Q_INVOKABLE void updateCurrentStoryItemTitle(const QString &newTitle);
    /// 强制刷新TreeView显示
    Q_INVOKABLE void forceRefreshTreeView();
    
    // 数据持久化接口
    Q_INVOKABLE bool saveProject(const QString& filePath);
    Q_INVOKABLE bool loadProject(const QString& filePath);
    Q_INVOKABLE bool autoSave();
    Q_INVOKABLE QString currentProjectPath() const;
    Q_INVOKABLE bool hasUnsavedChanges() const;
    Q_INVOKABLE bool exportCurrentArticle(const ArticleEpType &type) const;
    /// 创建新项目，清空所有数据
    Q_INVOKABLE void createNewProject();

    // 设置管理接口
    Q_INVOKABLE void saveSetting(const QString& key, const QVariant& value);
    Q_INVOKABLE void saveAllSettings();
    Q_INVOKABLE void loadAllSettings();
    Q_INVOKABLE QVariant loadSetting(const QString& key, const QVariant& defaultValue = QVariant()) const;
    Q_INVOKABLE QString getSettingsPath() const { return m_settingsFilePath; }
    Q_INVOKABLE void resetAllSettingsToDefault();
    Q_INVOKABLE void setAutoSaveEnabled(bool enabled);
    Q_INVOKABLE void setAutoSaveInterval(int seconds);
    Q_INVOKABLE void exportSettings(const QString& content);
    Q_INVOKABLE void importSettings();
    Q_INVOKABLE QString selectFolder();
    /// 标记项目有未保存的更改
    Q_INVOKABLE void markProjectDirty();
    
private:
    /// 获取默认设置
    QVariantMap getDefaultSettings();
    /// 检查并移除废弃的设置项
    void checkAndRemoveDeprecatedSettings(QVariantMap& settings);
private slots:
    void onElementModified(const QUuid &id, ElementTypeWrapper::ElementType type);
signals:
    void currentArticleChanged();
    void currentStoryIndexChanged();
    void projectSaved(const QString& filePath);
    void projectLoaded(const QString& filePath);
    void unsavedChangesChanged(bool hasChanges);
    void articlesChanged();
    void prevChapterContentChanged();
private:
    explicit DataManager(QObject *parent = nullptr);
    static DataManager* m_instance;
    
    // 更新前一章内容的方法
    void updatePrevChapterContent();
    QModelIndex m_currentStoryIndex;
    StoryModel* m_storyModel;
    ElementModel* m_elementModel; // The original, unfiltered model
    ElementFilterProxyModel* m_characterModel;
    ElementFilterProxyModel* m_locationModel;
    ElementFilterProxyModel* m_itemModel;
    ElementFilterProxyModel* m_origanisationModel;
    ElementFilterProxyModel* m_eventModel;
    ElementFilterProxyModel* m_abilitiesModel;

    ElementFilterProxyModel* m_allCharacterModel;
    ElementFilterProxyModel* m_allLocationModel;
    ElementFilterProxyModel* m_allItemModel;
    ElementFilterProxyModel* m_allOriganisationModel;
    ElementFilterProxyModel* m_allEventModel;
    ElementFilterProxyModel* m_allAbilitiesModel;


    Article* m_currentArticle = nullptr; // <-- 当前选中的文章
    QHash<QUuid, Article*> m_articles;   // <-- 所有文章的存储池
    QString m_prevChapterContent; //上一章的文本内容，用于总结回顾
    // 数据持久化相关
    QString m_currentProjectPath;              ///< 当前项目文件路径
    bool m_hasUnsavedChanges = false;          ///< 是否有未保存的更改
    QTimer* m_autoSaveTimer;                   ///< 自动保存定时器
    
    // 设置管理相关
    QHash<QString, QVariant> m_settings;      ///< 设置数据
    QString m_settingsFilePath;                ///< 设置文件路径
    
    // 大纲和世界观存储结构
    QHash<QUuid, QString> m_bookOutlines;          ///< 书籍ID到文本大纲内容的映射
    QHash<QUuid, QString> m_bookMindMapOutlines;   ///< 书籍ID到思维导图大纲内容的映射
    QHash<QUuid, QString> m_bookWorldbuildings;    ///< 书籍ID到世界观内容的映射
    
    // 序列化方法
    QJsonObject serializeProject() const;
    QJsonObject serializeStoryStructure() const;
    QJsonObject serializeArticles() const;
    QJsonObject serializeElements() const;
    QJsonObject serializeAssociations() const;
    QJsonObject serializeCanvases() const;
    QJsonObject serializeTextOutlineModel() const;
    QJsonObject serializeMindMapOutlineModel() const;
    
    // 反序列化方法
    bool deserializeProject(const QJsonObject& obj);
    bool deserializeStoryStructure(const QJsonObject& obj);
    bool deserializeArticles(const QJsonObject& obj);
    bool deserializeElements(const QJsonObject& obj);
    bool deserializeAssociations(const QJsonObject& obj);
    bool deserializeCanvases(const QJsonObject& obj);
    bool deserializeTextOutlineModel(const QJsonObject& obj);
    bool deserializeMindMapOutlineModel(const QJsonObject& obj);
    
    // 辅助方法
    /// 获取当前书籍ID
    QUuid getCurrentBookId() const;
    void setUnsavedChanges(bool hasChanges);
    /// 创建测试数据（用于开发测试）
    void createTestData();
    
    // 核心组件成员变量
    CanvasManager* m_canvasManager;            ///< 画布管理器
    TextOutlineModel* m_textOutlineModel;      ///< 文本大纲模型
    OutlineModel* m_mindMapOutlineModel;        ///< 思维导图大纲模型
    AIContinuationManager* m_aiContinuationManager;  ///< AI续写管理器
    ForeshadowingModel* m_foreshadowingModel;  ///< 伏笔管理模型
};

#endif // DATAMANAGER_H
