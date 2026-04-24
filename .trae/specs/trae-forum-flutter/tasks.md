# TRAE Community APK - 任务清单

## Phase 0: 规格与现状校准

### Task 0.1: 确认产品方向
**目标**: 将项目方向统一为“TRAE 论坛 + CoolApk 风格社区 APK”。
- [x] 明确主目标是原生社区 APK，而不是 WebView 套壳
- [x] 明确 CoolApk/c001apk 作为交互和功能参考
- [x] 明确数据源为 `https://forum.trae.cn`
- [x] 明确只读 MVP 优先，登录写操作后置

### Task 0.2: 更新规格文档
**目标**: 更新 `.trae/specs/trae-forum-flutter/` 下的 spec、tasks、checklist。
- [x] 更新产品规格
- [x] 更新实施任务
- [x] 更新验收清单

## Phase 1: Discourse 只读数据底座

### Task 1.1: Discourse 原始模型
**目标**: 用 Freezed/json_serializable 定义真实 API 响应模型。
- [ ] `lib/data/models/discourse/discourse_topic.dart`
- [ ] `lib/data/models/discourse/discourse_post.dart`
- [ ] `lib/data/models/discourse/discourse_category.dart`
- [ ] `lib/data/models/discourse/discourse_user.dart`
- [ ] `lib/data/models/discourse/discourse_search_result.dart`
- [ ] 运行 `build_runner` 并提交生成文件

### Task 1.2: Discourse API Service
**目标**: 封装论坛公开读取接口。
- [ ] `getLatestTopics({int page})` -> `GET /latest.json`
- [ ] `getTopTopics({String period, int page})` -> `GET /top.json`
- [ ] `getCategories()` -> `GET /categories.json`
- [ ] `getTopicsByCategory(int categoryId, {int page})` -> `GET /c/{category_id}.json`
- [ ] `getTopicDetail(int topicId)` -> `GET /t/{topic_id}.json`
- [ ] `getTopicPosts(int topicId, {int page})` -> `GET /t/{topic_id}/posts.json`
- [ ] `searchTopics(String query, {int page})` -> `GET /search.json`
- [ ] `getUserInfo(String username)` -> `GET /u/{username}.json`

### Task 1.3: 数据适配器
**目标**: 将 Discourse 数据映射到现有 Feed/Comment/User 模型。
- [x] `TopicAdapter.adaptTopicToFeed()`
- [x] `PostAdapter.adaptPostToReply()`
- [x] `CategoryAdapter.adaptCategory()`
- [x] `UserAdapter.adaptUser()`
- [x] 头像 URL 模板解析
- [x] ISO 8601 时间转换
- [x] HTML 内容保留给富文本渲染
- [x] null、空字段、相对 URL 兜底

### Task 1.4: 适配现有 ApiService / Repository
**目标**: 在不大改 UI 的前提下替换数据来源。
- [x] `ApiService.getHomeFeed()` 使用 `/latest.json`
- [x] `ApiService.getFeedContent()` 使用 `/t/{id}.json`
- [x] `ApiService.getFeedContentReply()` 使用帖子流
- [x] `ApiService.getSearch()` 使用 Discourse 搜索
- [x] `ApiService.getUserSpace()` 使用 Discourse 用户接口
- [x] `FeedRepository` 保持对 UI 层的现有契约
- [x] 错误处理返回用户可理解的信息

### Task 1.5: 真实数据验收 Gate
**目标**: 建立只读 MVP 的硬性通过标准。
- [x] 首页主体内容来自真实 `https://forum.trae.cn/latest.json` 或分类/热门接口
- [x] 详情页主体内容来自真实 `https://forum.trae.cn/t/{topic_id}.json`
- [x] 搜索页结果来自真实 `https://forum.trae.cn/search.json?q={query}`
- [x] 用户主页主体内容来自真实 `https://forum.trae.cn/u/{username}.json`
- [x] 核心页面不使用 mock、硬编码示例、静态 JSON 作为成功态数据
- [x] 核心页面不使用整页 WebView 承载主体内容
- [x] API 失败时展示错误态/空态/重试，不用假数据伪装成功

## Phase 2: CoolApk 风格首页与详情

### Task 2.1: 首页频道结构
**目标**: 建立社区 App 的主浏览体验。
- [ ] 首页 Tab：推荐、热门、官方、求助、建议、技巧、作品、交流、活动
- [ ] 每个频道独立分页状态
- [ ] 每个频道保留滚动位置
- [ ] 下拉刷新、上拉加载更多
- [ ] 骨架屏、空态、错误重试

### Task 2.2: Feed 卡片升级
**目标**: 让帖子以 CoolApk 风格动态卡片展示。
- [ ] 作者头像、昵称、时间
- [ ] 分类、标签、置顶/精选标记
- [ ] 标题、摘要、图片/封面
- [ ] 回复数、浏览数、点赞数
- [ ] 分享、收藏、本地更多菜单入口
- [ ] 点击作者进入用户主页
- [ ] 点击标签/分类进入列表页

