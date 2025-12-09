cmake_minimum_required(VERSION 3.16)
project(storyScienceDesktop VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# --- 翻译配置 步骤 1 ---
# 在 find_package 中添加 LinguistTools 组件
find_package(Qt6 6.2 REQUIRED COMPONENTS Quick QuickControls2 Widgets LinguistTools)

# 设置单例类型
set_source_files_properties(Style.qml PROPERTIES QT_QML_SINGLETON_TYPE TRUE)
qt_add_executable(appstoryScience
    main.cpp
    elementmodel.h elementmodel.cpp
    icons.qrc
    appicon.rc
    qml.qrc
)

# --- 翻译配置 步骤 2 ---
# 创建一个列表，包含所有需要扫描翻译的 C++ 和 QML 源文件
# 这基本上是 qt_add_qml_module 中所有源文件的集合
set(TRANSLATION_SOURCES
    # C++ Sources
    main.cpp
    storyitem.h storyitem.cpp
    storymodel.h storymodel.cpp
    datamanager.h datamanager.cpp
    elementmodel.h elementmodel.cpp
    elementfilterproxymodel.h elementfilterproxymodel.cpp
    elementtype.h elementtype.cpp
    elementstatus.h elementstatus.cpp
    storytype.h storytype.cpp
    article.h article.cpp
    graphmodel.h graphmodel.cpp
    canvasmanager.cpp canvasmanager.h
    outlinenode.h
    outlinemodel.h outlinemodel.cpp
    vocabularydictionary.h vocabularydictionary.cpp
    textoutlinemodel.h textoutlinemodel.cpp
    clipboardhelper.h clipboardhelper.cpp
    aicontinuationmanager.h aicontinuationmanager.cpp
    highlightmodel.h highlightmodel.cpp
    textanalyzer.h textanalyzer.cpp
    foreshadowingitem.h foreshadowingitem.cpp
    foreshadowingmodel.h foreshadowingmodel.cpp
    # QML Files
    main.qml
    EditorArea.qml
    Style.qml
    LeftPanel.qml
    ElementCard.qml
    RightPanel.qml
    BottomPanel.qml
    TopBar.qml
    ElementDelegate.qml
    AddElementPopup.qml
    ElementPicker.qml
    CreateStoryItemDialog.qml
    CharacterStatusView.qml
    CharacterStatusEdit.qml
    LocationStatusView.qml
    LocationStatusEdit.qml
    ItemStatusView.qml
    ItemStatusEdit.qml
    AbilityStatusView.qml
    AbilityStatusEdit.qml
    OrganizationStatusView.qml
    OrganizationStatusEdit.qml
    EventStatusView.qml
    EventStatusEdit.qml
    Node.qml
    Edge.qml
    GraphView.qml
    CanvasSwitcher.qml
    AvatarCard.qml
    WorldbuildingView.qml
    StoryTreeDelegate.qml
    MindMapView.qml
    OutlineView.qml
    NodeEditDialog.qml
    TextOutlineView.qml
    VocabularyHelperPopup.qml
    AIContinuePopup.qml
    AICreateElementPopup.qml
    OptimizeArticlePopup.qml
    MessageBox.qml
    ReaderView.qml
    BookPropertyDialog.qml
    ForeShadowPopup.qml
)

# --- 翻译配置 步骤 3 ---
# 定义你的 .ts 翻译文件。请在项目根目录下创建一个 i18n 文件夹
set(TRANSLATION_FILES
    i18n/storyScience_zh.ts  # 中文
    i18n/storyScience_en.ts  # 英文
)

# --- 翻译配置 步骤 4 ---
# 调用 qt_add_translations 来自动处理 lupdate 和 lrelease
# 它会创建一个名为 appstoryScience_translations.qrc 的资源文件
qt_add_translations(appstoryScience
    TS_FILES ${TRANSLATION_FILES}
    SOURCES ${TRANSLATION_SOURCES}
)

qt_add_qml_module(appstoryScience
    URI storyScience
    VERSION 1.0
    # 这里的文件列表保持不变
    QML_FILES
    main.qml
    AbilityStatusEdit.qml
    AbilityStatusView.qml
    AddElementPopup.qml
    AIContinuePopup.qml
    AICreateElementPopup.qml
    AvatarCard.qml
    BookPropertyDialog.qml
    BottomPanel.qml
    CanvasSwitcher.qml
    CharacterStatusEdit.qml
    CharacterStatusView.qml
    CreateStoryItemDialog.qml
    CustomComboBox.qml
    Edge.qml
    EditorArea.qml
    ElementCard.qml
    ElementDelegate.qml
    ElementPicker.qml
    EventStatusEdit.qml
    EventStatusView.qml
    ForeShadowPopup.qml
    GraphView.qml
    ItemStatusEdit.qml
    ItemStatusView.qml
    KeyDetailsView.qml
    LeftPanel.qml
    LocationStatusEdit.qml
    LocationStatusView.qml
    MessageBox.qml
    MindMapView.qml
    ModernCarouselCard.qml
    ModernCarouselView.qml
    Node.qml
    NodeDescriptionPopup.qml
    NodeEditDialog.qml
    NotesView.qml
    OptimizeArticlePopup.qml
    OrganizationStatusEdit.qml
    OrganizationStatusView.qml
    OutlineView.qml
    ReaderView.qml
    RightPanel.qml
    StoryTreeDelegate.qml
    Style.qml
    SystemCard.qml
    SystemCardManager.qml
    TextOutlineView.qml
    TimelineOverview.qml
    TopBar.qml
    TutorialOverlay.qml
    VocabularyHelperPopup.qml
    WorldbuildingView.qml
    SOURCES
     storyitem.h storyitem.cpp
     storymodel.h storymodel.cpp
     datamanager.h datamanager.cpp
     elementmodel.h elementmodel.cpp
     elementfilterproxymodel.h elementfilterproxymodel.cpp
     elementtype.h elementtype.cpp
     elementstatus.h elementstatus.cpp
     storytype.h storytype.cpp
     article.h article.cpp
     graphmodel.h graphmodel.cpp
     canvasmanager.cpp canvasmanager.h
     outlinenode.h
     outlinemodel.h outlinemodel.cpp
     vocabularydictionary.h vocabularydictionary.cpp
     textoutlinemodel.h textoutlinemodel.cpp
     clipboardhelper.h clipboardhelper.cpp
     aicontinuationmanager.h aicontinuationmanager.cpp
     highlightmodel.h highlightmodel.cpp
     textanalyzer.h textanalyzer.cpp
     foreshadowingitem.h foreshadowingitem.cpp
     foreshadowingmodel.h foreshadowingmodel.cpp
     keydetailsmanager.h keydetailsmanager.cpp
    RESOURCES fileDN.qrc keydetails.qrc
    SOURCES languagemanager.h languagemanager.cpp
    SOURCES CarouselCardModel.h CarouselCardModel.cpp
    SOURCES tutorialmanager.h tutorialmanager.cpp
    SOURCES utils.h utils.cpp
    RESOURCES qml.qrc
    QML_FILES ImmersiveExitButton.qml
    QML_FILES SummaryOverlay.qml
    QML_FILES OptimizationPreviewDialog.qml
    QML_FILES DonatePage.qml
)

set_target_properties(appstoryScience PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appstoryScience
    PRIVATE Qt6::Quick Qt6::QuickControls2 Qt6::Widgets)

# --- 翻译配置 步骤 5 ---
# 将 qt_add_translations 自动生成的 .qrc 文件添加到可执行文件中
target_sources(appstoryScience PRIVATE
    ${appstoryScience_TRANSLATION_FILES}
)

include(GNUInstallDirs)
install(TARGETS appstoryScience
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
