/**
 * @file tutorialmanager.h
 * @brief 教程管理器类
 * 
 * TutorialManager 负责管理应用程序的教程功能，
 * 支持分页、步骤导航和窗口大小跟踪。
 */

#ifndef TUTORIALMANAGER_H
#define TUTORIALMANAGER_H

#include <QObject>
#include <QVariantList>
#include <QSettings>

/**
 * @class TutorialManager
 * @brief 教程管理器类
 * 
 * 管理应用程序的教程流程，支持多页面、多步骤的教程导航。
 * 跟踪窗口大小和当前步骤，提供教程完成状态管理。
 */
class TutorialManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool tutorialActive READ tutorialActive WRITE setTutorialActive NOTIFY tutorialActiveChanged)
    Q_PROPERTY(int currentStep READ currentStep WRITE setCurrentStep NOTIFY currentStepChanged)
    Q_PROPERTY(int windowWidth READ windowWidth WRITE setWindowWidth NOTIFY windowSizeChanged)
    Q_PROPERTY(int windowHeight READ windowHeight WRITE setWindowHeight NOTIFY windowSizeChanged)
    Q_PROPERTY(int currentPage READ currentPage WRITE setCurrentPage NOTIFY currentPageChanged)
public:
    explicit TutorialManager(QObject *parent = nullptr);

    bool tutorialActive() const;
    int currentStep() const;
    int currentPage() const;
    int windowWidth() const;
    int windowHeight() const;

    Q_INVOKABLE int totalSteps() const;
    Q_INVOKABLE QVariantMap getCurrentStepData() const;
    Q_INVOKABLE void nextStep();
    Q_INVOKABLE void previousStep();
    Q_INVOKABLE void setTutorialActive(bool active);

public slots:
    void setCurrentStep(int step);
    void setCurrentPage(int page); 
    void setWindowWidth(int w);
    void setWindowHeight(int h);

signals:
    void tutorialActiveChanged();
    void currentStepChanged();
    void windowSizeChanged();
    void currentPageChanged();
    void tutorialFinished();

private:
    bool m_tutorialActive = false;
    int m_currentStep = 0;
    int m_windowWidth = 0;
    int m_windowHeight = 0;
    int m_currentPage = 0;

    QVariantList m_steps;  ///< 当前页面的步骤列表，每个元素是 { "text", "objectName" }
    QVariantList page1Steps;
    QVariantList page2Steps;
    QVariantList page3Steps;
    QVariantList page4Steps;
    QVariantList page5Steps;
    QVariantList page6Steps;
};

#endif // TUTORIALMANAGER_H