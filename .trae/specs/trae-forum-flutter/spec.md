# TRAE Community APK - CoolApk 风格原生化规格

## 项目目标

将 `https://forum.trae.cn/` 原生化为一个面向移动端的社区 APK。产品交互参考 `c001apk` / CoolApk 的社区信息流体验，但数据源、内容结构、品牌表达和功能边界均以 TRAE 论坛为准。

核心目标不是 WebView 套壳，而是把 TRAE 论坛的 Discourse 内容转成 Flutter 原生社区体验：

- 首页像社区 App 一样浏览、刷新、切换频道和查看热门内容。
- 帖子像动态一样展示作者、标题、正文摘要、分类、标签、回复数、浏览数、点赞数和图片。
- 详情页原生展示 Discourse 话题正文与回复流。
- 搜索、用户主页、消息、收藏、历史和设置逐步补齐。
- WebView 仅作为外链、登录兜底或暂未原生化页面的临时入口。

## 参考边界

### CoolApk / c001apk 可借鉴部分

- 底部主导航：首页、发现/搜索、消息、我的。
- 首页多 Tab/频道信息流：推荐、热门、分类、标签、活动等。
- Feed 卡片：作者区、内容区、媒体区、互动区。
- 动态详情：正文、评论排序、快捷回复、楼层/对话查看。
- 用户能力：关注、拉黑、分享、举报、用户主页。
- 本地能力：收藏、浏览历史、搜索历史、主题、字体、缓存清理。

### 不复制的部分

- 不接入 CoolApk API。
- 不复刻 CoolApk 应用下载、数码数据库等与 TRAE 论坛无关的业务。
- 不模拟不存在的服务端写接口；发帖、回复、点赞等需要认证的能力必须以 Discourse 实际可用接口为准。
- 不把论坛内容直接放进整页 WebView 作为主体验。

## 当前技术方向

- Flutter + Material Design 3。
- Riverpod 管理状态。
- Dio 访问 Discourse REST API。
- GoRouter 管理路由。
- Freezed / json_serializable 定义数据模型。
- cached_network_image / photo_view 处理图片加载与预览。
- flutter_html 渲染 Discourse `cooked` HTML。

## 数据源

基础站点：`https://forum.trae.cn`

### 真实数据验收门槛

首页、详情、搜索、用户主页是本项目的核心只读路径，验收时 SHALL 全部来自真实 `forum.trae.cn` 数据。以下情况 SHALL 判定为未通过验收：

- 页面主体内容来自 mock、硬编码示例、静态 JSON 或本地假数据。
- 页面主体内容由整页 WebView 承载，而不是 Flutter 原生组件渲染。
- 页面只展示路由占位、固定文案或空壳布局。
- API 请求失败后用假数据伪装成功状态。
- 只完成其中一部分页面真实接入，却声明只读 MVP 完成。

允许的例外：

- 单元测试、Widget 测试和离线开发可使用 mock。
- 网络失败、接口 4xx/5xx、解析失败时可展示错误态、空态或重试入口。
- 外部链接、登录兜底、暂未原生化的非核心页面可使用 WebView。

公开读取优先使用 Discourse 标准接口：

```text
GET /latest.json
GET /top.json
GET /categories.json
GET /c/{category_id}.json
GET /t/{topic_id}.json
GET /t/{topic_id}/posts.json
GET /search.json?q={query}
GET /u/{username}.json
GET /u/{username}/summary.json
```

需要登录的写操作作为后续阶段：

```text
POST /posts
POST /post_actions
DELETE /post_actions/{id}
GET /notifications.json
```

## TRAE 论坛分类

应用 SHALL 将 Discourse 分类映射为原生社区频道。

| ID | 名称 | App 频道用途 |
|----|------|--------------|
| 4 | 官方公告 | 官方信息、产品更新 |
| 7 | 帮助与支持 | 问题求助、技术支持 |
| 8 | 产品建议 | 反馈、建议、共创 |
| 9 | 技巧分享 | 教程、经验、最佳实践 |
| 10 | 案例与作品 | 项目展示、作品分享 |
| 11 | 互动交流 | 日常讨论、开放交流 |
| 29 | 福利活动 | 活动、福利、运营内容 |
| 33 | 社区伙伴 | 伙伴内容、生态协作 |
| 35 | SOLO挑战赛专区 | SOLO 活动与作品提交 |

