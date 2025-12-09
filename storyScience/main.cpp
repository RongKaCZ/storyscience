/**
 * @file main.cpp
 * @brief 应用程序入口点
 * 
 * 初始化Qt应用程序，注册QML类型，设置语言管理器，
 * 并加载主QML界面。
 */

#include "datamanager.h"
#include "elementmodel.h"
#include "graphmodel.h"
#include "vocabularydictionary.h"
#include "aicontinuationmanager.h"
#include "keydetailsmanager.h"
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>
#include <storymodel.h>
#include <QSettings>
#include <QQuickWindow>
#include "elementtype.h"
#include "storytype.h"
#include "datamanager.h"
#include "clipboardhelper.h"
#include "textanalyzer.h"
#include "languagemanager.h"
#include "carouselcardmodel.h"
#include "tutorialmanager.h"
#include "utils.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QQuickStyle::setStyle("Material");
    QQmlApplicationEngine engine;

    LanguageManager::instance()->setQmlEngine(&engine);
    engine.rootContext()->setContextProperty("languageManager", LanguageManager::instance());
    LanguageManager::instance()->selectLanguage("zh");

    KeyDetailsManager* keyDetailsManager = new KeyDetailsManager(&app);
    engine.rootContext()->setContextProperty("keyDetailsManager", keyDetailsManager);

    qmlRegisterUncreatableType<ElementTypeWrapper>(
        "ElementType", 1, 0,
        "ElementType",
        "Error: only enums"
    );
    qmlRegisterUncreatableType<StoryTypeWrapper>("StoryType",1,0,"StoryType","Error:only enums");
    qmlRegisterType<Article>("storyScience", 1, 0, "Article");
    qmlRegisterUncreatableType<ArticleEpType>(
        "ArticleEpType", 1, 0,
        "ArticleEpType",
        "Error: only enums"
        );
    
    qRegisterMetaType<GraphNode>("GraphNode");
    qRegisterMetaType<GraphEdge>("GraphEdge");
    qRegisterMetaType<QPointF>("QPointF");
    qmlRegisterType<GraphModel>("storyScience", 1, 0, "GraphModel");
    qmlRegisterType<OutlineModel>("storyScience", 1, 0, "OutlineModel");
    qmlRegisterType<AIContinuationManager>("storyScience", 1, 0, "AIContinuationManager");

    const QUrl url(QStringLiteral("qrc:/storyScience/main.qml"));
    
    DataManager* dataManager = DataManager::instance();
    qmlRegisterSingletonInstance<DataManager>("storyScience", 1, 0, "DataManager", dataManager);
    qmlRegisterSingletonInstance<ElementModel>("storyScience", 1, 0, "ElementModel", dataManager->elementModel());
    
    qmlRegisterType<StoryModel>("storyScience", 1, 0, "StoryModel");
    qmlRegisterType<VocabularyDictionary>("storyScience", 1, 0, "VocabularyDictionary");
    qmlRegisterType<TextAnalyzer>("storyScience", 1, 0, "TextAnalyzer");
    engine.rootContext()->setContextProperty("clipboard",ClipboardHelper::instance());

    qmlRegisterType<ForeshadowingItem>("storyScience", 1, 0, "ForeshadowingItem");
    qmlRegisterType<CarouselCardModel>("storyScience",1,0,"CarouselCardModel");

    TutorialManager* tutorialManager = new TutorialManager(&app);
    engine.rootContext()->setContextProperty("tutorialManager", tutorialManager);

    Utils utils;
    engine.rootContext()->setContextProperty("Utils", &utils);

    QVariant value = DataManager::instance()->loadSetting("firstRun", true);
    bool isFirstRun = value.toBool();

    if (isFirstRun) {
        tutorialManager->setTutorialActive(true);
        tutorialManager->setCurrentStep(0);
        DataManager::instance()->saveSetting("firstRun", false);
    }

    qRegisterMetaType<CarouselCardData>("CarouselCardData");

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
