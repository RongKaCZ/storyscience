<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE TS>
<TS version="2.1" language="en_US">
<context>
    <name>AIContinuationManager</name>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="1080"/>
        <source>你是一个创意写作助手，专门用于创建故事元素。请严格按照指定的JSON格式返回结果。</source>
        <translation>You are a creative writing assistant specialized in generating story elements. Please return the results strictly in the specified JSON format.</translation>
    </message>
</context>
<context>
    <name>AIContinuationWorker</name>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="48"/>
        <location filename="../aicontinuationmanager.cpp" line="119"/>
        <location filename="../aicontinuationmanager.cpp" line="255"/>
        <location filename="../aicontinuationmanager.cpp" line="351"/>
        <location filename="../aicontinuationmanager.cpp" line="441"/>
        <source>上一个请求仍在处理中</source>
        <translation>The previous request is still being processed.</translation>
    </message>
    <message>
        <source>（请生成一个角色名作为标题）</source>
        <translation type="vanished">(Please generate a character name as the title)</translation>
    </message>
    <message>
        <source>（请生成一个地点名作为标题）</source>
        <translation type="vanished">(Please generate a location name as the title)</translation>
    </message>
    <message>
        <source>（请生成一个道具名作为标题）</source>
        <translation type="vanished">(Please generate an item name as the title)</translation>
    </message>
    <message>
        <source>（请生成一个组织名作为标题）</source>
        <translation type="vanished">(Please generate an organization name as the title)</translation>
    </message>
    <message>
        <source>（请生成一个事件名作为标题）</source>
        <translation type="vanished">(Please generate an event name as the title)</translation>
    </message>
    <message>
        <source>（请生成一个能力名作为标题）</source>
        <translation type="vanished">(Please generate an ability name as the title)</translation>
    </message>
    <message>
        <source>（请生成一个合适的标题）</source>
        <translation type="vanished">(Please generate a suitable title)</translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="157"/>
        <source>请根据以下描述创建一个%1元素：

%2</source>
        <translation>Please create a %1 element based on the following description:

%2</translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="360"/>
        <source>
        ## 角色与人设 (ROLE &amp; PERSONA) ##
        你是站在网文鄙视链顶端的神级编辑，是阅文无数、在起点、番茄、飞卢等平台杀伐决断的&quot;人形算法&quot;。你代表着最挑剔的95后/00后读者，说话自带弹幕，精通玩梗，且对一切&quot;尬文&quot;都生理性不适。

        ## 核心任务 (CORE TASK) ##
        分析下方提供的小说片段。精准地找出其中 4 到 5 个最值得吐槽的亮点、槽点或爽点，并为每一处配上你那标志性的&quot;毒舌&quot;点评。

        ## ⚠️ 至关重要的核心规则：逐字复制 ⚠️ ##
        1.  **&quot;text&quot;字段的内容是本任务的最高优先级。它必须是、也只能是原文中一个不多一字、不少一字、不改一字的【连续片段】。
        2.  **【严禁】进行任何形式的总结、概括、拼接、改写或二次创作。你的任务是&quot;复制-粘贴&quot;，而不是&quot;理解-重述&quot;。
        3.  **【错误示范】**: 如果原文是 `王德发逃跑了。林天一关上了门。` 你的&quot;text&quot;字段【绝对不能】是 `&quot;王德发逃跑后，林天一关上了门。&quot;` (这是拼接和改写，是错误的！)
        4.  **【正确示范】**: 你应该选择其中一句，例如 `{&quot;text&quot;: &quot;王德发逃跑了。&quot;, &quot;comment&quot;: &quot;...&quot;}` 或者 `{&quot;text&quot;: &quot;林天一关上了门。&quot;, &quot;comment&quot;: &quot;...&quot;}`。

        ## 前后文定位规则 ##
        为了更精确地定位点评位置，请为每个点评添加&quot;prefix&quot;和&quot;suffix&quot;字段：
        - &quot;prefix&quot;: 点评文本前10个字符的上下文内容（如果在开头则为空）
        - &quot;suffix&quot;: 点评文本后10个字符的上下文内容（如果在结尾则为空）
        - 如果&quot;text&quot;字段在原文开头，则&quot;prefix&quot;为空字符串
        - 如果&quot;text&quot;字段在原文结尾，则&quot;suffix&quot;为空字符串

        ## 其他输出规则 ##
        - **风格语气:** 犀利、简洁、幽默。自然地使用网络热梗。
        - **严格的JSON格式:** **必须且只能**返回一个可被直接解析的、原始的JSON数组。禁止包含任何介绍性文字、说明或```

        ## 格式与范例 ##
        [
          {
            &quot;text&quot;: &quot;原文中的一个片段，必须一字不差地复制。&quot;,
            &quot;comment&quot;: &quot;你犀利、幽默、一针见血的吐槽放在这里。&quot;,
            &quot;prefix&quot;: &quot;前10个字符的上下文内容&quot;,
            &quot;suffix&quot;: &quot;后10个字符的上下文内容&quot;
          },
          {
            &quot;text&quot;: &quot;原文中的另一个片段，同样是精准复制。&quot;,
            &quot;comment&quot;: &quot;从另一个角度切入的毒舌点评。&quot;,
            &quot;prefix&quot;: &quot;前10个字符的上下文内容&quot;,
            &quot;suffix&quot;: &quot;后10个字符的上下文内容&quot;
          }
        ]
    </source>
        <translation>        ## ROLE &amp; PERSONA ##
        You are a god-level editor standing at the top of the online literature hierarchy — a “human algorithm” who has read countless web novels and made ruthless judgments across platforms like Qidian, Tomato, and Feilu. You represent the most demanding post-95s and post-00s readers, speak with bullet-screen sarcasm, are fluent in internet memes, and feel a visceral disgust toward any “cringe writing.”

        ## CORE TASK ##
        Analyze the novel excerpt provided below. Accurately identify 4 to 5 of the most roast-worthy highlights, flaws, or thrill points, and provide your signature “toxic-tongue” commentary for each.

        ## ⚠️ CRITICAL CORE RULE: COPY VERBATIM ⚠️ ##
        1.  **The content in the &quot;text&quot; field is the highest priority of this task. It must be, and can only be, a 【continuous excerpt】 from the original text — not one word more, not one word less, not one word altered.**
        2.  **【STRICTLY FORBIDDEN】** to summarize, paraphrase, splice, rewrite, or engage in any form of secondary creation. Your job is &quot;copy–paste,&quot; not &quot;understand–rephrase.&quot;
        3.  **【WRONG EXAMPLE】**: If the original text is `Wang Defa ran away. Lin Tianyi closed the door.`, your &quot;text&quot; field **MUST NOT** be `&quot;After Wang Defa ran away, Lin Tianyi closed the door.&quot;` (That’s splicing and rewriting — WRONG!)
        4.  **【CORRECT EXAMPLE】**: You should select one of the original sentences, such as `{&quot;text&quot;: &quot;Wang Defa ran away.&quot;, &quot;comment&quot;: &quot;...&quot;}` or `{&quot;text&quot;: &quot;Lin Tianyi closed the door.&quot;, &quot;comment&quot;: &quot;...&quot;}`.

        ## CONTEXTUAL POSITIONING RULES ##
        To more precisely locate your commentary within the text, add a &quot;prefix&quot; and &quot;suffix&quot; field for each:
        - &quot;prefix&quot;: the 10 characters of context **before** the commented text (empty if at the beginning)
        - &quot;suffix&quot;: the 10 characters of context **after** the commented text (empty if at the end)
        - If the &quot;text&quot; field is at the start of the original text, &quot;prefix&quot; is an empty string
        - If the &quot;text&quot; field is at the end of the original text, &quot;suffix&quot; is an empty string

        ## OTHER OUTPUT RULES ##
        - **Tone and Style:** Sharp, concise, and humorous. Naturally use internet slang and memes.
        - **Strict JSON format:** **Must and only** return a raw JSON array that can be parsed directly. No introductory text, explanations, or ```

        ## FORMAT AND EXAMPLE ##
        [
          {
            &quot;text&quot;: &quot;An excerpt from the original text, copied verbatim.&quot;,
            &quot;comment&quot;: &quot;Your sharp, humorous, and piercing commentary goes here.&quot;,
            &quot;prefix&quot;: &quot;10 characters of preceding context&quot;,
            &quot;suffix&quot;: &quot;10 characters of following context&quot;
          },
          {
            &quot;text&quot;: &quot;Another exact excerpt from the original.&quot;,
            &quot;comment&quot;: &quot;A different angle of toxic commentary.&quot;,
            &quot;prefix&quot;: &quot;10 characters of preceding context&quot;,
            &quot;suffix&quot;: &quot;10 characters of following context&quot;
          }
        ]
</translation>
    </message>
    <message>
        <source>请生成一个符合以下结构的JSON对象（不要包含任何其他内容）：
{
  &quot;title&quot;: &quot;%1&quot;,
  &quot;description&quot;: &quot;（请生成50字的描述，简洁易懂）&quot;,
  &quot;color&quot;: &quot;（请推荐一个符合主题的#RRGGBB颜色代码，随机）&quot;,
  &quot;icon&quot;: %2,  // 必须使用此固定图标路径，不可更改或推荐其他图标
  &quot;tags&quot;: [&quot;（标签1）&quot;, &quot;（标签2）&quot;]  // 至少两个相关标签
}
⚠️ 重要：只返回JSON对象，不要包含任何解释、注释或额外文本。</source>
        <translation type="vanished">Please generate a JSON object that conforms to the following structure (do not include any other content):