## 产品信息架构

### 主导航

系统 SHALL 提供 4 个一级入口：

- 首页：TRAE 社区信息流，默认入口。
- 发现：搜索、分类、标签、热门话题、精选合集。
- 消息：通知、回复、点赞、@我；未登录时展示登录引导或只读提示。
- 我的：用户资料、本地收藏、历史、设置、登录状态。

### 首页频道

首页 SHALL 提供 CoolApk 风格的横向频道切换：

- 推荐：默认使用 `/latest.json`，按最新活跃话题展示。
- 热门：使用 `/top.json` 或基于 views/reply/like 的本地排序兜底。
- 官方：分类 4。
- 求助：分类 7。
- 建议：分类 8。
- 技巧：分类 9。
- 作品：分类 10。
- 交流：分类 11。
- 活动：分类 29 / 35。

频道配置 SHOULD 支持后续本地排序、自定义显示和隐藏。

## 核心模型映射

### Discourse Topic -> 社区 Feed

系统 SHALL 将话题列表项映射为 Feed 卡片。

```text
Topic.id -> feed.id
Topic.title -> feed.title
Topic.excerpt -> feed.content / summary
Topic.category_id -> feed.category
Topic.tags -> feed.tags
Topic.posts_count / reply_count -> feed.replyCount
Topic.views -> feed.viewCount
Topic.like_count -> feed.likeCount
Topic.created_at / last_posted_at -> feed.createTime / updateTime
Topic.posters / users -> feed.author / participants
Topic.image_url -> feed.coverImage
```

### Discourse Post -> 评论/正文

系统 SHALL 将首楼 Post 作为话题正文，将其余 Posts 作为回复流。

```text
Post.id -> reply.id
Post.post_number -> reply.floor
Post.username -> reply.username
Post.avatar_template -> reply.avatarUrl
Post.cooked -> reply.richContentHtml
Post.created_at -> reply.createTime
Post.like_count -> reply.likeCount
Post.reply_to_post_number -> reply.parentFloor
```

### Discourse Cooked HTML -> 编辑化内容块

系统 SHALL 将 Discourse `cooked` HTML 解析为可排版的内容块，而不是直接按原始 HTML 顺序做简单纵向堆叠。

```text
p / text -> paragraph block
h1-h4 -> heading block
img / upload -> image block
figure / image group -> media block
blockquote -> quote block
pre / code -> code block
ul / ol -> list block
a -> inline link / link card candidate
```

内容块 SHALL 保留原文语义和阅读顺序，但 UI 层可以按移动端杂志式排版规则调整视觉节奏、图片尺寸、留白、标题层级和媒体组合。

### 头像 URL

系统 SHALL 解析 Discourse `avatar_template`：

- 将 `{size}` 替换为合适尺寸，如 `96` 或 `120`。
- 相对路径补齐 `https://forum.trae.cn`。
- 空头像使用本地默认头像或首字母占位。

## 功能需求

### Requirement: 原生首页信息流

系统 SHALL 提供类似 CoolApk 的社区 Feed 首页。

#### Scenario: 首次打开首页
- WHEN 用户打开 App
- THEN 应用 SHALL 请求 `https://forum.trae.cn/latest.json`
- AND 展示原生 Feed 卡片列表
- AND Feed 卡片内容 SHALL 来自真实 Discourse Topic 数据
- AND 支持下拉刷新、上拉加载更多、加载态、空态和错误重试

#### Scenario: 切换频道
- WHEN 用户点击分类/频道 Tab
- THEN 应用 SHALL 请求对应 Discourse 分类或排序接口
- AND 保留每个频道的滚动位置和分页状态

#### Scenario: 点击 Feed 卡片
- WHEN 用户点击帖子卡片
- THEN 应用 SHALL 进入原生话题详情页
- AND 不直接跳转整页 WebView

### Requirement: CoolApk 风格 Feed 卡片

系统 SHALL 用原生组件展示社区帖子。

