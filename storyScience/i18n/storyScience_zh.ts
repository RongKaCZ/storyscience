<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE TS>
<TS version="2.1" language="zh_CN">
<context>
    <name>AIContinuationManager</name>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="784"/>
        <source>你是一个创意写作助手，专门用于创建故事元素。请严格按照指定的JSON格式返回结果。</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>AIContinuationWorker</name>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="47"/>
        <location filename="../aicontinuationmanager.cpp" line="85"/>
        <location filename="../aicontinuationmanager.cpp" line="202"/>
        <location filename="../aicontinuationmanager.cpp" line="260"/>
        <source>上一个请求仍在处理中</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="99"/>
        <source>（请生成一个角色名作为标题）</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="102"/>
        <source>（请生成一个地点名作为标题）</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="105"/>
        <source>（请生成一个道具名作为标题）</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="108"/>
        <source>（请生成一个组织名作为标题）</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="111"/>
        <source>（请生成一个事件名作为标题）</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="114"/>
        <source>（请生成一个能力名作为标题）</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="117"/>
        <source>（请生成一个合适的标题）</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="121"/>
        <source>请根据以下描述创建一个%1元素：

%2</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="151"/>
        <source>请生成一个符合以下结构的JSON对象（不要包含任何其他内容）：
{
  &quot;title&quot;: &quot;%1&quot;,
  &quot;description&quot;: &quot;（请生成50字的描述，简洁易懂）&quot;,
  &quot;color&quot;: &quot;（请推荐一个符合主题的#RRGGBB颜色代码，随机）&quot;,
  &quot;icon&quot;: %2,  // 必须使用此固定图标路径，不可更改或推荐其他图标
  &quot;tags&quot;: [&quot;（标签1）&quot;, &quot;（标签2）&quot;]  // 至少两个相关标签
}
⚠️ 重要：只返回JSON对象，不要包含任何解释、注释或额外文本。</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="167"/>
        <source>你是一个创意写作助手，专门用于动态生成故事元素。你必须严格返回合法的JSON对象，不带任何额外内容。icon 字段必须使用指定的固定路径，禁止自行推荐、更改或使用其他图标关键词。</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="213"/>
        <source>
        你是一名专业的网络小说编辑，熟悉起点、晋江、番茄等网文平台的写作风格。
        请对输入的小说文本进行优化和美化，要求如下：
        1. 保留原剧情和设定，不改变故事走向和核心爽点。
        2. 优化文笔，使语言更加流畅、具有画面感和代入感。
        3. 加强人物描写（外貌、动作、心理），避免平铺直叙。
        4. 增强环境氛围和细节刻画，营造玄幻感和压迫感。
        5. 保持网文常见的节奏与爽点表达（逆袭、打脸、系统奖励等）。
        6. 删除或压缩重复、啰嗦的部分，使行文紧凑有力。
        7. 结尾增加“钩子”，让读者期待后续剧情。
        最终仅输出优化后的小说正文，不要输出任何解释或多余内容。
        </source>
        <translation></translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="267"/>
        <source>点评一下这个小说片段：</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="269"/>
        <source>
        ## 角色与人设 (ROLE &amp; PERSONA) ##
        你是站在网文鄙视链顶端的神级编辑，是阅文无数、在起点、番茄、飞卢等平台杀伐决断的“人形算法”。你代表着最挑剔的95后/00后读者，说话自带弹幕，精通玩梗，且对一切“尬文”都生理性不适。

        ## 核心任务 (CORE TASK) ##
        分析下方提供的小说片段。精准地找出其中 4 到 5 个最值得吐槽的亮点、槽点或爽点，并为每一处配上你那标志性的“毒舌”点评。

        ## ⚠️ 至关重要的核心规则：逐字复制 ⚠️ ##
        1.  **&quot;text&quot;字段的内容是本任务的最高优先级。它必须是、也只能是原文中一个不多一字、不少一字、不改一字的【连续片段】。**
        2.  **【严禁】进行任何形式的总结、概括、拼接、改写或二次创作。你的任务是“复制-粘贴”，而不是“理解-重述”。**
        3.  **【错误示范】**: 如果原文是 `王德发逃跑了。林天一关上了门。` 你的&quot;text&quot;字段【绝对不能】是 `&quot;王德发逃跑后，林天一关上了门。&quot;` (这是拼接和改写，是错误的！)
        4.  **【正确示范】**: 你应该选择其中一句，例如 `{&quot;text&quot;: &quot;王德发逃跑了。&quot;, &quot;comment&quot;: &quot;...&quot;}` 或者 `{&quot;text&quot;: &quot;林天一关上了门。&quot;, &quot;comment&quot;: &quot;...&quot;}`。

        ## 其他输出规则 ##
        - **风格语气:** 犀利、简洁、幽默。自然地使用网络热梗。
        - **严格的JSON格式:** **必须且只能**返回一个可被直接解析的、原始的JSON数组。禁止包含任何介绍性文字、说明或Markdown的` ```json `包装。

        ## 格式与范例 ##
        [
          {
            &quot;text&quot;: &quot;原文中的一个片段，必须一字不差地复制。&quot;,
            &quot;comment&quot;: &quot;你犀利、幽默、一针见血的吐槽放在这里。&quot;
          },
          {
            &quot;text&quot;: &quot;原文中的另一个片段，同样是精准复制。&quot;,
            &quot;comment&quot;: &quot;从另一个角度切入的毒舌点评。&quot;
          }
        ]
    </source>
        <translation></translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="343"/>
        <source>角色</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="345"/>
        <source>地点</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="347"/>
        <source>道具</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="349"/>
        <source>组织</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="351"/>
        <source>事件</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="353"/>
        <source>能力</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="355"/>
        <source>元素</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>AIContinuePopup</name>
    <message>
        <location filename="../AIContinuePopup.qml" line="59"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AIContinuePopup.qml" line="59"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AIContinuePopup.qml" line="59"/>
        <source>输入续写提示，如“接着写一段战斗场景...”</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AIContinuePopup.qml" line="79"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AIContinuePopup.qml" line="79"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AIContinuePopup.qml" line="79"/>
        <source>发送</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AIContinuePopup.qml" line="119"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AIContinuePopup.qml" line="119"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AIContinuePopup.qml" line="119"/>
        <source>取消钉住</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AIContinuePopup.qml" line="119"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AIContinuePopup.qml" line="119"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AIContinuePopup.qml" line="119"/>
        <source>钉住窗口</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>AICreateElementPopup</name>
    <message>
        <location filename="../AICreateElementPopup.qml" line="28"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AICreateElementPopup.qml" line="28"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AICreateElementPopup.qml" line="28"/>
        <source>人物</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AICreateElementPopup.qml" line="30"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AICreateElementPopup.qml" line="30"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AICreateElementPopup.qml" line="30"/>
        <source>地点</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AICreateElementPopup.qml" line="32"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AICreateElementPopup.qml" line="32"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AICreateElementPopup.qml" line="32"/>
        <source>道具</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AICreateElementPopup.qml" line="34"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AICreateElementPopup.qml" line="34"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AICreateElementPopup.qml" line="34"/>
        <source>能力</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AICreateElementPopup.qml" line="36"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AICreateElementPopup.qml" line="36"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AICreateElementPopup.qml" line="36"/>
        <source>组织</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AICreateElementPopup.qml" line="38"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AICreateElementPopup.qml" line="38"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AICreateElementPopup.qml" line="38"/>
        <source>事件</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AICreateElementPopup.qml" line="40"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AICreateElementPopup.qml" line="40"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AICreateElementPopup.qml" line="40"/>
        <source>元素</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AICreateElementPopup.qml" line="97"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AICreateElementPopup.qml" line="97"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AICreateElementPopup.qml" line="97"/>
        <source>例如：一个性格冷酷但内心善良的女剑客，有着神秘的过去和特殊的剑术能力...</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AICreateElementPopup.qml" line="113"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AICreateElementPopup.qml" line="113"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AICreateElementPopup.qml" line="113"/>
        <source>取消</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AICreateElementPopup.qml" line="132"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AICreateElementPopup.qml" line="132"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AICreateElementPopup.qml" line="132"/>
        <source>创建</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>AbilityStatusEdit</name>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="16"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AbilityStatusEdit.qml" line="16"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AbilityStatusEdit.qml" line="16"/>
        <source>基本信息</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="27"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AbilityStatusEdit.qml" line="27"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AbilityStatusEdit.qml" line="27"/>
        <source>详情</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="39"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AbilityStatusEdit.qml" line="39"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AbilityStatusEdit.qml" line="39"/>
        <source>无</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="53"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AbilityStatusEdit.qml" line="53"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AbilityStatusEdit.qml" line="53"/>
        <source>力量类型:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="55"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AbilityStatusEdit.qml" line="55"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AbilityStatusEdit.qml" line="55"/>
        <source>普通</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="67"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AbilityStatusEdit.qml" line="67"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AbilityStatusEdit.qml" line="67"/>
        <source>消耗:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="81"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AbilityStatusEdit.qml" line="81"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AbilityStatusEdit.qml" line="81"/>
        <source>冷却时间:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="95"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AbilityStatusEdit.qml" line="95"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AbilityStatusEdit.qml" line="95"/>
        <source>等级:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="97"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AbilityStatusEdit.qml" line="97"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AbilityStatusEdit.qml" line="97"/>
        <source>等级</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="110"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AbilityStatusEdit.qml" line="110"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AbilityStatusEdit.qml" line="110"/>
        <source>前置条件</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="144"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AbilityStatusEdit.qml" line="144"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AbilityStatusEdit.qml" line="144"/>
        <source>删除</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="164"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AbilityStatusEdit.qml" line="164"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AbilityStatusEdit.qml" line="164"/>
        <source>前置条件（能力ID或等级）</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="168"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AbilityStatusEdit.qml" line="168"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AbilityStatusEdit.qml" line="168"/>
        <source>添加</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>AbilityStatusView</name>
    <message>
        <location filename="../AbilityStatusView.qml" line="23"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AbilityStatusView.qml" line="23"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AbilityStatusView.qml" line="23"/>
        <source>能力信息</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AbilityStatusView.qml" line="47"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AbilityStatusView.qml" line="47"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AbilityStatusView.qml" line="47"/>
        <source>力量类型</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AbilityStatusView.qml" line="47"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AbilityStatusView.qml" line="47"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AbilityStatusView.qml" line="47"/>
        <source>普通</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AbilityStatusView.qml" line="48"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AbilityStatusView.qml" line="48"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AbilityStatusView.qml" line="48"/>
        <source>消耗</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AbilityStatusView.qml" line="49"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AbilityStatusView.qml" line="49"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AbilityStatusView.qml" line="49"/>
        <source>冷却时间</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AbilityStatusView.qml" line="50"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AbilityStatusView.qml" line="50"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AbilityStatusView.qml" line="50"/>
        <source>等级</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AbilityStatusView.qml" line="91"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AbilityStatusView.qml" line="91"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AbilityStatusView.qml" line="91"/>
        <source>详情</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AbilityStatusView.qml" line="103"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AbilityStatusView.qml" line="103"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AbilityStatusView.qml" line="103"/>
        <source>无</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AbilityStatusView.qml" line="129"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AbilityStatusView.qml" line="129"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AbilityStatusView.qml" line="129"/>
        <source>前置条件</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>AddElementPopup</name>
    <message>
        <location filename="../AddElementPopup.qml" line="35"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AddElementPopup.qml" line="35"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AddElementPopup.qml" line="35"/>
        <source>新元素</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AddElementPopup.qml" line="140"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AddElementPopup.qml" line="140"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AddElementPopup.qml" line="140"/>
        <source>标题</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AddElementPopup.qml" line="148"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AddElementPopup.qml" line="148"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AddElementPopup.qml" line="148"/>
        <source>描述...</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AddElementPopup.qml" line="154"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AddElementPopup.qml" line="154"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AddElementPopup.qml" line="154"/>
        <source>颜色:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AddElementPopup.qml" line="245"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AddElementPopup.qml" line="245"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AddElementPopup.qml" line="245"/>
        <source>标签:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AddElementPopup.qml" line="286"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AddElementPopup.qml" line="286"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AddElementPopup.qml" line="286"/>
        <source>×</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AddElementPopup.qml" line="314"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AddElementPopup.qml" line="314"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AddElementPopup.qml" line="314"/>
        <source>输入新标签后按 Enter</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AddElementPopup.qml" line="326"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AddElementPopup.qml" line="326"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AddElementPopup.qml" line="326"/>
        <source>添加</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AddElementPopup.qml" line="120"/>
        <location filename="../AddElementPopup.qml" line="343"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AddElementPopup.qml" line="120"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AddElementPopup.qml" line="343"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AddElementPopup.qml" line="120"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AddElementPopup.qml" line="343"/>
        <source>创建</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AddElementPopup.qml" line="364"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AddElementPopup.qml" line="364"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AddElementPopup.qml" line="364"/>
        <source>取消</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>Article</name>
    <message>
        <location filename="../article.cpp" line="7"/>
        <location filename="../article.cpp" line="11"/>
        <source>新章节</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>AvatarCard</name>
    <message>
        <location filename="../AvatarCard.qml" line="29"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AvatarCard.qml" line="29"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AvatarCard.qml" line="29"/>
        <source>头像</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AvatarCard.qml" line="47"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AvatarCard.qml" line="47"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AvatarCard.qml" line="47"/>
        <source>未设置</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../AvatarCard.qml" line="99"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/AvatarCard.qml" line="99"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/AvatarCard.qml" line="99"/>
        <source>未设置头像</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>BookPropertyDialog</name>
    <message>
        <location filename="../BookPropertyDialog.qml" line="14"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BookPropertyDialog.qml" line="14"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BookPropertyDialog.qml" line="14"/>
        <source>书籍属性</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="38"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BookPropertyDialog.qml" line="38"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BookPropertyDialog.qml" line="38"/>
        <source>基本信息</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="52"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BookPropertyDialog.qml" line="52"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BookPropertyDialog.qml" line="52"/>
        <source>书名：</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="57"/>
        <location filename="../BookPropertyDialog.qml" line="211"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BookPropertyDialog.qml" line="57"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BookPropertyDialog.qml" line="211"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BookPropertyDialog.qml" line="57"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BookPropertyDialog.qml" line="211"/>
        <source>未知</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="66"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BookPropertyDialog.qml" line="66"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BookPropertyDialog.qml" line="66"/>
        <source>章节数：</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="72"/>
        <location filename="../BookPropertyDialog.qml" line="87"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BookPropertyDialog.qml" line="72"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BookPropertyDialog.qml" line="87"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BookPropertyDialog.qml" line="72"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BookPropertyDialog.qml" line="87"/>
        <source>计算中...</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="81"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BookPropertyDialog.qml" line="81"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BookPropertyDialog.qml" line="81"/>
        <source>总字数：</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="98"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BookPropertyDialog.qml" line="98"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BookPropertyDialog.qml" line="98"/>
        <source>章节列表</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="146"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BookPropertyDialog.qml" line="146"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BookPropertyDialog.qml" line="146"/>
        <source> 字</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="199"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BookPropertyDialog.qml" line="199"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BookPropertyDialog.qml" line="199"/>
        <source>根节点</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="201"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BookPropertyDialog.qml" line="201"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BookPropertyDialog.qml" line="201"/>
        <source>书籍</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="203"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BookPropertyDialog.qml" line="203"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BookPropertyDialog.qml" line="203"/>
        <source>分卷</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="205"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BookPropertyDialog.qml" line="205"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BookPropertyDialog.qml" line="205"/>
        <source>部分</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="207"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BookPropertyDialog.qml" line="207"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BookPropertyDialog.qml" line="207"/>
        <source>章节</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="209"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BookPropertyDialog.qml" line="209"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BookPropertyDialog.qml" line="209"/>
        <source>场景</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>BottomPanel</name>
    <message>
        <location filename="../BottomPanel.qml" line="35"/>
        <location filename="../BottomPanel.qml" line="537"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="35"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="537"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="35"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="537"/>
        <source>你是一个小说续写助手，请根据用户提供的上下文和提示，续写合适的内容。</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="65"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="65"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="65"/>
        <source>设置</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="73"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="73"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="73"/>
        <source>保存并关闭</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="96"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="96"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="96"/>
        <source>关闭</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="128"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="128"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="128"/>
        <source>界面设置</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="139"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="139"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="139"/>
        <source>显示字数统计</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="148"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="148"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="148"/>
        <source>深色主题</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="176"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="176"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="176"/>
        <source>文件管理</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="187"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="187"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="187"/>
        <source>删除前确认</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="195"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="195"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="195"/>
        <source>启用备份</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="205"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="205"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="205"/>
        <source>默认保存位置:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="212"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="212"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="212"/>
        <source>选择默认文件保存位置</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="217"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="217"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="217"/>
        <source>浏览...</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="229"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="229"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="229"/>
        <source>AI续写设置</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="240"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="240"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="240"/>
        <source>AI提供商:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="291"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="291"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="291"/>
        <source>请输入API URL</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="307"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="307"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="307"/>
        <source>请输入API密钥</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="317"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="317"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="317"/>
        <source>模型名称:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="324"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="324"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="324"/>
        <source>请输入模型名称</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="333"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="333"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="333"/>
        <source>系统提示:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="342"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="342"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="342"/>
        <source>请输入系统提示，如&apos;你是一个小说续写助手&apos;</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="351"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="351"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="351"/>
        <source>高级设置</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="358"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="358"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="358"/>
        <source>导出设置</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="365"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="365"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="365"/>
        <source>导入设置</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="372"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="372"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="372"/>
        <source>显示设置路径</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="627"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="627"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="627"/>
        <source>设置文件路径</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="644"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="644"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="644"/>
        <source>复制</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="652"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/BottomPanel.qml" line="652"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/BottomPanel.qml" line="652"/>
        <source>确定</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>CanvasSwitcher</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CanvasSwitcher.qml" line="84"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CanvasSwitcher.qml" line="84"/>
        <location filename="../CanvasSwitcher.qml" line="84"/>
        <source>重命名</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CanvasSwitcher.qml" line="93"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CanvasSwitcher.qml" line="93"/>
        <location filename="../CanvasSwitcher.qml" line="93"/>
        <source>删除</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CanvasSwitcher.qml" line="106"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CanvasSwitcher.qml" line="106"/>
        <location filename="../CanvasSwitcher.qml" line="106"/>
        <source>重命名图谱</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>CharacterStatusEdit</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="22"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="22"/>
        <location filename="../CharacterStatusEdit.qml" line="22"/>
        <source>基本信息</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="32"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="32"/>
        <location filename="../CharacterStatusEdit.qml" line="32"/>
        <source>等级:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="34"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="34"/>
        <location filename="../CharacterStatusEdit.qml" line="34"/>
        <source>青铜</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="46"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="46"/>
        <location filename="../CharacterStatusEdit.qml" line="46"/>
        <source>经验值:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="60"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="60"/>
        <location filename="../CharacterStatusEdit.qml" line="60"/>
        <source>阶段:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="62"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="62"/>
        <location filename="../CharacterStatusEdit.qml" line="62"/>
        <source>1级</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="75"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="75"/>
        <location filename="../CharacterStatusEdit.qml" line="75"/>
        <source>详情</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="87"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="87"/>
        <location filename="../CharacterStatusEdit.qml" line="87"/>
        <source>无</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="102"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="102"/>
        <location filename="../CharacterStatusEdit.qml" line="102"/>
        <source>属性</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="151"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="233"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="390"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="151"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="233"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="390"/>
        <location filename="../CharacterStatusEdit.qml" line="151"/>
        <location filename="../CharacterStatusEdit.qml" line="233"/>
        <location filename="../CharacterStatusEdit.qml" line="390"/>
        <source>删除</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="170"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="170"/>
        <location filename="../CharacterStatusEdit.qml" line="170"/>
        <source>属性名</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="175"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="175"/>
        <location filename="../CharacterStatusEdit.qml" line="175"/>
        <source>属性值</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="179"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="257"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="336"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="414"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="179"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="257"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="336"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="414"/>
        <location filename="../CharacterStatusEdit.qml" line="179"/>
        <location filename="../CharacterStatusEdit.qml" line="257"/>
        <location filename="../CharacterStatusEdit.qml" line="336"/>
        <location filename="../CharacterStatusEdit.qml" line="414"/>
        <source>添加</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="199"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="199"/>
        <location filename="../CharacterStatusEdit.qml" line="199"/>
        <source>能力列表</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="253"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="253"/>
        <location filename="../CharacterStatusEdit.qml" line="253"/>
        <source>能力ID</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="278"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="278"/>
        <location filename="../CharacterStatusEdit.qml" line="278"/>
        <source>物品列表</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="332"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="332"/>
        <location filename="../CharacterStatusEdit.qml" line="332"/>
        <source>物品ID</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="356"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="356"/>
        <location filename="../CharacterStatusEdit.qml" line="356"/>
        <source>状态效果</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="410"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="410"/>
        <location filename="../CharacterStatusEdit.qml" line="410"/>
        <source>效果名称</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="434"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="434"/>
        <location filename="../CharacterStatusEdit.qml" line="434"/>
        <source>传记</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="464"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="464"/>
        <location filename="../CharacterStatusEdit.qml" line="464"/>
        <source>头像</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusEdit.qml" line="490"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusEdit.qml" line="490"/>
        <location filename="../CharacterStatusEdit.qml" line="490"/>
        <source>选择</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>CharacterStatusView</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusView.qml" line="23"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusView.qml" line="23"/>
        <location filename="../CharacterStatusView.qml" line="23"/>
        <source>角色信息</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusView.qml" line="43"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusView.qml" line="43"/>
        <location filename="../CharacterStatusView.qml" line="43"/>
        <source>头像</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusView.qml" line="84"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusView.qml" line="84"/>
        <location filename="../CharacterStatusView.qml" line="84"/>
        <source>等级</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusView.qml" line="84"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusView.qml" line="84"/>
        <location filename="../CharacterStatusView.qml" line="84"/>
        <source>青铜</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusView.qml" line="85"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusView.qml" line="85"/>
        <location filename="../CharacterStatusView.qml" line="85"/>
        <source>经验值</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusView.qml" line="86"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusView.qml" line="86"/>
        <location filename="../CharacterStatusView.qml" line="86"/>
        <source>阶段</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusView.qml" line="86"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusView.qml" line="86"/>
        <location filename="../CharacterStatusView.qml" line="86"/>
        <source>1级</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusView.qml" line="127"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusView.qml" line="127"/>
        <location filename="../CharacterStatusView.qml" line="127"/>
        <source>详情</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusView.qml" line="139"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusView.qml" line="340"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusView.qml" line="139"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusView.qml" line="340"/>
        <location filename="../CharacterStatusView.qml" line="139"/>
        <location filename="../CharacterStatusView.qml" line="340"/>
        <source>无</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusView.qml" line="165"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusView.qml" line="165"/>
        <location filename="../CharacterStatusView.qml" line="165"/>
        <source>属性</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusView.qml" line="217"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusView.qml" line="217"/>
        <location filename="../CharacterStatusView.qml" line="217"/>
        <source>能力列表</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusView.qml" line="254"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusView.qml" line="254"/>
        <location filename="../CharacterStatusView.qml" line="254"/>
        <source>物品列表</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusView.qml" line="291"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusView.qml" line="291"/>
        <location filename="../CharacterStatusView.qml" line="291"/>
        <source>状态效果</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CharacterStatusView.qml" line="328"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CharacterStatusView.qml" line="328"/>
        <location filename="../CharacterStatusView.qml" line="328"/>
        <source>传记</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>CreateStoryItemDialog</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CreateStoryItemDialog.qml" line="14"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CreateStoryItemDialog.qml" line="14"/>
        <location filename="../CreateStoryItemDialog.qml" line="14"/>
        <source>项</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CreateStoryItemDialog.qml" line="40"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CreateStoryItemDialog.qml" line="40"/>
        <location filename="../CreateStoryItemDialog.qml" line="40"/>
        <source>请输入</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/CreateStoryItemDialog.qml" line="47"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/CreateStoryItemDialog.qml" line="47"/>
        <location filename="../CreateStoryItemDialog.qml" line="47"/>
        <source>开始创作吧...</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>DataManager</name>
    <message>
        <location filename="../datamanager.cpp" line="258"/>
        <source>新章节</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="634"/>
        <source>导出为 TXT</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="635"/>
        <source>纯文本文档 (*.txt)</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="639"/>
        <source>导出为 Markdown</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="640"/>
        <source>Markdown 文档 (*.md)</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="748"/>
        <location filename="../datamanager.cpp" line="752"/>
        <source>主角</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="749"/>
        <source>故事的主要人物</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="752"/>
        <source>英雄</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="757"/>
        <source>魔法世界</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="758"/>
        <source>一个充满奇幻的世界</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="761"/>
        <source>奇幻</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="761"/>
        <source>魔法</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="770"/>
        <source>测试小说</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="1332"/>
        <source>导出设置</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="1353"/>
        <source>导入设置</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="1387"/>
        <source>选择文件夹</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="1727"/>
        <location filename="../datamanager.cpp" line="1735"/>
        <source>未知章节</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>Edge</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/Edge.qml" line="156"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/Edge.qml" line="185"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/Edge.qml" line="156"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/Edge.qml" line="185"/>
        <location filename="../Edge.qml" line="156"/>
        <location filename="../Edge.qml" line="185"/>
        <source>关联</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/Edge.qml" line="178"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/Edge.qml" line="178"/>
        <location filename="../Edge.qml" line="178"/>
        <source>编辑关系标签</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/Edge.qml" line="182"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/Edge.qml" line="182"/>
        <location filename="../Edge.qml" line="182"/>
        <source>关系描述:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/Edge.qml" line="202"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/Edge.qml" line="202"/>
        <location filename="../Edge.qml" line="202"/>
        <source>编辑标签</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/Edge.qml" line="209"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/Edge.qml" line="209"/>
        <location filename="../Edge.qml" line="209"/>
        <source>删除连接</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>EditorArea</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EditorArea.qml" line="338"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EditorArea.qml" line="338"/>
        <location filename="../EditorArea.qml" line="338"/>
        <source>字数: </source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EditorArea.qml" line="345"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EditorArea.qml" line="345"/>
        <location filename="../EditorArea.qml" line="345"/>
        <source>速度: </source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EditorArea.qml" line="345"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EditorArea.qml" line="345"/>
        <location filename="../EditorArea.qml" line="345"/>
        <source> 字/分钟</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EditorArea.qml" line="365"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EditorArea.qml" line="365"/>
        <location filename="../EditorArea.qml" line="365"/>
        <source>未保存</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EditorArea.qml" line="365"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EditorArea.qml" line="365"/>
        <location filename="../EditorArea.qml" line="365"/>
        <source>已保存</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EditorArea.qml" line="401"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EditorArea.qml" line="401"/>
        <location filename="../EditorArea.qml" line="401"/>
        <source>新章节</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EditorArea.qml" line="403"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EditorArea.qml" line="403"/>
        <location filename="../EditorArea.qml" line="403"/>
        <source>请选择一个章节或场景</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EditorArea.qml" line="425"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EditorArea.qml" line="425"/>
        <location filename="../EditorArea.qml" line="425"/>
        <source>润色</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EditorArea.qml" line="827"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EditorArea.qml" line="827"/>
        <location filename="../EditorArea.qml" line="827"/>
        <source>复制</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EditorArea.qml" line="828"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EditorArea.qml" line="828"/>
        <location filename="../EditorArea.qml" line="828"/>
        <source>词典</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EditorArea.qml" line="829"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EditorArea.qml" line="829"/>
        <location filename="../EditorArea.qml" line="829"/>
        <source>AI写</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EditorArea.qml" line="835"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EditorArea.qml" line="835"/>
        <location filename="../EditorArea.qml" line="835"/>
        <source>伏笔</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>ElementCard</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementCard.qml" line="11"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementCard.qml" line="11"/>
        <location filename="../ElementCard.qml" line="11"/>
        <source>加载中...</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>ElementDelegate</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementDelegate.qml" line="99"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementDelegate.qml" line="99"/>
        <location filename="../ElementDelegate.qml" line="99"/>
        <source>更多操作</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementDelegate.qml" line="120"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementDelegate.qml" line="120"/>
        <location filename="../ElementDelegate.qml" line="120"/>
        <source>编辑</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementDelegate.qml" line="124"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementDelegate.qml" line="124"/>
        <location filename="../ElementDelegate.qml" line="124"/>
        <source>查看状态</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementDelegate.qml" line="128"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementDelegate.qml" line="128"/>
        <location filename="../ElementDelegate.qml" line="128"/>
        <source>编辑状态</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementDelegate.qml" line="132"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementDelegate.qml" line="132"/>
        <location filename="../ElementDelegate.qml" line="132"/>
        <source>从当前项移除</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementDelegate.qml" line="138"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementDelegate.qml" line="138"/>
        <location filename="../ElementDelegate.qml" line="138"/>
        <source>彻底删除元素</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementDelegate.qml" line="176"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementDelegate.qml" line="176"/>
        <location filename="../ElementDelegate.qml" line="176"/>
        <source>标题</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementDelegate.qml" line="177"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementDelegate.qml" line="177"/>
        <location filename="../ElementDelegate.qml" line="177"/>
        <source>描述...</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementDelegate.qml" line="182"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementDelegate.qml" line="182"/>
        <location filename="../ElementDelegate.qml" line="182"/>
        <source>颜色:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementDelegate.qml" line="196"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementDelegate.qml" line="196"/>
        <location filename="../ElementDelegate.qml" line="196"/>
        <source>标签:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementDelegate.qml" line="241"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementDelegate.qml" line="241"/>
        <location filename="../ElementDelegate.qml" line="241"/>
        <source>输入新标签后按 Enter</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementDelegate.qml" line="251"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementDelegate.qml" line="251"/>
        <location filename="../ElementDelegate.qml" line="251"/>
        <source>添加</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementDelegate.qml" line="271"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementDelegate.qml" line="489"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementDelegate.qml" line="271"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementDelegate.qml" line="489"/>
        <location filename="../ElementDelegate.qml" line="271"/>
        <location filename="../ElementDelegate.qml" line="489"/>
        <source>保存</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementDelegate.qml" line="287"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementDelegate.qml" line="499"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementDelegate.qml" line="287"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementDelegate.qml" line="499"/>
        <location filename="../ElementDelegate.qml" line="287"/>
        <location filename="../ElementDelegate.qml" line="499"/>
        <source>取消</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementDelegate.qml" line="332"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementDelegate.qml" line="332"/>
        <location filename="../ElementDelegate.qml" line="332"/>
        <source>元素状态 - </source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementDelegate.qml" line="386"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementDelegate.qml" line="386"/>
        <location filename="../ElementDelegate.qml" line="386"/>
        <source>关闭</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementDelegate.qml" line="432"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementDelegate.qml" line="432"/>
        <location filename="../ElementDelegate.qml" line="432"/>
        <source>编辑元素状态 - </source>
        <translation></translation>
    </message>
</context>
<context>
    <name>ElementPicker</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementPicker.qml" line="16"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementPicker.qml" line="16"/>
        <location filename="../ElementPicker.qml" line="16"/>
        <source>选择要关联的元素</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementPicker.qml" line="40"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementPicker.qml" line="40"/>
        <location filename="../ElementPicker.qml" line="40"/>
        <source>人物</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementPicker.qml" line="41"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementPicker.qml" line="41"/>
        <location filename="../ElementPicker.qml" line="41"/>
        <source>地点</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementPicker.qml" line="42"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementPicker.qml" line="42"/>
        <location filename="../ElementPicker.qml" line="42"/>
        <source>道具</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementPicker.qml" line="43"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementPicker.qml" line="43"/>
        <location filename="../ElementPicker.qml" line="43"/>
        <source>能力</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementPicker.qml" line="44"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementPicker.qml" line="44"/>
        <location filename="../ElementPicker.qml" line="44"/>
        <source>组织</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ElementPicker.qml" line="45"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ElementPicker.qml" line="45"/>
        <location filename="../ElementPicker.qml" line="45"/>
        <source>事件</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>EventStatusEdit</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="16"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="16"/>
        <location filename="../EventStatusEdit.qml" line="16"/>
        <source>基本信息</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="27"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="27"/>
        <location filename="../EventStatusEdit.qml" line="27"/>
        <source>详情</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="39"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="39"/>
        <location filename="../EventStatusEdit.qml" line="39"/>
        <source>无</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="53"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="53"/>
        <location filename="../EventStatusEdit.qml" line="53"/>
        <source>时间:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="67"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="67"/>
        <location filename="../EventStatusEdit.qml" line="67"/>
        <source>时间线位置:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="69"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="69"/>
        <location filename="../EventStatusEdit.qml" line="69"/>
        <source>时间线</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="81"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="81"/>
        <location filename="../EventStatusEdit.qml" line="81"/>
        <source>地点ID:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="95"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="95"/>
        <location filename="../EventStatusEdit.qml" line="95"/>
        <source>状态:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="97"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="99"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="101"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="97"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="99"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="101"/>
        <location filename="../EventStatusEdit.qml" line="97"/>
        <location filename="../EventStatusEdit.qml" line="99"/>
        <location filename="../EventStatusEdit.qml" line="101"/>
        <source>计划中</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="97"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="102"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="97"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="102"/>
        <location filename="../EventStatusEdit.qml" line="97"/>
        <location filename="../EventStatusEdit.qml" line="102"/>
        <source>进行中</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="97"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="103"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="97"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="103"/>
        <location filename="../EventStatusEdit.qml" line="97"/>
        <location filename="../EventStatusEdit.qml" line="103"/>
        <source>完成中</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="97"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="104"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="97"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="104"/>
        <location filename="../EventStatusEdit.qml" line="97"/>
        <location filename="../EventStatusEdit.qml" line="104"/>
        <source>已结束</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="119"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="119"/>
        <location filename="../EventStatusEdit.qml" line="119"/>
        <source>结果:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="135"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="135"/>
        <location filename="../EventStatusEdit.qml" line="135"/>
        <source>影响分数:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="150"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="150"/>
        <location filename="../EventStatusEdit.qml" line="150"/>
        <source>参与者列表</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="184"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="184"/>
        <location filename="../EventStatusEdit.qml" line="184"/>
        <source>删除</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="204"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="204"/>
        <location filename="../EventStatusEdit.qml" line="204"/>
        <source>参与者ID</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusEdit.qml" line="208"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusEdit.qml" line="208"/>
        <location filename="../EventStatusEdit.qml" line="208"/>
        <source>添加</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>EventStatusView</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusView.qml" line="23"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusView.qml" line="23"/>
        <location filename="../EventStatusView.qml" line="23"/>
        <source>事件信息</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusView.qml" line="47"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusView.qml" line="47"/>
        <location filename="../EventStatusView.qml" line="47"/>
        <source>时间</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusView.qml" line="47"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusView.qml" line="49"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusView.qml" line="47"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusView.qml" line="49"/>
        <location filename="../EventStatusView.qml" line="47"/>
        <location filename="../EventStatusView.qml" line="49"/>
        <source>未设置</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusView.qml" line="48"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusView.qml" line="48"/>
        <location filename="../EventStatusView.qml" line="48"/>
        <source>时间线位置</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusView.qml" line="48"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusView.qml" line="48"/>
        <location filename="../EventStatusView.qml" line="48"/>
        <source>时间线</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusView.qml" line="49"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusView.qml" line="49"/>
        <location filename="../EventStatusView.qml" line="49"/>
        <source>地点</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusView.qml" line="50"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusView.qml" line="50"/>
        <location filename="../EventStatusView.qml" line="50"/>
        <source>状态</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusView.qml" line="50"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusView.qml" line="50"/>
        <location filename="../EventStatusView.qml" line="50"/>
        <source>计划中</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusView.qml" line="51"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusView.qml" line="51"/>
        <location filename="../EventStatusView.qml" line="51"/>
        <source>结果</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusView.qml" line="51"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusView.qml" line="105"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusView.qml" line="143"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusView.qml" line="51"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusView.qml" line="105"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusView.qml" line="143"/>
        <location filename="../EventStatusView.qml" line="51"/>
        <location filename="../EventStatusView.qml" line="105"/>
        <location filename="../EventStatusView.qml" line="143"/>
        <source>无</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusView.qml" line="52"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusView.qml" line="52"/>
        <location filename="../EventStatusView.qml" line="52"/>
        <source>影响分数</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusView.qml" line="93"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusView.qml" line="93"/>
        <location filename="../EventStatusView.qml" line="93"/>
        <source>详情</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/EventStatusView.qml" line="131"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/EventStatusView.qml" line="131"/>
        <location filename="../EventStatusView.qml" line="131"/>
        <source>参与者列表</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>ForeShadowPopup</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ForeShadowPopup.qml" line="17"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ForeShadowPopup.qml" line="17"/>
        <location filename="../ForeShadowPopup.qml" line="17"/>
        <source>&lt;b&gt;原文：&lt;/b&gt;</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ForeShadowPopup.qml" line="41"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ForeShadowPopup.qml" line="41"/>
        <location filename="../ForeShadowPopup.qml" line="41"/>
        <source>标记伏笔</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ForeShadowPopup.qml" line="69"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ForeShadowPopup.qml" line="69"/>
        <location filename="../ForeShadowPopup.qml" line="69"/>
        <source>伏笔描述 (给自己的笔记):</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ForeShadowPopup.qml" line="74"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ForeShadowPopup.qml" line="74"/>
        <location filename="../ForeShadowPopup.qml" line="74"/>
        <source>例如：这把剑的来历，将在主角回忆时揭晓...</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ForeShadowPopup.qml" line="85"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ForeShadowPopup.qml" line="85"/>
        <location filename="../ForeShadowPopup.qml" line="85"/>
        <source>取消</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ForeShadowPopup.qml" line="91"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ForeShadowPopup.qml" line="91"/>
        <location filename="../ForeShadowPopup.qml" line="91"/>
        <source>保存伏笔</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>GraphView</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/GraphView.qml" line="43"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/GraphView.qml" line="45"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/GraphView.qml" line="43"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/GraphView.qml" line="45"/>
        <location filename="../GraphView.qml" line="43"/>
        <location filename="../GraphView.qml" line="45"/>
        <source>未知元素</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/GraphView.qml" line="222"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/GraphView.qml" line="222"/>
        <location filename="../GraphView.qml" line="222"/>
        <source>添加图谱</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/GraphView.qml" line="226"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/GraphView.qml" line="226"/>
        <location filename="../GraphView.qml" line="226"/>
        <source>新图谱</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/GraphView.qml" line="231"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/GraphView.qml" line="351"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/GraphView.qml" line="231"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/GraphView.qml" line="351"/>
        <location filename="../GraphView.qml" line="231"/>
        <location filename="../GraphView.qml" line="351"/>
        <source>添加节点</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/GraphView.qml" line="237"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/GraphView.qml" line="237"/>
        <location filename="../GraphView.qml" line="237"/>
        <source>取消连接</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/GraphView.qml" line="271"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/GraphView.qml" line="271"/>
        <location filename="../GraphView.qml" line="271"/>
        <source>保存中...</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/GraphView.qml" line="272"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/GraphView.qml" line="272"/>
        <location filename="../GraphView.qml" line="272"/>
        <source>加载中...</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/GraphView.qml" line="277"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/GraphView.qml" line="277"/>
        <location filename="../GraphView.qml" line="277"/>
        <source>节点: %1 | 连接: %2 | 缩放: %3%</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/GraphView.qml" line="281"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/GraphView.qml" line="281"/>
        <location filename="../GraphView.qml" line="281"/>
        <source>无图谱数据</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/GraphView.qml" line="286"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/GraphView.qml" line="286"/>
        <location filename="../GraphView.qml" line="286"/>
        <source>成功</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/GraphView.qml" line="287"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/GraphView.qml" line="287"/>
        <location filename="../GraphView.qml" line="287"/>
        <source>失败</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/GraphView.qml" line="294"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/GraphView.qml" line="294"/>
        <location filename="../GraphView.qml" line="294"/>
        <source>清空</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/GraphView.qml" line="327"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/GraphView.qml" line="327"/>
        <location filename="../GraphView.qml" line="327"/>
        <source>确认清空</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/GraphView.qml" line="334"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/GraphView.qml" line="334"/>
        <location filename="../GraphView.qml" line="334"/>
        <source>确定要清空当前图谱的所有节点和连接吗？
此操作不可撤销。</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/GraphView.qml" line="341"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/GraphView.qml" line="341"/>
        <location filename="../GraphView.qml" line="341"/>
        <source>已清空图谱</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/GraphView.qml" line="355"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/GraphView.qml" line="355"/>
        <location filename="../GraphView.qml" line="355"/>
        <source>清空画布</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>ItemStatusEdit</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusEdit.qml" line="16"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusEdit.qml" line="16"/>
        <location filename="../ItemStatusEdit.qml" line="16"/>
        <source>基本信息</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusEdit.qml" line="26"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusEdit.qml" line="26"/>
        <location filename="../ItemStatusEdit.qml" line="26"/>
        <source>稀有度:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusEdit.qml" line="28"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusEdit.qml" line="28"/>
        <location filename="../ItemStatusEdit.qml" line="28"/>
        <source>稀有</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusEdit.qml" line="41"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusEdit.qml" line="41"/>
        <location filename="../ItemStatusEdit.qml" line="41"/>
        <source>详情</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusEdit.qml" line="53"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusEdit.qml" line="53"/>
        <location filename="../ItemStatusEdit.qml" line="53"/>
        <source>无</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusEdit.qml" line="67"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusEdit.qml" line="67"/>
        <location filename="../ItemStatusEdit.qml" line="67"/>
        <source>类别:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusEdit.qml" line="81"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusEdit.qml" line="81"/>
        <location filename="../ItemStatusEdit.qml" line="81"/>
        <source>耐久度:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusEdit.qml" line="95"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusEdit.qml" line="95"/>
        <location filename="../ItemStatusEdit.qml" line="95"/>
        <source>价值:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusEdit.qml" line="109"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusEdit.qml" line="109"/>
        <location filename="../ItemStatusEdit.qml" line="109"/>
        <source>所有者ID:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusEdit.qml" line="124"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusEdit.qml" line="124"/>
        <location filename="../ItemStatusEdit.qml" line="124"/>
        <source>效果列表</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusEdit.qml" line="158"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusEdit.qml" line="158"/>
        <location filename="../ItemStatusEdit.qml" line="158"/>
        <source>删除</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusEdit.qml" line="178"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusEdit.qml" line="178"/>
        <location filename="../ItemStatusEdit.qml" line="178"/>
        <source>效果ID</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusEdit.qml" line="182"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusEdit.qml" line="182"/>
        <location filename="../ItemStatusEdit.qml" line="182"/>
        <source>添加</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>ItemStatusView</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusView.qml" line="23"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusView.qml" line="23"/>
        <location filename="../ItemStatusView.qml" line="23"/>
        <source>道具信息</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusView.qml" line="47"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusView.qml" line="47"/>
        <location filename="../ItemStatusView.qml" line="47"/>
        <source>稀有度</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusView.qml" line="47"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusView.qml" line="47"/>
        <location filename="../ItemStatusView.qml" line="47"/>
        <source>稀有</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusView.qml" line="48"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusView.qml" line="48"/>
        <location filename="../ItemStatusView.qml" line="48"/>
        <source>类别</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusView.qml" line="48"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusView.qml" line="48"/>
        <location filename="../ItemStatusView.qml" line="48"/>
        <source>未设置</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusView.qml" line="49"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusView.qml" line="49"/>
        <location filename="../ItemStatusView.qml" line="49"/>
        <source>耐久度</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusView.qml" line="50"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusView.qml" line="50"/>
        <location filename="../ItemStatusView.qml" line="50"/>
        <source>价值</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusView.qml" line="51"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusView.qml" line="51"/>
        <location filename="../ItemStatusView.qml" line="51"/>
        <source>所有者</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusView.qml" line="51"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusView.qml" line="104"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusView.qml" line="51"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusView.qml" line="104"/>
        <location filename="../ItemStatusView.qml" line="51"/>
        <location filename="../ItemStatusView.qml" line="104"/>
        <source>无</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusView.qml" line="92"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusView.qml" line="92"/>
        <location filename="../ItemStatusView.qml" line="92"/>
        <source>详情</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ItemStatusView.qml" line="130"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ItemStatusView.qml" line="130"/>
        <location filename="../ItemStatusView.qml" line="130"/>
        <source>效果列表</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>LeftPanel</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="71"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="71"/>
        <location filename="../LeftPanel.qml" line="71"/>
        <source>故事科学</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="184"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="184"/>
        <location filename="../LeftPanel.qml" line="184"/>
        <source>+ 创建新书</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="200"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="200"/>
        <location filename="../LeftPanel.qml" line="200"/>
        <source>+ 新建分卷</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="202"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="202"/>
        <location filename="../LeftPanel.qml" line="202"/>
        <source>+ 新建篇章</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="204"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="204"/>
        <location filename="../LeftPanel.qml" line="204"/>
        <source>+ 新建章节</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="206"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="208"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="206"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="208"/>
        <location filename="../LeftPanel.qml" line="206"/>
        <location filename="../LeftPanel.qml" line="208"/>
        <source>+ 新建场景</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="232"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="240"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="232"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="240"/>
        <location filename="../LeftPanel.qml" line="232"/>
        <location filename="../LeftPanel.qml" line="240"/>
        <source>新书</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="250"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="250"/>
        <location filename="../LeftPanel.qml" line="250"/>
        <source>新分卷</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="255"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="255"/>
        <location filename="../LeftPanel.qml" line="255"/>
        <source>新篇章</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="260"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="260"/>
        <location filename="../LeftPanel.qml" line="260"/>
        <source>新章节</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="265"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="270"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="265"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="270"/>
        <location filename="../LeftPanel.qml" line="265"/>
        <location filename="../LeftPanel.qml" line="270"/>
        <source>新场景</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="295"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="295"/>
        <location filename="../LeftPanel.qml" line="295"/>
        <source>创建新分卷...</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="297"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="297"/>
        <location filename="../LeftPanel.qml" line="297"/>
        <source>创建新篇章...</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="299"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="299"/>
        <location filename="../LeftPanel.qml" line="299"/>
        <source>创建新章节...</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="301"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="301"/>
        <location filename="../LeftPanel.qml" line="301"/>
        <source>创建新场景...</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="318"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="318"/>
        <location filename="../LeftPanel.qml" line="318"/>
        <source>关联已有元素...</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="325"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="325"/>
        <location filename="../LeftPanel.qml" line="325"/>
        <source>导出章节文本</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="356"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="356"/>
        <location filename="../LeftPanel.qml" line="356"/>
        <source>查看全书属性</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="362"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="362"/>
        <location filename="../LeftPanel.qml" line="362"/>
        <source>删除</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="371"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="371"/>
        <location filename="../LeftPanel.qml" line="371"/>
        <source>你确定要删除吗？</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LeftPanel.qml" line="378"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LeftPanel.qml" line="378"/>
        <location filename="../LeftPanel.qml" line="378"/>
        <source>删除该项目吗？</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>LocationStatusEdit</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusEdit.qml" line="16"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusEdit.qml" line="16"/>
        <location filename="../LocationStatusEdit.qml" line="16"/>
        <source>基本信息</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusEdit.qml" line="26"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusEdit.qml" line="26"/>
        <location filename="../LocationStatusEdit.qml" line="26"/>
        <source>地区:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusEdit.qml" line="41"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusEdit.qml" line="41"/>
        <location filename="../LocationStatusEdit.qml" line="41"/>
        <source>详情</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusEdit.qml" line="53"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusEdit.qml" line="53"/>
        <location filename="../LocationStatusEdit.qml" line="53"/>
        <source>无</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusEdit.qml" line="67"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusEdit.qml" line="67"/>
        <location filename="../LocationStatusEdit.qml" line="67"/>
        <source>人口:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusEdit.qml" line="69"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusEdit.qml" line="69"/>
        <location filename="../LocationStatusEdit.qml" line="69"/>
        <source>100万人</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusEdit.qml" line="81"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusEdit.qml" line="81"/>
        <location filename="../LocationStatusEdit.qml" line="81"/>
        <source>控制组织ID:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusEdit.qml" line="95"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusEdit.qml" line="95"/>
        <location filename="../LocationStatusEdit.qml" line="95"/>
        <source>重要性:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusEdit.qml" line="97"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusEdit.qml" line="97"/>
        <location filename="../LocationStatusEdit.qml" line="97"/>
        <source>罕见</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusEdit.qml" line="109"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusEdit.qml" line="109"/>
        <location filename="../LocationStatusEdit.qml" line="109"/>
        <source>坐标:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusEdit.qml" line="123"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusEdit.qml" line="123"/>
        <location filename="../LocationStatusEdit.qml" line="123"/>
        <source>气候:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusEdit.qml" line="137"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusEdit.qml" line="137"/>
        <location filename="../LocationStatusEdit.qml" line="137"/>
        <source>可达性:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusEdit.qml" line="139"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusEdit.qml" line="139"/>
        <location filename="../LocationStatusEdit.qml" line="139"/>
        <source>不可达</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusEdit.qml" line="152"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusEdit.qml" line="152"/>
        <location filename="../LocationStatusEdit.qml" line="152"/>
        <source>资源列表</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusEdit.qml" line="186"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusEdit.qml" line="186"/>
        <location filename="../LocationStatusEdit.qml" line="186"/>
        <source>删除</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusEdit.qml" line="206"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusEdit.qml" line="206"/>
        <location filename="../LocationStatusEdit.qml" line="206"/>
        <source>资源名称</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusEdit.qml" line="210"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusEdit.qml" line="210"/>
        <location filename="../LocationStatusEdit.qml" line="210"/>
        <source>添加</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>LocationStatusView</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusView.qml" line="23"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusView.qml" line="23"/>
        <location filename="../LocationStatusView.qml" line="23"/>
        <source>地点信息</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusView.qml" line="47"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusView.qml" line="47"/>
        <location filename="../LocationStatusView.qml" line="47"/>
        <source>地区</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusView.qml" line="47"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusView.qml" line="51"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusView.qml" line="52"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusView.qml" line="47"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusView.qml" line="51"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusView.qml" line="52"/>
        <location filename="../LocationStatusView.qml" line="47"/>
        <location filename="../LocationStatusView.qml" line="51"/>
        <location filename="../LocationStatusView.qml" line="52"/>
        <source>未设置</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusView.qml" line="48"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusView.qml" line="48"/>
        <location filename="../LocationStatusView.qml" line="48"/>
        <source>人口</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusView.qml" line="48"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusView.qml" line="48"/>
        <location filename="../LocationStatusView.qml" line="48"/>
        <source>100万人</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusView.qml" line="49"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusView.qml" line="49"/>
        <location filename="../LocationStatusView.qml" line="49"/>
        <source>控制组织</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusView.qml" line="49"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusView.qml" line="106"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusView.qml" line="144"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusView.qml" line="49"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusView.qml" line="106"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusView.qml" line="144"/>
        <location filename="../LocationStatusView.qml" line="49"/>
        <location filename="../LocationStatusView.qml" line="106"/>
        <location filename="../LocationStatusView.qml" line="144"/>
        <source>无</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusView.qml" line="50"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusView.qml" line="50"/>
        <location filename="../LocationStatusView.qml" line="50"/>
        <source>重要性</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusView.qml" line="50"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusView.qml" line="50"/>
        <location filename="../LocationStatusView.qml" line="50"/>
        <source>罕见</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusView.qml" line="51"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusView.qml" line="51"/>
        <location filename="../LocationStatusView.qml" line="51"/>
        <source>坐标</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusView.qml" line="52"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusView.qml" line="52"/>
        <location filename="../LocationStatusView.qml" line="52"/>
        <source>气候</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusView.qml" line="53"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusView.qml" line="53"/>
        <location filename="../LocationStatusView.qml" line="53"/>
        <source>可达性</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusView.qml" line="53"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusView.qml" line="53"/>
        <location filename="../LocationStatusView.qml" line="53"/>
        <source>不可达</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusView.qml" line="94"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusView.qml" line="94"/>
        <location filename="../LocationStatusView.qml" line="94"/>
        <source>详情</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/LocationStatusView.qml" line="132"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/LocationStatusView.qml" line="132"/>
        <location filename="../LocationStatusView.qml" line="132"/>
        <source>资源列表</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>MessageBox</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/MessageBox.qml" line="17"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/MessageBox.qml" line="17"/>
        <location filename="../MessageBox.qml" line="17"/>
        <source>提示</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/MessageBox.qml" line="18"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/MessageBox.qml" line="18"/>
        <location filename="../MessageBox.qml" line="18"/>
        <source>确定要执行此操作吗？</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/MessageBox.qml" line="19"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/MessageBox.qml" line="19"/>
        <location filename="../MessageBox.qml" line="19"/>
        <source>确定</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/MessageBox.qml" line="20"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/MessageBox.qml" line="20"/>
        <location filename="../MessageBox.qml" line="20"/>
        <source>取消</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>MindMapView</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/MindMapView.qml" line="125"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/MindMapView.qml" line="125"/>
        <location filename="../MindMapView.qml" line="125"/>
        <source>添加左子节点</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/MindMapView.qml" line="130"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/MindMapView.qml" line="130"/>
        <location filename="../MindMapView.qml" line="130"/>
        <source>添加右子节点</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/MindMapView.qml" line="136"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/MindMapView.qml" line="136"/>
        <location filename="../MindMapView.qml" line="136"/>
        <source>编辑文本</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/MindMapView.qml" line="146"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/MindMapView.qml" line="146"/>
        <location filename="../MindMapView.qml" line="146"/>
        <source>删除节点</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>Node</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/Node.qml" line="77"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/Node.qml" line="77"/>
        <location filename="../Node.qml" line="77"/>
        <source>未知元素</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/Node.qml" line="121"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/Node.qml" line="121"/>
        <location filename="../Node.qml" line="121"/>
        <source>开始连接</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/Node.qml" line="129"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/Node.qml" line="129"/>
        <location filename="../Node.qml" line="129"/>
        <source>删除节点</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>NodeEditDialog</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/NodeEditDialog.qml" line="15"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/NodeEditDialog.qml" line="15"/>
        <location filename="../NodeEditDialog.qml" line="15"/>
        <source>编辑文本</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/NodeEditDialog.qml" line="37"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/NodeEditDialog.qml" line="37"/>
        <location filename="../NodeEditDialog.qml" line="37"/>
        <source>请输入新的文本:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/NodeEditDialog.qml" line="44"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/NodeEditDialog.qml" line="44"/>
        <location filename="../NodeEditDialog.qml" line="44"/>
        <source>文本</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>OptimizeArticlePopup</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OptimizeArticlePopup.qml" line="41"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OptimizeArticlePopup.qml" line="41"/>
        <location filename="../OptimizeArticlePopup.qml" line="41"/>
        <source>优化文章</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OptimizeArticlePopup.qml" line="54"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OptimizeArticlePopup.qml" line="54"/>
        <location filename="../OptimizeArticlePopup.qml" line="54"/>
        <source>如何优化文章。使语言更生动?增加细节描述?调整文章结构?提升逻辑性?</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OptimizeArticlePopup.qml" line="80"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OptimizeArticlePopup.qml" line="94"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OptimizeArticlePopup.qml" line="80"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OptimizeArticlePopup.qml" line="94"/>
        <location filename="../OptimizeArticlePopup.qml" line="80"/>
        <location filename="../OptimizeArticlePopup.qml" line="94"/>
        <source>取消</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OptimizeArticlePopup.qml" line="111"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OptimizeArticlePopup.qml" line="125"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OptimizeArticlePopup.qml" line="111"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OptimizeArticlePopup.qml" line="125"/>
        <location filename="../OptimizeArticlePopup.qml" line="111"/>
        <location filename="../OptimizeArticlePopup.qml" line="125"/>
        <source>优化</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>OrganizationStatusEdit</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusEdit.qml" line="16"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusEdit.qml" line="16"/>
        <location filename="../OrganizationStatusEdit.qml" line="16"/>
        <source>基本信息</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusEdit.qml" line="27"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusEdit.qml" line="27"/>
        <location filename="../OrganizationStatusEdit.qml" line="27"/>
        <source>详情</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusEdit.qml" line="39"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusEdit.qml" line="39"/>
        <location filename="../OrganizationStatusEdit.qml" line="39"/>
        <source>无</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusEdit.qml" line="53"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusEdit.qml" line="53"/>
        <location filename="../OrganizationStatusEdit.qml" line="53"/>
        <source>影响力:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusEdit.qml" line="67"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusEdit.qml" line="67"/>
        <location filename="../OrganizationStatusEdit.qml" line="67"/>
        <source>总部地点ID:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusEdit.qml" line="81"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusEdit.qml" line="81"/>
        <location filename="../OrganizationStatusEdit.qml" line="81"/>
        <source>目标:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusEdit.qml" line="98"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusEdit.qml" line="98"/>
        <location filename="../OrganizationStatusEdit.qml" line="98"/>
        <source>资源列表</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusEdit.qml" line="132"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusEdit.qml" line="227"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusEdit.qml" line="132"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusEdit.qml" line="227"/>
        <location filename="../OrganizationStatusEdit.qml" line="132"/>
        <location filename="../OrganizationStatusEdit.qml" line="227"/>
        <source>删除</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusEdit.qml" line="152"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusEdit.qml" line="152"/>
        <location filename="../OrganizationStatusEdit.qml" line="152"/>
        <source>资源名称</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusEdit.qml" line="156"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusEdit.qml" line="256"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusEdit.qml" line="156"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusEdit.qml" line="256"/>
        <location filename="../OrganizationStatusEdit.qml" line="156"/>
        <location filename="../OrganizationStatusEdit.qml" line="256"/>
        <source>添加</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusEdit.qml" line="176"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusEdit.qml" line="176"/>
        <location filename="../OrganizationStatusEdit.qml" line="176"/>
        <source>成员列表</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusEdit.qml" line="198"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusEdit.qml" line="247"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusEdit.qml" line="198"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusEdit.qml" line="247"/>
        <location filename="../OrganizationStatusEdit.qml" line="198"/>
        <location filename="../OrganizationStatusEdit.qml" line="247"/>
        <source>成员ID</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusEdit.qml" line="213"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusEdit.qml" line="252"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusEdit.qml" line="213"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusEdit.qml" line="252"/>
        <location filename="../OrganizationStatusEdit.qml" line="213"/>
        <location filename="../OrganizationStatusEdit.qml" line="252"/>
        <source>角色</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>OrganizationStatusView</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusView.qml" line="23"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusView.qml" line="23"/>
        <location filename="../OrganizationStatusView.qml" line="23"/>
        <source>组织信息</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusView.qml" line="47"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusView.qml" line="47"/>
        <location filename="../OrganizationStatusView.qml" line="47"/>
        <source>影响力</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusView.qml" line="48"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusView.qml" line="48"/>
        <location filename="../OrganizationStatusView.qml" line="48"/>
        <source>总部</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusView.qml" line="48"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusView.qml" line="48"/>
        <location filename="../OrganizationStatusView.qml" line="48"/>
        <source>未设置</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusView.qml" line="49"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusView.qml" line="49"/>
        <location filename="../OrganizationStatusView.qml" line="49"/>
        <source>目标</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusView.qml" line="49"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusView.qml" line="102"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusView.qml" line="49"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusView.qml" line="102"/>
        <location filename="../OrganizationStatusView.qml" line="49"/>
        <location filename="../OrganizationStatusView.qml" line="102"/>
        <source>无</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusView.qml" line="90"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusView.qml" line="90"/>
        <location filename="../OrganizationStatusView.qml" line="90"/>
        <source>详情</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusView.qml" line="128"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusView.qml" line="128"/>
        <location filename="../OrganizationStatusView.qml" line="128"/>
        <source>资源列表</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusView.qml" line="165"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusView.qml" line="165"/>
        <location filename="../OrganizationStatusView.qml" line="165"/>
        <source>成员列表</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusView.qml" line="190"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusView.qml" line="190"/>
        <location filename="../OrganizationStatusView.qml" line="190"/>
        <source>未知ID</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OrganizationStatusView.qml" line="190"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OrganizationStatusView.qml" line="190"/>
        <location filename="../OrganizationStatusView.qml" line="190"/>
        <source>未知角色</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>OutlineModel</name>
    <message>
        <location filename="../outlinemodel.cpp" line="15"/>
        <location filename="../outlinemodel.cpp" line="280"/>
        <source>中心主题</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>OutlineView</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OutlineView.qml" line="45"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OutlineView.qml" line="45"/>
        <location filename="../OutlineView.qml" line="45"/>
        <source>大纲视图</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OutlineView.qml" line="46"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OutlineView.qml" line="46"/>
        <location filename="../OutlineView.qml" line="46"/>
        <source>文本大纲</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OutlineView.qml" line="121"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OutlineView.qml" line="146"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OutlineView.qml" line="121"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OutlineView.qml" line="146"/>
        <location filename="../OutlineView.qml" line="121"/>
        <location filename="../OutlineView.qml" line="146"/>
        <source>保存</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OutlineView.qml" line="157"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OutlineView.qml" line="157"/>
        <location filename="../OutlineView.qml" line="157"/>
        <source>添加子节点</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OutlineView.qml" line="166"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OutlineView.qml" line="166"/>
        <location filename="../OutlineView.qml" line="166"/>
        <source>删除节点</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OutlineView.qml" line="176"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OutlineView.qml" line="176"/>
        <location filename="../OutlineView.qml" line="176"/>
        <source>自动布局</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/OutlineView.qml" line="186"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/OutlineView.qml" line="186"/>
        <location filename="../OutlineView.qml" line="186"/>
        <source>缩放: </source>
        <translation></translation>
    </message>
</context>
<context>
    <name>ReaderView</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ReaderView.qml" line="20"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ReaderView.qml" line="548"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ReaderView.qml" line="550"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ReaderView.qml" line="553"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ReaderView.qml" line="582"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ReaderView.qml" line="585"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ReaderView.qml" line="20"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ReaderView.qml" line="548"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ReaderView.qml" line="550"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ReaderView.qml" line="553"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ReaderView.qml" line="582"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ReaderView.qml" line="585"/>
        <location filename="../ReaderView.qml" line="20"/>
        <location filename="../ReaderView.qml" line="548"/>
        <location filename="../ReaderView.qml" line="550"/>
        <location filename="../ReaderView.qml" line="553"/>
        <location filename="../ReaderView.qml" line="582"/>
        <location filename="../ReaderView.qml" line="585"/>
        <source>无标题章节</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ReaderView.qml" line="197"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ReaderView.qml" line="197"/>
        <location filename="../ReaderView.qml" line="197"/>
        <source>返回编辑</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ReaderView.qml" line="265"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ReaderView.qml" line="265"/>
        <location filename="../ReaderView.qml" line="265"/>
        <source>字体大小:</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ReaderView.qml" line="330"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ReaderView.qml" line="330"/>
        <location filename="../ReaderView.qml" line="330"/>
        <source>AI点评</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ReaderView.qml" line="517"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ReaderView.qml" line="517"/>
        <location filename="../ReaderView.qml" line="517"/>
        <source>字数: </source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ReaderView.qml" line="531"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ReaderView.qml" line="531"/>
        <location filename="../ReaderView.qml" line="531"/>
        <source>AI读者视角</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ReaderView.qml" line="564"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ReaderView.qml" line="564"/>
        <location filename="../ReaderView.qml" line="564"/>
        <source>请选择左侧故事树中的一个章节进行阅读</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/ReaderView.qml" line="575"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/ReaderView.qml" line="575"/>
        <location filename="../ReaderView.qml" line="575"/>
        <source>请选择左侧故事树中的一个章节进行阅读

AI读者视角提供了更舒适的阅读体验，适合查看和审阅作品。</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>RightPanel</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="28"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="28"/>
        <location filename="../RightPanel.qml" line="28"/>
        <source>+ 新建人物</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="30"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="30"/>
        <location filename="../RightPanel.qml" line="30"/>
        <source>新人物</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="35"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="35"/>
        <location filename="../RightPanel.qml" line="35"/>
        <source>+ 新建地点</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="37"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="37"/>
        <location filename="../RightPanel.qml" line="37"/>
        <source>新地点</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="42"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="42"/>
        <location filename="../RightPanel.qml" line="42"/>
        <source>+ 新建道具</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="44"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="44"/>
        <location filename="../RightPanel.qml" line="44"/>
        <source>新道具</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="49"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="49"/>
        <location filename="../RightPanel.qml" line="49"/>
        <source>+ 新建能力</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="51"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="51"/>
        <location filename="../RightPanel.qml" line="51"/>
        <source>新能力</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="56"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="56"/>
        <location filename="../RightPanel.qml" line="56"/>
        <source>+ 新建组织</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="58"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="58"/>
        <location filename="../RightPanel.qml" line="58"/>
        <source>新组织</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="63"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="63"/>
        <location filename="../RightPanel.qml" line="63"/>
        <source>+ 新建事件</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="65"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="65"/>
        <location filename="../RightPanel.qml" line="65"/>
        <source>新事件</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="171"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="171"/>
        <location filename="../RightPanel.qml" line="171"/>
        <source>展开</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="171"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="171"/>
        <location filename="../RightPanel.qml" line="171"/>
        <source>收起</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="179"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="179"/>
        <location filename="../RightPanel.qml" line="179"/>
        <source>伏笔库</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="179"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="179"/>
        <location filename="../RightPanel.qml" line="179"/>
        <source>元素库</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="230"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="230"/>
        <location filename="../RightPanel.qml" line="230"/>
        <source>人物</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="241"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="241"/>
        <location filename="../RightPanel.qml" line="241"/>
        <source>地点</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="251"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="251"/>
        <location filename="../RightPanel.qml" line="251"/>
        <source>道具</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="261"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="261"/>
        <location filename="../RightPanel.qml" line="261"/>
        <source>能力</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="271"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="271"/>
        <location filename="../RightPanel.qml" line="271"/>
        <source>组织</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="281"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="281"/>
        <location filename="../RightPanel.qml" line="281"/>
        <source>事件</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="394"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="394"/>
        <location filename="../RightPanel.qml" line="394"/>
        <source>&lt;b&gt;原文：&lt;/b&gt;</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="408"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="408"/>
        <location filename="../RightPanel.qml" line="408"/>
        <source>&lt;b&gt;描述: &lt;/b&gt;</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="434"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="434"/>
        <location filename="../RightPanel.qml" line="434"/>
        <source>&lt;b&gt;来自章节:&lt;/b&gt; </source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="463"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="463"/>
        <location filename="../RightPanel.qml" line="463"/>
        <source>标记完成</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="463"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="463"/>
        <location filename="../RightPanel.qml" line="463"/>
        <source>未完成</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/RightPanel.qml" line="499"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/RightPanel.qml" line="499"/>
        <location filename="../RightPanel.qml" line="499"/>
        <source>AI创建</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>TopBar</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/TopBar.qml" line="96"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/TopBar.qml" line="96"/>
        <location filename="../TopBar.qml" line="96"/>
        <source>写作</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/TopBar.qml" line="135"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/TopBar.qml" line="135"/>
        <location filename="../TopBar.qml" line="135"/>
        <source>图谱</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/TopBar.qml" line="174"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/TopBar.qml" line="174"/>
        <location filename="../TopBar.qml" line="174"/>
        <source>大纲</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/TopBar.qml" line="213"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/TopBar.qml" line="213"/>
        <location filename="../TopBar.qml" line="213"/>
        <source>世界观</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/TopBar.qml" line="259"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/TopBar.qml" line="259"/>
        <location filename="../TopBar.qml" line="259"/>
        <source>新建</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/TopBar.qml" line="262"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/TopBar.qml" line="745"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/TopBar.qml" line="262"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/TopBar.qml" line="745"/>
        <location filename="../TopBar.qml" line="262"/>
        <location filename="../TopBar.qml" line="745"/>
        <source>新建项目</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/TopBar.qml" line="286"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/TopBar.qml" line="286"/>
        <location filename="../TopBar.qml" line="286"/>
        <source>保存</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/TopBar.qml" line="290"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/TopBar.qml" line="290"/>
        <location filename="../TopBar.qml" line="290"/>
        <source>快速保存（立即保存当前项目）</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/TopBar.qml" line="325"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/TopBar.qml" line="325"/>
        <location filename="../TopBar.qml" line="325"/>
        <source>另存为</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/TopBar.qml" line="355"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/TopBar.qml" line="355"/>
        <location filename="../TopBar.qml" line="355"/>
        <source>加载</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/TopBar.qml" line="391"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/TopBar.qml" line="391"/>
        <location filename="../TopBar.qml" line="391"/>
        <source>设置和视图选项</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/TopBar.qml" line="443"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/TopBar.qml" line="443"/>
        <location filename="../TopBar.qml" line="443"/>
        <source>设置</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/TopBar.qml" line="470"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/TopBar.qml" line="470"/>
        <location filename="../TopBar.qml" line="470"/>
        <source>语言</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/TopBar.qml" line="475"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/TopBar.qml" line="475"/>
        <location filename="../TopBar.qml" line="475"/>
        <source>中文</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/TopBar.qml" line="518"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/TopBar.qml" line="518"/>
        <location filename="../TopBar.qml" line="518"/>
        <source>切换读者视角</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/TopBar.qml" line="662"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/TopBar.qml" line="662"/>
        <location filename="../TopBar.qml" line="662"/>
        <source>选择文件</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/TopBar.qml" line="755"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/TopBar.qml" line="755"/>
        <location filename="../TopBar.qml" line="755"/>
        <source>请输入项目名称：</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/TopBar.qml" line="762"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/TopBar.qml" line="762"/>
        <location filename="../TopBar.qml" line="762"/>
        <source>项目名称</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>VocabularyHelperPopup</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/VocabularyHelperPopup.qml" line="29"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/VocabularyHelperPopup.qml" line="29"/>
        <location filename="../VocabularyHelperPopup.qml" line="29"/>
        <source>语气</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/VocabularyHelperPopup.qml" line="30"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/VocabularyHelperPopup.qml" line="30"/>
        <location filename="../VocabularyHelperPopup.qml" line="30"/>
        <source>动作词</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/VocabularyHelperPopup.qml" line="31"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/VocabularyHelperPopup.qml" line="31"/>
        <location filename="../VocabularyHelperPopup.qml" line="31"/>
        <source>眼睛</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/VocabularyHelperPopup.qml" line="32"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/VocabularyHelperPopup.qml" line="32"/>
        <location filename="../VocabularyHelperPopup.qml" line="32"/>
        <source>心理</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/VocabularyHelperPopup.qml" line="33"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/VocabularyHelperPopup.qml" line="33"/>
        <location filename="../VocabularyHelperPopup.qml" line="33"/>
        <source>环境</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/VocabularyHelperPopup.qml" line="34"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/VocabularyHelperPopup.qml" line="34"/>
        <location filename="../VocabularyHelperPopup.qml" line="34"/>
        <source>外貌</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/VocabularyHelperPopup.qml" line="35"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/VocabularyHelperPopup.qml" line="35"/>
        <location filename="../VocabularyHelperPopup.qml" line="35"/>
        <source>声音</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/VocabularyHelperPopup.qml" line="36"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/VocabularyHelperPopup.qml" line="36"/>
        <location filename="../VocabularyHelperPopup.qml" line="36"/>
        <source>对话</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/VocabularyHelperPopup.qml" line="37"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/VocabularyHelperPopup.qml" line="37"/>
        <location filename="../VocabularyHelperPopup.qml" line="37"/>
        <source>战斗</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/VocabularyHelperPopup.qml" line="38"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/VocabularyHelperPopup.qml" line="38"/>
        <location filename="../VocabularyHelperPopup.qml" line="38"/>
        <source>场景</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/VocabularyHelperPopup.qml" line="39"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/VocabularyHelperPopup.qml" line="39"/>
        <location filename="../VocabularyHelperPopup.qml" line="39"/>
        <source>修真术语</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/VocabularyHelperPopup.qml" line="40"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/VocabularyHelperPopup.qml" line="40"/>
        <location filename="../VocabularyHelperPopup.qml" line="40"/>
        <source>身份头衔</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/VocabularyHelperPopup.qml" line="41"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/VocabularyHelperPopup.qml" line="41"/>
        <location filename="../VocabularyHelperPopup.qml" line="41"/>
        <source>物品名</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/VocabularyHelperPopup.qml" line="42"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/VocabularyHelperPopup.qml" line="42"/>
        <location filename="../VocabularyHelperPopup.qml" line="42"/>
        <source>抽象概念</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/VocabularyHelperPopup.qml" line="43"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/VocabularyHelperPopup.qml" line="43"/>
        <location filename="../VocabularyHelperPopup.qml" line="43"/>
        <source>能量</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/VocabularyHelperPopup.qml" line="76"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/VocabularyHelperPopup.qml" line="76"/>
        <location filename="../VocabularyHelperPopup.qml" line="76"/>
        <source>辅助词汇库</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/VocabularyHelperPopup.qml" line="93"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/VocabularyHelperPopup.qml" line="93"/>
        <location filename="../VocabularyHelperPopup.qml" line="93"/>
        <source>搜索当前分类词汇...</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/VocabularyHelperPopup.qml" line="108"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/VocabularyHelperPopup.qml" line="108"/>
        <location filename="../VocabularyHelperPopup.qml" line="108"/>
        <source>清空</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/VocabularyHelperPopup.qml" line="251"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/VocabularyHelperPopup.qml" line="251"/>
        <location filename="../VocabularyHelperPopup.qml" line="251"/>
        <source>关闭</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/VocabularyHelperPopup.qml" line="276"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/VocabularyHelperPopup.qml" line="276"/>
        <location filename="../VocabularyHelperPopup.qml" line="276"/>
        <source>已复制</source>
        <translation></translation>
    </message>
</context>
<context>
    <name>WorldbuildingView</name>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/WorldbuildingView.qml" line="29"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/WorldbuildingView.qml" line="29"/>
        <location filename="../WorldbuildingView.qml" line="29"/>
        <source>地理</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/WorldbuildingView.qml" line="30"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/WorldbuildingView.qml" line="30"/>
        <location filename="../WorldbuildingView.qml" line="30"/>
        <source>历史</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/WorldbuildingView.qml" line="31"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/WorldbuildingView.qml" line="31"/>
        <location filename="../WorldbuildingView.qml" line="31"/>
        <source>文化</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/WorldbuildingView.qml" line="32"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/WorldbuildingView.qml" line="32"/>
        <location filename="../WorldbuildingView.qml" line="32"/>
        <source>种族</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/WorldbuildingView.qml" line="77"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/WorldbuildingView.qml" line="77"/>
        <location filename="../WorldbuildingView.qml" line="77"/>
        <source>+ 添加分类</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/WorldbuildingView.qml" line="105"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/WorldbuildingView.qml" line="105"/>
        <location filename="../WorldbuildingView.qml" line="105"/>
        <source>世界观 - </source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/WorldbuildingView.qml" line="209"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/WorldbuildingView.qml" line="209"/>
        <location filename="../WorldbuildingView.qml" line="209"/>
        <source>添加新分类</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/WorldbuildingView.qml" line="220"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/WorldbuildingView.qml" line="220"/>
        <location filename="../WorldbuildingView.qml" line="220"/>
        <source>请输入新分类名称：</source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Debug/storyScience/WorldbuildingView.qml" line="227"/>
        <location filename="../build/Desktop_Qt_6_8_3_MSVC2022_64bit-Release/storyScience/WorldbuildingView.qml" line="227"/>
        <location filename="../WorldbuildingView.qml" line="227"/>
        <source>分类名称</source>
        <translation></translation>
    </message>
</context>
</TS>