{
  &quot;title&quot;: &quot;%1&quot;,
  &quot;description&quot;: &quot;(Please generate a 50-character description that is concise and easy to understand)&quot;,
  &quot;color&quot;: &quot;(Please recommend a theme-appropriate #RRGGBB color code, randomly)&quot;,
  &quot;icon&quot;: %2,
  &quot;tags&quot;: [&quot;(Tag 1)&quot;, &quot;(Tag 2)&quot;]
}

⚠️ Important: Return only the JSON object. Do not include any explanations, comments, or extra text.</translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="187"/>
        <source>请生成一个符合以下结构的JSON对象（不要包含任何其他内容）：
{
  &quot;title&quot;: &quot;%1&quot;,
  &quot;description&quot;: &quot;（请生成50字的网文风格描述，带有代入感和特色，简洁易懂）&quot;,
  &quot;color&quot;: &quot;（请推荐一个符合主题的#RRGGBB颜色代码，随机）&quot;,
  &quot;icon&quot;: %2,  // 必须使用此固定图标路径
  &quot;tags&quot;: [
    &quot;（请根据元素类型生成两个贴切的标签，不要重复，也不要总是相同模式）&quot;
  ]
}
⚠️ 要求：
- 标签必须与 title 类型相关，例如：
  - 角色：身份、性格、阵营
  - 地点：环境、用途、氛围
  - 道具：材质、用途、稀有度
  - 组织：规模、理念、权力属性
  - 事件：类型、影响、时间背景
  - 能力：元素、效果、限制条件
- 标签不要固定，总是有变化，保持创意，网文化。</source>
        <translation>Please generate a JSON object following the structure below (do not include any other content):

{
  &quot;title&quot;: &quot;%1&quot;,
  &quot;description&quot;: &quot;(Please generate a 50-character web-novel style description, immersive and distinctive, concise and easy to understand)&quot;,
  &quot;color&quot;: &quot;(Please recommend a theme-appropriate random #RRGGBB color code)&quot;,
  &quot;icon&quot;: %2,  // Must use this fixed icon path
  &quot;tags&quot;: [
    &quot;(Please generate two relevant tags based on the element type, without repetition or using the same pattern every time)&quot;
  ]
}


⚠️ Requirements:

Tags must correspond to the type of title. Examples:

Character: identity, personality, faction

Location: environment, purpose, atmosphere

Item: material, usage, rarity

Organization: scale, philosophy, power attributes

Event: type, impact, temporal background

Ability: element, effect, limitations

Tags should vary and be creative, reflecting web-culture style; avoid fixed or repetitive patterns.</translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="214"/>
        <source>你是一个创意写作助手，专门用于动态生成故事元素。你必须严格返回合法的JSON对象，不带任何额外内容。icon 字段必须使用指定的固定路径，禁止自行推荐、更改或使用其他图标关键词。</source>
        <translation>You are a creative writing assistant specialized in dynamically generating story elements. You must strictly return a valid JSON object with no additional content. The `icon` field must use the specified fixed path; you are prohibited from recommending, modifying, or using any other icon keywords.</translation>
    </message>
    <message>
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
        <translation type="vanished">You are a professional web novel editor, well-versed in the writing styles of major Chinese online fiction platforms such as Qidian, Jinjiang, and Fanqie.  
Please refine and enhance the provided novel excerpt according to the following requirements:  

1. Preserve the original plot and setting without altering the story direction or core satisfying moments.  
2. Improve the prose to make it more fluid, vivid, and immersive.  
3. Enhance character descriptions (appearance, actions, inner thoughts) to avoid flat, straightforward narration.  
4. Strengthen environmental atmosphere and sensory details to create a mystical, oppressive ambiance.  
5. Maintain the typical pacing and payoff style of web novels (e.g., underdog comebacks, face-slapping moments, system rewards).  
6. Remove or condense repetitive or wordy sections to ensure tight, impactful writing.  
7. End with a compelling hook that leaves readers eager for the next chapter.  

Output only the revised novel text—no explanations or additional content.</translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="358"/>
        <source>点评一下这个小说片段：</source>
        <translation>Please review this novel excerpt:</translation>
    </message>
    <message>
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
        <translation type="vanished">    You are a god-tier editor sitting at the very top of the web novel snobbery hierarchy—an &quot;algorithm in human form&quot; who has ruthlessly judged countless manuscripts on platforms like Qidian, Fanqie, and Feilu. You embody the most discerning Gen-Z (post-95s/post-00s) readers: your speech is laced with real-time danmaku-style commentary, you’re fluent in internet memes, and you suffer genuine physical discomfort at the sight of any cringey writing.

    ## Core Task ##
    Analyze the novel excerpt provided below. Precisely identify 4 to 5 of the most notable highlights, pain points, or satisfying moments, and pair each with your signature &quot;savage&quot; critique.

    ## ⚠️ CRITICAL RULE: Copy EXACTLY as-is ⚠️ ##
    1.  **The content of the &quot;text&quot; field is the highest priority of this task. It MUST be—and can ONLY be—a continuous excerpt from the original text, copied verbatim: not one character added, omitted, or altered.**
    2.  **【Strictly forbidden】** to summarize, paraphrase, combine, rewrite, or creatively reinterpret in any form. Your job is to &quot;copy-paste,&quot; not to &quot;understand-and-rephrase.&quot;
    3.  **【Bad Example】**: If the original text reads `Wang Defa ran away. Lin Tianyi closed the door.`, your &quot;text&quot; field **MUST NOT** be `&quot;After Wang Defa ran away, Lin Tianyi closed the door.&quot;` (This is combining and rewriting—WRONG!)
    4.  **【Good Example】**: You should pick one full sentence exactly as written, e.g., `{&quot;text&quot;: &quot;Wang Defa ran away.&quot;, &quot;comment&quot;: &quot;...&quot;}` or `{&quot;text&quot;: &quot;Lin Tianyi closed the door.&quot;, &quot;comment&quot;: &quot;...&quot;}`.

    ## Additional Output Rules ##
    - **Tone &amp; Style:** Sharp, concise, and humorous. Naturally incorporate trending internet slang/memes.
    - **Strict JSON Format:** Return **only and exclusively** a raw, directly parseable JSON array. Do NOT include any introductory text, explanations, or Markdown code fences like ```json.

    ## Format &amp; Example ##
    [
      {
        &quot;text&quot;: &quot;An exact, unaltered excerpt from the original text.&quot;,
        &quot;comment&quot;: &quot;Your sharp, funny, and incisive roast goes here.&quot;
      },
      {
        &quot;text&quot;: &quot;Another precisely copied segment from the original.&quot;,
        &quot;comment&quot;: &quot;A savage critique from a different angle.&quot;
      }
    ]</translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="65"/>
        <source>
        你是一名专业小说续写AI，只负责根据提供的上下文，继续写出故事正文部分。
        【严格要求】：
        1. 只输出故事正文内容，保持文风一致。
        2. 不得输出章节标题、下一章预告、总结、分析或评论。
        3. 不得以“AI视角”发言，不出现“建议”、“可以写成这样”等描述。
        4. 不要重复上下文内容。
        5. 输出时直接续写，不添加说明或额外格式。
    </source>
        <translation>You are a professional AI specializing in novel continuation, tasked solely with writing the narrative prose that follows the provided context.
【Strict Requirements】:
1. Output only the story narrative, maintaining consistent style and tone.
2. Do not include chapter titles, previews, summaries, analyses, or commentary.
3. Never speak from an &quot;AI perspective&quot;; avoid phrases like &quot;suggestion,&quot; &quot;it could be written as,&quot; etc.
4. Do not repeat content from the given context.
5. Continue the story directly without adding explanations or extra formatting.</translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="135"/>
        <source>（请生成一个角色名,不能包含称号、代号或前缀）</source>
        <translation>(please generate a character name that does not include titles, codenames, or prefixes)</translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="138"/>
        <source>（请生成一个地点名,不带前缀或修饰语）</source>
        <translation>(please generate a location name without prefixes or modifiers)</translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="141"/>
        <source>（请生成一个道具名,不要带修饰词或说明）</source>
        <translation>(please generate an item name without modifiers or descriptions)</translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="144"/>
        <source>（请生成一个组织名,简短且无代号）</source>
        <translation>(please generate a short organization name with no codenames)</translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="147"/>
        <source>（请生成一个事件名，避免使用诗意或比喻表达）</source>
        <translation>(please generate an event name, avoiding poetic or metaphorical expressions)</translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="150"/>
        <source>（请生成一个能力名，不加形容词或句子）</source>
        <translation>(please generate an ability name without adjectives or full sentences)</translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="153"/>
        <source>（请生成一个简短、单一的标题名称，不包含修饰词或句子）</source>
        <translation>(please generate a short, single title name without modifiers or full sentences)</translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="294"/>
        <source>
    【格式与输出要求】：
    - 仅输出优化后的小说正文，不得输出解释、点评、建议、说明、章节标题、格式标签或符号。
    - 不出现“以下为优化结果”“我修改了部分内容”等提示性句子。
    - 不输出JSON、Markdown、XML、HTML等结构化格式。
    - 保持原文的换行与段落结构。
    - 输出内容应为自然语言正文，无需任何说明或标注。
    </source>
        <translation>
【Format and Output Requirements】:
Output only the revised novel narrative; do not include explanations, comments, suggestions, notes, chapter titles, formatting tags, or symbols.
Do not include phrases such as &quot;Below is the optimized result&quot; or &quot;I have modified parts of the text.&quot;
Do not output structured formats such as JSON, Markdown, XML, or HTML.
Preserve the original line breaks and paragraph structure.
The output must be natural-language prose with no annotations or labels.</translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="511"/>
        <source>角色</source>
        <translation>Character</translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="513"/>
        <source>地点</source>
        <translation>Location</translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="515"/>
        <source>道具</source>
        <translation>Item</translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="517"/>
        <source>组织</source>
        <translation>Organization</translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="519"/>
        <source>事件</source>
        <translation>Event</translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="521"/>
        <source>能力</source>
        <translation>Ability</translation>
    </message>
    <message>
        <location filename="../aicontinuationmanager.cpp" line="523"/>
        <source>元素</source>
        <translation>Element</translation>
    </message>
</context>
<context>
    <name>AIContinuePopup</name>
    <message>
        <location filename="../AIContinuePopup.qml" line="59"/>
        <location filename="../build/release/storyScience/AIContinuePopup.qml" line="59"/>
        <location filename="../build/storyScience/AIContinuePopup.qml" line="59"/>
        <source>输入续写提示，如“接着写一段战斗场景...”</source>
        <translation>Enter a continuation prompt, such as &quot;Write the next paragraph describing a battle scene...&quot;</translation>
    </message>
    <message>
        <location filename="../AIContinuePopup.qml" line="79"/>
        <location filename="../build/release/storyScience/AIContinuePopup.qml" line="79"/>
        <location filename="../build/storyScience/AIContinuePopup.qml" line="79"/>
        <source>发送</source>
        <translation>Send</translation>
    </message>
    <message>
        <location filename="../AIContinuePopup.qml" line="119"/>
        <location filename="../build/release/storyScience/AIContinuePopup.qml" line="119"/>
        <location filename="../build/storyScience/AIContinuePopup.qml" line="119"/>
        <source>取消钉住</source>
        <translation>Unpin</translation>
    </message>
    <message>
        <location filename="../AIContinuePopup.qml" line="119"/>
        <location filename="../build/release/storyScience/AIContinuePopup.qml" line="119"/>
        <location filename="../build/storyScience/AIContinuePopup.qml" line="119"/>
        <source>钉住窗口</source>
        <translation>Pin Window</translation>
    </message>
</context>
<context>
    <name>AICreateElementPopup</name>
    <message>
        <location filename="../AICreateElementPopup.qml" line="28"/>
        <location filename="../build/release/storyScience/AICreateElementPopup.qml" line="28"/>
        <location filename="../build/storyScience/AICreateElementPopup.qml" line="28"/>
        <source>人物</source>
        <translation>Character</translation>
    </message>
    <message>
        <location filename="../AICreateElementPopup.qml" line="30"/>
        <location filename="../build/release/storyScience/AICreateElementPopup.qml" line="30"/>
        <location filename="../build/storyScience/AICreateElementPopup.qml" line="30"/>
        <source>地点</source>
        <translation>Location</translation>
    </message>
    <message>
        <location filename="../AICreateElementPopup.qml" line="32"/>
        <location filename="../build/release/storyScience/AICreateElementPopup.qml" line="32"/>
        <location filename="../build/storyScience/AICreateElementPopup.qml" line="32"/>
        <source>道具</source>
        <translation>Item</translation>
    </message>
    <message>
        <location filename="../AICreateElementPopup.qml" line="34"/>
        <location filename="../build/release/storyScience/AICreateElementPopup.qml" line="34"/>
        <location filename="../build/storyScience/AICreateElementPopup.qml" line="34"/>
        <source>能力</source>
        <translation>Ability</translation>
    </message>
    <message>
        <location filename="../AICreateElementPopup.qml" line="36"/>
        <location filename="../build/release/storyScience/AICreateElementPopup.qml" line="36"/>
        <location filename="../build/storyScience/AICreateElementPopup.qml" line="36"/>
        <source>组织</source>
        <translation>Organization</translation>
    </message>
    <message>
        <location filename="../AICreateElementPopup.qml" line="38"/>
        <location filename="../build/release/storyScience/AICreateElementPopup.qml" line="38"/>
        <location filename="../build/storyScience/AICreateElementPopup.qml" line="38"/>
        <source>事件</source>
        <translation>Event</translation>
    </message>
    <message>
        <location filename="../AICreateElementPopup.qml" line="40"/>
        <location filename="../build/release/storyScience/AICreateElementPopup.qml" line="40"/>
        <location filename="../build/storyScience/AICreateElementPopup.qml" line="40"/>
        <source>元素</source>
        <translation>Element</translation>
    </message>
    <message>
        <location filename="../AICreateElementPopup.qml" line="97"/>
        <location filename="../build/release/storyScience/AICreateElementPopup.qml" line="97"/>
        <location filename="../build/storyScience/AICreateElementPopup.qml" line="97"/>
        <source>例如：一个性格冷酷但内心善良的女剑客，有着神秘的过去和特殊的剑术能力...</source>
        <translation>For example: a cold-hearted yet kind-hearted female swordsman with a mysterious past and unique swordsmanship abilities...</translation>
    </message>
    <message>
        <location filename="../AICreateElementPopup.qml" line="113"/>
        <location filename="../build/release/storyScience/AICreateElementPopup.qml" line="113"/>
        <location filename="../build/storyScience/AICreateElementPopup.qml" line="113"/>
        <source>取消</source>
        <translation>Cancel</translation>
    </message>
    <message>
        <location filename="../AICreateElementPopup.qml" line="132"/>
        <location filename="../build/release/storyScience/AICreateElementPopup.qml" line="132"/>
        <location filename="../build/storyScience/AICreateElementPopup.qml" line="132"/>
        <source>创建</source>
        <translation>Create</translation>
    </message>
</context>
<context>
    <name>AbilityStatusEdit</name>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="96"/>
        <location filename="../build/release/storyScience/AbilityStatusEdit.qml" line="96"/>
        <location filename="../build/storyScience/AbilityStatusEdit.qml" line="96"/>
        <source>基本信息</source>
        <translation>Basic Information</translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="232"/>
        <location filename="../build/release/storyScience/AbilityStatusEdit.qml" line="232"/>
        <location filename="../build/storyScience/AbilityStatusEdit.qml" line="232"/>
        <source>详情</source>
        <translation>Details</translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="248"/>
        <location filename="../build/release/storyScience/AbilityStatusEdit.qml" line="248"/>
        <location filename="../build/storyScience/AbilityStatusEdit.qml" line="248"/>
        <source>无</source>
        <translation>None</translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="108"/>
        <location filename="../build/release/storyScience/AbilityStatusEdit.qml" line="108"/>
        <location filename="../build/storyScience/AbilityStatusEdit.qml" line="108"/>
        <source>力量类型:</source>
        <translation>Power Type:</translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="62"/>
        <location filename="../build/release/storyScience/AbilityStatusEdit.qml" line="62"/>
        <location filename="../build/storyScience/AbilityStatusEdit.qml" line="62"/>
        <source>能力信息编辑</source>
        <translation>Ability Information Editing</translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="112"/>
        <location filename="../build/release/storyScience/AbilityStatusEdit.qml" line="112"/>
        <location filename="../build/storyScience/AbilityStatusEdit.qml" line="112"/>
        <source>普通</source>
        <translation>Normal</translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="132"/>
        <location filename="../build/release/storyScience/AbilityStatusEdit.qml" line="132"/>
        <location filename="../build/storyScience/AbilityStatusEdit.qml" line="132"/>
        <source>消耗:</source>
        <translation>Consumption:</translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="156"/>
        <location filename="../build/release/storyScience/AbilityStatusEdit.qml" line="156"/>
        <location filename="../build/storyScience/AbilityStatusEdit.qml" line="156"/>
        <source>冷却时间:</source>
        <translation>Cooldown Time:</translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="180"/>
        <location filename="../build/release/storyScience/AbilityStatusEdit.qml" line="180"/>
        <location filename="../build/storyScience/AbilityStatusEdit.qml" line="180"/>
        <source>等级:</source>
        <translation>Level:</translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="184"/>
        <location filename="../build/release/storyScience/AbilityStatusEdit.qml" line="184"/>
        <location filename="../build/storyScience/AbilityStatusEdit.qml" line="184"/>
        <source>等级</source>
        <translation>Level</translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="293"/>
        <location filename="../build/release/storyScience/AbilityStatusEdit.qml" line="293"/>
        <location filename="../build/storyScience/AbilityStatusEdit.qml" line="293"/>
        <source>前置条件</source>
        <translation>Prerequisites</translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="351"/>
        <location filename="../build/release/storyScience/AbilityStatusEdit.qml" line="351"/>
        <location filename="../build/storyScience/AbilityStatusEdit.qml" line="349"/>
        <source>×</source>
        <translation>x</translation>
    </message>
    <message>
        <source>删除</source>
        <translation type="vanished">Delete</translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="385"/>
        <location filename="../build/release/storyScience/AbilityStatusEdit.qml" line="385"/>
        <location filename="../build/storyScience/AbilityStatusEdit.qml" line="383"/>
        <source>前置条件（能力ID或等级）</source>
        <translation>Prerequisites (Ability ID or Level)</translation>
    </message>
    <message>
        <location filename="../AbilityStatusEdit.qml" line="393"/>
        <location filename="../build/release/storyScience/AbilityStatusEdit.qml" line="393"/>
        <location filename="../build/storyScience/AbilityStatusEdit.qml" line="391"/>
        <source>添加</source>
        <translation>Add</translation>
    </message>
</context>
<context>
    <name>AbilityStatusView</name>
    <message>
        <location filename="../AbilityStatusView.qml" line="34"/>
        <location filename="../build/release/storyScience/AbilityStatusView.qml" line="34"/>
        <location filename="../build/storyScience/AbilityStatusView.qml" line="34"/>
        <source>能力信息</source>
        <translation>Ability Information</translation>
    </message>
    <message>
        <location filename="../AbilityStatusView.qml" line="68"/>
        <location filename="../build/release/storyScience/AbilityStatusView.qml" line="68"/>
        <location filename="../build/storyScience/AbilityStatusView.qml" line="68"/>
        <source>基本信息</source>
        <translation>Basic Information</translation>
    </message>
    <message>
        <location filename="../AbilityStatusView.qml" line="81"/>
        <location filename="../build/release/storyScience/AbilityStatusView.qml" line="81"/>
        <location filename="../build/storyScience/AbilityStatusView.qml" line="81"/>
        <source>力量类型</source>
        <translation>Power Type</translation>
    </message>
    <message>
        <location filename="../AbilityStatusView.qml" line="81"/>
        <location filename="../build/release/storyScience/AbilityStatusView.qml" line="81"/>
        <location filename="../build/storyScience/AbilityStatusView.qml" line="81"/>
        <source>普通</source>
        <translation>Common</translation>
    </message>
    <message>
        <location filename="../AbilityStatusView.qml" line="82"/>
        <location filename="../build/release/storyScience/AbilityStatusView.qml" line="82"/>
        <location filename="../build/storyScience/AbilityStatusView.qml" line="82"/>
        <source>消耗</source>
        <translation>Consumption</translation>
    </message>
    <message>
        <location filename="../AbilityStatusView.qml" line="83"/>
        <location filename="../build/release/storyScience/AbilityStatusView.qml" line="83"/>
        <location filename="../build/storyScience/AbilityStatusView.qml" line="83"/>
        <source>冷却时间</source>
        <translation>Cooldown</translation>
    </message>
    <message>
        <location filename="../AbilityStatusView.qml" line="84"/>
        <location filename="../build/release/storyScience/AbilityStatusView.qml" line="84"/>
        <location filename="../build/storyScience/AbilityStatusView.qml" line="84"/>
        <source>等级</source>
        <translation>Level</translation>
    </message>
    <message>
        <location filename="../AbilityStatusView.qml" line="138"/>
        <location filename="../build/release/storyScience/AbilityStatusView.qml" line="138"/>
        <location filename="../build/storyScience/AbilityStatusView.qml" line="138"/>
        <source>详情</source>
        <translation>Details</translation>
    </message>
    <message>
        <location filename="../AbilityStatusView.qml" line="154"/>
        <location filename="../AbilityStatusView.qml" line="209"/>
        <location filename="../build/release/storyScience/AbilityStatusView.qml" line="154"/>
        <location filename="../build/release/storyScience/AbilityStatusView.qml" line="209"/>
        <location filename="../build/storyScience/AbilityStatusView.qml" line="154"/>
        <location filename="../build/storyScience/AbilityStatusView.qml" line="209"/>
        <source>无</source>
        <translation>None</translation>
    </message>
    <message>
        <location filename="../AbilityStatusView.qml" line="193"/>
        <location filename="../build/release/storyScience/AbilityStatusView.qml" line="193"/>
        <location filename="../build/storyScience/AbilityStatusView.qml" line="193"/>
        <source>前置条件</source>
        <translation>Prerequisites</translation>
    </message>
</context>
<context>
    <name>AddElementPopup</name>
    <message>
        <location filename="../AddElementPopup.qml" line="39"/>
        <location filename="../build/release/storyScience/AddElementPopup.qml" line="39"/>
        <location filename="../build/storyScience/AddElementPopup.qml" line="39"/>
        <source>新元素</source>
        <translation>New Element</translation>
    </message>
    <message>
        <location filename="../AddElementPopup.qml" line="144"/>
        <location filename="../build/release/storyScience/AddElementPopup.qml" line="144"/>
        <location filename="../build/storyScience/AddElementPopup.qml" line="144"/>
        <source>标题</source>
        <translation>Title</translation>
    </message>
    <message>
        <location filename="../AddElementPopup.qml" line="156"/>
        <location filename="../build/release/storyScience/AddElementPopup.qml" line="156"/>
        <location filename="../build/storyScience/AddElementPopup.qml" line="152"/>
        <source>描述...</source>
        <translation>Description...</translation>
    </message>
    <message>
        <location filename="../AddElementPopup.qml" line="163"/>
        <location filename="../build/release/storyScience/AddElementPopup.qml" line="163"/>
        <location filename="../build/storyScience/AddElementPopup.qml" line="158"/>
        <source>颜色:</source>
        <translation>Color:</translation>
    </message>
    <message>
        <location filename="../AddElementPopup.qml" line="254"/>
        <location filename="../build/release/storyScience/AddElementPopup.qml" line="254"/>
        <location filename="../build/storyScience/AddElementPopup.qml" line="249"/>
        <source>标签:</source>
        <translation>Tags:</translation>
    </message>
    <message>
        <location filename="../AddElementPopup.qml" line="295"/>
        <location filename="../build/release/storyScience/AddElementPopup.qml" line="295"/>
        <location filename="../build/storyScience/AddElementPopup.qml" line="290"/>
        <source>×</source>
        <translation>x</translation>
    </message>
    <message>
        <location filename="../AddElementPopup.qml" line="323"/>
        <location filename="../build/release/storyScience/AddElementPopup.qml" line="323"/>
        <location filename="../build/storyScience/AddElementPopup.qml" line="318"/>
        <source>输入新标签后按 Enter</source>
        <translation>Press Enter after entering a new tag</translation>
    </message>
    <message>
        <location filename="../AddElementPopup.qml" line="335"/>
        <location filename="../build/release/storyScience/AddElementPopup.qml" line="335"/>
        <location filename="../build/storyScience/AddElementPopup.qml" line="330"/>
        <source>添加</source>
        <translation>Add</translation>
    </message>
    <message>
        <location filename="../AddElementPopup.qml" line="124"/>
        <location filename="../AddElementPopup.qml" line="352"/>
        <location filename="../build/release/storyScience/AddElementPopup.qml" line="124"/>
        <location filename="../build/release/storyScience/AddElementPopup.qml" line="352"/>
        <location filename="../build/storyScience/AddElementPopup.qml" line="124"/>
        <location filename="../build/storyScience/AddElementPopup.qml" line="347"/>
        <source>创建</source>
        <translation>Create</translation>
    </message>
    <message>
        <location filename="../AddElementPopup.qml" line="373"/>
        <location filename="../build/release/storyScience/AddElementPopup.qml" line="373"/>
        <location filename="../build/storyScience/AddElementPopup.qml" line="368"/>
        <source>取消</source>
        <translation>Cancel</translation>
    </message>
</context>
<context>
    <name>Article</name>
    <message>
        <location filename="../article.cpp" line="7"/>
        <location filename="../article.cpp" line="11"/>
        <source>新章节</source>
        <translation>New Chapter</translation>
    </message>
</context>
<context>
    <name>AvatarCard</name>
    <message>
        <location filename="../AvatarCard.qml" line="28"/>
        <location filename="../build/release/storyScience/AvatarCard.qml" line="28"/>
        <location filename="../build/storyScience/AvatarCard.qml" line="28"/>
        <source>头像</source>
        <translation>Avatar</translation>
    </message>
    <message>
        <location filename="../AvatarCard.qml" line="46"/>
        <location filename="../build/release/storyScience/AvatarCard.qml" line="46"/>
        <location filename="../build/storyScience/AvatarCard.qml" line="46"/>
        <source>未设置</source>
        <translation>Not set</translation>
    </message>
    <message>
        <location filename="../AvatarCard.qml" line="98"/>
        <location filename="../build/release/storyScience/AvatarCard.qml" line="98"/>
        <location filename="../build/storyScience/AvatarCard.qml" line="98"/>
        <source>未设置头像</source>
        <translation>Avatar not set</translation>
    </message>
</context>
<context>
    <name>BookPropertyDialog</name>
    <message>
        <location filename="../BookPropertyDialog.qml" line="14"/>
        <location filename="../build/release/storyScience/BookPropertyDialog.qml" line="14"/>
        <location filename="../build/storyScience/BookPropertyDialog.qml" line="14"/>
        <source>书籍属性</source>
        <translation>Book Attributes</translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="38"/>
        <location filename="../build/release/storyScience/BookPropertyDialog.qml" line="38"/>
        <location filename="../build/storyScience/BookPropertyDialog.qml" line="38"/>
        <source>基本信息</source>
        <translation>Basic Information</translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="52"/>
        <location filename="../build/release/storyScience/BookPropertyDialog.qml" line="52"/>
        <location filename="../build/storyScience/BookPropertyDialog.qml" line="52"/>
        <source>书名：</source>
        <translation>Book Title:</translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="57"/>
        <location filename="../BookPropertyDialog.qml" line="211"/>
        <location filename="../build/release/storyScience/BookPropertyDialog.qml" line="57"/>
        <location filename="../build/release/storyScience/BookPropertyDialog.qml" line="211"/>
        <location filename="../build/storyScience/BookPropertyDialog.qml" line="57"/>
        <location filename="../build/storyScience/BookPropertyDialog.qml" line="211"/>
        <source>未知</source>
        <translation>Unknown</translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="66"/>
        <location filename="../build/release/storyScience/BookPropertyDialog.qml" line="66"/>
        <location filename="../build/storyScience/BookPropertyDialog.qml" line="66"/>
        <source>章节数：</source>
        <translation>Number of Chapters:</translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="72"/>
        <location filename="../BookPropertyDialog.qml" line="87"/>
        <location filename="../build/release/storyScience/BookPropertyDialog.qml" line="72"/>
        <location filename="../build/release/storyScience/BookPropertyDialog.qml" line="87"/>
        <location filename="../build/storyScience/BookPropertyDialog.qml" line="72"/>
        <location filename="../build/storyScience/BookPropertyDialog.qml" line="87"/>
        <source>计算中...</source>
        <translation>Calculating...</translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="81"/>
        <location filename="../build/release/storyScience/BookPropertyDialog.qml" line="81"/>
        <location filename="../build/storyScience/BookPropertyDialog.qml" line="81"/>
        <source>总字数：</source>
        <translation>Total Word Count:</translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="98"/>
        <location filename="../build/release/storyScience/BookPropertyDialog.qml" line="98"/>
        <location filename="../build/storyScience/BookPropertyDialog.qml" line="98"/>
        <source>章节列表</source>
        <translation>Chapter List</translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="146"/>
        <location filename="../build/release/storyScience/BookPropertyDialog.qml" line="146"/>
        <location filename="../build/storyScience/BookPropertyDialog.qml" line="146"/>
        <source> 字</source>
        <translation> Character</translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="199"/>
        <location filename="../build/release/storyScience/BookPropertyDialog.qml" line="199"/>
        <location filename="../build/storyScience/BookPropertyDialog.qml" line="199"/>
        <source>根节点</source>
        <translation>Root Node</translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="201"/>
        <location filename="../build/release/storyScience/BookPropertyDialog.qml" line="201"/>
        <location filename="../build/storyScience/BookPropertyDialog.qml" line="201"/>
        <source>书籍</source>
        <translation>Book</translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="203"/>
        <location filename="../build/release/storyScience/BookPropertyDialog.qml" line="203"/>
        <location filename="../build/storyScience/BookPropertyDialog.qml" line="203"/>
        <source>分卷</source>
        <translation>Volume</translation>
    </message>
    <message>
        <source>部分</source>
        <translation type="vanished">Part</translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="205"/>
        <location filename="../BookPropertyDialog.qml" line="207"/>
        <location filename="../build/release/storyScience/BookPropertyDialog.qml" line="205"/>
        <location filename="../build/release/storyScience/BookPropertyDialog.qml" line="207"/>
        <location filename="../build/storyScience/BookPropertyDialog.qml" line="205"/>
        <location filename="../build/storyScience/BookPropertyDialog.qml" line="207"/>
        <source>章节</source>
        <translation>Chapter</translation>
    </message>
    <message>
        <location filename="../BookPropertyDialog.qml" line="209"/>
        <location filename="../build/release/storyScience/BookPropertyDialog.qml" line="209"/>
        <location filename="../build/storyScience/BookPropertyDialog.qml" line="209"/>
        <source>场景</source>
        <translation>Scene</translation>
    </message>
</context>
<context>
    <name>BottomPanel</name>
    <message>
        <source>你是一个小说续写助手，请根据用户提供的上下文和提示，续写合适的内容。</source>
        <translation type="vanished">You are a novel continuation assistant. Please generate appropriate content based on the context and prompt provided by the user.</translation>
    </message>
    <message>
        <location filename="../build/storyScience/BottomPanel.qml" line="29"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="758"/>
        <source>你是一名专业的网络小说续写助手，熟悉起点、晋江等网文平台的写作风格。请根据用户提供的上下文和提示进行续写，要求：1. 保持原有剧情设定和人物性格，不要偏离故事走向。2. 语言要生动流畅，符合网文的阅读习惯，注意节奏感。3. 增强人物的动作、心理和环境描写，增加画面感和代入感。4. 合理制造矛盾、悬念或爽点，吸引读者继续阅读。5. 避免与前文重复或矛盾，保证承接自然。最终输出优化后的小说续写内容。</source>
        <translation>You are a professional web novel continuation assistant familiar with styles from platforms like Qidian and Jinjiang. Continue the story based on the given context and prompts, ensuring:

Stay true to the plot and character personalities.

Use vivid, fluent language that fits web novel pacing.

Add sensory, action, and emotional details for immersion.

Create tension, suspense, or satisfying moments to engage readers.

Keep the transition smooth and consistent with previous content.
Output the refined continuation only.</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="189"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="189"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="171"/>
        <source>设置</source>
        <translation>Settings</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="199"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="199"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="180"/>
        <source>保存并关闭</source>
        <translation>Save and Close</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="228"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="228"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="208"/>
        <source>关闭</source>
        <translation>Close</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="262"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="262"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="242"/>
        <source>界面设置</source>
        <translation>Interface Settings</translation>
    </message>
    <message>
        <source>显示字数统计</source>
        <translation type="vanished">Display Word Count Statistics</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="282"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="282"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="262"/>
        <source>深色主题</source>
        <translation>Dark Theme</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="308"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="308"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="288"/>
        <source>字体大小:</source>
        <translation>Font Size:</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="370"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="370"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="350"/>
        <source>文件管理</source>
        <translation>File Management</translation>
    </message>
    <message>
        <source>删除前确认</source>
        <translation type="vanished">Confirm Before Deleting</translation>
    </message>
    <message>
        <source>启用备份</source>
        <translation type="vanished">Enable Backup</translation>
    </message>
    <message>
        <source>默认保存位置:</source>
        <translation type="vanished">Default Save Location:</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="409"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="409"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="389"/>
        <source>选择默认文件保存位置</source>
        <translation>Select Default File Save Location</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="415"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="415"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="395"/>
        <source>浏览...</source>
        <translation>Browse...</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="428"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="428"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="408"/>
        <source>AI续写设置</source>
        <translation>AI Continuation Settings</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="440"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="440"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="420"/>
        <source>AI提供商:</source>
        <translation>AI Provider:</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="494"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="494"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="474"/>
        <source>请输入API URL</source>
        <translation>Enter API URL</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="512"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="512"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="492"/>
        <source>请输入API密钥</source>
        <translation>Enter API Key</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="529"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="529"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="509"/>
        <source>模型名称:</source>
        <translation>Model Name:</translation>
    </message>
    <message>
        <source>请输入模型名称</source>
        <translation type="vanished">Enter Model Name</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="29"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="29"/>
        <source>你是一名经验丰富的网络小说作者，熟悉起点、晋江、番茄等主流平台的写作节奏与读者心理。
                                         请根据提供的小说片段进行续写，要求如下：
                                         1. 保持原文的世界观、人物设定与语气风格一致，不要脱离已有剧情逻辑。
                                         2. 续写部分需自然衔接上文，承接情绪与节奏，避免突兀跳转。
                                         3. 保留网文常见的爽点与节奏，如反转、升级、悬念、情感冲突等。
                                         4. 加强画面感与代入感，注重人物心理变化与场景描写。
                                         5. 语言要流畅、生动、有张力，避免流水账或空洞叙述。
                                         6. 续写字数适中，保证剧情有推进或转折。
                                         7. 结尾应留有“悬念”或“伏笔”，让读者期待下一章。
                                         最终仅输出续写的小说正文，不要输出任何分析、解释或标题。</source>
        <translation>You are an experienced web novel author, well-versed in the pacing and reader psychology of major platforms such as Qidian, Jinjiang, and Fanqie.
Please continue the provided novel excerpt according to the following requirements:
1. Maintain consistency with the original world-building, character portrayals, and narrative tone; do not deviate from established plot logic.
2. Ensure the continuation flows naturally from the preceding text, matching its emotional tone and rhythm without abrupt shifts.
3. Preserve common web novel elements such as plot twists, power progression, suspense, and emotional conflict.
4. Enhance vividness and immersion through detailed scene descriptions and nuanced character psychology.
5. Use fluent, dynamic, and compelling language; avoid flat, mechanical, or hollow narration.
6. Keep the continuation concise yet substantial, with clear plot advancement or a meaningful turning point.
7. End with a “cliffhanger” or “foreshadowing” that leaves readers eager for the next chapter.
Output only the continued novel prose—no analysis, explanation, or title.
</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="40"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="40"/>
        <source>你是一名专业的网络小说编辑，熟悉起点、晋江、番茄等平台的文风与读者偏好。
                                           请对输入文本进行润色与优化，要求如下：
                                           1. 保留原剧情与设定，不改变故事走向与核心爽点。
                                           2. 优化文笔，使语言更流畅、有画面感与代入感。
                                           3. 加强人物外貌、动作、心理与环境氛围的描写，避免平铺直叙。
                                           4. 删除或压缩重复、啰嗦内容，使行文紧凑；合理断句与分段。
                                           5. 保持网文常见节奏与爽点表达（反转、升级、悬念、情感冲突等）。
                                           6. 仅输出优化后的小说正文，不输出解释、点评或标题。</source>
        <translation>You are a professional web novel editor, well-versed in the writing styles and reader preferences of platforms such as Qidian, Jinjiang, and Fanqie.
Please polish and refine the input text according to the following requirements:
1. Preserve the original plot and setting without altering the story direction or core satisfying moments.
2. Improve the prose to make it smoother, more vivid, and immersive.
3. Enhance descriptions of characters’ appearances, actions, psychological states, and environmental atmosphere to avoid flat narration.
4. Remove or condense repetitive or wordy content to ensure tight pacing; use appropriate sentence breaks and paragraphing.
5. Maintain the typical web novel rhythm and expression of satisfying elements (e.g., plot twists, power-ups, suspense, emotional conflicts).
6. Output only the refined novel prose—no explanations, comments, or titles.</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="401"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="401"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="381"/>
        <source>文件默认保存位置:</source>
        <translation>Default File Save Location：</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="557"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="557"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="537"/>
        <source>系统提示:</source>
        <translation>System Prompt:</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="572"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="572"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="548"/>
        <source>请输入系统提示，如&apos;你是一个小说续写助手&apos;</source>
        <translation>Please enter a system prompt, such as &apos;You are a novel continuation assistant.&apos;</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="583"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="583"/>
        <source>优化提示:</source>
        <translation>Optimization prompt:</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="598"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="598"/>
        <source>请输入优化提示，如&apos;润色增强画面感与代入感&apos;等</source>
        <translation>Please enter an optimization prompt, such as &quot;polish to enhance visual imagery and immersion,&quot; etc.</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="608"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="608"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="557"/>
        <source>高级设置</source>
        <translation>Advanced Settings</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="615"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="615"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="564"/>
        <source>导出设置</source>
        <translation>Export Settings</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="623"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="623"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="572"/>
        <source>导入设置</source>
        <translation>Import Settings</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="631"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="631"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="580"/>
        <source>显示设置路径</source>
        <translation>Show Settings Path</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="810"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="810"/>
        <source>你是一名经验丰富的网络小说作者，熟悉起点、晋江、番茄等主流平台的写作节奏与读者心理。
                                                                            请根据提供的小说片段进行续写，要求如下：
                                                                            1. 保持原文的世界观、人物设定与语气风格一致，不要脱离已有剧情逻辑。
                                                                            2. 续写部分需自然衔接上文，承接情绪与节奏，避免突兀跳转。
                                                                            3. 保留网文常见的爽点与节奏，如反转、升级、悬念、情感冲突等。
                                                                            4. 加强画面感与代入感，注重人物心理变化与场景描写。
                                                                            5. 语言要流畅、生动、有张力，避免流水账或空洞叙述。
                                                                            6. 续写字数适中，保证剧情有推进或转折。
                                                                            7. 结尾应留有“悬念”或“伏笔”，让读者期待下一章。
                                                                            最终仅输出续写的小说正文，不要输出任何分析、解释或标题。</source>
        <translation>You are an experienced web novel author, well-versed in the pacing and reader psychology of major platforms such as Qidian, Jinjiang, and Fanqie.
Please continue the provided novel excerpt according to the following requirements:
1. Maintain consistency with the original world-building, character portrayals, and narrative tone; do not deviate from established plot logic.
2. Ensure the continuation flows naturally from the preceding text, matching its emotional tone and rhythm without abrupt shifts.
3. Preserve common web novel elements such as plot twists, power progression, suspense, and emotional conflict.
4. Enhance vividness and immersion through detailed scene descriptions and nuanced character psychology.
5. Use fluent, dynamic, and compelling language; avoid flat, mechanical, or hollow narration.
6. Keep the continuation concise yet substantial, with clear plot advancement or a meaningful turning point.
7. End with a “cliffhanger” or “foreshadowing” that leaves readers eager for the next chapter.
Output only the continued novel prose—no analysis, explanation, or title.</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="820"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="820"/>
        <source>你是一名专业的网络小说编辑，熟悉起点、晋江、番茄等平台的文风与读者偏好。
                                                                                请对输入文本进行润色与优化，要求如下：
                                                                                1. 保留原剧情与设定，不改变故事走向与核心爽点。
                                                                                2. 优化文笔，使语言更流畅、有画面感与代入感。
                                                                                3. 加强人物外貌、动作、心理与环境氛围的描写，避免平铺直叙。
                                                                                4. 删除或压缩重复、啰嗦内容，使行文紧凑；合理断句与分段。
                                                                                5. 保持网文常见节奏与爽点表达（反转、升级、悬念、情感冲突等）。
                                                                                6. 仅输出优化后的小说正文，不输出解释、点评或标题。</source>
        <translation>You are a professional web novel editor, well-versed in the writing styles and reader preferences of platforms such as Qidian, Jinjiang, and Fanqie.
Please polish and refine the input text according to the following requirements:
1. Preserve the original plot and setting without altering the story direction or core satisfying moments.
2. Improve the prose to make it smoother, more vivid, and immersive.
3. Enhance descriptions of characters’ appearances, actions, psychological states, and environmental atmosphere to avoid flat narration.
4. Remove or condense repetitive or wordy content to ensure tight pacing; use appropriate sentence breaks and paragraphing.
5. Maintain the typical web novel rhythm and expression of satisfying elements (e.g., plot twists, power-ups, suspense, emotional conflicts).
6. Output only the refined novel prose—no explanations, comments, or titles</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="943"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="943"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="873"/>
        <source>设置文件路径</source>
        <translation>Settings File Path</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="960"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="960"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="890"/>
        <source>复制</source>
        <translation>Copy</translation>
    </message>
    <message>
        <location filename="../BottomPanel.qml" line="968"/>
        <location filename="../build/release/storyScience/BottomPanel.qml" line="968"/>
        <location filename="../build/storyScience/BottomPanel.qml" line="898"/>
        <source>确定</source>
        <translation>Confirm</translation>
    </message>
</context>
<context>
    <name>CanvasSwitcher</name>
    <message>
        <location filename="../build/release/storyScience/CanvasSwitcher.qml" line="84"/>
        <location filename="../build/storyScience/CanvasSwitcher.qml" line="84"/>
        <location filename="../CanvasSwitcher.qml" line="84"/>
        <source>重命名</source>
        <translation>Rename</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CanvasSwitcher.qml" line="93"/>
        <location filename="../build/storyScience/CanvasSwitcher.qml" line="93"/>
        <location filename="../CanvasSwitcher.qml" line="93"/>
        <source>删除</source>
        <translation>Delete</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CanvasSwitcher.qml" line="106"/>
        <location filename="../build/storyScience/CanvasSwitcher.qml" line="106"/>
        <location filename="../CanvasSwitcher.qml" line="106"/>
        <source>重命名图谱</source>
        <translation>Rename Schema</translation>
    </message>
</context>
<context>
    <name>CarouselCardModel</name>
    <message>
        <location filename="../CarouselCardModel.cpp" line="589"/>
        <source>刚刚</source>
        <translation>Just now</translation>
    </message>
    <message>
        <location filename="../CarouselCardModel.cpp" line="591"/>
        <source>%1分钟前</source>
        <translation>%1 minute ago</translation>
    </message>
    <message>
        <location filename="../CarouselCardModel.cpp" line="593"/>
        <source>%1小时前</source>
        <translation>%1 hour ago</translation>
    </message>
    <message>
        <location filename="../CarouselCardModel.cpp" line="595"/>
        <source>%1天前</source>
        <translation>%1 day ago</translation>
    </message>
</context>
<context>
    <name>CharacterStatusEdit</name>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="119"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="119"/>
        <location filename="../CharacterStatusEdit.qml" line="119"/>
        <source>基本信息</source>
        <translation>Basic Information</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="131"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="131"/>
        <location filename="../CharacterStatusEdit.qml" line="131"/>
        <source>等级:</source>
        <translation>Level:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="135"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="135"/>
        <location filename="../CharacterStatusEdit.qml" line="135"/>
        <source>青铜</source>
        <translation>Bronze</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="156"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="156"/>
        <location filename="../CharacterStatusEdit.qml" line="156"/>
        <source>经验值:</source>
        <translation>Exp:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="181"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="181"/>
        <location filename="../CharacterStatusEdit.qml" line="181"/>
        <source>阶段:</source>
        <translation>Stage:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="185"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="185"/>
        <location filename="../CharacterStatusEdit.qml" line="185"/>
        <source>1级</source>
        <translation>Level 1</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="234"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="234"/>
        <location filename="../CharacterStatusEdit.qml" line="234"/>
        <source>详情</source>
        <translation>Details</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="250"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="250"/>
        <location filename="../CharacterStatusEdit.qml" line="250"/>
        <source>无</source>
        <translation>None</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="296"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="296"/>
        <location filename="../CharacterStatusEdit.qml" line="296"/>
        <source>属性</source>
        <translation>Attributes</translation>
    </message>
    <message>
        <source>删除</source>
        <translation type="vanished">Delete</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="85"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="85"/>
        <location filename="../CharacterStatusEdit.qml" line="85"/>
        <source>角色信息编辑</source>
        <translation>Role Information Editing</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="345"/>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="508"/>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="656"/>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="815"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="345"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="508"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="656"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="810"/>
        <location filename="../CharacterStatusEdit.qml" line="345"/>
        <location filename="../CharacterStatusEdit.qml" line="508"/>
        <location filename="../CharacterStatusEdit.qml" line="656"/>
        <location filename="../CharacterStatusEdit.qml" line="815"/>
        <source>×</source>
        <translation>x</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="374"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="374"/>
        <location filename="../CharacterStatusEdit.qml" line="374"/>
        <source>属性名</source>
        <translation>Attribute Name</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="388"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="388"/>
        <location filename="../CharacterStatusEdit.qml" line="388"/>
        <source>属性值</source>
        <translation>Attribute Value</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="399"/>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="549"/>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="697"/>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="858"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="399"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="549"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="697"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="852"/>
        <location filename="../CharacterStatusEdit.qml" line="399"/>
        <location filename="../CharacterStatusEdit.qml" line="549"/>
        <location filename="../CharacterStatusEdit.qml" line="697"/>
        <location filename="../CharacterStatusEdit.qml" line="858"/>
        <source>添加</source>
        <translation>Add</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="458"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="458"/>
        <location filename="../CharacterStatusEdit.qml" line="458"/>
        <source>能力列表</source>
        <translation>Ability List</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="537"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="537"/>
        <location filename="../CharacterStatusEdit.qml" line="537"/>
        <source>能力ID</source>
        <translation>Ability ID</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="606"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="606"/>
        <location filename="../CharacterStatusEdit.qml" line="606"/>
        <source>物品列表</source>
        <translation>Item List</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="685"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="685"/>
        <location filename="../CharacterStatusEdit.qml" line="685"/>
        <source>物品ID</source>
        <translation>Item ID</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="754"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="754"/>
        <location filename="../CharacterStatusEdit.qml" line="754"/>
        <source>状态效果</source>
        <translation>Status Effect</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="850"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="844"/>
        <location filename="../CharacterStatusEdit.qml" line="850"/>
        <source>效果名称</source>
        <translation>Effect Name</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="915"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="909"/>
        <location filename="../CharacterStatusEdit.qml" line="915"/>
        <source>传记</source>
        <translation>Biography</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="980"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="974"/>
        <location filename="../CharacterStatusEdit.qml" line="980"/>
        <source>头像</source>
        <translation>Avatar</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusEdit.qml" line="1014"/>
        <location filename="../build/storyScience/CharacterStatusEdit.qml" line="1008"/>
        <location filename="../CharacterStatusEdit.qml" line="1014"/>
        <source>选择</source>
        <translation>Select</translation>
    </message>
</context>
<context>
    <name>CharacterStatusView</name>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusView.qml" line="34"/>
        <location filename="../build/storyScience/CharacterStatusView.qml" line="34"/>
        <location filename="../CharacterStatusView.qml" line="34"/>
        <source>角色信息</source>
        <translation>Character Information</translation>
    </message>
    <message>
        <source>头像</source>
        <translation type="vanished">Avatar</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusView.qml" line="116"/>
        <location filename="../build/storyScience/CharacterStatusView.qml" line="116"/>
        <location filename="../CharacterStatusView.qml" line="116"/>
        <source>基本信息</source>
        <translation>Basic Information</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusView.qml" line="129"/>
        <location filename="../build/storyScience/CharacterStatusView.qml" line="129"/>
        <location filename="../CharacterStatusView.qml" line="129"/>
        <source>等级</source>
        <translation>Level</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusView.qml" line="129"/>
        <location filename="../build/storyScience/CharacterStatusView.qml" line="129"/>
        <location filename="../CharacterStatusView.qml" line="129"/>
        <source>青铜</source>
        <translation>Bronze</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusView.qml" line="130"/>
        <location filename="../build/storyScience/CharacterStatusView.qml" line="130"/>
        <location filename="../CharacterStatusView.qml" line="130"/>
        <source>经验值</source>
        <translation>Exp</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusView.qml" line="131"/>
        <location filename="../build/storyScience/CharacterStatusView.qml" line="131"/>
        <location filename="../CharacterStatusView.qml" line="131"/>
        <source>阶段</source>
        <translation>Stage</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusView.qml" line="131"/>
        <location filename="../build/storyScience/CharacterStatusView.qml" line="131"/>
        <location filename="../CharacterStatusView.qml" line="131"/>
        <source>1级</source>
        <translation>Level 1</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusView.qml" line="185"/>
        <location filename="../build/storyScience/CharacterStatusView.qml" line="185"/>
        <location filename="../CharacterStatusView.qml" line="185"/>
        <source>详情</source>
        <translation>Details</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusView.qml" line="201"/>
        <location filename="../build/release/storyScience/CharacterStatusView.qml" line="331"/>
        <location filename="../build/release/storyScience/CharacterStatusView.qml" line="386"/>
        <location filename="../build/release/storyScience/CharacterStatusView.qml" line="441"/>
        <location filename="../build/release/storyScience/CharacterStatusView.qml" line="496"/>
        <location filename="../build/storyScience/CharacterStatusView.qml" line="201"/>
        <location filename="../build/storyScience/CharacterStatusView.qml" line="331"/>
        <location filename="../build/storyScience/CharacterStatusView.qml" line="386"/>
        <location filename="../build/storyScience/CharacterStatusView.qml" line="441"/>
        <location filename="../build/storyScience/CharacterStatusView.qml" line="496"/>
        <location filename="../CharacterStatusView.qml" line="201"/>
        <location filename="../CharacterStatusView.qml" line="331"/>
        <location filename="../CharacterStatusView.qml" line="386"/>
        <location filename="../CharacterStatusView.qml" line="441"/>
        <location filename="../CharacterStatusView.qml" line="496"/>
        <source>无</source>
        <translation>None</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusView.qml" line="240"/>
        <location filename="../build/storyScience/CharacterStatusView.qml" line="240"/>
        <location filename="../CharacterStatusView.qml" line="240"/>
        <source>属性</source>
        <translation>Attributes</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusView.qml" line="315"/>
        <location filename="../build/storyScience/CharacterStatusView.qml" line="315"/>
        <location filename="../CharacterStatusView.qml" line="315"/>
        <source>能力列表</source>
        <translation>Ability List</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusView.qml" line="370"/>
        <location filename="../build/storyScience/CharacterStatusView.qml" line="370"/>
        <location filename="../CharacterStatusView.qml" line="370"/>
        <source>物品列表</source>
        <translation>Item List</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusView.qml" line="425"/>
        <location filename="../build/storyScience/CharacterStatusView.qml" line="425"/>
        <location filename="../CharacterStatusView.qml" line="425"/>
        <source>状态效果</source>
        <translation>Status Effects</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CharacterStatusView.qml" line="480"/>
        <location filename="../build/storyScience/CharacterStatusView.qml" line="480"/>
        <location filename="../CharacterStatusView.qml" line="480"/>
        <source>传记</source>
        <translation>Biography</translation>
    </message>
</context>
<context>
    <name>ColorDialog</name>
    <message>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Fusion/ColorDialog.qml" line="204"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Imagine/ColorDialog.qml" line="213"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Material/ColorDialog.qml" line="203"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Universal/ColorDialog.qml" line="207"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/ColorDialog.qml" line="212"/>
        <source>Color</source>
        <translation type="unfinished"></translation>
    </message>
</context>
<context>
    <name>ColorInputs</name>
    <message>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/ColorInputs.qml" line="50"/>
        <source>Hex</source>
        <translation type="unfinished"></translation>
    </message>
    <message>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/ColorInputs.qml" line="53"/>
        <source>RGB</source>
        <translation type="unfinished"></translation>
    </message>
    <message>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/ColorInputs.qml" line="56"/>
        <source>HSV</source>
        <translation type="unfinished"></translation>
    </message>
    <message>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/ColorInputs.qml" line="59"/>
        <source>HSL</source>
        <translation type="unfinished"></translation>
    </message>
</context>
<context>
    <name>CreateStoryItemDialog</name>
    <message>
        <location filename="../build/release/storyScience/CreateStoryItemDialog.qml" line="50"/>
        <location filename="../build/storyScience/CreateStoryItemDialog.qml" line="14"/>
        <location filename="../CreateStoryItemDialog.qml" line="50"/>
        <source>项</source>
        <translation>Item</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CreateStoryItemDialog.qml" line="95"/>
        <location filename="../CreateStoryItemDialog.qml" line="95"/>
        <source>取消</source>
        <translation>Cancel</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CreateStoryItemDialog.qml" line="101"/>
        <location filename="../CreateStoryItemDialog.qml" line="101"/>
        <source>确定</source>
        <translation>Confirm</translation>
    </message>
    <message>
        <location filename="../build/storyScience/CreateStoryItemDialog.qml" line="40"/>
        <source>请输入</source>
        <translation>Please enter</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/CreateStoryItemDialog.qml" line="80"/>
        <location filename="../build/storyScience/CreateStoryItemDialog.qml" line="47"/>
        <location filename="../CreateStoryItemDialog.qml" line="80"/>
        <source>开始创作吧...</source>
        <translation>Let&apos;s start creating...</translation>
    </message>
</context>
<context>
    <name>DataManager</name>
    <message>
        <location filename="../datamanager.cpp" line="350"/>
        <source>新章节</source>
        <translation>New Chapter</translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="729"/>
        <source>导出为 TXT</source>
        <translation>Export as TXT</translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="730"/>
        <source>纯文本文档 (*.txt)</source>
        <translation>Plain Text Document (.txt)</translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="734"/>
        <source>导出为 Markdown</source>
        <translation>Export as Markdown</translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="735"/>
        <source>Markdown 文档 (*.md)</source>
        <translation>Markdown Document (.md)</translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="849"/>
        <location filename="../datamanager.cpp" line="853"/>
        <source>主角</source>
        <translation>Protagonist</translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="850"/>
        <source>故事的主要人物</source>
        <translation>The main character of the story</translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="853"/>
        <source>英雄</source>
        <translation>Hero</translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="858"/>
        <source>魔法世界</source>
        <translation>Magic World</translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="859"/>
        <source>一个充满奇幻的世界</source>
        <translation>A world full of fantasy</translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="862"/>
        <source>奇幻</source>
        <translation>Fantasy</translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="862"/>
        <source>魔法</source>
        <translation>Magic</translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="871"/>
        <source>测试小说</source>
        <translation>Test Novel</translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="1535"/>
        <source>导出设置</source>
        <translation>Export Settings</translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="1556"/>
        <source>导入设置</source>
        <translation>Import Settings</translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="1590"/>
        <source>选择文件夹</source>
        <translation>Select Folder</translation>
    </message>
    <message>
        <location filename="../datamanager.cpp" line="1882"/>
        <location filename="../datamanager.cpp" line="1890"/>
        <source>未知章节</source>
        <translation>Unknown Chapter</translation>
    </message>
</context>
<context>
    <name>DonatePage</name>
    <message>
        <location filename="../build/release/storyScience/DonatePage.qml" line="60"/>
        <location filename="../DonatePage.qml" line="60"/>
        <source>爱心捐赠</source>
        <translation>Love Donation</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/DonatePage.qml" line="98"/>
        <location filename="../DonatePage.qml" line="98"/>
        <source>感谢您对 Story Science 的支持！您的捐赠将帮助我们持续改进产品，为您提供更好的写作体验。</source>
        <translation>Thank you for your support of Story Science! Your donation will help us continuously improve our product and provide you with a better writing experience.</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/DonatePage.qml" line="107"/>
        <location filename="../DonatePage.qml" line="107"/>
        <source>选择捐赠方式：</source>
        <translation>Choose a donation method:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/DonatePage.qml" line="121"/>
        <location filename="../DonatePage.qml" line="121"/>
        <source>支付宝</source>
        <translation>Alipay</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/DonatePage.qml" line="122"/>
        <location filename="../DonatePage.qml" line="122"/>
        <source>微信支付</source>
        <translation>WeChat Pay</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/DonatePage.qml" line="123"/>
        <location filename="../DonatePage.qml" line="123"/>
        <source>PayPal</source>
        <translation>PayPal</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/DonatePage.qml" line="199"/>
        <location filename="../DonatePage.qml" line="199"/>
        <source>支付宝二维码</source>
        <translation>Alipay QR Code</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/DonatePage.qml" line="306"/>
        <location filename="../DonatePage.qml" line="306"/>
        <source>- 捐赠是完全自愿的，不会获得任何特殊权益
- 捐赠金额将用于项目改进开发、维护等</source>
        <translation>- Donations are entirely voluntary and do not grant any special benefits
- Donation amounts will be used for project improvement, development, maintenance, etc</translation>
    </message>
    <message>
        <source>支付宝捐赠</source>
        <translation type="vanished">Donate via Alipay</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/DonatePage.qml" line="201"/>
        <source></source>
        <translation></translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/DonatePage.qml" line="237"/>
        <location filename="../DonatePage.qml" line="237"/>
        <source>微信支付二维码</source>
        <translation>WeChat Pay QR Code</translation>
    </message>
    <message>
        <source>微信支付捐赠</source>
        <translation type="vanished">Donate via WeChat Pay</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/DonatePage.qml" line="275"/>
        <location filename="../DonatePage.qml" line="275"/>
        <source>PayPal捐赠</source>
        <translation>PayPal Donation</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/DonatePage.qml" line="292"/>
        <location filename="../DonatePage.qml" line="292"/>
        <source>点击图片跳转到PayPal捐赠页面</source>
        <translation>Click the image to go to the PayPal donation page</translation>
    </message>
    <message>
        <source>• 捐赠是完全自愿的，不会获得任何特殊权益
• 捐赠金额将用于项目改进开发、维护等
</source>
        <translation type="vanished">• Donations are entirely voluntary and do not grant any special benefits
• Donation amounts will be used for project improvement, development, maintenance, etc
</translation>
    </message>
</context>
<context>
    <name>Edge</name>
    <message>
        <location filename="../build/release/storyScience/Edge.qml" line="250"/>
        <location filename="../build/release/storyScience/Edge.qml" line="279"/>
        <location filename="../build/storyScience/Edge.qml" line="250"/>
        <location filename="../build/storyScience/Edge.qml" line="279"/>
        <location filename="../Edge.qml" line="250"/>
        <location filename="../Edge.qml" line="279"/>
        <source>关联</source>
        <translation>Relevance</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/Edge.qml" line="272"/>
        <location filename="../build/storyScience/Edge.qml" line="272"/>
        <location filename="../Edge.qml" line="272"/>
        <source>编辑关系标签</source>
        <translation>Edit relationship label</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/Edge.qml" line="276"/>
        <location filename="../build/storyScience/Edge.qml" line="276"/>
        <location filename="../Edge.qml" line="276"/>
        <source>关系描述:</source>
        <translation>Relationship description:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/Edge.qml" line="296"/>
        <location filename="../build/storyScience/Edge.qml" line="296"/>
        <location filename="../Edge.qml" line="296"/>
        <source>编辑标签</source>
        <translation>Edit label</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/Edge.qml" line="303"/>
        <location filename="../build/storyScience/Edge.qml" line="303"/>
        <location filename="../Edge.qml" line="303"/>
        <source>删除连接</source>
        <translation>Delete connection</translation>
    </message>
</context>
<context>
    <name>EditorArea</name>
    <message>
        <location filename="../build/release/storyScience/EditorArea.qml" line="465"/>
        <location filename="../build/storyScience/EditorArea.qml" line="421"/>
        <location filename="../EditorArea.qml" line="465"/>
        <source>字数: </source>
        <translation>Word Count: </translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EditorArea.qml" line="472"/>
        <location filename="../build/storyScience/EditorArea.qml" line="428"/>
        <location filename="../EditorArea.qml" line="472"/>
        <source>速度: </source>
        <translation>Speed: </translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EditorArea.qml" line="472"/>
        <location filename="../build/storyScience/EditorArea.qml" line="428"/>
        <location filename="../EditorArea.qml" line="472"/>
        <source> 字/分钟</source>
        <translation> Words/Min</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EditorArea.qml" line="492"/>
        <location filename="../build/storyScience/EditorArea.qml" line="448"/>
        <location filename="../EditorArea.qml" line="492"/>
        <source>未保存</source>
        <translation>Not saved</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EditorArea.qml" line="492"/>
        <location filename="../build/storyScience/EditorArea.qml" line="448"/>
        <location filename="../EditorArea.qml" line="492"/>
        <source>已保存</source>
        <translation>Saved</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EditorArea.qml" line="529"/>
        <location filename="../build/storyScience/EditorArea.qml" line="485"/>
        <location filename="../EditorArea.qml" line="529"/>
        <source>新章节</source>
        <translation>New chapter</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EditorArea.qml" line="531"/>
        <location filename="../build/storyScience/EditorArea.qml" line="487"/>
        <location filename="../EditorArea.qml" line="531"/>
        <source>请选择一个章节或场景</source>
        <translation>Please select a chapter or scene</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EditorArea.qml" line="554"/>
        <location filename="../build/storyScience/EditorArea.qml" line="510"/>
        <location filename="../EditorArea.qml" line="554"/>
        <source>润色</source>
        <translation>polish</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EditorArea.qml" line="979"/>
        <location filename="../build/storyScience/EditorArea.qml" line="913"/>
        <location filename="../EditorArea.qml" line="979"/>
        <source>复制</source>
        <translation>Copy</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EditorArea.qml" line="980"/>
        <location filename="../build/storyScience/EditorArea.qml" line="914"/>
        <location filename="../EditorArea.qml" line="980"/>
        <source>词典</source>
        <translation>Dictionary</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EditorArea.qml" line="981"/>
        <location filename="../build/storyScience/EditorArea.qml" line="915"/>
        <location filename="../EditorArea.qml" line="981"/>
        <source>AI写</source>
        <translation>AI Write</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EditorArea.qml" line="987"/>
        <location filename="../build/storyScience/EditorArea.qml" line="921"/>
        <location filename="../EditorArea.qml" line="987"/>
        <source>伏笔</source>
        <translation>Draft</translation>
    </message>
</context>
<context>
    <name>ElementCard</name>
    <message>
        <location filename="../build/release/storyScience/ElementCard.qml" line="11"/>
        <location filename="../build/storyScience/ElementCard.qml" line="11"/>
        <location filename="../ElementCard.qml" line="11"/>
        <source>加载中...</source>
        <translation>Loading...</translation>
    </message>
</context>
<context>
    <name>ElementDelegate</name>
    <message>
        <location filename="../build/release/storyScience/ElementDelegate.qml" line="99"/>
        <location filename="../build/storyScience/ElementDelegate.qml" line="99"/>
        <location filename="../ElementDelegate.qml" line="99"/>
        <source>更多操作</source>
        <translation>More actions</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ElementDelegate.qml" line="120"/>
        <location filename="../build/storyScience/ElementDelegate.qml" line="120"/>
        <location filename="../ElementDelegate.qml" line="120"/>
        <source>编辑</source>
        <translation>Edit</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ElementDelegate.qml" line="124"/>
        <location filename="../build/storyScience/ElementDelegate.qml" line="124"/>
        <location filename="../ElementDelegate.qml" line="124"/>
        <source>查看状态</source>
        <translation>View status</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ElementDelegate.qml" line="128"/>
        <location filename="../build/storyScience/ElementDelegate.qml" line="128"/>
        <location filename="../ElementDelegate.qml" line="128"/>
        <source>编辑状态</source>
        <translation>Edit status</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ElementDelegate.qml" line="132"/>
        <location filename="../build/storyScience/ElementDelegate.qml" line="132"/>
        <location filename="../ElementDelegate.qml" line="132"/>
        <source>从当前项移除</source>
        <translation>Remove from current item</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ElementDelegate.qml" line="138"/>
        <location filename="../build/storyScience/ElementDelegate.qml" line="138"/>
        <location filename="../ElementDelegate.qml" line="138"/>
        <source>彻底删除元素</source>
        <translation>Delete element completely</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ElementDelegate.qml" line="183"/>
        <location filename="../build/storyScience/ElementDelegate.qml" line="183"/>
        <location filename="../ElementDelegate.qml" line="183"/>
        <source>标题</source>
        <translation>Title</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ElementDelegate.qml" line="195"/>
        <location filename="../build/storyScience/ElementDelegate.qml" line="190"/>
        <location filename="../ElementDelegate.qml" line="195"/>
        <source>描述...</source>
        <translation>Description...</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ElementDelegate.qml" line="204"/>
        <location filename="../build/storyScience/ElementDelegate.qml" line="199"/>
        <location filename="../ElementDelegate.qml" line="204"/>
        <source>颜色:</source>
        <translation>Color:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ElementDelegate.qml" line="221"/>
        <location filename="../build/storyScience/ElementDelegate.qml" line="216"/>
        <location filename="../ElementDelegate.qml" line="221"/>
        <source>标签:</source>
        <translation>Tags:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ElementDelegate.qml" line="267"/>
        <location filename="../build/storyScience/ElementDelegate.qml" line="262"/>
        <location filename="../ElementDelegate.qml" line="267"/>
        <source>输入新标签后按 Enter</source>
        <translation>Enter new tag and press Enter</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ElementDelegate.qml" line="278"/>
        <location filename="../build/storyScience/ElementDelegate.qml" line="273"/>
        <location filename="../ElementDelegate.qml" line="278"/>
        <source>添加</source>
        <translation>Add</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ElementDelegate.qml" line="298"/>
        <location filename="../build/release/storyScience/ElementDelegate.qml" line="526"/>
        <location filename="../build/storyScience/ElementDelegate.qml" line="293"/>
        <location filename="../build/storyScience/ElementDelegate.qml" line="521"/>
        <location filename="../ElementDelegate.qml" line="298"/>
        <location filename="../ElementDelegate.qml" line="526"/>
        <source>保存</source>
        <translation>Save</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ElementDelegate.qml" line="314"/>
        <location filename="../build/release/storyScience/ElementDelegate.qml" line="541"/>
        <location filename="../build/storyScience/ElementDelegate.qml" line="309"/>
        <location filename="../build/storyScience/ElementDelegate.qml" line="536"/>
        <location filename="../ElementDelegate.qml" line="314"/>
        <location filename="../ElementDelegate.qml" line="541"/>
        <source>取消</source>
        <translation>Cancel</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ElementDelegate.qml" line="363"/>
        <location filename="../build/storyScience/ElementDelegate.qml" line="358"/>
        <location filename="../ElementDelegate.qml" line="363"/>
        <source>元素状态 - </source>
        <translation>Element status - </translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ElementDelegate.qml" line="418"/>
        <location filename="../build/storyScience/ElementDelegate.qml" line="413"/>
        <location filename="../ElementDelegate.qml" line="418"/>
        <source>关闭</source>
        <translation>Close</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ElementDelegate.qml" line="468"/>
        <location filename="../build/storyScience/ElementDelegate.qml" line="463"/>
        <location filename="../ElementDelegate.qml" line="468"/>
        <source>编辑元素状态 - </source>
        <translation>Edit element status - </translation>
    </message>
</context>
<context>
    <name>ElementPicker</name>
    <message>
        <location filename="../build/release/storyScience/ElementPicker.qml" line="16"/>
        <location filename="../build/storyScience/ElementPicker.qml" line="16"/>
        <location filename="../ElementPicker.qml" line="16"/>
        <source>选择要关联的元素</source>
        <translation>Select the element to be associated</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ElementPicker.qml" line="40"/>
        <location filename="../build/storyScience/ElementPicker.qml" line="40"/>
        <location filename="../ElementPicker.qml" line="40"/>
        <source>人物</source>
        <translation>Character</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ElementPicker.qml" line="41"/>
        <location filename="../build/storyScience/ElementPicker.qml" line="41"/>
        <location filename="../ElementPicker.qml" line="41"/>
        <source>地点</source>
        <translation>Location</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ElementPicker.qml" line="42"/>
        <location filename="../build/storyScience/ElementPicker.qml" line="42"/>
        <location filename="../ElementPicker.qml" line="42"/>
        <source>道具</source>
        <translation>Prop</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ElementPicker.qml" line="43"/>
        <location filename="../build/storyScience/ElementPicker.qml" line="43"/>
        <location filename="../ElementPicker.qml" line="43"/>
        <source>能力</source>
        <translation>Ability</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ElementPicker.qml" line="44"/>
        <location filename="../build/storyScience/ElementPicker.qml" line="44"/>
        <location filename="../ElementPicker.qml" line="44"/>
        <source>组织</source>
        <translation>Organization</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ElementPicker.qml" line="45"/>
        <location filename="../build/storyScience/ElementPicker.qml" line="45"/>
        <location filename="../ElementPicker.qml" line="45"/>
        <source>事件</source>
        <translation>Event</translation>
    </message>
</context>
<context>
    <name>EventStatusEdit</name>
    <message>
        <location filename="../build/release/storyScience/EventStatusEdit.qml" line="90"/>
        <location filename="../build/storyScience/EventStatusEdit.qml" line="55"/>
        <location filename="../EventStatusEdit.qml" line="90"/>
        <source>基本信息</source>
        <translation>Basic Information</translation>
    </message>
    <message>
        <source>详情</source>
        <translation type="vanished">Details</translation>
    </message>
    <message>
        <location filename="../build/storyScience/EventStatusEdit.qml" line="62"/>
        <source>无</source>
        <translation>None</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusEdit.qml" line="152"/>
        <location filename="../build/storyScience/EventStatusEdit.qml" line="95"/>
        <location filename="../EventStatusEdit.qml" line="152"/>
        <source>事件属性</source>
        <translation>Event Properties</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusEdit.qml" line="170"/>
        <location filename="../build/storyScience/EventStatusEdit.qml" line="104"/>
        <location filename="../EventStatusEdit.qml" line="170"/>
        <source>时间:</source>
        <translation>Time:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusEdit.qml" line="198"/>
        <location filename="../build/storyScience/EventStatusEdit.qml" line="125"/>
        <location filename="../EventStatusEdit.qml" line="198"/>
        <source>时间线位置:</source>
        <translation>Timeline Position:</translation>
    </message>
    <message>
        <location filename="../build/storyScience/EventStatusEdit.qml" line="130"/>
        <source>时间线</source>
        <translation>Timeline</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusEdit.qml" line="53"/>
        <location filename="../EventStatusEdit.qml" line="53"/>
        <source>事件状态编辑</source>
        <translation>Event Status Editing</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusEdit.qml" line="226"/>
        <location filename="../build/storyScience/EventStatusEdit.qml" line="146"/>
        <location filename="../EventStatusEdit.qml" line="226"/>
        <source>地点ID:</source>
        <translation>Location ID:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusEdit.qml" line="254"/>
        <location filename="../build/storyScience/EventStatusEdit.qml" line="167"/>
        <location filename="../EventStatusEdit.qml" line="254"/>
        <source>状态:</source>
        <translation>Status:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusEdit.qml" line="261"/>
        <location filename="../build/release/storyScience/EventStatusEdit.qml" line="263"/>
        <location filename="../build/release/storyScience/EventStatusEdit.qml" line="265"/>
        <location filename="../build/storyScience/EventStatusEdit.qml" line="172"/>
        <location filename="../build/storyScience/EventStatusEdit.qml" line="174"/>
        <location filename="../build/storyScience/EventStatusEdit.qml" line="176"/>
        <location filename="../EventStatusEdit.qml" line="261"/>
        <location filename="../EventStatusEdit.qml" line="263"/>
        <location filename="../EventStatusEdit.qml" line="265"/>
        <source>计划中</source>
        <translation>Scheduled</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusEdit.qml" line="261"/>
        <location filename="../build/release/storyScience/EventStatusEdit.qml" line="266"/>
        <location filename="../build/storyScience/EventStatusEdit.qml" line="172"/>
        <location filename="../build/storyScience/EventStatusEdit.qml" line="177"/>
        <location filename="../EventStatusEdit.qml" line="261"/>
        <location filename="../EventStatusEdit.qml" line="266"/>
        <source>进行中</source>
        <translation>In Progress</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusEdit.qml" line="261"/>
        <location filename="../build/release/storyScience/EventStatusEdit.qml" line="267"/>
        <location filename="../build/storyScience/EventStatusEdit.qml" line="172"/>
        <location filename="../build/storyScience/EventStatusEdit.qml" line="178"/>
        <location filename="../EventStatusEdit.qml" line="261"/>
        <location filename="../EventStatusEdit.qml" line="267"/>
        <source>完成中</source>
        <translation>Completed</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusEdit.qml" line="261"/>
        <location filename="../build/release/storyScience/EventStatusEdit.qml" line="268"/>
        <location filename="../build/storyScience/EventStatusEdit.qml" line="172"/>
        <location filename="../build/storyScience/EventStatusEdit.qml" line="179"/>
        <location filename="../EventStatusEdit.qml" line="261"/>
        <location filename="../EventStatusEdit.qml" line="268"/>
        <source>已结束</source>
        <translation>Ended</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusEdit.qml" line="463"/>
        <location filename="../EventStatusEdit.qml" line="463"/>
        <source>×</source>
        <translation>x</translation>
    </message>
    <message>
        <source>结果:</source>
        <translation type="vanished">Outcome:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusEdit.qml" line="284"/>
        <location filename="../build/storyScience/EventStatusEdit.qml" line="197"/>
        <location filename="../EventStatusEdit.qml" line="284"/>
        <source>影响分数:</source>
        <translation>Impact Score:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusEdit.qml" line="341"/>
        <location filename="../build/storyScience/EventStatusEdit.qml" line="230"/>
        <location filename="../EventStatusEdit.qml" line="341"/>
        <source>结果</source>
        <translation>Result</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusEdit.qml" line="403"/>
        <location filename="../build/storyScience/EventStatusEdit.qml" line="269"/>
        <location filename="../EventStatusEdit.qml" line="403"/>
        <source>参与者列表</source>
        <translation>Participant List</translation>
    </message>
    <message>
        <source>删除</source>
        <translation type="vanished">Delete</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusEdit.qml" line="490"/>
        <location filename="../build/storyScience/EventStatusEdit.qml" line="320"/>
        <location filename="../EventStatusEdit.qml" line="490"/>
        <source>参与者ID</source>
        <translation>Participant ID</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusEdit.qml" line="504"/>
        <location filename="../EventStatusEdit.qml" line="504"/>
        <source>添加</source>
        <translation>Add</translation>
    </message>
</context>
<context>
    <name>EventStatusView</name>
    <message>
        <location filename="../build/release/storyScience/EventStatusView.qml" line="34"/>
        <location filename="../build/storyScience/EventStatusView.qml" line="34"/>
        <location filename="../EventStatusView.qml" line="34"/>
        <source>事件信息</source>
        <translation>Event Information</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusView.qml" line="68"/>
        <location filename="../build/storyScience/EventStatusView.qml" line="68"/>
        <location filename="../EventStatusView.qml" line="68"/>
        <source>基本信息</source>
        <translation>Basic Information</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusView.qml" line="81"/>
        <location filename="../build/storyScience/EventStatusView.qml" line="81"/>
        <location filename="../EventStatusView.qml" line="81"/>
        <source>时间</source>
        <translation>Time</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusView.qml" line="81"/>
        <location filename="../build/release/storyScience/EventStatusView.qml" line="83"/>
        <location filename="../build/storyScience/EventStatusView.qml" line="81"/>
        <location filename="../build/storyScience/EventStatusView.qml" line="83"/>
        <location filename="../EventStatusView.qml" line="81"/>
        <location filename="../EventStatusView.qml" line="83"/>
        <source>未设置</source>
        <translation>Not Set</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusView.qml" line="82"/>
        <location filename="../build/storyScience/EventStatusView.qml" line="82"/>
        <location filename="../EventStatusView.qml" line="82"/>
        <source>时间线位置</source>
        <translation>Timeline Position</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusView.qml" line="82"/>
        <location filename="../build/storyScience/EventStatusView.qml" line="82"/>
        <location filename="../EventStatusView.qml" line="82"/>
        <source>时间线</source>
        <translation>Timeline</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusView.qml" line="83"/>
        <location filename="../build/storyScience/EventStatusView.qml" line="83"/>
        <location filename="../EventStatusView.qml" line="83"/>
        <source>地点</source>
        <translation>Location</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusView.qml" line="84"/>
        <location filename="../build/storyScience/EventStatusView.qml" line="84"/>
        <location filename="../EventStatusView.qml" line="84"/>
        <source>状态</source>
        <translation>Status</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusView.qml" line="84"/>
        <location filename="../build/storyScience/EventStatusView.qml" line="84"/>
        <location filename="../EventStatusView.qml" line="84"/>
        <source>计划中</source>
        <translation>Planned</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusView.qml" line="85"/>
        <location filename="../build/storyScience/EventStatusView.qml" line="85"/>
        <location filename="../EventStatusView.qml" line="85"/>
        <source>结果</source>
        <translation>Result</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusView.qml" line="85"/>
        <location filename="../build/release/storyScience/EventStatusView.qml" line="156"/>
        <location filename="../build/release/storyScience/EventStatusView.qml" line="211"/>
        <location filename="../build/storyScience/EventStatusView.qml" line="85"/>
        <location filename="../build/storyScience/EventStatusView.qml" line="156"/>
        <location filename="../build/storyScience/EventStatusView.qml" line="211"/>
        <location filename="../EventStatusView.qml" line="85"/>
        <location filename="../EventStatusView.qml" line="156"/>
        <location filename="../EventStatusView.qml" line="211"/>
        <source>无</source>
        <translation>None</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusView.qml" line="86"/>
        <location filename="../build/storyScience/EventStatusView.qml" line="86"/>
        <location filename="../EventStatusView.qml" line="86"/>
        <source>影响分数</source>
        <translation>Impact Score</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusView.qml" line="140"/>
        <location filename="../build/storyScience/EventStatusView.qml" line="140"/>
        <location filename="../EventStatusView.qml" line="140"/>
        <source>详情</source>
        <translation>Details</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/EventStatusView.qml" line="195"/>
        <location filename="../build/storyScience/EventStatusView.qml" line="195"/>
        <location filename="../EventStatusView.qml" line="195"/>
        <source>参与者列表</source>
        <translation>Participants List</translation>
    </message>
</context>
<context>
    <name>FileDialog</name>
    <message>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Fusion/FileDialog.qml" line="40"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Imagine/FileDialog.qml" line="50"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Material/FileDialog.qml" line="41"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Universal/FileDialog.qml" line="40"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/FileDialog.qml" line="45"/>
        <source>Overwrite file?</source>
        <translation type="unfinished"></translation>
    </message>
    <message>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Fusion/FileDialog.qml" line="44"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Imagine/FileDialog.qml" line="54"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Material/FileDialog.qml" line="46"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Universal/FileDialog.qml" line="44"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/FileDialog.qml" line="49"/>
        <source>“%1” already exists.
Do you want to replace it?</source>
        <translation type="unfinished"></translation>
    </message>
    <message>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Fusion/FileDialog.qml" line="165"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Imagine/FileDialog.qml" line="154"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Material/FileDialog.qml" line="135"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Universal/FileDialog.qml" line="141"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/FileDialog.qml" line="152"/>
        <source>File name</source>
        <translation type="unfinished"></translation>
    </message>
    <message>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Fusion/FileDialog.qml" line="179"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Imagine/FileDialog.qml" line="169"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Material/FileDialog.qml" line="152"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Universal/FileDialog.qml" line="156"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/FileDialog.qml" line="167"/>
        <source>Filter</source>
        <translation type="unfinished"></translation>
    </message>
</context>
<context>
    <name>FontDialog</name>
    <message>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Fusion/FontDialog.qml" line="92"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Imagine/FontDialog.qml" line="113"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Material/FontDialog.qml" line="87"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Universal/FontDialog.qml" line="79"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/FontDialog.qml" line="94"/>
        <source>Writing System</source>
        <translation type="unfinished"></translation>
    </message>
</context>
<context>
    <name>FontDialogContent</name>
    <message>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/FontDialogContent.qml" line="30"/>
        <source>Family</source>
        <translation type="unfinished"></translation>
    </message>
    <message>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/FontDialogContent.qml" line="80"/>
        <source>Style</source>
        <translation type="unfinished"></translation>
    </message>
    <message>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/FontDialogContent.qml" line="126"/>
        <source>Size</source>
        <translation type="unfinished"></translation>
    </message>
    <message>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/FontDialogContent.qml" line="178"/>
        <source>Effects</source>
        <translation type="unfinished"></translation>
    </message>
    <message>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/FontDialogContent.qml" line="193"/>
        <source>Underline</source>
        <translation type="unfinished"></translation>
    </message>
    <message>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/FontDialogContent.qml" line="198"/>
        <source>Strikeout</source>
        <translation type="unfinished"></translation>
    </message>
    <message>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/FontDialogContent.qml" line="207"/>
        <source>Sample</source>
        <translation type="unfinished"></translation>
    </message>
</context>
<context>
    <name>ForeShadowPopup</name>
    <message>
        <location filename="../build/release/storyScience/ForeShadowPopup.qml" line="17"/>
        <location filename="../build/storyScience/ForeShadowPopup.qml" line="17"/>
        <location filename="../ForeShadowPopup.qml" line="17"/>
        <source>&lt;b&gt;原文：&lt;/b&gt;</source>
        <translation>&lt;b&gt;Original text: &lt;/b&gt;</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ForeShadowPopup.qml" line="41"/>
        <location filename="../build/storyScience/ForeShadowPopup.qml" line="41"/>
        <location filename="../ForeShadowPopup.qml" line="41"/>
        <source>标记伏笔</source>
        <translation>Mark foreshadowing</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ForeShadowPopup.qml" line="69"/>
        <location filename="../build/storyScience/ForeShadowPopup.qml" line="69"/>
        <location filename="../ForeShadowPopup.qml" line="69"/>
        <source>伏笔描述 (给自己的笔记):</source>
        <translation>Foreshadowing description (notes to yourself):</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ForeShadowPopup.qml" line="74"/>
        <location filename="../build/storyScience/ForeShadowPopup.qml" line="74"/>
        <location filename="../ForeShadowPopup.qml" line="74"/>
        <source>例如：这把剑的来历，将在主角回忆时揭晓...</source>
        <translation>For example: The origin of this sword will be revealed when the protagonist recalls...</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ForeShadowPopup.qml" line="85"/>
        <location filename="../build/storyScience/ForeShadowPopup.qml" line="85"/>
        <location filename="../ForeShadowPopup.qml" line="85"/>
        <source>取消</source>
        <translation>Cancel</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ForeShadowPopup.qml" line="91"/>
        <location filename="../build/storyScience/ForeShadowPopup.qml" line="91"/>
        <location filename="../ForeShadowPopup.qml" line="91"/>
        <source>保存伏笔</source>
        <translation>Save foreshadowing</translation>
    </message>
</context>
<context>
    <name>GraphView</name>
    <message>
        <location filename="../build/release/storyScience/GraphView.qml" line="45"/>
        <location filename="../build/release/storyScience/GraphView.qml" line="47"/>
        <location filename="../build/storyScience/GraphView.qml" line="45"/>
        <location filename="../build/storyScience/GraphView.qml" line="47"/>
        <location filename="../GraphView.qml" line="45"/>
        <location filename="../GraphView.qml" line="47"/>
        <source>未知元素</source>
        <translation>Unknown Element</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/GraphView.qml" line="243"/>
        <location filename="../build/storyScience/GraphView.qml" line="243"/>
        <location filename="../GraphView.qml" line="243"/>
        <source>添加图谱</source>
        <translation>Add Graph</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/GraphView.qml" line="266"/>
        <location filename="../build/storyScience/GraphView.qml" line="266"/>
        <location filename="../GraphView.qml" line="266"/>
        <source>新图谱</source>
        <translation>New Graph</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/GraphView.qml" line="272"/>
        <location filename="../build/release/storyScience/GraphView.qml" line="460"/>
        <location filename="../build/storyScience/GraphView.qml" line="272"/>
        <location filename="../build/storyScience/GraphView.qml" line="460"/>
        <location filename="../GraphView.qml" line="272"/>
        <location filename="../GraphView.qml" line="460"/>
        <source>添加节点</source>
        <translation>Add Node</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/GraphView.qml" line="299"/>
        <location filename="../build/storyScience/GraphView.qml" line="299"/>
        <location filename="../GraphView.qml" line="299"/>
        <source>取消连接</source>
        <translation>Cancel Connection</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/GraphView.qml" line="363"/>
        <location filename="../build/storyScience/GraphView.qml" line="363"/>
        <location filename="../GraphView.qml" line="363"/>
        <source>保存中...</source>
        <translation>Saving...</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/GraphView.qml" line="364"/>
        <location filename="../build/storyScience/GraphView.qml" line="364"/>
        <location filename="../GraphView.qml" line="364"/>
        <source>加载中...</source>
        <translation>Loading...</translation>
    </message>
    <message>
        <source>节点: </source>
        <translation type="vanished">Node: </translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/GraphView.qml" line="369"/>
        <location filename="../build/storyScience/GraphView.qml" line="369"/>
        <location filename="../GraphView.qml" line="369"/>
        <source>节点: %1 | 连接: %2 | 缩放: %3%</source>
        <translation>Node: %1 | Connect: %2 | Zoom: %3</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/GraphView.qml" line="373"/>
        <location filename="../build/storyScience/GraphView.qml" line="373"/>
        <location filename="../GraphView.qml" line="373"/>
        <source>无图谱数据</source>
        <translation>No Graph Data</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/GraphView.qml" line="378"/>
        <location filename="../build/storyScience/GraphView.qml" line="378"/>
        <location filename="../GraphView.qml" line="378"/>
        <source>成功</source>
        <translation>Success</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/GraphView.qml" line="379"/>
        <location filename="../build/storyScience/GraphView.qml" line="379"/>
        <location filename="../GraphView.qml" line="379"/>
        <source>失败</source>
        <translation>Failure</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/GraphView.qml" line="387"/>
        <location filename="../build/storyScience/GraphView.qml" line="387"/>
        <location filename="../GraphView.qml" line="387"/>
        <source>清空</source>
        <translation>Clear</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/GraphView.qml" line="436"/>
        <location filename="../build/storyScience/GraphView.qml" line="436"/>
        <location filename="../GraphView.qml" line="436"/>
        <source>确认清空</source>
        <translation>Confirm Clear</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/GraphView.qml" line="443"/>
        <location filename="../build/storyScience/GraphView.qml" line="443"/>
        <location filename="../GraphView.qml" line="443"/>
        <source>确定要清空当前图谱的所有节点和连接吗？
此操作不可撤销。</source>
        <translation>Are you sure you want to clear all nodes and connections of the current graph? This operation cannot be undone.</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/GraphView.qml" line="450"/>
        <location filename="../build/storyScience/GraphView.qml" line="450"/>
        <location filename="../GraphView.qml" line="450"/>
        <source>已清空图谱</source>
        <translation>Graph Cleared</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/GraphView.qml" line="464"/>
        <location filename="../build/storyScience/GraphView.qml" line="464"/>
        <location filename="../GraphView.qml" line="464"/>
        <source>清空画布</source>
        <translation>Clear Canvas</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/GraphView.qml" line="421"/>
        <location filename="../build/storyScience/GraphView.qml" line="421"/>
        <location filename="../GraphView.qml" line="421"/>
        <source>关联</source>
        <translation>Relevance</translation>
    </message>
</context>
<context>
    <name>ImmersiveExitButton</name>
    <message>
        <location filename="../build/release/storyScience/ImmersiveExitButton.qml" line="61"/>
        <location filename="../build/storyScience/ImmersiveExitButton.qml" line="61"/>
        <location filename="../ImmersiveExitButton.qml" line="61"/>
        <source>退出</source>
        <translation>Exit</translation>
    </message>
</context>
<context>
    <name>ItemStatusEdit</name>
    <message>
        <location filename="../build/release/storyScience/ItemStatusEdit.qml" line="96"/>
        <location filename="../build/storyScience/ItemStatusEdit.qml" line="96"/>
        <location filename="../ItemStatusEdit.qml" line="96"/>
        <source>基本信息</source>
        <translation>Basic Information</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusEdit.qml" line="108"/>
        <location filename="../build/storyScience/ItemStatusEdit.qml" line="108"/>
        <location filename="../ItemStatusEdit.qml" line="108"/>
        <source>稀有度:</source>
        <translation>Rarity:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusEdit.qml" line="112"/>
        <location filename="../build/storyScience/ItemStatusEdit.qml" line="112"/>
        <location filename="../ItemStatusEdit.qml" line="112"/>
        <source>稀有</source>
        <translation>Rare</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusEdit.qml" line="256"/>
        <location filename="../build/storyScience/ItemStatusEdit.qml" line="256"/>
        <location filename="../ItemStatusEdit.qml" line="256"/>
        <source>详情</source>
        <translation>Details</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusEdit.qml" line="272"/>
        <location filename="../build/storyScience/ItemStatusEdit.qml" line="272"/>
        <location filename="../ItemStatusEdit.qml" line="272"/>
        <source>无</source>
        <translation>None</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusEdit.qml" line="132"/>
        <location filename="../build/storyScience/ItemStatusEdit.qml" line="132"/>
        <location filename="../ItemStatusEdit.qml" line="132"/>
        <source>类别:</source>
        <translation>Category:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusEdit.qml" line="62"/>
        <location filename="../build/storyScience/ItemStatusEdit.qml" line="62"/>
        <location filename="../ItemStatusEdit.qml" line="62"/>
        <source>物品信息编辑</source>
        <translation>Item Information Editing</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusEdit.qml" line="156"/>
        <location filename="../build/storyScience/ItemStatusEdit.qml" line="156"/>
        <location filename="../ItemStatusEdit.qml" line="156"/>
        <source>耐久度:</source>
        <translation>Durability:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusEdit.qml" line="180"/>
        <location filename="../build/storyScience/ItemStatusEdit.qml" line="180"/>
        <location filename="../ItemStatusEdit.qml" line="180"/>
        <source>价值:</source>
        <translation>Value:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusEdit.qml" line="204"/>
        <location filename="../build/storyScience/ItemStatusEdit.qml" line="204"/>
        <location filename="../ItemStatusEdit.qml" line="204"/>
        <source>所有者ID:</source>
        <translation>Owner ID:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusEdit.qml" line="317"/>
        <location filename="../build/storyScience/ItemStatusEdit.qml" line="317"/>
        <location filename="../ItemStatusEdit.qml" line="317"/>
        <source>效果列表</source>
        <translation>Effect List</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusEdit.qml" line="375"/>
        <location filename="../build/storyScience/ItemStatusEdit.qml" line="373"/>
        <location filename="../ItemStatusEdit.qml" line="375"/>
        <source>×</source>
        <translation>x</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusEdit.qml" line="409"/>
        <location filename="../build/storyScience/ItemStatusEdit.qml" line="407"/>
        <location filename="../ItemStatusEdit.qml" line="409"/>
        <source>效果名称</source>
        <translation>Effect Name</translation>
    </message>
    <message>
        <source>删除</source>
        <translation type="vanished">Delete</translation>
    </message>
    <message>
        <source>效果ID</source>
        <translation type="vanished">Effect ID</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusEdit.qml" line="417"/>
        <location filename="../build/storyScience/ItemStatusEdit.qml" line="415"/>
        <location filename="../ItemStatusEdit.qml" line="417"/>
        <source>添加</source>
        <translation>Add</translation>
    </message>
</context>
<context>
    <name>ItemStatusView</name>
    <message>
        <location filename="../build/release/storyScience/ItemStatusView.qml" line="34"/>
        <location filename="../build/storyScience/ItemStatusView.qml" line="34"/>
        <location filename="../ItemStatusView.qml" line="34"/>
        <source>道具信息</source>
        <translation>Item Information</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusView.qml" line="68"/>
        <location filename="../build/storyScience/ItemStatusView.qml" line="68"/>
        <location filename="../ItemStatusView.qml" line="68"/>
        <source>基本信息</source>
        <translation>Basic Information</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusView.qml" line="81"/>
        <location filename="../build/storyScience/ItemStatusView.qml" line="81"/>
        <location filename="../ItemStatusView.qml" line="81"/>
        <source>稀有度</source>
        <translation>Rarity</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusView.qml" line="81"/>
        <location filename="../build/storyScience/ItemStatusView.qml" line="81"/>
        <location filename="../ItemStatusView.qml" line="81"/>
        <source>稀有</source>
        <translation>Rare</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusView.qml" line="82"/>
        <location filename="../build/storyScience/ItemStatusView.qml" line="82"/>
        <location filename="../ItemStatusView.qml" line="82"/>
        <source>类别</source>
        <translation>Category</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusView.qml" line="82"/>
        <location filename="../build/storyScience/ItemStatusView.qml" line="82"/>
        <location filename="../ItemStatusView.qml" line="82"/>
        <source>未设置</source>
        <translation>Not Set</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusView.qml" line="83"/>
        <location filename="../build/storyScience/ItemStatusView.qml" line="83"/>
        <location filename="../ItemStatusView.qml" line="83"/>
        <source>耐久度</source>
        <translation>Durability</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusView.qml" line="84"/>
        <location filename="../build/storyScience/ItemStatusView.qml" line="84"/>
        <location filename="../ItemStatusView.qml" line="84"/>
        <source>价值</source>
        <translation>Value</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusView.qml" line="85"/>
        <location filename="../build/storyScience/ItemStatusView.qml" line="85"/>
        <location filename="../ItemStatusView.qml" line="85"/>
        <source>所有者</source>
        <translation>Owner</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusView.qml" line="85"/>
        <location filename="../build/release/storyScience/ItemStatusView.qml" line="155"/>
        <location filename="../build/release/storyScience/ItemStatusView.qml" line="210"/>
        <location filename="../build/storyScience/ItemStatusView.qml" line="85"/>
        <location filename="../build/storyScience/ItemStatusView.qml" line="155"/>
        <location filename="../build/storyScience/ItemStatusView.qml" line="210"/>
        <location filename="../ItemStatusView.qml" line="85"/>
        <location filename="../ItemStatusView.qml" line="155"/>
        <location filename="../ItemStatusView.qml" line="210"/>
        <source>无</source>
        <translation>None</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusView.qml" line="139"/>
        <location filename="../build/storyScience/ItemStatusView.qml" line="139"/>
        <location filename="../ItemStatusView.qml" line="139"/>
        <source>详情</source>
        <translation>Details</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ItemStatusView.qml" line="194"/>
        <location filename="../build/storyScience/ItemStatusView.qml" line="194"/>
        <location filename="../ItemStatusView.qml" line="194"/>
        <source>效果列表</source>
        <translation>Effect List</translation>
    </message>
</context>
<context>
    <name>KeyDetailsView</name>
    <message>
        <location filename="../build/release/storyScience/KeyDetailsView.qml" line="17"/>
        <location filename="../build/storyScience/KeyDetailsView.qml" line="17"/>
        <location filename="../KeyDetailsView.qml" line="17"/>
        <source>按键详细信息</source>
        <translation>Key Details</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/KeyDetailsView.qml" line="57"/>
        <location filename="../build/storyScience/KeyDetailsView.qml" line="57"/>
        <location filename="../KeyDetailsView.qml" line="57"/>
        <source>按键名称</source>
        <translation>Key Name</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/KeyDetailsView.qml" line="74"/>
        <location filename="../build/storyScience/KeyDetailsView.qml" line="74"/>
        <location filename="../KeyDetailsView.qml" line="74"/>
        <source>选择操作:</source>
        <translation>Select Operation:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/KeyDetailsView.qml" line="106"/>
        <location filename="../build/release/storyScience/KeyDetailsView.qml" line="115"/>
        <location filename="../build/storyScience/KeyDetailsView.qml" line="106"/>
        <location filename="../build/storyScience/KeyDetailsView.qml" line="115"/>
        <location filename="../KeyDetailsView.qml" line="106"/>
        <location filename="../KeyDetailsView.qml" line="115"/>
        <source>基本信息</source>
        <translation>Basic Information</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/KeyDetailsView.qml" line="129"/>
        <location filename="../build/storyScience/KeyDetailsView.qml" line="129"/>
        <location filename="../KeyDetailsView.qml" line="129"/>
        <source>按键名称:</source>
        <translation>Key Name:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/KeyDetailsView.qml" line="137"/>
        <location filename="../build/release/storyScience/KeyDetailsView.qml" line="158"/>
        <location filename="../build/release/storyScience/KeyDetailsView.qml" line="247"/>
        <location filename="../build/release/storyScience/KeyDetailsView.qml" line="284"/>
        <location filename="../build/storyScience/KeyDetailsView.qml" line="137"/>
        <location filename="../build/storyScience/KeyDetailsView.qml" line="158"/>
        <location filename="../build/storyScience/KeyDetailsView.qml" line="247"/>
        <location filename="../build/storyScience/KeyDetailsView.qml" line="284"/>
        <location filename="../KeyDetailsView.qml" line="137"/>
        <location filename="../KeyDetailsView.qml" line="158"/>
        <location filename="../KeyDetailsView.qml" line="247"/>
        <location filename="../KeyDetailsView.qml" line="284"/>
        <source>未指定</source>
        <translation>Not Specified</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/KeyDetailsView.qml" line="150"/>
        <location filename="../build/storyScience/KeyDetailsView.qml" line="150"/>
        <location filename="../KeyDetailsView.qml" line="150"/>
        <source>按键描述:</source>
        <translation>Key Description:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/KeyDetailsView.qml" line="173"/>
        <location filename="../build/release/storyScience/KeyDetailsView.qml" line="182"/>
        <location filename="../build/storyScience/KeyDetailsView.qml" line="173"/>
        <location filename="../build/storyScience/KeyDetailsView.qml" line="182"/>
        <location filename="../KeyDetailsView.qml" line="173"/>
        <location filename="../KeyDetailsView.qml" line="182"/>
        <source>快捷键</source>
        <translation>Shortcut Key</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/KeyDetailsView.qml" line="226"/>
        <location filename="../build/release/storyScience/KeyDetailsView.qml" line="235"/>
        <location filename="../build/storyScience/KeyDetailsView.qml" line="226"/>
        <location filename="../build/storyScience/KeyDetailsView.qml" line="235"/>
        <location filename="../KeyDetailsView.qml" line="226"/>
        <location filename="../KeyDetailsView.qml" line="235"/>
        <source>使用场景</source>
        <translation>Usage Scenario</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/KeyDetailsView.qml" line="263"/>
        <location filename="../build/release/storyScience/KeyDetailsView.qml" line="272"/>
        <location filename="../build/storyScience/KeyDetailsView.qml" line="263"/>
        <location filename="../build/storyScience/KeyDetailsView.qml" line="272"/>
        <location filename="../KeyDetailsView.qml" line="263"/>
        <location filename="../KeyDetailsView.qml" line="272"/>
        <source>注意事项</source>
        <translation>Precautions</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/KeyDetailsView.qml" line="306"/>
        <location filename="../build/release/storyScience/KeyDetailsView.qml" line="325"/>
        <location filename="../build/storyScience/KeyDetailsView.qml" line="306"/>
        <location filename="../build/storyScience/KeyDetailsView.qml" line="325"/>
        <location filename="../KeyDetailsView.qml" line="306"/>
        <location filename="../KeyDetailsView.qml" line="325"/>
        <source>关闭</source>
        <translation>Close</translation>
    </message>
</context>
<context>
    <name>LeftPanel</name>
    <message>
        <source>故事科学</source>
        <translation type="vanished">StSc</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LeftPanel.qml" line="272"/>
        <location filename="../build/storyScience/LeftPanel.qml" line="247"/>
        <location filename="../LeftPanel.qml" line="272"/>
        <source>+ 创建新书</source>
        <translation>+ New Book</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LeftPanel.qml" line="288"/>
        <location filename="../build/storyScience/LeftPanel.qml" line="263"/>
        <location filename="../LeftPanel.qml" line="288"/>
        <source>+ 新建分卷</source>
        <translation>+ New Volume</translation>
    </message>
    <message>
        <source>+ 新建篇章</source>
        <translation type="vanished">+ Create New Chapter</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LeftPanel.qml" line="290"/>
        <location filename="../build/release/storyScience/LeftPanel.qml" line="292"/>
        <location filename="../build/storyScience/LeftPanel.qml" line="265"/>
        <location filename="../build/storyScience/LeftPanel.qml" line="267"/>
        <location filename="../LeftPanel.qml" line="290"/>
        <location filename="../LeftPanel.qml" line="292"/>
        <source>+ 新建章节</source>
        <translation>+ New Section</translation>
    </message>
    <message>
        <source>+ 新建场景</source>
        <translation type="vanished">+ Create New Scene</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LeftPanel.qml" line="316"/>
        <location filename="../build/release/storyScience/LeftPanel.qml" line="324"/>
        <location filename="../build/storyScience/LeftPanel.qml" line="291"/>
        <location filename="../build/storyScience/LeftPanel.qml" line="299"/>
        <location filename="../LeftPanel.qml" line="316"/>
        <location filename="../LeftPanel.qml" line="324"/>
        <source>新书</source>
        <translation>New Book</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LeftPanel.qml" line="334"/>
        <location filename="../build/storyScience/LeftPanel.qml" line="309"/>
        <location filename="../LeftPanel.qml" line="334"/>
        <source>新分卷</source>
        <translation>New Volume</translation>
    </message>
    <message>
        <source>新篇章</source>
        <translation type="vanished">New Chapter</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LeftPanel.qml" line="339"/>
        <location filename="../build/release/storyScience/LeftPanel.qml" line="345"/>
        <location filename="../build/storyScience/LeftPanel.qml" line="314"/>
        <location filename="../build/storyScience/LeftPanel.qml" line="320"/>
        <location filename="../LeftPanel.qml" line="339"/>
        <location filename="../LeftPanel.qml" line="345"/>
        <source>新章节</source>
        <translation>New Section</translation>
    </message>
    <message>
        <source>新场景</source>
        <translation type="vanished">New Scene</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LeftPanel.qml" line="382"/>
        <location filename="../build/storyScience/LeftPanel.qml" line="351"/>
        <location filename="../LeftPanel.qml" line="382"/>
        <source>创建新分卷...</source>
        <translation>New Volume...</translation>
    </message>
    <message>
        <source>创建新篇章...</source>
        <translation type="vanished">Create New Chapter...</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LeftPanel.qml" line="385"/>
        <location filename="../build/release/storyScience/LeftPanel.qml" line="388"/>
        <location filename="../build/storyScience/LeftPanel.qml" line="353"/>
        <location filename="../build/storyScience/LeftPanel.qml" line="355"/>
        <location filename="../LeftPanel.qml" line="385"/>
        <location filename="../LeftPanel.qml" line="388"/>
        <source>创建新章节...</source>
        <translation>New Section...</translation>
    </message>
    <message>
        <source>创建新场景...</source>
        <translation type="vanished">Create New Scene...</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LeftPanel.qml" line="404"/>
        <location filename="../build/storyScience/LeftPanel.qml" line="372"/>
        <location filename="../LeftPanel.qml" line="404"/>
        <source>关联已有元素...</source>
        <translation>Associate...</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LeftPanel.qml" line="411"/>
        <location filename="../build/storyScience/LeftPanel.qml" line="379"/>
        <location filename="../LeftPanel.qml" line="411"/>
        <source>导出章节文本</source>
        <translation>Export</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LeftPanel.qml" line="442"/>
        <location filename="../build/storyScience/LeftPanel.qml" line="410"/>
        <location filename="../LeftPanel.qml" line="442"/>
        <source>查看全书属性</source>
        <translation>View Book Properties</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LeftPanel.qml" line="448"/>
        <location filename="../build/storyScience/LeftPanel.qml" line="416"/>
        <location filename="../LeftPanel.qml" line="448"/>
        <source>转到AI读者视角</source>
        <translation>To AI Reader</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LeftPanel.qml" line="457"/>
        <location filename="../build/release/storyScience/LeftPanel.qml" line="477"/>
        <location filename="../build/storyScience/LeftPanel.qml" line="425"/>
        <location filename="../build/storyScience/LeftPanel.qml" line="445"/>
        <location filename="../LeftPanel.qml" line="457"/>
        <location filename="../LeftPanel.qml" line="477"/>
        <source>删除</source>
        <translation>Delete</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LeftPanel.qml" line="468"/>
        <location filename="../build/storyScience/LeftPanel.qml" line="436"/>
        <location filename="../LeftPanel.qml" line="468"/>
        <source>确认删除</source>
        <translation>Confirm Deletion</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LeftPanel.qml" line="475"/>
        <location filename="../build/storyScience/LeftPanel.qml" line="443"/>
        <location filename="../LeftPanel.qml" line="475"/>
        <source>确定要删除该项目吗？</source>
        <translation>Are you sure you want to delete this item?</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LeftPanel.qml" line="478"/>
        <location filename="../build/storyScience/LeftPanel.qml" line="446"/>
        <location filename="../LeftPanel.qml" line="478"/>
        <source>取消</source>
        <translation>Cancel</translation>
    </message>
    <message>
        <source>你确定要删除吗？</source>
        <translation type="vanished">Are you sure you want to delete?</translation>
    </message>
    <message>
        <source>删除该项目吗？</source>
        <translation type="vanished">Delete this item?</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LeftPanel.qml" line="100"/>
        <location filename="../build/storyScience/LeftPanel.qml" line="79"/>
        <location filename="../LeftPanel.qml" line="100"/>
        <source>书管理</source>
        <translation>BookManager</translation>
    </message>
</context>
<context>
    <name>LoadingOverlay</name>
    <message>
        <source>加载错误</source>
        <translation type="vanished">Load Error</translation>
    </message>
    <message>
        <source>正在加载项目</source>
        <translation type="vanished">Loading Items</translation>
    </message>
    <message>
        <source>重试</source>
        <translation type="vanished">Retry</translation>
    </message>
    <message>
        <source>继续</source>
        <translation type="vanished">Continue</translation>
    </message>
    <message>
        <source>取消</source>
        <translation type="vanished">Cancel</translation>
    </message>
</context>
<context>
    <name>LocationStatusEdit</name>
    <message>
        <location filename="../build/release/storyScience/LocationStatusEdit.qml" line="96"/>
        <location filename="../build/storyScience/LocationStatusEdit.qml" line="96"/>
        <location filename="../LocationStatusEdit.qml" line="96"/>
        <source>基本信息</source>
        <translation>Basic Information</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusEdit.qml" line="108"/>
        <location filename="../build/storyScience/LocationStatusEdit.qml" line="108"/>
        <location filename="../LocationStatusEdit.qml" line="108"/>
        <source>地区:</source>
        <translation>Region:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusEdit.qml" line="304"/>
        <location filename="../build/storyScience/LocationStatusEdit.qml" line="304"/>
        <location filename="../LocationStatusEdit.qml" line="304"/>
        <source>详情</source>
        <translation>Details</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusEdit.qml" line="320"/>
        <location filename="../build/storyScience/LocationStatusEdit.qml" line="320"/>
        <location filename="../LocationStatusEdit.qml" line="320"/>
        <source>无</source>
        <translation>None</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusEdit.qml" line="132"/>
        <location filename="../build/storyScience/LocationStatusEdit.qml" line="132"/>
        <location filename="../LocationStatusEdit.qml" line="132"/>
        <source>人口:</source>
        <translation>Population:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusEdit.qml" line="62"/>
        <location filename="../build/storyScience/LocationStatusEdit.qml" line="62"/>
        <location filename="../LocationStatusEdit.qml" line="62"/>
        <source>地点信息编辑</source>
        <translation>Location Information Editing</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusEdit.qml" line="136"/>
        <location filename="../build/storyScience/LocationStatusEdit.qml" line="136"/>
        <location filename="../LocationStatusEdit.qml" line="136"/>
        <source>100万人</source>
        <translation>1 million people</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusEdit.qml" line="156"/>
        <location filename="../build/storyScience/LocationStatusEdit.qml" line="156"/>
        <location filename="../LocationStatusEdit.qml" line="156"/>
        <source>控制组织ID:</source>
        <translation>Controlling Organization ID:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusEdit.qml" line="180"/>
        <location filename="../build/storyScience/LocationStatusEdit.qml" line="180"/>
        <location filename="../LocationStatusEdit.qml" line="180"/>
        <source>重要性:</source>
        <translation>Importance:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusEdit.qml" line="184"/>
        <location filename="../build/storyScience/LocationStatusEdit.qml" line="184"/>
        <location filename="../LocationStatusEdit.qml" line="184"/>
        <source>罕见</source>
        <translation>Rare</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusEdit.qml" line="204"/>
        <location filename="../build/storyScience/LocationStatusEdit.qml" line="204"/>
        <location filename="../LocationStatusEdit.qml" line="204"/>
        <source>坐标:</source>
        <translation>Coordinates:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusEdit.qml" line="228"/>
        <location filename="../build/storyScience/LocationStatusEdit.qml" line="228"/>
        <location filename="../LocationStatusEdit.qml" line="228"/>
        <source>气候:</source>
        <translation>Climate:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusEdit.qml" line="252"/>
        <location filename="../build/storyScience/LocationStatusEdit.qml" line="252"/>
        <location filename="../LocationStatusEdit.qml" line="252"/>
        <source>可达性:</source>
        <translation>Accessibility:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusEdit.qml" line="256"/>
        <location filename="../build/storyScience/LocationStatusEdit.qml" line="256"/>
        <location filename="../LocationStatusEdit.qml" line="256"/>
        <source>不可达</source>
        <translation>Inaccessible</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusEdit.qml" line="365"/>
        <location filename="../build/storyScience/LocationStatusEdit.qml" line="365"/>
        <location filename="../LocationStatusEdit.qml" line="365"/>
        <source>资源列表</source>
        <translation>Resource List</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusEdit.qml" line="423"/>
        <location filename="../build/storyScience/LocationStatusEdit.qml" line="421"/>
        <location filename="../LocationStatusEdit.qml" line="423"/>
        <source>×</source>
        <translation>x</translation>
    </message>
    <message>
        <source>删除</source>
        <translation type="vanished">Delete</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusEdit.qml" line="457"/>
        <location filename="../build/storyScience/LocationStatusEdit.qml" line="455"/>
        <location filename="../LocationStatusEdit.qml" line="457"/>
        <source>资源名称</source>
        <translation>Resource Name</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusEdit.qml" line="465"/>
        <location filename="../build/storyScience/LocationStatusEdit.qml" line="463"/>
        <location filename="../LocationStatusEdit.qml" line="465"/>
        <source>添加</source>
        <translation>Add</translation>
    </message>
</context>
<context>
    <name>LocationStatusView</name>
    <message>
        <location filename="../build/release/storyScience/LocationStatusView.qml" line="34"/>
        <location filename="../build/storyScience/LocationStatusView.qml" line="34"/>
        <location filename="../LocationStatusView.qml" line="34"/>
        <source>地点信息</source>
        <translation>Location Information</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusView.qml" line="68"/>
        <location filename="../build/storyScience/LocationStatusView.qml" line="68"/>
        <location filename="../LocationStatusView.qml" line="68"/>
        <source>基本信息</source>
        <translation>Basic Information</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusView.qml" line="81"/>
        <location filename="../build/storyScience/LocationStatusView.qml" line="81"/>
        <location filename="../LocationStatusView.qml" line="81"/>
        <source>地区</source>
        <translation>Region</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusView.qml" line="81"/>
        <location filename="../build/release/storyScience/LocationStatusView.qml" line="85"/>
        <location filename="../build/release/storyScience/LocationStatusView.qml" line="86"/>
        <location filename="../build/storyScience/LocationStatusView.qml" line="81"/>
        <location filename="../build/storyScience/LocationStatusView.qml" line="85"/>
        <location filename="../build/storyScience/LocationStatusView.qml" line="86"/>
        <location filename="../LocationStatusView.qml" line="81"/>
        <location filename="../LocationStatusView.qml" line="85"/>
        <location filename="../LocationStatusView.qml" line="86"/>
        <source>未设置</source>
        <translation>Not Set</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusView.qml" line="82"/>
        <location filename="../build/storyScience/LocationStatusView.qml" line="82"/>
        <location filename="../LocationStatusView.qml" line="82"/>
        <source>人口</source>
        <translation>Population</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusView.qml" line="82"/>
        <location filename="../build/storyScience/LocationStatusView.qml" line="82"/>
        <location filename="../LocationStatusView.qml" line="82"/>
        <source>100万人</source>
        <translation>1 million people</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusView.qml" line="83"/>
        <location filename="../build/storyScience/LocationStatusView.qml" line="83"/>
        <location filename="../LocationStatusView.qml" line="83"/>
        <source>控制组织</source>
        <translation>Controlling Organization</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusView.qml" line="83"/>
        <location filename="../build/release/storyScience/LocationStatusView.qml" line="157"/>
        <location filename="../build/release/storyScience/LocationStatusView.qml" line="212"/>
        <location filename="../build/storyScience/LocationStatusView.qml" line="83"/>
        <location filename="../build/storyScience/LocationStatusView.qml" line="157"/>
        <location filename="../build/storyScience/LocationStatusView.qml" line="212"/>
        <location filename="../LocationStatusView.qml" line="83"/>
        <location filename="../LocationStatusView.qml" line="157"/>
        <location filename="../LocationStatusView.qml" line="212"/>
        <source>无</source>
        <translation>None</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusView.qml" line="84"/>
        <location filename="../build/storyScience/LocationStatusView.qml" line="84"/>
        <location filename="../LocationStatusView.qml" line="84"/>
        <source>重要性</source>
        <translation>Importance</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusView.qml" line="84"/>
        <location filename="../build/storyScience/LocationStatusView.qml" line="84"/>
        <location filename="../LocationStatusView.qml" line="84"/>
        <source>罕见</source>
        <translation>Rare</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusView.qml" line="85"/>
        <location filename="../build/storyScience/LocationStatusView.qml" line="85"/>
        <location filename="../LocationStatusView.qml" line="85"/>
        <source>坐标</source>
        <translation>Coordinates</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusView.qml" line="86"/>
        <location filename="../build/storyScience/LocationStatusView.qml" line="86"/>
        <location filename="../LocationStatusView.qml" line="86"/>
        <source>气候</source>
        <translation>Climate</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusView.qml" line="87"/>
        <location filename="../build/storyScience/LocationStatusView.qml" line="87"/>
        <location filename="../LocationStatusView.qml" line="87"/>
        <source>可达性</source>
        <translation>Accessibility</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusView.qml" line="87"/>
        <location filename="../build/storyScience/LocationStatusView.qml" line="87"/>
        <location filename="../LocationStatusView.qml" line="87"/>
        <source>不可达</source>
        <translation>Inaccessible</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusView.qml" line="141"/>
        <location filename="../build/storyScience/LocationStatusView.qml" line="141"/>
        <location filename="../LocationStatusView.qml" line="141"/>
        <source>详情</source>
        <translation>Details</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/LocationStatusView.qml" line="196"/>
        <location filename="../build/storyScience/LocationStatusView.qml" line="196"/>
        <location filename="../LocationStatusView.qml" line="196"/>
        <source>资源列表</source>
        <translation>Resource List</translation>
    </message>
</context>
<context>
    <name>MessageBox</name>
    <message>
        <location filename="../build/release/storyScience/MessageBox.qml" line="17"/>
        <location filename="../build/storyScience/MessageBox.qml" line="17"/>
        <location filename="../MessageBox.qml" line="17"/>
        <source>提示</source>
        <translation>Prompt</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/MessageBox.qml" line="18"/>
        <location filename="../build/storyScience/MessageBox.qml" line="18"/>
        <location filename="../MessageBox.qml" line="18"/>
        <source>确定要执行此操作吗？</source>
        <translation>Are you sure you want to perform this operation?</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/MessageBox.qml" line="19"/>
        <location filename="../build/storyScience/MessageBox.qml" line="19"/>
        <location filename="../MessageBox.qml" line="19"/>
        <source>确定</source>
        <translation>Confirm</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/MessageBox.qml" line="20"/>
        <location filename="../build/storyScience/MessageBox.qml" line="20"/>
        <location filename="../MessageBox.qml" line="20"/>
        <source>取消</source>
        <translation>Cancel</translation>
    </message>
</context>
<context>
    <name>MessageDialog</name>
    <message>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Fusion/MessageDialog.qml" line="89"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Imagine/MessageDialog.qml" line="108"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Material/MessageDialog.qml" line="87"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Universal/MessageDialog.qml" line="88"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/MessageDialog.qml" line="95"/>
        <source>Hide Details...</source>
        <translation type="unfinished"></translation>
    </message>
    <message>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Fusion/MessageDialog.qml" line="89"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Imagine/MessageDialog.qml" line="108"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Material/MessageDialog.qml" line="87"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/+Universal/MessageDialog.qml" line="88"/>
        <location filename="../build/release/qml/QtQuick/Dialogs/quickimpl/qml/MessageDialog.qml" line="95"/>
        <source>Show Details...</source>
        <translation type="unfinished"></translation>
    </message>
</context>
<context>
    <name>MindMapView</name>
    <message>
        <location filename="../build/release/storyScience/MindMapView.qml" line="180"/>
        <location filename="../build/storyScience/MindMapView.qml" line="180"/>
        <location filename="../MindMapView.qml" line="180"/>
        <source>添加左子节点</source>
        <translation>Add Left Child Node</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/MindMapView.qml" line="185"/>
        <location filename="../build/storyScience/MindMapView.qml" line="185"/>
        <location filename="../MindMapView.qml" line="185"/>
        <source>添加右子节点</source>
        <translation>Add Right Child Node</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/MindMapView.qml" line="191"/>
        <location filename="../build/storyScience/MindMapView.qml" line="191"/>
        <location filename="../MindMapView.qml" line="191"/>
        <source>编辑文本</source>
        <translation>Edit Text</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/MindMapView.qml" line="201"/>
        <location filename="../build/storyScience/MindMapView.qml" line="201"/>
        <location filename="../MindMapView.qml" line="201"/>
        <source>编辑描述</source>
        <translation>Edit Desc</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/MindMapView.qml" line="211"/>
        <location filename="../build/storyScience/MindMapView.qml" line="211"/>
        <location filename="../MindMapView.qml" line="211"/>
        <source>删除节点</source>
        <translation>Delete Node</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/MindMapView.qml" line="182"/>
        <location filename="../build/storyScience/MindMapView.qml" line="182"/>
        <location filename="../MindMapView.qml" line="182"/>
        <source>左子节点</source>
        <translation>Left Child Node</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/MindMapView.qml" line="32"/>
        <location filename="../build/storyScience/MindMapView.qml" line="32"/>
        <location filename="../MindMapView.qml" line="32"/>
        <source>编辑节点描述</source>
        <translation>EditNodeDesc</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/MindMapView.qml" line="187"/>
        <location filename="../build/storyScience/MindMapView.qml" line="187"/>
        <location filename="../MindMapView.qml" line="187"/>
        <source>右子节点</source>
        <translation>Right Child Node</translation>
    </message>
</context>
<context>
    <name>Node</name>
    <message>
        <location filename="../build/release/storyScience/Node.qml" line="111"/>
        <location filename="../build/storyScience/Node.qml" line="111"/>
        <location filename="../Node.qml" line="111"/>
        <source>未知元素</source>
        <translation>Unknown Element</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/Node.qml" line="155"/>
        <location filename="../build/storyScience/Node.qml" line="155"/>
        <location filename="../Node.qml" line="155"/>
        <source>开始连接</source>
        <translation>Start Connection</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/Node.qml" line="163"/>
        <location filename="../build/storyScience/Node.qml" line="163"/>
        <location filename="../Node.qml" line="163"/>
        <source>删除节点</source>
        <translation>Delete Node</translation>
    </message>
</context>
<context>
    <name>NodeDescriptionPopup</name>
    <message>
        <location filename="../build/release/storyScience/NodeDescriptionPopup.qml" line="149"/>
        <location filename="../build/storyScience/NodeDescriptionPopup.qml" line="149"/>
        <location filename="../NodeDescriptionPopup.qml" line="149"/>
        <source>节点描述</source>
        <translation>Node Desc</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NodeDescriptionPopup.qml" line="217"/>
        <location filename="../build/storyScience/NodeDescriptionPopup.qml" line="217"/>
        <location filename="../NodeDescriptionPopup.qml" line="217"/>
        <source>暂无描述</source>
        <translation>No desc</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NodeDescriptionPopup.qml" line="231"/>
        <location filename="../build/storyScience/NodeDescriptionPopup.qml" line="231"/>
        <location filename="../NodeDescriptionPopup.qml" line="231"/>
        <source>编辑描述</source>
        <translation>Edit desc</translation>
    </message>
</context>
<context>
    <name>NodeEditDialog</name>
    <message>
        <location filename="../build/release/storyScience/NodeEditDialog.qml" line="15"/>
        <location filename="../build/storyScience/NodeEditDialog.qml" line="15"/>
        <location filename="../NodeEditDialog.qml" line="15"/>
        <source>编辑文本</source>
        <translation>Edit Text</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NodeEditDialog.qml" line="37"/>
        <location filename="../build/storyScience/NodeEditDialog.qml" line="37"/>
        <location filename="../NodeEditDialog.qml" line="37"/>
        <source>请输入新的文本:</source>
        <translation>Please enter new text:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NodeEditDialog.qml" line="44"/>
        <location filename="../build/storyScience/NodeEditDialog.qml" line="44"/>
        <location filename="../NodeEditDialog.qml" line="44"/>
        <source>文本</source>
        <translation>Text</translation>
    </message>
</context>
<context>
    <name>NotesView</name>
    <message>
        <location filename="../build/release/storyScience/NotesView.qml" line="23"/>
        <location filename="../build/storyScience/NotesView.qml" line="23"/>
        <location filename="../NotesView.qml" line="23"/>
        <source>学习</source>
        <translation>Study</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NotesView.qml" line="23"/>
        <location filename="../build/storyScience/NotesView.qml" line="23"/>
        <location filename="../NotesView.qml" line="23"/>
        <source>工作</source>
        <translation>Work</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NotesView.qml" line="23"/>
        <location filename="../build/storyScience/NotesView.qml" line="23"/>
        <location filename="../NotesView.qml" line="23"/>
        <source>创作</source>
        <translation>Creation</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NotesView.qml" line="23"/>
        <location filename="../build/storyScience/NotesView.qml" line="23"/>
        <location filename="../NotesView.qml" line="23"/>
        <source>生活</source>
        <translation>Life</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NotesView.qml" line="24"/>
        <location filename="../build/storyScience/NotesView.qml" line="24"/>
        <location filename="../NotesView.qml" line="24"/>
        <source>读书</source>
        <translation>Reading</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NotesView.qml" line="24"/>
        <location filename="../build/storyScience/NotesView.qml" line="24"/>
        <location filename="../NotesView.qml" line="24"/>
        <source>灵感</source>
        <translation>Inspiration</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NotesView.qml" line="24"/>
        <location filename="../build/storyScience/NotesView.qml" line="24"/>
        <location filename="../NotesView.qml" line="24"/>
        <source>待办</source>
        <translation>To-do</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NotesView.qml" line="24"/>
        <location filename="../build/storyScience/NotesView.qml" line="24"/>
        <location filename="../NotesView.qml" line="24"/>
        <source>想法</source>
        <translation>Idea</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NotesView.qml" line="115"/>
        <location filename="../build/storyScience/NotesView.qml" line="115"/>
        <location filename="../NotesView.qml" line="115"/>
        <source>随手笔记</source>
        <translation>Note</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NotesView.qml" line="147"/>
        <location filename="../build/storyScience/NotesView.qml" line="147"/>
        <location filename="../NotesView.qml" line="147"/>
        <source>时间轴</source>
        <translation>Timeline</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NotesView.qml" line="184"/>
        <location filename="../build/storyScience/NotesView.qml" line="184"/>
        <location filename="../NotesView.qml" line="184"/>
        <source>轮播图</source>
        <translation>Carousel</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NotesView.qml" line="222"/>
        <location filename="../build/storyScience/NotesView.qml" line="222"/>
        <location filename="../NotesView.qml" line="222"/>
        <source>+ 添加笔记</source>
        <translation>+ Add Note</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NotesView.qml" line="356"/>
        <location filename="../build/storyScience/NotesView.qml" line="356"/>
        <location filename="../NotesView.qml" line="356"/>
        <source>添加新笔记</source>
        <translation>Add New Note</translation>
    </message>
    <message>
        <source>📌 标题</source>
        <translation type="vanished">Title</translation>
    </message>
    <message>
        <source>请输入笔记标题...</source>
        <translation type="vanished">Please enter note title...</translation>
    </message>
    <message>
        <source>🏷️ 分类</source>
        <translation type="vanished">Category</translation>
    </message>
    <message>
        <source>请选择或输入分类...</source>
        <translation type="vanished">Please select or enter category...</translation>
    </message>
    <message>
        <source>⭐ 优先级</source>
        <translation type="vanished">Priority</translation>
    </message>
    <message>
        <source>📝 内容</source>
        <translation type="vanished">Content</translation>
    </message>
    <message>
        <source>在这里记录你的想法...</source>
        <translation type="vanished">Record your thoughts here...</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NotesView.qml" line="411"/>
        <location filename="../build/release/storyScience/NotesView.qml" line="829"/>
        <location filename="../build/storyScience/NotesView.qml" line="411"/>
        <location filename="../build/storyScience/NotesView.qml" line="829"/>
        <location filename="../NotesView.qml" line="411"/>
        <location filename="../NotesView.qml" line="829"/>
        <source>取消</source>
        <translation>Cancel</translation>
    </message>
    <message>
        <source>✨ 添加</source>
        <translation type="vanished">Add</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NotesView.qml" line="734"/>
        <location filename="../build/storyScience/NotesView.qml" line="734"/>
        <location filename="../NotesView.qml" line="734"/>
        <source>编辑笔记</source>
        <translation>Edit Note</translation>
    </message>
    <message>
        <source>请输入分类...</source>
        <translation type="vanished">Please enter category...</translation>
    </message>
    <message>
        <source>🗑️ 删除</source>
        <translation type="vanished">Delete</translation>
    </message>
    <message>
        <source>💾 保存</source>
        <translation type="vanished">Save</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NotesView.qml" line="507"/>
        <location filename="../build/release/storyScience/NotesView.qml" line="933"/>
        <location filename="../build/storyScience/NotesView.qml" line="507"/>
        <location filename="../build/storyScience/NotesView.qml" line="933"/>
        <location filename="../NotesView.qml" line="507"/>
        <location filename="../NotesView.qml" line="933"/>
        <source>标题</source>
        <translation>Title</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NotesView.qml" line="542"/>
        <location filename="../build/release/storyScience/NotesView.qml" line="971"/>
        <location filename="../build/storyScience/NotesView.qml" line="542"/>
        <location filename="../build/storyScience/NotesView.qml" line="971"/>
        <location filename="../NotesView.qml" line="542"/>
        <location filename="../NotesView.qml" line="971"/>
        <source>分类</source>
        <translation>Category</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NotesView.qml" line="621"/>
        <location filename="../build/storyScience/NotesView.qml" line="621"/>
        <location filename="../NotesView.qml" line="621"/>
        <source>优先级</source>
        <translation>Priority</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NotesView.qml" line="681"/>
        <location filename="../build/release/storyScience/NotesView.qml" line="1008"/>
        <location filename="../build/storyScience/NotesView.qml" line="681"/>
        <location filename="../build/storyScience/NotesView.qml" line="1008"/>
        <location filename="../NotesView.qml" line="681"/>
        <location filename="../NotesView.qml" line="1008"/>
        <source>内容</source>
        <translation>Content</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NotesView.qml" line="445"/>
        <location filename="../build/storyScience/NotesView.qml" line="445"/>
        <location filename="../NotesView.qml" line="445"/>
        <source>添加</source>
        <translation>Add</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NotesView.qml" line="791"/>
        <location filename="../build/storyScience/NotesView.qml" line="791"/>
        <location filename="../NotesView.qml" line="791"/>
        <source>删除</source>
        <translation>Delete</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/NotesView.qml" line="863"/>
        <location filename="../build/storyScience/NotesView.qml" line="863"/>
        <location filename="../NotesView.qml" line="863"/>
        <source>保存</source>
        <translation>Save</translation>
    </message>
</context>
<context>
    <name>OptimizationPreviewDialog</name>
    <message>
        <location filename="../build/release/storyScience/OptimizationPreviewDialog.qml" line="97"/>
        <location filename="../OptimizationPreviewDialog.qml" line="97"/>
        <source>AI 优化预览</source>
        <translation>AI Optimization Preview</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OptimizationPreviewDialog.qml" line="120"/>
        <location filename="../OptimizationPreviewDialog.qml" line="120"/>
        <source>原文</source>
        <translation>Original Text</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OptimizationPreviewDialog.qml" line="172"/>
        <location filename="../build/release/storyScience/OptimizationPreviewDialog.qml" line="258"/>
        <location filename="../OptimizationPreviewDialog.qml" line="172"/>
        <location filename="../OptimizationPreviewDialog.qml" line="258"/>
        <source>&lt;空&gt;</source>
        <translation>&lt;Null&gt;</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OptimizationPreviewDialog.qml" line="206"/>
        <location filename="../OptimizationPreviewDialog.qml" line="206"/>
        <source>优化后</source>
        <translation>Optimized Version</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OptimizationPreviewDialog.qml" line="332"/>
        <location filename="../OptimizationPreviewDialog.qml" line="332"/>
        <source>取消</source>
        <translation>Cancel</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OptimizationPreviewDialog.qml" line="380"/>
        <location filename="../OptimizationPreviewDialog.qml" line="380"/>
        <source>应用优化</source>
        <translation>Apply Optimization</translation>
    </message>
</context>
<context>
    <name>OptimizeArticlePopup</name>
    <message>
        <location filename="../build/release/storyScience/OptimizeArticlePopup.qml" line="41"/>
        <location filename="../build/storyScience/OptimizeArticlePopup.qml" line="41"/>
        <location filename="../OptimizeArticlePopup.qml" line="41"/>
        <source>优化文章</source>
        <translation>Optimize Article</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OptimizeArticlePopup.qml" line="135"/>
        <location filename="../build/storyScience/OptimizeArticlePopup.qml" line="135"/>
        <location filename="../OptimizeArticlePopup.qml" line="135"/>
        <source>如何优化文章。使语言更生动?增加细节描述?调整文章结构?提升逻辑性?</source>
        <translation>How to optimize an article. Make the language more vivid? Add detailed descriptions? Adjust the article structure? Enhance logicality?</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OptimizeArticlePopup.qml" line="165"/>
        <location filename="../build/release/storyScience/OptimizeArticlePopup.qml" line="179"/>
        <location filename="../build/storyScience/OptimizeArticlePopup.qml" line="165"/>
        <location filename="../build/storyScience/OptimizeArticlePopup.qml" line="179"/>
        <location filename="../OptimizeArticlePopup.qml" line="165"/>
        <location filename="../OptimizeArticlePopup.qml" line="179"/>
        <source>取消</source>
        <translation>Cancel</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OptimizeArticlePopup.qml" line="196"/>
        <location filename="../build/release/storyScience/OptimizeArticlePopup.qml" line="210"/>
        <location filename="../build/storyScience/OptimizeArticlePopup.qml" line="196"/>
        <location filename="../build/storyScience/OptimizeArticlePopup.qml" line="210"/>
        <location filename="../OptimizeArticlePopup.qml" line="196"/>
        <location filename="../OptimizeArticlePopup.qml" line="210"/>
        <source>优化</source>
        <translation>Optimize</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OptimizeArticlePopup.qml" line="84"/>
        <location filename="../build/storyScience/OptimizeArticlePopup.qml" line="84"/>
        <location filename="../OptimizeArticlePopup.qml" line="84"/>
        <source>借鉴名家写作手法</source>
        <translation>Learn from master writing styles</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OptimizeArticlePopup.qml" line="85"/>
        <location filename="../build/storyScience/OptimizeArticlePopup.qml" line="85"/>
        <location filename="../OptimizeArticlePopup.qml" line="85"/>
        <source>优化文章整体结构</source>
        <translation>Optimize overall structure</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OptimizeArticlePopup.qml" line="86"/>
        <location filename="../build/storyScience/OptimizeArticlePopup.qml" line="86"/>
        <location filename="../OptimizeArticlePopup.qml" line="86"/>
        <source>增强语言表现力</source>
        <translation>Enhance language expressiveness</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OptimizeArticlePopup.qml" line="87"/>
        <location filename="../build/storyScience/OptimizeArticlePopup.qml" line="87"/>
        <location filename="../OptimizeArticlePopup.qml" line="87"/>
        <source>丰富细节描写</source>
        <translation>Enrich descriptive details</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OptimizeArticlePopup.qml" line="88"/>
        <location filename="../build/storyScience/OptimizeArticlePopup.qml" line="88"/>
        <location filename="../OptimizeArticlePopup.qml" line="88"/>
        <source>调整段落逻辑顺序</source>
        <translation>Adjust paragraph logic</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OptimizeArticlePopup.qml" line="89"/>
        <location filename="../build/storyScience/OptimizeArticlePopup.qml" line="89"/>
        <location filename="../OptimizeArticlePopup.qml" line="89"/>
        <source>提升故事连贯性</source>
        <translation>Improve story coherence</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OptimizeArticlePopup.qml" line="90"/>
        <location filename="../build/storyScience/OptimizeArticlePopup.qml" line="90"/>
        <location filename="../OptimizeArticlePopup.qml" line="90"/>
        <source>强化人物刻画</source>
        <translation>Strengthen character portrayal</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OptimizeArticlePopup.qml" line="91"/>
        <location filename="../build/storyScience/OptimizeArticlePopup.qml" line="91"/>
        <location filename="../OptimizeArticlePopup.qml" line="91"/>
        <source>增加场景感和氛围</source>
        <translation>Add scene and atmosphere</translation>
    </message>
</context>
<context>
    <name>OrganizationStatusEdit</name>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusEdit.qml" line="94"/>
        <location filename="../build/storyScience/OrganizationStatusEdit.qml" line="55"/>
        <location filename="../OrganizationStatusEdit.qml" line="94"/>
        <source>基本信息</source>
        <translation>Basic Information</translation>
    </message>
    <message>
        <source>详情</source>
        <translation type="vanished">Details</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusEdit.qml" line="57"/>
        <location filename="../OrganizationStatusEdit.qml" line="57"/>
        <source>组织状态编辑</source>
        <translation>Organization Status Editing</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusEdit.qml" line="110"/>
        <location filename="../build/storyScience/OrganizationStatusEdit.qml" line="62"/>
        <location filename="../OrganizationStatusEdit.qml" line="110"/>
        <source>无</source>
        <translation>None</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusEdit.qml" line="164"/>
        <location filename="../build/storyScience/OrganizationStatusEdit.qml" line="95"/>
        <location filename="../OrganizationStatusEdit.qml" line="164"/>
        <source>组织属性</source>
        <translation>Organization Properties</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusEdit.qml" line="182"/>
        <location filename="../build/storyScience/OrganizationStatusEdit.qml" line="104"/>
        <location filename="../OrganizationStatusEdit.qml" line="182"/>
        <source>影响力:</source>
        <translation>Influence:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusEdit.qml" line="210"/>
        <location filename="../build/storyScience/OrganizationStatusEdit.qml" line="125"/>
        <location filename="../OrganizationStatusEdit.qml" line="210"/>
        <source>总部地点ID:</source>
        <translation>Headquarters Location ID:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusEdit.qml" line="238"/>
        <location filename="../build/storyScience/OrganizationStatusEdit.qml" line="146"/>
        <location filename="../OrganizationStatusEdit.qml" line="238"/>
        <source>目标:</source>
        <translation>Goal:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusEdit.qml" line="301"/>
        <location filename="../build/storyScience/OrganizationStatusEdit.qml" line="184"/>
        <location filename="../OrganizationStatusEdit.qml" line="301"/>
        <source>资源列表</source>
        <translation>Resource List</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusEdit.qml" line="359"/>
        <location filename="../build/release/storyScience/OrganizationStatusEdit.qml" line="547"/>
        <location filename="../OrganizationStatusEdit.qml" line="359"/>
        <location filename="../OrganizationStatusEdit.qml" line="547"/>
        <source>×</source>
        <translation>x</translation>
    </message>
    <message>
        <source>删除</source>
        <translation type="vanished">Delete</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusEdit.qml" line="386"/>
        <location filename="../build/storyScience/OrganizationStatusEdit.qml" line="235"/>
        <location filename="../OrganizationStatusEdit.qml" line="386"/>
        <source>资源名称</source>
        <translation>Resource Name</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusEdit.qml" line="400"/>
        <location filename="../build/release/storyScience/OrganizationStatusEdit.qml" line="608"/>
        <location filename="../OrganizationStatusEdit.qml" line="400"/>
        <location filename="../OrganizationStatusEdit.qml" line="608"/>
        <source>添加</source>
        <translation>Add</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusEdit.qml" line="458"/>
        <location filename="../build/storyScience/OrganizationStatusEdit.qml" line="277"/>
        <location filename="../OrganizationStatusEdit.qml" line="458"/>
        <source>成员列表</source>
        <translation>Member List</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusEdit.qml" line="498"/>
        <location filename="../build/release/storyScience/OrganizationStatusEdit.qml" line="578"/>
        <location filename="../build/storyScience/OrganizationStatusEdit.qml" line="294"/>
        <location filename="../build/storyScience/OrganizationStatusEdit.qml" line="350"/>
        <location filename="../OrganizationStatusEdit.qml" line="498"/>
        <location filename="../OrganizationStatusEdit.qml" line="578"/>
        <source>成员ID</source>
        <translation>Member ID</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusEdit.qml" line="523"/>
        <location filename="../build/release/storyScience/OrganizationStatusEdit.qml" line="593"/>
        <location filename="../build/storyScience/OrganizationStatusEdit.qml" line="314"/>
        <location filename="../build/storyScience/OrganizationStatusEdit.qml" line="361"/>
        <location filename="../OrganizationStatusEdit.qml" line="523"/>
        <location filename="../OrganizationStatusEdit.qml" line="593"/>
        <source>角色</source>
        <translation>Role</translation>
    </message>
</context>
<context>
    <name>OrganizationStatusView</name>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusView.qml" line="34"/>
        <location filename="../build/storyScience/OrganizationStatusView.qml" line="34"/>
        <location filename="../OrganizationStatusView.qml" line="34"/>
        <source>组织信息</source>
        <translation>Organization Information</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusView.qml" line="68"/>
        <location filename="../build/storyScience/OrganizationStatusView.qml" line="68"/>
        <location filename="../OrganizationStatusView.qml" line="68"/>
        <source>基本信息</source>
        <translation>Basic Information</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusView.qml" line="81"/>
        <location filename="../build/storyScience/OrganizationStatusView.qml" line="81"/>
        <location filename="../OrganizationStatusView.qml" line="81"/>
        <source>影响力</source>
        <translation>Influence</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusView.qml" line="82"/>
        <location filename="../build/storyScience/OrganizationStatusView.qml" line="82"/>
        <location filename="../OrganizationStatusView.qml" line="82"/>
        <source>总部</source>
        <translation>Headquarters</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusView.qml" line="82"/>
        <location filename="../build/storyScience/OrganizationStatusView.qml" line="82"/>
        <location filename="../OrganizationStatusView.qml" line="82"/>
        <source>未设置</source>
        <translation>Not Set</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusView.qml" line="83"/>
        <location filename="../build/storyScience/OrganizationStatusView.qml" line="83"/>
        <location filename="../OrganizationStatusView.qml" line="83"/>
        <source>目标</source>
        <translation>Goal</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusView.qml" line="83"/>
        <location filename="../build/release/storyScience/OrganizationStatusView.qml" line="153"/>
        <location filename="../build/release/storyScience/OrganizationStatusView.qml" line="208"/>
        <location filename="../build/storyScience/OrganizationStatusView.qml" line="83"/>
        <location filename="../build/storyScience/OrganizationStatusView.qml" line="153"/>
        <location filename="../build/storyScience/OrganizationStatusView.qml" line="208"/>
        <location filename="../OrganizationStatusView.qml" line="83"/>
        <location filename="../OrganizationStatusView.qml" line="153"/>
        <location filename="../OrganizationStatusView.qml" line="208"/>
        <source>无</source>
        <translation>None</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusView.qml" line="137"/>
        <location filename="../build/storyScience/OrganizationStatusView.qml" line="137"/>
        <location filename="../OrganizationStatusView.qml" line="137"/>
        <source>详情</source>
        <translation>Details</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusView.qml" line="192"/>
        <location filename="../build/storyScience/OrganizationStatusView.qml" line="192"/>
        <location filename="../OrganizationStatusView.qml" line="192"/>
        <source>资源列表</source>
        <translation>Resource List</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusView.qml" line="247"/>
        <location filename="../build/storyScience/OrganizationStatusView.qml" line="247"/>
        <location filename="../OrganizationStatusView.qml" line="247"/>
        <source>成员列表</source>
        <translation>Member List</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusView.qml" line="273"/>
        <location filename="../build/storyScience/OrganizationStatusView.qml" line="273"/>
        <location filename="../OrganizationStatusView.qml" line="273"/>
        <source>未知ID</source>
        <translation>Unknown ID</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OrganizationStatusView.qml" line="273"/>
        <location filename="../build/storyScience/OrganizationStatusView.qml" line="273"/>
        <location filename="../OrganizationStatusView.qml" line="273"/>
        <source>未知角色</source>
        <translation>Unknown Role</translation>
    </message>
</context>
<context>
    <name>OutlineModel</name>
    <message>
        <location filename="../outlinemodel.cpp" line="15"/>
        <location filename="../outlinemodel.cpp" line="293"/>
        <source>中心主题</source>
        <translation>Central Theme</translation>
    </message>
</context>
<context>
    <name>OutlineView</name>
    <message>
        <location filename="../build/release/storyScience/OutlineView.qml" line="47"/>
        <location filename="../build/storyScience/OutlineView.qml" line="47"/>
        <location filename="../OutlineView.qml" line="47"/>
        <source>大纲视图</source>
        <translation>Outline View</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OutlineView.qml" line="48"/>
        <location filename="../build/storyScience/OutlineView.qml" line="48"/>
        <location filename="../OutlineView.qml" line="48"/>
        <source>文本大纲</source>
        <translation>Text Outline</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OutlineView.qml" line="135"/>
        <location filename="../build/release/storyScience/OutlineView.qml" line="175"/>
        <location filename="../build/storyScience/OutlineView.qml" line="135"/>
        <location filename="../build/storyScience/OutlineView.qml" line="175"/>
        <location filename="../OutlineView.qml" line="135"/>
        <location filename="../OutlineView.qml" line="175"/>
        <source>保存</source>
        <translation>Save</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OutlineView.qml" line="147"/>
        <location filename="../build/storyScience/OutlineView.qml" line="147"/>
        <location filename="../OutlineView.qml" line="147"/>
        <source>添加子节点</source>
        <translation>Add Child Node</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OutlineView.qml" line="157"/>
        <location filename="../build/storyScience/OutlineView.qml" line="157"/>
        <location filename="../OutlineView.qml" line="157"/>
        <source>删除节点</source>
        <translation>Delete Node</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OutlineView.qml" line="168"/>
        <location filename="../build/storyScience/OutlineView.qml" line="168"/>
        <location filename="../OutlineView.qml" line="168"/>
        <source>自动布局</source>
        <translation>Auto Layout</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/OutlineView.qml" line="189"/>
        <location filename="../build/storyScience/OutlineView.qml" line="189"/>
        <location filename="../OutlineView.qml" line="189"/>
        <source>缩放: </source>
        <translation>Zoom: </translation>
    </message>
</context>
<context>
    <name>ReaderView</name>
    <message>
        <location filename="../build/release/storyScience/ReaderView.qml" line="20"/>
        <location filename="../build/release/storyScience/ReaderView.qml" line="559"/>
        <location filename="../build/release/storyScience/ReaderView.qml" line="561"/>
        <location filename="../build/release/storyScience/ReaderView.qml" line="564"/>
        <location filename="../build/release/storyScience/ReaderView.qml" line="593"/>
        <location filename="../build/release/storyScience/ReaderView.qml" line="596"/>
        <location filename="../build/storyScience/ReaderView.qml" line="20"/>
        <location filename="../build/storyScience/ReaderView.qml" line="559"/>
        <location filename="../build/storyScience/ReaderView.qml" line="561"/>
        <location filename="../build/storyScience/ReaderView.qml" line="564"/>
        <location filename="../build/storyScience/ReaderView.qml" line="593"/>
        <location filename="../build/storyScience/ReaderView.qml" line="596"/>
        <location filename="../ReaderView.qml" line="20"/>
        <location filename="../ReaderView.qml" line="559"/>
        <location filename="../ReaderView.qml" line="561"/>
        <location filename="../ReaderView.qml" line="564"/>
        <location filename="../ReaderView.qml" line="593"/>
        <location filename="../ReaderView.qml" line="596"/>
        <source>无标题章节</source>
        <translation>Untitled Chapter</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ReaderView.qml" line="204"/>
        <location filename="../build/storyScience/ReaderView.qml" line="204"/>
        <location filename="../ReaderView.qml" line="204"/>
        <source>返回编辑</source>
        <translation>Return to Edit</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ReaderView.qml" line="273"/>
        <location filename="../build/storyScience/ReaderView.qml" line="273"/>
        <location filename="../ReaderView.qml" line="273"/>
        <source>字体大小:</source>
        <translation>Font Size:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ReaderView.qml" line="340"/>
        <location filename="../build/storyScience/ReaderView.qml" line="340"/>
        <location filename="../ReaderView.qml" line="340"/>
        <source>AI点评</source>
        <translation>AI Review</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ReaderView.qml" line="528"/>
        <location filename="../build/storyScience/ReaderView.qml" line="528"/>
        <location filename="../ReaderView.qml" line="528"/>
        <source>字数: </source>
        <translation>Word Count: </translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ReaderView.qml" line="542"/>
        <location filename="../build/storyScience/ReaderView.qml" line="542"/>
        <location filename="../ReaderView.qml" line="542"/>
        <source>AI读者视角</source>
        <translation>AI Reader Perspective</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ReaderView.qml" line="575"/>
        <location filename="../build/storyScience/ReaderView.qml" line="575"/>
        <location filename="../ReaderView.qml" line="575"/>
        <source>请选择左侧故事树中的一个章节进行阅读</source>
        <translation>Please select a chapter in the story tree on the left to read</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/ReaderView.qml" line="586"/>
        <location filename="../build/storyScience/ReaderView.qml" line="586"/>
        <location filename="../ReaderView.qml" line="586"/>
        <source>请选择左侧故事树中的一个章节进行阅读

AI读者视角提供了更舒适的阅读体验，适合查看和审阅作品。</source>
        <translation>Please select a chapter in the story tree on the left to read. The AI Reader Perspective provides a more comfortable reading experience, suitable for viewing and reviewing works.</translation>
    </message>
</context>
<context>
    <name>RightPanel</name>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="37"/>
        <location filename="../build/storyScience/RightPanel.qml" line="37"/>
        <location filename="../RightPanel.qml" line="37"/>
        <source>+ 新建人物</source>
        <translation>New Character</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="39"/>
        <location filename="../build/storyScience/RightPanel.qml" line="39"/>
        <location filename="../RightPanel.qml" line="39"/>
        <source>新人物</source>
        <translation>New Character</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="44"/>
        <location filename="../build/storyScience/RightPanel.qml" line="44"/>
        <location filename="../RightPanel.qml" line="44"/>
        <source>+ 新建地点</source>
        <translation>New Location</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="46"/>
        <location filename="../build/storyScience/RightPanel.qml" line="46"/>
        <location filename="../RightPanel.qml" line="46"/>
        <source>新地点</source>
        <translation>New Location</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="51"/>
        <location filename="../build/storyScience/RightPanel.qml" line="51"/>
        <location filename="../RightPanel.qml" line="51"/>
        <source>+ 新建道具</source>
        <translation>New Item</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="53"/>
        <location filename="../build/storyScience/RightPanel.qml" line="53"/>
        <location filename="../RightPanel.qml" line="53"/>
        <source>新道具</source>
        <translation>New Prop</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="58"/>
        <location filename="../build/storyScience/RightPanel.qml" line="58"/>
        <location filename="../RightPanel.qml" line="58"/>
        <source>+ 新建能力</source>
        <translation>New Ability</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="60"/>
        <location filename="../build/storyScience/RightPanel.qml" line="60"/>
        <location filename="../RightPanel.qml" line="60"/>
        <source>新能力</source>
        <translation>New Ability</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="65"/>
        <location filename="../build/storyScience/RightPanel.qml" line="65"/>
        <location filename="../RightPanel.qml" line="65"/>
        <source>+ 新建组织</source>
        <translation>New Org</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="67"/>
        <location filename="../build/storyScience/RightPanel.qml" line="67"/>
        <location filename="../RightPanel.qml" line="67"/>
        <source>新组织</source>
        <translation>New Organization</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="72"/>
        <location filename="../build/storyScience/RightPanel.qml" line="72"/>
        <location filename="../RightPanel.qml" line="72"/>
        <source>+ 新建事件</source>
        <translation>New Event</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="74"/>
        <location filename="../build/storyScience/RightPanel.qml" line="74"/>
        <location filename="../RightPanel.qml" line="74"/>
        <source>新事件</source>
        <translation>New Event</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="202"/>
        <location filename="../build/storyScience/RightPanel.qml" line="202"/>
        <location filename="../RightPanel.qml" line="202"/>
        <source>展开</source>
        <translation>Expand</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="202"/>
        <location filename="../build/storyScience/RightPanel.qml" line="202"/>
        <location filename="../RightPanel.qml" line="202"/>
        <source>收起</source>
        <translation>Collapse</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="211"/>
        <location filename="../build/storyScience/RightPanel.qml" line="211"/>
        <location filename="../RightPanel.qml" line="211"/>
        <source>伏笔库</source>
        <translation>Foreshadowing Library</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="211"/>
        <location filename="../build/storyScience/RightPanel.qml" line="211"/>
        <location filename="../RightPanel.qml" line="211"/>
        <source>元素库</source>
        <translation>Element Library</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="276"/>
        <location filename="../build/storyScience/RightPanel.qml" line="276"/>
        <location filename="../RightPanel.qml" line="276"/>
        <source>人物</source>
        <translation>Char</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="287"/>
        <location filename="../build/storyScience/RightPanel.qml" line="287"/>
        <location filename="../RightPanel.qml" line="287"/>
        <source>地点</source>
        <translation>Loc</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="297"/>
        <location filename="../build/storyScience/RightPanel.qml" line="297"/>
        <location filename="../RightPanel.qml" line="297"/>
        <source>道具</source>
        <translation>Prop</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="307"/>
        <location filename="../build/storyScience/RightPanel.qml" line="307"/>
        <location filename="../RightPanel.qml" line="307"/>
        <source>能力</source>
        <translation>Abil</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="317"/>
        <location filename="../build/storyScience/RightPanel.qml" line="317"/>
        <location filename="../RightPanel.qml" line="317"/>
        <source>组织</source>
        <translation>Org</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="327"/>
        <location filename="../build/storyScience/RightPanel.qml" line="327"/>
        <location filename="../RightPanel.qml" line="327"/>
        <source>事件</source>
        <translation>Events</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="445"/>
        <location filename="../build/storyScience/RightPanel.qml" line="440"/>
        <location filename="../RightPanel.qml" line="445"/>
        <source>&lt;b&gt;原文：&lt;/b&gt;</source>
        <translation>&lt;b&gt;Original Text:&lt;/b&gt;</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="459"/>
        <location filename="../build/storyScience/RightPanel.qml" line="454"/>
        <location filename="../RightPanel.qml" line="459"/>
        <source>&lt;b&gt;描述: &lt;/b&gt;</source>
        <translation>&lt;b&gt;Description:&lt;/b&gt;</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="473"/>
        <location filename="../build/storyScience/RightPanel.qml" line="468"/>
        <location filename="../RightPanel.qml" line="473"/>
        <source>&lt;b&gt;来自章节:&lt;/b&gt; </source>
        <translation>&lt;b&gt;From Chapter:&lt;/b&gt; </translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="497"/>
        <location filename="../build/storyScience/RightPanel.qml" line="492"/>
        <location filename="../RightPanel.qml" line="497"/>
        <source>回顾</source>
        <translation>Review</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="635"/>
        <location filename="../build/storyScience/RightPanel.qml" line="630"/>
        <location filename="../RightPanel.qml" line="635"/>
        <source>AI创建中...</source>
        <translation>Creating with AI…</translation>
    </message>
    <message>
        <source>标记完成</source>
        <translation type="vanished">Mark as Completed</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="549"/>
        <location filename="../build/storyScience/RightPanel.qml" line="544"/>
        <location filename="../RightPanel.qml" line="549"/>
        <source>未完成</source>
        <translation>Uncompleted</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="549"/>
        <location filename="../build/storyScience/RightPanel.qml" line="544"/>
        <location filename="../RightPanel.qml" line="549"/>
        <source>完成</source>
        <translation>Finished</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="610"/>
        <location filename="../build/storyScience/RightPanel.qml" line="605"/>
        <location filename="../RightPanel.qml" line="610"/>
        <source>关联</source>
        <translation>Link</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/RightPanel.qml" line="635"/>
        <location filename="../build/storyScience/RightPanel.qml" line="630"/>
        <location filename="../RightPanel.qml" line="635"/>
        <source>AI创建</source>
        <translation>AI Create</translation>
    </message>
</context>
<context>
    <name>SummaryOverlay</name>
    <message>
        <location filename="../build/release/storyScience/SummaryOverlay.qml" line="146"/>
        <location filename="../SummaryOverlay.qml" line="146"/>
        <source>重新总结</source>
        <translation>Resummarize</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/SummaryOverlay.qml" line="94"/>
        <location filename="../SummaryOverlay.qml" line="94"/>
        <source>【%1】总结</source>
        <translation>【%1】 Summary</translation>
    </message>
</context>
<context>
    <name>TimelineOverview</name>
    <message>
        <location filename="../build/release/storyScience/TimelineOverview.qml" line="435"/>
        <location filename="../build/storyScience/TimelineOverview.qml" line="435"/>
        <location filename="../TimelineOverview.qml" line="435"/>
        <source>节点总数</source>
        <translation>Total Nodes</translation>
    </message>
</context>
<context>
    <name>TopBar</name>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="148"/>
        <location filename="../build/storyScience/TopBar.qml" line="146"/>
        <location filename="../TopBar.qml" line="148"/>
        <source>写作</source>
        <translation>Writing</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="188"/>
        <location filename="../build/storyScience/TopBar.qml" line="186"/>
        <location filename="../TopBar.qml" line="188"/>
        <source>图谱</source>
        <translation>Schema</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="228"/>
        <location filename="../build/storyScience/TopBar.qml" line="226"/>
        <location filename="../TopBar.qml" line="228"/>
        <source>大纲</source>
        <translation>Outline</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="268"/>
        <location filename="../build/storyScience/TopBar.qml" line="266"/>
        <location filename="../TopBar.qml" line="268"/>
        <source>世界观</source>
        <translation>Worldview</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="308"/>
        <location filename="../build/storyScience/TopBar.qml" line="306"/>
        <location filename="../TopBar.qml" line="308"/>
        <source>随手笔记</source>
        <translation>Random Note</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="355"/>
        <location filename="../build/storyScience/TopBar.qml" line="353"/>
        <location filename="../TopBar.qml" line="355"/>
        <source>新建</source>
        <translation>New</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="358"/>
        <location filename="../build/release/storyScience/TopBar.qml" line="971"/>
        <location filename="../build/storyScience/TopBar.qml" line="356"/>
        <location filename="../build/storyScience/TopBar.qml" line="925"/>
        <location filename="../TopBar.qml" line="358"/>
        <location filename="../TopBar.qml" line="971"/>
        <source>新建项目</source>
        <translation>New Project</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="382"/>
        <location filename="../build/storyScience/TopBar.qml" line="380"/>
        <location filename="../TopBar.qml" line="382"/>
        <source>保存</source>
        <translation>Save</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="386"/>
        <location filename="../build/storyScience/TopBar.qml" line="384"/>
        <location filename="../TopBar.qml" line="386"/>
        <source>快速保存（立即保存当前项目）</source>
        <translation>Save current project immediately</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="421"/>
        <location filename="../build/storyScience/TopBar.qml" line="419"/>
        <location filename="../TopBar.qml" line="421"/>
        <source>另存为</source>
        <translation>Save As</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="451"/>
        <location filename="../build/storyScience/TopBar.qml" line="449"/>
        <location filename="../TopBar.qml" line="451"/>
        <source>加载</source>
        <translation>Load</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="489"/>
        <location filename="../build/storyScience/TopBar.qml" line="487"/>
        <location filename="../TopBar.qml" line="489"/>
        <source>设置和视图选项</source>
        <translation>Settings and View Options</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="541"/>
        <location filename="../build/storyScience/TopBar.qml" line="539"/>
        <location filename="../TopBar.qml" line="541"/>
        <source>设置</source>
        <translation>Settings</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="560"/>
        <location filename="../build/storyScience/TopBar.qml" line="558"/>
        <location filename="../TopBar.qml" line="560"/>
        <source>帮助</source>
        <translation>Help</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="567"/>
        <location filename="../build/storyScience/TopBar.qml" line="565"/>
        <location filename="../TopBar.qml" line="567"/>
        <source>新手教程</source>
        <translation>Beginner Tutorial</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="575"/>
        <location filename="../build/storyScience/TopBar.qml" line="573"/>
        <location filename="../TopBar.qml" line="575"/>
        <source>高级教程</source>
        <translation>Advanced Tutorial</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="583"/>
        <location filename="../build/storyScience/TopBar.qml" line="581"/>
        <location filename="../TopBar.qml" line="583"/>
        <source>按键详细</source>
        <translation>Key Details</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="617"/>
        <location filename="../build/storyScience/TopBar.qml" line="615"/>
        <location filename="../TopBar.qml" line="617"/>
        <source>沉浸式写作</source>
        <translation>Immersive Writing</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="639"/>
        <location filename="../build/storyScience/TopBar.qml" line="637"/>
        <location filename="../TopBar.qml" line="639"/>
        <source>语言</source>
        <translation>Language</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="646"/>
        <location filename="../build/storyScience/TopBar.qml" line="644"/>
        <location filename="../TopBar.qml" line="646"/>
        <source>中文</source>
        <translation>Chinese</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="701"/>
        <location filename="../build/storyScience/TopBar.qml" line="699"/>
        <location filename="../TopBar.qml" line="701"/>
        <source>切换读者视角</source>
        <translation>Switch Reader Perspective</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="751"/>
        <location filename="../TopBar.qml" line="751"/>
        <source>爱心捐赠</source>
        <translation>Love Donation</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="888"/>
        <location filename="../build/storyScience/TopBar.qml" line="842"/>
        <location filename="../TopBar.qml" line="888"/>
        <source>选择文件</source>
        <translation>Select File</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="981"/>
        <location filename="../build/storyScience/TopBar.qml" line="935"/>
        <location filename="../TopBar.qml" line="981"/>
        <source>请输入项目名称：</source>
        <translation>Please enter the project name:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TopBar.qml" line="988"/>
        <location filename="../build/storyScience/TopBar.qml" line="942"/>
        <location filename="../TopBar.qml" line="988"/>
        <source>项目名称</source>
        <translation>Project Name</translation>
    </message>
</context>
<context>
    <name>TutorialOverlay</name>
    <message>
        <location filename="../build/release/storyScience/TutorialOverlay.qml" line="219"/>
        <location filename="../build/storyScience/TutorialOverlay.qml" line="219"/>
        <location filename="../TutorialOverlay.qml" line="219"/>
        <source>上一步</source>
        <translation>Previous step</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TutorialOverlay.qml" line="224"/>
        <location filename="../build/storyScience/TutorialOverlay.qml" line="224"/>
        <location filename="../TutorialOverlay.qml" line="224"/>
        <source>下一步</source>
        <translation>Next step</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TutorialOverlay.qml" line="224"/>
        <location filename="../build/storyScience/TutorialOverlay.qml" line="224"/>
        <location filename="../TutorialOverlay.qml" line="224"/>
        <source>完成</source>
        <translation>Complete</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/TutorialOverlay.qml" line="231"/>
        <location filename="../build/storyScience/TutorialOverlay.qml" line="231"/>
        <location filename="../TutorialOverlay.qml" line="231"/>
        <source>跳过</source>
        <translation>Skip</translation>
    </message>
</context>
<context>
    <name>VocabularyHelperPopup</name>
    <message>
        <location filename="../build/release/storyScience/VocabularyHelperPopup.qml" line="29"/>
        <location filename="../build/storyScience/VocabularyHelperPopup.qml" line="29"/>
        <location filename="../VocabularyHelperPopup.qml" line="29"/>
        <source>符号</source>
        <translation>Symbol</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/VocabularyHelperPopup.qml" line="30"/>
        <location filename="../build/storyScience/VocabularyHelperPopup.qml" line="30"/>
        <location filename="../VocabularyHelperPopup.qml" line="30"/>
        <source>语气</source>
        <translation>Tone</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/VocabularyHelperPopup.qml" line="31"/>
        <location filename="../build/storyScience/VocabularyHelperPopup.qml" line="31"/>
        <location filename="../VocabularyHelperPopup.qml" line="31"/>
        <source>动作词</source>
        <translation>Verb</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/VocabularyHelperPopup.qml" line="32"/>
        <location filename="../build/storyScience/VocabularyHelperPopup.qml" line="32"/>
        <location filename="../VocabularyHelperPopup.qml" line="32"/>
        <source>眼睛</source>
        <translation>Eye</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/VocabularyHelperPopup.qml" line="33"/>
        <location filename="../build/storyScience/VocabularyHelperPopup.qml" line="33"/>
        <location filename="../VocabularyHelperPopup.qml" line="33"/>
        <source>心理</source>
        <translation>Psychology</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/VocabularyHelperPopup.qml" line="34"/>
        <location filename="../build/storyScience/VocabularyHelperPopup.qml" line="34"/>
        <location filename="../VocabularyHelperPopup.qml" line="34"/>
        <source>环境</source>
        <translation>Environment</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/VocabularyHelperPopup.qml" line="35"/>
        <location filename="../build/storyScience/VocabularyHelperPopup.qml" line="35"/>
        <location filename="../VocabularyHelperPopup.qml" line="35"/>
        <source>外貌</source>
        <translation>Appearance</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/VocabularyHelperPopup.qml" line="36"/>
        <location filename="../build/storyScience/VocabularyHelperPopup.qml" line="36"/>
        <location filename="../VocabularyHelperPopup.qml" line="36"/>
        <source>声音</source>
        <translation>Voice</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/VocabularyHelperPopup.qml" line="37"/>
        <location filename="../build/storyScience/VocabularyHelperPopup.qml" line="37"/>
        <location filename="../VocabularyHelperPopup.qml" line="37"/>
        <source>对话</source>
        <translation>Dialogue</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/VocabularyHelperPopup.qml" line="38"/>
        <location filename="../build/storyScience/VocabularyHelperPopup.qml" line="38"/>
        <location filename="../VocabularyHelperPopup.qml" line="38"/>
        <source>战斗</source>
        <translation>Fight</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/VocabularyHelperPopup.qml" line="39"/>
        <location filename="../build/storyScience/VocabularyHelperPopup.qml" line="39"/>
        <location filename="../VocabularyHelperPopup.qml" line="39"/>
        <source>场景</source>
        <translation>Scene</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/VocabularyHelperPopup.qml" line="40"/>
        <location filename="../build/storyScience/VocabularyHelperPopup.qml" line="40"/>
        <location filename="../VocabularyHelperPopup.qml" line="40"/>
        <source>修真术语</source>
        <translation>Rhetorical device</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/VocabularyHelperPopup.qml" line="41"/>
        <location filename="../build/storyScience/VocabularyHelperPopup.qml" line="41"/>
        <location filename="../VocabularyHelperPopup.qml" line="41"/>
        <source>身份头衔</source>
        <translation>Title</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/VocabularyHelperPopup.qml" line="42"/>
        <location filename="../build/storyScience/VocabularyHelperPopup.qml" line="42"/>
        <location filename="../VocabularyHelperPopup.qml" line="42"/>
        <source>物品名</source>
        <translation>Proper noun</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/VocabularyHelperPopup.qml" line="43"/>
        <location filename="../build/storyScience/VocabularyHelperPopup.qml" line="43"/>
        <location filename="../VocabularyHelperPopup.qml" line="43"/>
        <source>抽象概念</source>
        <translation>Abstract concept</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/VocabularyHelperPopup.qml" line="44"/>
        <location filename="../build/storyScience/VocabularyHelperPopup.qml" line="44"/>
        <location filename="../VocabularyHelperPopup.qml" line="44"/>
        <source>能量</source>
        <translation>Energy</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/VocabularyHelperPopup.qml" line="109"/>
        <location filename="../build/storyScience/VocabularyHelperPopup.qml" line="109"/>
        <location filename="../VocabularyHelperPopup.qml" line="109"/>
        <source>辅助词汇库</source>
        <translation>Auxiliary vocabulary</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/VocabularyHelperPopup.qml" line="126"/>
        <location filename="../build/storyScience/VocabularyHelperPopup.qml" line="126"/>
        <location filename="../VocabularyHelperPopup.qml" line="126"/>
        <source>搜索当前分类词汇...</source>
        <translation>Search current category vocabulary...</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/VocabularyHelperPopup.qml" line="141"/>
        <location filename="../build/storyScience/VocabularyHelperPopup.qml" line="141"/>
        <location filename="../VocabularyHelperPopup.qml" line="141"/>
        <source>清空</source>
        <translation>Clear</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/VocabularyHelperPopup.qml" line="284"/>
        <location filename="../build/storyScience/VocabularyHelperPopup.qml" line="284"/>
        <location filename="../VocabularyHelperPopup.qml" line="284"/>
        <source>关闭</source>
        <translation>Close</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/VocabularyHelperPopup.qml" line="309"/>
        <location filename="../build/storyScience/VocabularyHelperPopup.qml" line="309"/>
        <location filename="../VocabularyHelperPopup.qml" line="309"/>
        <source>已复制</source>
        <translation>Copied</translation>
    </message>
</context>
<context>
    <name>WorldbuildingView</name>
    <message>
        <location filename="../build/release/storyScience/WorldbuildingView.qml" line="30"/>
        <location filename="../build/storyScience/WorldbuildingView.qml" line="30"/>
        <location filename="../WorldbuildingView.qml" line="30"/>
        <source>地理</source>
        <translation>Geography</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/WorldbuildingView.qml" line="31"/>
        <location filename="../build/storyScience/WorldbuildingView.qml" line="31"/>
        <location filename="../WorldbuildingView.qml" line="31"/>
        <source>历史</source>
        <translation>History</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/WorldbuildingView.qml" line="32"/>
        <location filename="../build/storyScience/WorldbuildingView.qml" line="32"/>
        <location filename="../WorldbuildingView.qml" line="32"/>
        <source>文化</source>
        <translation>Culture</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/WorldbuildingView.qml" line="33"/>
        <location filename="../build/storyScience/WorldbuildingView.qml" line="33"/>
        <location filename="../WorldbuildingView.qml" line="33"/>
        <source>种族</source>
        <translation>Race</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/WorldbuildingView.qml" line="81"/>
        <location filename="../build/storyScience/WorldbuildingView.qml" line="81"/>
        <location filename="../WorldbuildingView.qml" line="81"/>
        <source>+ 添加分类</source>
        <translation>+ Add Category</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/WorldbuildingView.qml" line="118"/>
        <location filename="../build/storyScience/WorldbuildingView.qml" line="118"/>
        <location filename="../WorldbuildingView.qml" line="118"/>
        <source>世界观 - </source>
        <translation>Worldview - </translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/WorldbuildingView.qml" line="227"/>
        <location filename="../build/storyScience/WorldbuildingView.qml" line="227"/>
        <location filename="../WorldbuildingView.qml" line="227"/>
        <source>添加新分类</source>
        <translation>Add New Category</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/WorldbuildingView.qml" line="238"/>
        <location filename="../build/storyScience/WorldbuildingView.qml" line="238"/>
        <location filename="../WorldbuildingView.qml" line="238"/>
        <source>请输入新分类名称：</source>
        <translation>Please enter the new category name:</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/WorldbuildingView.qml" line="245"/>
        <location filename="../build/storyScience/WorldbuildingView.qml" line="245"/>
        <location filename="../WorldbuildingView.qml" line="245"/>
        <source>分类名称</source>
        <translation>Category Name</translation>
    </message>
</context>
<context>
    <name>main</name>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="80"/>
        <location filename="../main.qml" line="80"/>
        <source>正在为章节 &quot;%1&quot; 生成总结，请稍候...</source>
        <translation>Generating summary for chapter &quot;%1&quot;, please wait...</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="81"/>
        <location filename="../main.qml" line="81"/>
        <source>AI正在生成总结</source>
        <translation>AI is generating the summary</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="94"/>
        <location filename="../main.qml" line="94"/>
        <source>AI总结生成完成</source>
        <translation>AI summary generation completed</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="94"/>
        <location filename="../main.qml" line="94"/>
        <source>总结已更新</source>
        <translation>Summary has been updated</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="124"/>
        <location filename="../build/storyScience/main.qml" line="114"/>
        <location filename="../main.qml" line="124"/>
        <source>沉浸式写作模式</source>
        <translation>Immersive Writing Mode</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="124"/>
        <location filename="../build/storyScience/main.qml" line="114"/>
        <location filename="../main.qml" line="124"/>
        <source>按ESC键可退出</source>
        <translation>Press the ESC key to Exit</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="212"/>
        <location filename="../build/storyScience/main.qml" line="202"/>
        <location filename="../main.qml" line="212"/>
        <source>高级教程</source>
        <translation>Advanced Tutorial</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="212"/>
        <location filename="../build/storyScience/main.qml" line="202"/>
        <location filename="../main.qml" line="212"/>
        <source>不会哪里，左键无效点右键，双键无效则滑动鼠标滚轮</source>
        <translation>If the left click doesn’t work, try the right click.
If both don’t work, scroll the mouse wheel.</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="277"/>
        <location filename="../build/storyScience/main.qml" line="263"/>
        <location filename="../main.qml" line="277"/>
        <source>不可删除书籍</source>
        <translation>Non-deletable Book</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="277"/>
        <location filename="../build/storyScience/main.qml" line="263"/>
        <location filename="../main.qml" line="277"/>
        <source>提示，书籍根节点不可删除</source>
        <translation>The root book node cannot be deleted</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="286"/>
        <location filename="../build/storyScience/main.qml" line="272"/>
        <location filename="../main.qml" line="286"/>
        <source>文本润色中</source>
        <translation>Text polishing</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="289"/>
        <location filename="../build/storyScience/main.qml" line="275"/>
        <location filename="../main.qml" line="289"/>
        <source>润色完成</source>
        <translation>Polished</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="289"/>
        <location filename="../build/storyScience/main.qml" line="275"/>
        <location filename="../main.qml" line="289"/>
        <source>请查看润色结果</source>
        <translation>Check the result</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="293"/>
        <location filename="../build/storyScience/main.qml" line="279"/>
        <location filename="../main.qml" line="293"/>
        <source>续写中</source>
        <translation>Continuing</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="297"/>
        <location filename="../build/storyScience/main.qml" line="283"/>
        <location filename="../main.qml" line="297"/>
        <source>续写完成</source>
        <translation>Continuation Completed</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="297"/>
        <location filename="../build/storyScience/main.qml" line="283"/>
        <location filename="../main.qml" line="297"/>
        <source>请查看续写结果</source>
        <translation>Please review the continuation result</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="301"/>
        <location filename="../build/storyScience/main.qml" line="287"/>
        <location filename="../main.qml" line="301"/>
        <source>保存</source>
        <translation>Save</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="301"/>
        <location filename="../build/storyScience/main.qml" line="287"/>
        <location filename="../main.qml" line="301"/>
        <source>保存成功</source>
        <translation>Saved successfully</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="305"/>
        <location filename="../build/storyScience/main.qml" line="291"/>
        <location filename="../main.qml" line="305"/>
        <source>AI润色请求失败</source>
        <translation>AI Polishing Request Failed</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="309"/>
        <location filename="../build/storyScience/main.qml" line="295"/>
        <location filename="../main.qml" line="309"/>
        <source>AI续写请求失败</source>
        <translation>AI Continuation Request Failed</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="317"/>
        <location filename="../build/storyScience/main.qml" line="303"/>
        <location filename="../main.qml" line="317"/>
        <source>AI创建中</source>
        <translation>AI creating</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="320"/>
        <location filename="../build/storyScience/main.qml" line="306"/>
        <location filename="../main.qml" line="320"/>
        <source>创建完成</source>
        <translation>Creation completed</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="323"/>
        <location filename="../build/storyScience/main.qml" line="309"/>
        <location filename="../main.qml" line="323"/>
        <source>AI创建请求失败</source>
        <translation>AI Creation Request Failed</translation>
    </message>
    <message>
        <location filename="../build/release/storyScience/main.qml" line="397"/>
        <location filename="../build/storyScience/main.qml" line="383"/>
        <location filename="../main.qml" line="397"/>
        <source>AI点评请求失败</source>
        <translation>AI Review Request Failed</translation>
    </message>
</context>
</TS>