### Task 2.3: 原生话题详情页
**目标**: 替换占位详情页，真实展示 Discourse 话题。
- [ ] 加载首楼正文
- [ ] 渲染 HTML、链接、图片、代码块
- [ ] 展示分类、标签、作者、发布时间
- [ ] 回复列表分页
- [ ] 楼层号、回复关系、点赞数
- [ ] 评论排序 UI 入口
- [ ] 底部回复栏未登录/暂未支持状态

### Task 2.4: 详情页杂志式图文排版
**目标**: 将帖子正文从简单富文本堆叠升级为编辑化阅读布局。
- [x] 将 Discourse `cooked` HTML 解析为 paragraph、heading、image、imageGroup、quote、code、list、link、table 等内容块
- [x] 实现首图/封面式媒体块
- [x] 实现单图全宽展示和图注式图片块
- [x] 实现 2 图并排或错落布局
- [x] 实现 3-4 图主次网格布局
- [x] 实现 5 图以上精选预览网格并可进入图片预览
- [x] 实现引用块、代码块、列表块、表格块的原生样式
- [x] 实现长文段落的标题层级、首段强调、行高和留白规则
- [ ] 保留原文语义顺序，不遗漏文字、图片、链接或代码
- [ ] 小屏设备无横向溢出、遮挡和文本压缩
- [ ] 深色/浅色主题下图文排版均可读
- [ ] 禁止以“文字一段 + 图片一张 + 文字一段”的默认线性布局作为最终详情页效果

## Phase 3: 发现、搜索、用户与我的

### Task 3.1: 发现页
**目标**: 聚合可浏览入口。
- [ ] 分类网格
- [ ] 热门标签
- [ ] 热门/精选话题
- [ ] SOLO / 活动专区入口
- [ ] 最近浏览入口

### Task 3.2: 搜索体验
**目标**: 做成社区搜索，而不是静态占位。
- [ ] 搜索历史本地持久化
- [ ] 热门搜索从配置或接口派生
- [ ] 搜索结果列表接真实接口
- [ ] 支持结果为空和错误重试
- [ ] 支持按类型筛选的 UI 预留

### Task 3.3: 用户主页
**目标**: 原生展示 Discourse 用户资料。
- [ ] 用户头像、用户名、简介
- [ ] 统计信息
- [ ] 用户近期话题/回复
- [ ] 关注/私信等登录能力入口置灰或提示

### Task 3.4: 我的页面与本地能力
**目标**: 未登录也有可用个人空间。
- [ ] 本地收藏
- [ ] 浏览历史
- [ ] 搜索历史管理
- [ ] 主题模式
- [ ] 字体大小
- [ ] 缓存清理
- [ ] 关于与版本信息

## Phase 4: 登录与互动

### Task 4.1: 认证方案调研
**目标**: 明确 Discourse 登录可行路径。
- [ ] 确认是否支持 API Key、User API Key、OAuth 或 SSO
- [ ] 确认可在 App 内合法使用的登录流程
- [ ] 确认 CSRF、Cookie、Session 保存方式
- [ ] 输出实现方案和风险

### Task 4.2: 写操作接入
**目标**: 在认证方案确认后实现互动。
- [ ] 发帖
- [ ] 回复
- [ ] 点赞/取消点赞
- [ ] 收藏/取消收藏
- [ ] 关注用户/话题
- [ ] 通知消息
- [ ] 会话过期处理

## Phase 5: 测试与发布

### Task 5.1: 单元测试
**目标**: 锁定数据映射和错误处理。
- [ ] Topic 适配器测试
- [ ] Post 适配器测试
- [ ] Category 适配器测试
- [ ] User 适配器测试
- [ ] API Service mock 测试

### Task 5.2: Widget / 集成测试
**目标**: 验证关键用户路径。
- [ ] 首页加载真实论坛列表
- [ ] 频道切换
- [ ] 话题详情加载真实正文和回复
- [ ] 搜索结果展示真实论坛结果
- [ ] 用户主页展示真实 Discourse 用户资料
- [ ] 错误态和空态

### Task 5.3: 发布准备
**目标**: 生成可安装 APK。
- [ ] `flutter analyze`
- [ ] `flutter test`
- [ ] Android 权限检查
- [ ] App 图标和启动页
- [ ] Release APK 构建
- [ ] 真机弱网和深色模式验证

## 里程碑

| 里程碑 | 完成定义 | 状态 |
|--------|----------|------|
| M0 规格更新 | spec/tasks/checklist 已更新 | ✅ 完成 |
| M1 真实只读数据打通 | 首页、详情、搜索、用户主页主体内容均来自真实 `forum.trae.cn` API | ⏳ 待完成 |
| M2 原生社区 MVP | 首页频道、Feed 卡片、详情回复可顺畅浏览 | ⏳ 待完成 |
| M3 CoolApk 风格体验 | 发现、我的、本地收藏、历史、设置补齐 | ⏳ 待完成 |
| M3.5 详情页阅读体验 | 帖子详情具备杂志式图文排版，不是简单线性富文本 | ⏳ 待完成 |
| M4 互动能力 | 登录、发帖、回复、点赞、通知可用 | ⏳ 待调研 |
| M5 APK 发布 | Release APK 构建并通过验收 | ⏳ 待完成 |
