/**
 * @file tutorialmanager.cpp
 * @brief TutorialManager 类的实现
 */

#include "tutorialmanager.h"
#include <QSettings>
#include <QDebug>

TutorialManager::TutorialManager(QObject *parent)
    : QObject(parent)
{
    page1Steps = QVariantList{
        QVariantMap{{"text", "左键探索世界，右键发现真理。不会哪里点哪里！科学从这里开始！"}, {"objectName", "logoAndTitle"}},
        QVariantMap{{"text", "这里是管理章节，可右键单个章"}, {"objectName", "bookTreeView"}},
        QVariantMap{{"text", "这是创建书、卷、章..."}, {"objectName", "newBtn"}},
        QVariantMap{{"text", "这是写作页，用于创作，按F11进入沉浸式写作"}, {"objectName", "writerView"}},
        QVariantMap{{"text", "这是关系图谱页，用于绘制元素之间的联系"}, {"objectName", "graphView"}},
        QVariantMap{{"text", "这是书籍大纲页，有思维导图大纲和文本大纲两种模式"}, {"objectName", "outlineView"}},
        QVariantMap{{"text", "这里设置本文的世界观，比如地理，人文，历史..."}, {"objectName", "buildingView"}},
        QVariantMap{{"text", "这是随手笔记页面，用于记录零散的想法或者灵感，或者笔记"}, {"objectName", "notesView"}},
        QVariantMap{{"text", "这里文章标题，标题会同步左边的章节树"}, {"objectName", "titleField"}},
        QVariantMap{{"text", "正文编辑区，书写你的作品，右键或者选择文本可弹出辅助功能"}, {"objectName", "textArea"}},
        QVariantMap{{"text", "这里AI润色按钮，如果觉得文章写得不太好，可以通过它去进行AI润色"}, {"objectName", "btnFocusTitle"}},
        QVariantMap{{"text", "这边是右侧的元素/伏笔库显示区域"}, {"objectName", "mainContentArea"}},
        QVariantMap{{"text", "关联元素按钮，用于关联本章你要使用的元素，比如人物，地点，关联完毕会在元素区显示"}, {"objectName", "connectElementBtn"}},
        QVariantMap{{"text", "如果觉得创建元素没有灵感，可以尝试AI去创建，可能效果不如意，不过可以试试看"}, {"objectName", "aiAutoCreateBtn"}},
        QVariantMap{{"text", "这是手动创建元素的按钮，点击一下试试？"}, {"objectName", "newElementBtn"}},
        QVariantMap{{"text", "这个是切换元素库与伏笔库的按钮，点击则切换到伏笔库查看已经添加过的伏笔"}, {"objectName", "switchForEBtn"}},
    };
    // 关系图谱视图
    page2Steps = QVariantList{
        QVariantMap{{"text", "主画布区域，用于显示图谱节点和连接线，右键添加或者右键节点可以连接"}, {"objectName", "canvas"}},
        QVariantMap{{"text", "添加图谱按钮，用于创建新的图谱"}, {"objectName", "addCanvasButton"}},
        QVariantMap{{"text", "添加节点按钮，用于向图谱中添加新节点"}, {"objectName", "addNodeButton"}},
    };
    // 大纲视图
    page3Steps = QVariantList{
        //QVariantMap{{"text", "顶部工具栏，包含大纲视图的导航和操作按钮"}, {"objectName", "topBarToolBar"}},
        QVariantMap{{"text", "大纲操作按钮组，包含保存、添加子节点、删除节点和自动布局按钮"}, {"objectName", "outlineButtons"}},

    };

    // 世界观视图
    page4Steps = QVariantList{
        QVariantMap{{"text", "默认分类列表，世界的分类"}, {"objectName", "categoryList"}},
        QVariantMap{{"text", "添加世界观"}, {"objectName", "addCategoryButton"}},
    };

    // 随手笔记视图
    page5Steps = QVariantList{
        QVariantMap{{"text", "返回主页"}, {"objectName", "backButton"}},
        QVariantMap{{"text", "AI点评页面"}, {"objectName", "readerArea"}},
        QVariantMap{{"text", "调整字体大小"}, {"objectName", "fontSizeSlider"}},
        QVariantMap{{"text", "AI点评，会模仿读者的风格点评"}, {"objectName", "aiCommentButton"}},
    };

    page6Steps = QVariantList{
       QVariantMap{{"text", "时间轴按钮，切换时间轴"}, {"objectName", "timelineButton"}},
       QVariantMap{{"text", "轮播图按钮，切换轮播图"}, {"objectName", "carouselButton"}},
       QVariantMap{{"text", "添加笔记按钮，创建新的笔记"}, {"objectName", "addNoteButton"}},
       QVariantMap{{"text", "拖动滑块，左右滑动时间轴"}, {"objectName", "timelineSlider"}},
    };

    m_steps = page1Steps;
    m_currentPage = 0; // 修复：初始页面应为0而不是1
}

bool TutorialManager::tutorialActive() const { return m_tutorialActive; }

int TutorialManager::currentStep() const { return m_currentStep; }

int TutorialManager::currentPage() const { return m_currentPage; }

int TutorialManager::windowWidth() const { return m_windowWidth; }

int TutorialManager::windowHeight() const { return m_windowHeight; }

int TutorialManager::totalSteps() const {
    return m_steps.size();
}

QVariantMap TutorialManager::getCurrentStepData() const {
    if (m_currentStep >= 0 && m_currentStep < m_steps.size())
        return m_steps[m_currentStep].toMap();
    return {};
}

void TutorialManager::nextStep() {
    if (m_currentStep < totalSteps() - 1) {
        m_currentStep++;
        emit currentStepChanged();
    } else {
        //qDebug() << "教程结束";
        emit tutorialFinished();
    }
}

void TutorialManager::previousStep() {
    if (m_currentStep > 0) {
        m_currentStep--;
        emit currentStepChanged();
    }
}

void TutorialManager::setTutorialActive(bool active) {
    if (m_tutorialActive != active) {
        m_tutorialActive = active;
        if (!active) {
            m_currentStep = 0; // 重置
        }
        emit tutorialActiveChanged();
    }
}

void TutorialManager::setCurrentStep(int step) {
    if (m_currentStep != step && step >= 0 && step < totalSteps()) {
        m_currentStep = step;
        emit currentStepChanged();
    }
}

void TutorialManager::setCurrentPage(int page)
{
    m_steps.clear();

    switch(page){
        case 0:  // mainStack.currentIndex = 0 (写作视图)
            m_steps = page1Steps;
            break;
        case 1:  // mainStack.currentIndex = 1 (关系图谱视图)
            m_steps = page2Steps;
            break;
        case 2:  // mainStack.currentIndex = 2 (大纲视图)
            m_steps = page3Steps;
            break;
        case 3:  // mainStack.currentIndex = 3 (世界观视图)
            m_steps = page4Steps;
            break;
        case 4:
            //跳过读者页
            m_steps = page5Steps;
            break;
        case 5:  // mainStack.currentIndex = 4 (随时笔记视图)
            m_steps = page6Steps;
            break;
        default:
            m_steps = page1Steps;
            break;
    }
    m_currentStep = 0;// 重置
    emit currentStepChanged();
}

void TutorialManager::setWindowWidth(int w) {
    if (m_windowWidth != w) {
        m_windowWidth = w;
        emit windowSizeChanged();
    }
}

void TutorialManager::setWindowHeight(int h) {
    if (m_windowHeight != h) {
        m_windowHeight = h;
        emit windowSizeChanged();
    }
}