#### Scenario: 展示普通话题
- GIVEN Discourse Topic 数据
- WHEN 渲染 Feed 卡片
- THEN 卡片 SHALL 展示作者头像、昵称、发布时间、分类、标签、标题、摘要、互动数据
- AND 若存在图片或封面 SHALL 展示图片区域

#### Scenario: 展示置顶/官方/精选
- GIVEN Topic 包含 `pinned`、官方分类或 `featured` 标签
- WHEN 渲染 Feed 卡片
- THEN 卡片 SHALL 显示清晰但克制的状态标记

### Requirement: 话题详情页

系统 SHALL 原生展示 Discourse 话题详情。

#### Scenario: 加载详情
- WHEN 用户进入详情页
- THEN 应用 SHALL 调用 `https://forum.trae.cn/t/{topic_id}.json`
- AND 将首楼内容作为正文展示
- AND 正文 SHALL 来自真实 Discourse Post `cooked` 内容
- AND 使用富文本组件渲染 HTML、链接、图片和代码块

#### Scenario: 杂志式图文排版
- GIVEN 首楼内容包含文字、图片、链接、引用或代码
- WHEN 渲染话题正文
- THEN 应用 SHALL 使用原生编辑化内容布局
- AND 将正文拆分为段落、标题、媒体、引用、代码、列表等内容块
- AND 图片 SHALL 根据上下文以首图、全宽图、横向图组、图注式图片或内嵌媒体块展示
- AND 段落和图片之间 SHALL 通过版式节奏组织阅读流
- AND 不得只使用“文字一段 + 图片一张 + 文字一段”的线性默认布局作为最终效果

#### Scenario: 图片主导内容
- GIVEN 话题正文包含多张图片
- WHEN 图片数量大于 1
- THEN 应用 SHALL 根据图片数量和比例选择合适布局
- AND 2 张图片 SHOULD 使用并排或上下错落布局
- AND 3 到 4 张图片 SHOULD 使用主次图网格
- AND 5 张以上图片 SHOULD 使用精选预览网格并支持进入图片预览
- AND 图片必须保留点击预览能力

#### Scenario: 长文阅读
- GIVEN 话题正文包含多个长段落
- WHEN 渲染正文
- THEN 应用 SHALL 使用标题、段落间距、首段强调、引用块或分隔节奏提升可读性
- AND 长段落 SHOULD 控制行高、宽度和留白
- AND 不得让正文在移动端形成密集的纯文本墙

#### Scenario: 回复列表
- WHEN 详情页正文加载完成
- THEN 应用 SHALL 展示回复流
- AND 回复数据 SHALL 来自真实 Discourse `post_stream.posts`
- AND 支持按时间、热门排序的 UI 入口
- AND 排序能力受 Discourse API 限制时 SHALL 明确在代码中以适配层兜底

### Requirement: 搜索与发现

系统 SHALL 提供社区内容发现能力。

#### Scenario: 搜索话题
- WHEN 用户输入关键词
- THEN 应用 SHALL 调用 `https://forum.trae.cn/search.json?q={query}`
- AND 展示话题结果、用户结果或可识别的结果类型
- AND 搜索结果 SHALL 来自真实 Discourse Search 响应
- AND 保存本地搜索历史

#### Scenario: 浏览分类与标签
- WHEN 用户进入发现页
- THEN 应用 SHALL 展示论坛分类、热门标签和热门话题
- AND 点击分类/标签进入对应列表页

### Requirement: 用户与我的

系统 SHALL 提供用户资料和本地个人空间。

#### Scenario: 查看用户主页
- WHEN 用户点击作者
- THEN 应用 SHALL 调用 `https://forum.trae.cn/u/{username}.json`
- AND 展示头像、用户名、简介、统计、近期帖子
- AND 用户主页主体信息 SHALL 来自真实 Discourse User 响应

#### Scenario: 未登录我的页面
- WHEN 用户未登录
- THEN 我的页面 SHALL 展示登录入口、本地收藏、浏览历史和设置
- AND 不阻塞只读浏览论坛内容

### Requirement: 登录与写操作

系统 SHALL 将认证能力作为独立阶段，不影响只读浏览 MVP。

#### Scenario: 只读 MVP
- WHEN 未实现登录
- THEN 首页、详情、搜索、用户资料 SHALL 正常浏览
- AND 发帖、回复、点赞、关注 SHALL 显示登录或暂未支持提示

#### Scenario: 后续接入登录
- WHEN Discourse 认证方案确认
- THEN 应用 SHALL 支持安全保存会话
- AND 写操作 SHALL 复用 Discourse 官方接口

### Requirement: WebView 边界

系统 SHALL 限制 WebView 的使用范围。

#### Scenario: 外部链接
- WHEN 用户点击正文中的外部链接
- THEN 应用 MAY 使用内置 WebView 或外部浏览器打开

#### Scenario: 暂未原生化页面
- WHEN 功能暂未原生实现
- THEN 应用 MAY 使用 WebView 兜底
- AND 页面入口 SHALL 标记为过渡方案

## 非功能需求

### 性能

- 首页首屏数据加载目标 < 2 秒，网络慢时必须有骨架屏或加载态。
- Feed 列表滑动目标 > 50fps。
- 图片列表使用缓存、尺寸约束和懒加载。
- 频道切换保留页面状态，避免重复刷新导致体验跳动。

### 可靠性

- 所有 API 层 SHALL 有网络错误、HTTP 错误、解析错误的用户可理解提示。
- 适配器 SHALL 对 null、缺字段、空数组和相对 URL 有兜底。
- 详情页 SHALL 支持内容为空、帖子被删除、话题关闭等状态。

### 视觉与交互

- 保持 Material 3 基础风格，同时吸收 CoolApk 的高信息密度社区体验。
- 卡片圆角、间距、字体应紧凑清晰，适合长期刷信息流。
- 不使用整页营销式首页；启动后直接进入可浏览社区内容。
- 深色/浅色主题均应可读。
- 话题详情页正文 SHOULD 具备杂志期刊式图文编排感，利用首图、图组、引用、分节、留白和层级提升阅读体验。
- 详情页图片排布 SHALL 在小屏设备上保持可读、无遮挡、无横向溢出。
- 详情页排版优化 SHALL 不改变原帖语义顺序，不遗漏正文内容。

## 实施阶段

### Phase 1: 只读社区 MVP

- 接通 Discourse 最新、热门、分类、详情、回复、搜索、用户接口。
- 首页、详情、搜索、用户主页原生可用，且主体内容全部来自真实 `forum.trae.cn` 数据。
- 发帖、回复、点赞、关注暂作为未登录/暂未支持入口。

### Phase 2: CoolApk 风格体验补齐

- 优化 Feed 卡片、评论楼层、快捷操作、图片预览、收藏和历史。
- 优化话题详情页正文为杂志期刊式图文排版，而不是简单线性富文本堆叠。
- 发现页加入分类、标签、热门话题。
- 我的页加入本地数据与设置。

### Phase 3: 登录与互动

- 明确 Discourse 认证方案。
- 支持通知、回复、点赞、发帖、关注等写操作。
- 完善风控、错误处理和会话过期处理。

### Phase 4: 发布质量

- 完成单元测试、Widget 测试、集成测试。
- 完成 Android APK 构建、图标、启动页、权限、隐私说明。
- 验证不同屏幕尺寸、深色模式、弱网场景。

## 验收标准

- APK 打开后默认进入原生 TRAE 社区首页。
- 首页可浏览真实 `forum.trae.cn` 话题列表。
- 分类/频道切换、刷新、加载更多可用。
- 点击话题进入原生详情页，正文和回复来自 Discourse API。
- 话题详情页正文具备杂志期刊式图文排布，图片、段落、引用、代码和图组均有原生版式处理。
- 搜索可返回真实论坛内容。
- 用户主页可展示真实 Discourse 用户资料。
- 首页、详情、搜索、用户主页任一页面仍使用 mock/静态数据/整页 WebView 承载主体内容时，验收 SHALL 失败。
- WebView 不作为主信息流或主详情页实现。
- `flutter analyze` 无阻塞错误。
- 核心适配器测试覆盖 Topic、Post、Category、User 的正常与边界映射。
