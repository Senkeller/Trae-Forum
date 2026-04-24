# TRAE Forum Flutter 客户端功能还原规格说明（90%+ 目标）

## 1. 文档信息

| 字段 | 内容 |
|---|---|
| 文档版本 | v1.0 |
| 目标项目 | `/Users/jason/Documents/codex/TraeU/traeu` |
| 目标站点 | https://forum.trae.cn |
| 基线采样日期 | 2026-04-24 |
| 目标 | 还原原始论坛 90% 以上核心功能；补齐占位页；完成二级页面闭环 |
| 技术栈 | Flutter + Riverpod + GoRouter + Dio + WebView |

---

## 2. 目标与成功标准

### 2.1 总目标
将当前应用从“可读为主的论坛客户端”升级为“读写完整、消息完整、账号完整”的 Discourse 客户端，达到原站核心功能 90%+ 的可用覆盖。

### 2.2 量化验收指标（必须满足）

| 指标 | 当前估计 | 目标 |
|---|---:|---:|
| 功能覆盖率（加权） | ~45% | >=90% |
| 路由可用率（非占位） | 9/30 | >=27/30 |
| 核心写操作成功率（登录后） | <30% | >=95% |
| 核心页面 P95 首屏时间（Wi-Fi） | 未定义 | <=2.5s |
| 崩溃率 | 未定义 | <0.3% |
| 关键回归用例通过率 | 未定义 | 100% |

### 2.3 功能覆盖率加权公式

```text
覆盖率 = Σ(模块完成度 × 模块权重)

模块权重：
信息流/列表 15%
帖子详情/回复 15%
发帖/回复编辑删除 15%
搜索 8%
分类/标签导航 8%
消息通知 12%
私信/聊天 8%
用户主页与社交关系 8%
登录与会话管理 6%
设置与偏好 3%
```

---

## 3. 原站功能基线（采样事实）

基于 `site.json`、`categories.json`、`latest.json` 采样：

1. 顶部菜单含 `latest/unread/new/unseen/top/read/posted/bookmarks/hot/categories/votes`。
2. 时间筛选含 `all/yearly/quarterly/monthly/weekly/daily`。
3. 最新列表分页 `per_page=30`，支持 `more_topics_url`。
4. 主分类至少包含：官方公告、新手入门、官方活动、帮助与支持、产品建议、技巧分享、案例与作品、互动交流、福利活动、企业版专区、本周精选、社区伙伴、SOLO挑战赛专区。
5. 通知类型覆盖 mention/reply/quote/like/bookmark/chat/event/follow 等完整枚举（含 chat_*）。
6. 原站是 Discourse 体系，核心 API 为 `/latest.json`、`/t/{id}.json`、`/search.json`、`/notifications`、`/u/{username}/*`、`/posts`、`/post_actions`。

---

## 4. 当前项目现状（基于代码）

### 4.1 已有基础能力

1. 首页多 Tab 拉取最新/热门/分类数据已接通。
2. 帖子详情和回复列表已可读。
3. 搜索可调用 Discourse `/search.json`。
4. 用户主页数据（profile/summary/activity）有 Provider 链路。
5. 通知列表与“标记已读”已有实现。
6. WebView 登录与 Cookie 同步已有基础实现。

### 4.2 关键缺口

1. `GoRoute` 总 30 个，约 21 个仍是占位页面。
2. `ApiService` 中多项写接口 `Not implemented`（发帖、关注、点赞、收藏、消息等）。
3. 详情页底部输入仍是只读提示，未接真实发送链路。
4. 关注/取关逻辑调用旧 `/v6/*` 路径，与 Discourse 不一致。
5. 消息页详情跳转到占位 `TopicDetailPage`，未接真实帖子详情路由。
6. 测试样例与现有 UI/接口已发生明显漂移，存在失真测试。

---

## 5. 范围定义

### 5.1 In-Scope（必须实现）

1. 全量替换占位页为可用页面。
2. 打通 90% 核心读写功能。
3. 完成二级页面（分类详情、标签详情、消息子页、关注粉丝页、书签页、历史页、收藏页）。
4. 完成登录后会话一致性（WebView、Dio、Cookie、CSRF）。
5. 完成核心交互闭环（发帖、回帖、点赞、收藏、关注、已读）。
6. 完成端到端验收与回归测试体系。

### 5.2 Out-of-Scope（可延期）

1. 管理员后台能力（封禁、版务审查全功能）。
2. 非核心插件能力（投票插件高级配置、活动插件后台配置）。
3. 完整离线模式（仅保留有限缓存）。

---

## 6. 页面与路由规格（全量）

> 规则：以下每个页面必须有“空态、加载态、错误态、登录态、无权限态”。

### 6.1 主导航与一级页

| 路由 | 页面 | 目标状态 | 必要功能 |
|---|---|---|---|
| `/` | MainPage | 完成 | 底栏切换 + 状态保持 + 深链恢复 |
| `/home` | HomePage | 完成增强 | latest/hot/分类Tab、分页、下拉刷新、快捷评论入口 |
| `/search` | SearchPage | 完成增强 | 普通搜索+高级筛选入口+搜索历史 |
| `/messages` | MessagePage | 完成增强 | 通知分组、已读、跳转详情、分页 |
| `/user/:uid` | UserProfilePage | 完成增强 | 用户信息、活动、话题、关注操作 |

### 6.2 内容页

| 路由 | 页面 | 当前 | 目标规格 |
|---|---|---|---|
| `/feed/:id` | FeedDetailPage | 部分可用 | 首帖内容、回复流、排序、发送回复、点赞回复、引用回复 |
| `/feed/create` | FeedCreatePage | 占位 | 新建话题（标题+正文+分类+标签+预览+草稿） |
| `/feed/:id/reply` | FeedReplyPage | 占位 | 独立回复编辑器（支持引用楼层） |
| `/topic/:tag` | TopicDetailPage | 占位 | 标签/话题流详情页（按 tag 过滤列表） |
| `/topics` | TopicListPage | 占位 | 综合话题流（latest/top/hot/votes/posted/bookmarks） |
| `/product/:id` | ProductDetailPage | 占位 | 若无业务必要可映射为专题页或下线 |

### 6.3 用户与社交页

| 路由 | 页面 | 当前 | 目标规格 |
|---|---|---|---|
| `/user/edit` | UserEditPage | 占位 | 编辑昵称/头像/简介/偏好（受 Discourse 权限约束） |
| `/user/:uid/follows` | FollowListPage | 占位 | 关注列表、取消关注、跳转用户主页 |
| `/user/:uid/fans` | FanListPage | 占位 | 粉丝列表、回关、跳转用户主页 |

### 6.4 消息与通知二级页

| 路由 | 页面 | 当前 | 目标规格 |
|---|---|---|---|
| `/notifications` | NotificationsPage | 占位 | 独立通知页（与消息页共享状态） |
| `/messages/:type` | MessageDetailPage | 占位 | 按类型查看通知子流 |
| `/settings/notifications` | NotificationSettingsPage | 缺路由 | 新增页面：通知偏好开关（本地+服务端可同步项） |

### 6.5 设置与辅助页

| 路由 | 页面 | 当前 | 目标规格 |
|---|---|---|---|
| `/settings` | SettingsPage | 部分可用 | 真实可保存项+缓存清理+退出登录 |
| `/settings/theme` | ThemeSettingsPage | 占位 | 主题模式、色彩方案 |
| `/settings/font` | FontSettingsPage | 占位 | 字体比例、内容密度 |
| `/settings/blacklist` | BlacklistPage | 占位 | 本地屏蔽词/用户过滤 |
| `/settings/about` | AboutPage | 占位 | 版本、协议、隐私、开源许可 |
| `/history` | HistoryPage | 占位 | 浏览历史（本地存储） |
| `/favorites` | FavoritesPage | 占位 | 收藏列表（服务端书签优先） |
| `/image-preview` | ImagePreviewPage | 占位 | 手势缩放、左右滑动、保存分享 |
| `/register` | RegisterPage | 占位 | 统一跳转 SSO 注册页 |
| `/forgot-password` | ForgotPasswordPage | 占位 | 统一跳转 SSO 找回页 |

---

## 7. 功能模块详细规格

## 7.1 首页/列表模块

### 功能要求
1. 支持 `latest/hot/top/categories/votes/bookmarks/posted` 列表源。
2. 列表项展示：标题、摘要、作者、时间、分类、标签、回复数、浏览数、点赞数。
3. 支持置顶、已读状态、草稿状态标识。
4. 支持下拉刷新与无缝分页。

### 接口建议
1. `GET /latest.json?page={n}`
2. `GET /hot.json?page={n}`
3. `GET /top.json?period={period}&page={n}`
4. `GET /c/{categoryId}.json?page={n}`
5. `GET /tags/{tag}.json?page={n}`（如启用）

### 验收标准
1. 连续翻页 5 页无重复、无崩溃。
2. tab 切换后保留滚动位置。
3. 首屏渲染失败时可重试成功。

## 7.2 帖子详情与回复模块

### 功能要求
1. 首帖完整渲染（HTML cooked 内容、图片、链接、代码块）。
2. 回复流分页、排序（最新/最早/热门按可实现策略）。
3. 楼中楼回复（`reply_to_post_number`）。
4. 回复发送、编辑、删除（权限允许时）。
5. 点赞/取消点赞帖子与回复。

### 接口建议
1. `GET /t/{topicId}.json`
2. `GET /t/{topicId}/posts.json?page={n}`
3. `POST /posts`（发回复）
4. `PUT /posts/{postId}`（编辑）
5. `DELETE /posts/{postId}`（删除，按权限）
6. `POST /post_actions`（点赞）
7. `DELETE /post_actions/{postId}?post_action_type_id=2`（取消点赞）

### 验收标准
1. 详情页回复发送后 2 秒内可见（乐观更新 + 实际回写）。
2. 回复失败可重试，错误信息可见。
3. 富文本/图片/代码渲染与原站视觉语义一致度 >=90%。

## 7.3 发帖模块

### 功能要求
1. 新建话题：标题、正文、分类、标签、草稿。
2. 预览模式（markdown -> cooked 对照）。
3. 话题发布成功后跳转详情页。

### 接口建议
1. `POST /posts` with `title/raw/category/tags[]`
2. `GET /drafts/*.json`（可选）

### 验收标准
1. 支持发布文本、图片、链接。
2. 草稿自动保存与恢复。

## 7.4 搜索模块

### 功能要求
1. 关键词搜索。
2. 高级搜索：分类、标签、时间范围、排序。
3. 搜索建议联想（输入建议）。
4. 搜索历史管理。

### 接口建议
1. `GET /search.json?q={query}`
2. `GET /search/query?term={prefix}`

### 验收标准
1. 同关键词结果与网页端数量级一致。
2. 高级筛选生效（可通过 query string 验证）。

## 7.5 分类/标签模块

### 功能要求
1. 分类列表页展示主分类 + 子分类。
2. 分类详情页支持话题流与置顶展示。
3. 标签页展示热门标签与标签话题流。

### 接口建议
1. `GET /categories.json`
2. `GET /c/{id}.json`
3. `GET /tags.json`
4. `GET /tag/{tag}.json` 或 `GET /tags/{tag}.json`（按站点实际）

### 验收标准
1. 分类数量、名称、层级与原站一致。
2. 子分类跳转正确，支持分页。

## 7.6 消息通知模块

### 功能要求
1. 按类型筛选通知（reply/like/mention/chat/bookmark/event/follow）。
2. 标记单条已读、全部已读。
3. 点击通知跳转到具体帖子/消息上下文。
4. 未读角标实时更新。

### 接口建议
1. `GET /notifications`
2. `PUT /notifications/mark-read`

### 验收标准
1. 已读状态在刷新后保持一致。
2. 通知点击目标路由正确（不再落到占位页）。

## 7.7 私信与聊天模块

### 功能要求
1. 私信列表、私信详情阅读。
2. 私信话题发送回复。
3. 聊天频道列表、频道消息列表。
4. Chat mention 与通知联动。

### 接口建议
1. `GET /topics/private-messages/{username}.json`
2. `GET /u/{username}/user-menu-private-messages`
3. `GET /chat/api/me/channels`
4. `GET /chat/api/channels`

### 验收标准
1. 登录后可读取私信列表与至少一个会话详情。
2. 聊天列表可加载并稳定分页。

## 7.8 用户中心与社交关系

### 功能要求
1. 用户主页：资料、统计、话题、回复、获赞、投票。
2. 关注/取关（使用 Discourse 兼容接口，不允许旧 `/v6/*` 假实现）。
3. 粉丝/关注列表页完成。

### 接口建议
1. `GET /u/{username}.json`
2. `GET /u/{username}/summary.json`
3. `GET /u/{username}/activity/*.json`
4. 关注接口需基于站点可用能力确认（若站点插件支持 following 系列）。

### 验收标准
1. 用户活动分类切换无报错。
2. 关注操作状态在刷新后一致。

## 7.9 登录与会话模块

### 功能要求
1. 保留 WebView SSO 登录主链路。
2. 会话统一：WebView Cookie -> Dio CookieJar -> API 可鉴权。
3. CSRF token 自动注入写请求。
4. 启动恢复登录态，过期自动回收。

### 验收标准
1. 登录后立即可发回复/点赞/标记已读。
2. 应用重启后保持会话可用。
3. 会话过期后有明确提示并引导重登。

## 7.10 设置与偏好

### 功能要求
1. 主题、字体、图片质量、通知开关落地到本地持久化。
2. 清理缓存真实可执行。
3. 退出登录清空会话与本地用户信息。

### 验收标准
1. 配置重启后生效。
2. 退出后写接口全部返回未登录并有提示。

---

## 8. API 与网络规范

### 8.1 通用请求规范

1. 统一 `DioClient` 管理请求。
2. 写请求统一注入：`X-Requested-With`、`Discourse-Logged-In`、`Discourse-Present`、`X-CSRF-Token`。
3. 统一错误模型：网络错误、鉴权错误、业务错误、限流错误。
4. 对 429 实现退避重试策略。

### 8.2 必须移除/替换项

1. 移除或废弃所有 `/v6/*` 旧路径调用。
2. 移除 `ApiService` 中返回 `Not implemented` 的伪实现。
3. 移除占位响应 `status:404` 的假成功逻辑。

### 8.3 分页规范

1. 列表默认页大小 30（对齐站点）。
2. 使用 `more_topics_url` 或页码推进。
3. 客户端去重键：`topic.id` 或 `post.id`。

---

## 9. 数据模型与适配规范

### 9.1 统一模型层级

1. `Remote DTO`（Discourse 原始字段）。
2. `Domain Model`（业务统一字段）。
3. `View Model`（页面展示字段）。

### 9.2 强制字段映射

| 领域字段 | Discourse 字段 |
|---|---|
| topicId | `topic.id` |
| title | `topic.title` |
| excerpt | `topic.excerpt` |
| author | `users + posters` 关联 |
| avatar | `avatar_template -> size 替换` |
| replyCount | `reply_count` |
| likeCount | `like_count` 或 `actions_summary` |
| isPinned | `pinned` |
| tags | `tags[]` |

### 9.3 兼容要求

1. 对空字段、缺字段、插件字段容错。
2. 严禁 UI 直接依赖 DTO。

---

## 10. 状态管理规范（Riverpod）

1. Provider 粒度按页面域拆分：home/topic/search/notification/user/session/settings。
2. 每个状态模型必须包含：`isLoading/isRefreshing/isLoadingMore/error/hasMore`。
3. 写操作采用“乐观更新 + 回滚”机制。
4. 跨页面共享状态通过 `StateNotifier` 或 `AsyncNotifier`，禁止 Widget 内部重复请求。

---

## 11. 占位页补完清单（强制）

以下页面必须从占位升级为真实页面：

1. FeedCreatePage
2. FeedReplyPage
3. UserEditPage
4. FollowListPage
5. FanListPage
6. TopicListPage
7. TopicDetailPage
8. ProductDetailPage（可改为专题页）
9. SearchResultPage
10. MessageDetailPage
11. NotificationsPage
12. ThemeSettingsPage
13. FontSettingsPage
14. BlacklistPage
15. AboutPage
16. RegisterPage
17. ForgotPasswordPage
18. HistoryPage
19. FavoritesPage
20. ImagePreviewPage
21. ErrorPage（增强为统一错误中心页）

---

## 12. 非功能要求

### 12.1 性能

1. 首页首屏 P95 <=2.5s。
2. 列表滚动 60fps 稳定。
3. 图片加载失败率 <2%。

### 12.2 稳定性

1. 空指针和解析异常必须被兜底。
2. 所有网络请求可取消，页面销毁不回调 setState。

### 12.3 可观察性

1. 接入结构化日志：请求ID、接口、耗时、状态码。
2. 关键操作埋点：登录、发帖、回帖、点赞、关注、已读。

### 12.4 安全

1. 禁止明文持久化敏感 token。
2. Cookie 仅通过 CookieJar 管理。
3. 清理日志中隐私字段。

---

## 13. 测试规格

### 13.1 测试分层

1. 单元测试：Adapter/Repository/Provider。
2. Widget 测试：首页、详情、搜索、消息、用户页。
3. 集成测试：登录 -> 浏览 -> 回复 -> 点赞 -> 通知已读。
4. 回归测试：占位页全部替换后路由冒烟。

### 13.2 必测用例清单（核心）

1. 未登录进入写操作，正确拦截并引导登录。
2. 登录后发回复成功，详情页即时可见。
3. 点赞后计数变化，刷新后保持一致。
4. 通知标记已读后未读数更新。
5. 分类/标签分页去重正确。
6. 网络失败/超时/429 有稳定提示。
7. 应用重启后会话恢复。
8. 退出登录后会话失效。

### 13.3 质量门禁

1. 单元+Widget 测试总通过率 100%。
2. 核心链路集成测试全部通过。
3. `flutter analyze` 无 error。

---

## 14. 研发里程碑与交付计划

## 里程碑 M1（基础修复，1-1.5 周）

1. 清理 `Not implemented` 假实现。
2. 修复错误路由跳转与消息详情跳转。
3. 登录会话和 CSRF 链路打通。
4. 统一网络错误模型。

**验收**：登录后点赞、回复、已读三条链路可用。

## 里程碑 M2（核心读写闭环，1.5-2 周）

1. 完成发帖页、回复页、详情写操作。
2. 完成分类/标签/话题列表页。
3. 完成关注粉丝列表页。

**验收**：信息流、详情、发帖、回帖、关注闭环。

## 里程碑 M3（二级页与消息体系，1.5 周）

1. 完成消息详情页、通知独立页。
2. 完成私信与聊天最小可用版本。
3. 完成设置子页与收藏/历史页。

**验收**：主要二级页面无占位。

## 里程碑 M4（收敛与发布，1 周）

1. 性能优化与稳定性收敛。
2. 全量测试、回归、文档整理。
3. 对照原站完成 90% 覆盖评分。

**验收**：覆盖率 >=90%，质量门禁全部通过。

---

## 15. 执行任务拆分（可直接给其他 AI）

### 15.1 工作流顺序

1. `API层修复` -> 2. `Provider层改造` -> 3. `页面落地` -> 4. `路由补齐` -> 5. `测试补齐` -> 6. `性能收敛`

### 15.2 子任务包

| 包ID | 名称 | 负责人建议 | 输入 | 输出 |
|---|---|---|---|---|
| P1 | Discourse写接口打通 | 后端/网络AI | `discourse_api_service.dart` | 发帖/回复/点赞/已读可用 |
| P2 | 会话与CSRF统一 | 基础设施AI | `dio_client.dart`, interceptors | 登录后写接口稳定 |
| P3 | 占位页替换I | UI AI | 路由+页面骨架 | 10个页面可用 |
| P4 | 占位页替换II | UI AI | 路由+页面骨架 | 剩余11个页面可用 |
| P5 | 消息与通知闭环 | 业务AI | message/notification providers | 通知与详情跳转闭环 |
| P6 | 用户社交闭环 | 业务AI | user providers/pages | 关注粉丝与活动闭环 |
| P7 | 测试与回归 | QA AI | test目录 | 覆盖并通过质量门禁 |

---

## 16. Definition of Done（最终交付定义）

同时满足以下条件才算完成：

1. 功能覆盖评分 >=90%。
2. 占位页清零，或剩余 <=3 个且有书面延期理由。
3. 关键写操作可用：发帖、回帖、点赞、已读、关注。
4. 核心链路自动化测试全绿。
5. 用户可在登录状态下完整完成“浏览 -> 互动 -> 消息回流”。
6. 提交发布说明，包含：已完成功能、未完成项、风险、回滚策略。

---

## 17. 附录A：当前代码重点整改位

1. `lib/core/network/api_service.dart`：去除 `Not implemented` 与旧 `/v6` 假实现。
2. `lib/config/routes.dart`：补齐占位路由真实页面，修复消息跳转目标。
3. `lib/presentation/pages/feed/feed_detail_page.dart`：底部输入改为真实发送。
4. `lib/presentation/providers/user_provider.dart`：`toggleFollow()` 改为 Discourse 兼容实现。
5. `lib/presentation/pages/message/message_page.dart`：通知点击进入真实详情页。
6. `test/*`：修复与当前 UI/接口不一致的失真测试。

---

## 18. 附录B：推荐开发约束

1. 不新增重依赖，优先复用现有 Riverpod + Dio 架构。
2. 每个 PR 限制在单模块，保持可回滚。
3. 每个 PR 必带对应测试。
4. 禁止再引入“伪成功返回”占位接口。

---

## 19. 附录C：原站功能对照总表（开发主索引）

> 用途：作为“任务分发主表”，每个 AI 任务必须引用对应 `FUNC-ID`。

| FUNC-ID | 原站功能 | 客户端目标页面 | 核心接口 | 当前状态 | 完成定义（DoF） | 权重 |
|---|---|---|---|---|---|---:|
| F001 | 最新话题流 | `/home` 推荐Tab | `GET /latest.json` | 部分完成 | 列表、分页、刷新、去重、错误重试可用 | 4 |
| F002 | 热门话题流 | `/home` 热门Tab | `GET /hot.json` | 部分完成 | `hot` 异常时自动回退 `top` | 2 |
| F003 | 分类话题流 | `/home` 分类Tab | `GET /c/{id}.json` | 部分完成 | 主分类与子分类可切换、分页正常 | 4 |
| F004 | 话题详情 | `/feed/:id` | `GET /t/{id}.json` | 部分完成 | 首帖渲染、外链跳转、图片预览完整 | 4 |
| F005 | 回复流 | `/feed/:id` | `GET /t/{id}/posts.json` | 部分完成 | 分页加载、排序、去重、错误重试 | 4 |
| F006 | 发回复 | `/feed/:id` | `POST /posts` | 部分完成 | 登录后回复成功并即时回显 | 5 |
| F007 | 发话题 | `/feed/create` | `POST /posts` | 未完成 | 标题/正文/分类/标签发布成功 | 5 |
| F008 | 点赞/取消点赞 | 详情与列表 | `POST/DELETE /post_actions` | 部分完成 | 点赞状态、计数、刷新后一致 | 4 |
| F009 | 搜索 | `/search` | `GET /search.json` | 部分完成 | 关键词、分页、历史、空态完整 | 3 |
| F010 | 搜索联想 | `/search` | `GET /search/query` | 未完成 | 输入联想响应 <300ms（P95） | 1 |
| F011 | 分类总览 | `/topics`,`/categories` | `GET /categories.json` | 未完成 | 分类树与原站一致，支持跳转 | 3 |
| F012 | 标签总览/详情 | `/topics`,`/topic/:tag` | `GET /tags*.json` | 未完成 | 标签列表、标签详情流可用 | 2 |
| F013 | 通知列表 | `/messages`,`/notifications` | `GET /notifications` | 部分完成 | 筛选、分页、未读数准确 | 4 |
| F014 | 标记已读 | `/messages` | `PUT /notifications/mark-read` | 部分完成 | 单条/全部已读状态持久 | 3 |
| F015 | 私信列表 | `/messages/:type` | `GET /topics/private-messages/{u}.json` | 未完成 | 列表展示与跳转详情 | 3 |
| F016 | 聊天频道 | `/messages/:type` | `GET /chat/api/*` | 未完成 | 频道列表加载、权限提示正确 | 2 |
| F017 | 用户主页 | `/user/:uid` | `GET /u/{username}.json` | 部分完成 | 资料、统计、活动分栏完整 | 4 |
| F018 | 用户总结 | `/user/:uid` | `GET /u/{username}/summary.json` | 部分完成 | 总结数据渲染稳定 | 2 |
| F019 | 用户活动 | `/user/:uid` | `GET /u/{username}/activity*.json` | 部分完成 | 多分类活动切换、分页可用 | 3 |
| F020 | 关注/粉丝列表 | `/user/:uid/follows`,`/fans` | 站点能力探测后定 | 未完成 | 列表可读，关注状态一致 | 3 |
| F021 | 统一登录 | `/login` | WebView SSO + Cookie | 部分完成 | 登录后写接口全部可用 | 5 |
| F022 | 会话恢复/登出 | 全局 | CookieJar + 本地状态 | 部分完成 | 重启恢复、登出彻底失效 | 3 |
| F023 | 设置中心 | `/settings/*` | 本地存储 + 可同步项 | 部分完成 | 主题/字体/通知可持久 | 2 |
| F024 | 收藏/历史 | `/favorites`,`/history` | 书签接口+本地历史 | 未完成 | 可查看、跳转、清空 | 2 |

---

## 20. 附录D：站点能力探测与降级规范

### 20.1 探测目标

在站点插件或配置变化时，自动判断能力可用性，避免客户端硬编码导致功能失效。

### 20.2 探测时机

1. App 启动冷启动完成后。
2. 登录成功后立即触发。
3. 每 24 小时后台刷新一次。
4. 手动“诊断模式”入口可强制刷新。

### 20.3 探测项

| 能力键 | 探测方法 | 成功条件 | 失败降级 |
|---|---|---|---|
| `cap_chat` | `GET /chat/api/me/channels` | 200 且结构可解析 | 隐藏聊天入口，保留说明 |
| `cap_private_message` | `GET /topics/private-messages/{u}.json` | 200 | 隐藏私信入口 |
| `cap_votes` | 读取 `site.json.filters` 是否含 `votes` | true | 隐藏投票Tab |
| `cap_following` | `site.json.notification_types` 含 `following*` + 试探接口 | 可读/可写 | 隐藏关注写操作，仅展示用户信息 |
| `cap_bookmarks` | 通知类型含 `bookmark_reminder` + 书签菜单可读 | true | 收藏页切换本地收藏 |
| `cap_tags` | `site.json` 标签开关与 `top_tags` | true | 隐藏标签页 |
| `cap_solved` | 用户活动接口含 solved 路径可用 | 200 | 隐藏 solved 分类 |

### 20.4 能力存储

1. 本地键：`capabilities_v1`。
2. 字段：`version`, `fetchedAt`, `caps`, `sourceHashes`。
3. 失效策略：TTL 24h，登录态变化时强制失效。

### 20.5 UI 降级规则

1. 不可用能力必须“显式隐藏”或“禁用+原因提示”，禁止点进去才报错。
2. 降级文案统一：`当前社区未开启该功能`。

---

## 21. 附录E：登录、Cookie、CSRF 详细协议

### 21.1 登录流程（标准）

1. 打开 SSO WebView 登录页（`www.trae.cn`）。
2. 观察回跳 `forum.trae.cn/session/sso_login` 或论坛首页。
3. 读取 WebView `document.cookie`。
4. 写入 `DioClient.cookieJar`（域名维度：`forum.trae.cn`）。
5. 拉取一次鉴权写接口预检（如 `POST /posts` dry-run 不提交）。
6. 成功后刷新用户态 Provider。

### 21.2 Cookie 管理

1. 持久化 `PersistCookieJar` 必须开启。
2. Cookie 白名单：`_t`, `_forum_session`, 论坛必要 session cookie。
3. 禁止手工拼接 `Cookie` Header，统一走 CookieManager。

### 21.3 CSRF 管理

1. 优先从页面 `meta[name=csrf-token]` 提取。
2. 备选从可用接口响应头/站点初始化数据提取。
3. 写请求拦截器在 Header 注入：`X-CSRF-Token`。
4. 遇到 403 + CSRF 关键词时自动触发一次 token 刷新重试（仅 1 次）。

### 21.4 会话失效判定

判定条件任一满足即失效：

1. 写接口返回 401。
2. 连续两次 403 且提示鉴权/CSRF 失效。
3. CookieJar 无核心 session cookie。

处理动作：

1. 标记全局 `authState=expired`。
2. 弹出统一重登提示。
3. 写操作排队失败并可重试。

---

## 22. 附录F：错误码、重试与用户提示矩阵

| 场景 | 识别条件 | 重试策略 | 用户提示 | 监控级别 |
|---|---|---|---|---|
| 未登录 | 401 | 不重试 | 请先登录 | Warn |
| 权限不足 | 403（非CSRF） | 不重试 | 无权限执行该操作 | Warn |
| CSRF失效 | 403 + CSRF关键词 | 刷新token后重试1次 | 会话验证中… | Warn |
| 资源不存在 | 404 | 不重试 | 内容不存在或已删除 | Info |
| 参数错误 | 422 | 不重试 | 输入内容不合法 | Info |
| 冲突 | 409 | 可重试1次 | 内容已更新，请刷新后重试 | Warn |
| 限流 | 429 | 指数退避：1s/2s/4s，最多3次 | 操作过于频繁，请稍后再试 | Warn |
| 服务错误 | 5xx | 指数退避：1s/2s，最多2次 | 服务繁忙，请稍后重试 | Error |
| 网络超时 | Dio timeout | 快速重试1次 | 网络超时，请重试 | Warn |
| 解析失败 | JSON映射异常 | 不重试 | 数据格式异常 | Error |

统一要求：

1. 同一错误 10 秒内仅弹一次 toast/snackbar（去抖）。
2. 关键错误必须记录结构化日志：`route`, `api`, `status`, `requestId`, `traceId`（若存在）。

---

## 23. 附录G：数据存储版本与迁移策略

### 23.1 存储分层

1. `session_store`：登录态、用户基础信息。
2. `settings_store`：主题、字体、通知偏好。
3. `cache_store`：列表缓存、详情缓存、搜索历史。
4. `cap_store`：能力探测结果。

### 23.2 版本策略

| 存储域 | 当前版本 | 升级策略 | 回滚策略 |
|---|---:|---|---|
| session | 1 | 兼容新增字段 | 不兼容则清空会话并提示重登 |
| settings | 1 | 新增字段默认值注入 | 保留旧字段并忽略未知字段 |
| cache | 1 | 结构变更直接失效重建 | 可直接清空缓存 |
| capabilities | 1 | TTL+版本双重失效 | 清空后重新探测 |

### 23.3 迁移原则

1. 任意 schema 变更必须增加 `schemaVersion`。
2. 迁移函数必须幂等。
3. 失败时不崩溃，降级为清空并重建。

---

## 24. 附录H：页面级性能预算与观测字段

### 24.1 性能预算

| 页面 | 指标 | 预算 |
|---|---|---:|
| 首页列表 | 首屏可交互 TTI(P95) | <=2.5s |
| 详情页 | 首帖渲染完成(P95) | <=2.0s |
| 搜索页 | 首次结果返回(P95) | <=2.5s |
| 消息页 | 通知首屏(P95) | <=2.0s |
| 用户页 | 资料+首批活动(P95) | <=2.2s |
| 分页加载 | 下一页可见耗时(P95) | <=1.5s |
| 图片加载 | 首图加载成功率 | >=98% |

### 24.2 必须埋点（事件）

1. `page_open`：`page`, `source`, `ts`。
2. `api_request`：`api`, `method`, `status`, `durationMs`。
3. `api_retry`：`api`, `retryCount`, `reason`。
4. `action_post_create` / `action_post_reply` / `action_like` / `action_mark_read`。
5. `auth_login_success` / `auth_login_failed` / `auth_expired`。

---

## 25. 附录I：无障碍与多端适配规范

### 25.1 无障碍（A11y）

1. 点击区域最小 `44x44`。
2. 所有图标按钮提供语义标签（`Semantics`）。
3. 文本最小字号不低于 12sp，支持字体缩放。
4. 对比度满足 WCAG AA（普通文本 >=4.5:1）。
5. 动效可被系统“减少动态效果”设置关闭。

### 25.2 多端适配

1. 窄屏（<360dp）降级布局避免溢出。
2. 平板（>=600dp）使用双栏或更大边距布局。
3. 横屏保持信息密度可读，不遮挡输入框。
4. WebView 页面支持安全区与键盘弹出适配。

---

## 26. 附录J：测试夹具与契约测试规范

### 26.1 固定夹具（Fixtures）

在 `test/fixtures/discourse/` 增加：

1. `site.json`
2. `categories.json`
3. `latest_page_0.json`
4. `topic_detail_{id}.json`
5. `topic_posts_{id}_page_{n}.json`
6. `search_{query}.json`
7. `notifications_page_0.json`
8. `user_{username}.json`
9. `user_summary_{username}.json`
10. `user_activity_{username}_{type}.json`

### 26.2 契约测试（Contract Test）

1. 校验关键字段存在：`id/title/slug/category_id/post_stream/posts` 等。
2. 允许新增字段，禁止关键字段类型漂移。
3. 对响应缺字段做降级断言（非崩溃）。

### 26.3 回归触发条件

以下变更必须触发全量集成回归：

1. `discourse_api_service.dart` 变更。
2. `api_service.dart` 变更。
3. `auth`/`cookie`/`interceptor` 变更。

---

## 27. 附录K：发布、灰度与回滚预案

### 27.1 Feature Flag

新增配置开关：

1. `ff_post_create`
2. `ff_post_reply`
3. `ff_like_action`
4. `ff_private_message`
5. `ff_chat`
6. `ff_following`

默认策略：

1. 高风险能力（chat/following）先灰度关闭。
2. 核心能力（浏览/详情/搜索）默认开启。

### 27.2 发布分阶段

1. 内测：10% 用户，观察 48h。
2. 小流量：30% 用户，观察 48h。
3. 全量：100% 用户。

### 27.3 回滚触发阈值

任一满足立即回滚：

1. 崩溃率 >0.5%（持续 30 分钟）。
2. 核心写操作失败率 >10%（持续 30 分钟）。
3. 登录成功率下降 >15%（同比上版本）。

### 27.4 回滚动作

1. 关闭相关 `ff_*`。
2. 下发热修复配置（若支持）。
3. 回退至前一稳定包体。
4. 发布事故复盘文档（24h 内）。

---

## 28. 附录L：多 AI 并行执行协议（可直接复制）

### 28.1 任务模板（给单个 AI）

```text
任务ID: <P1/P2/...>
目标模块: <文件路径或页面域>
引用规格: SPECS_FORUM_RESTORE_90.md 中 FUNC-ID: <Fxxx...>
输入: <当前代码路径 + 依赖关系>
输出:
1) 变更文件清单
2) 代码实现
3) 测试用例
4) 风险与回滚点
约束:
1) 不得引入 Not implemented 假实现
2) 不得破坏现有登录链路
3) 必须通过 flutter analyze 与对应测试
```

### 28.2 分支与提交规范

1. 分支：`feature/FUNC-<ID>-<short-name>`。
2. 提交：`feat(FUNC-<ID>): <summary>`。
3. 每个 PR 只含一个功能域，禁止超范围改动。

### 28.3 PR 检查清单

1. 关联 `FUNC-ID` 是否完整。
2. UI 态：加载/空态/错误态/无权限态是否齐全。
3. 网络异常与重试是否符合“错误矩阵”。
4. 自动化测试是否覆盖新增逻辑。
5. 是否新增了任何临时占位逻辑（禁止）。

### 28.4 禁止项

1. 不允许新增旧 `/v6/*` 路径依赖。
2. 不允许写死 Cookie/Token。
3. 不允许吞掉异常不记录日志。
4. 不允许用“Mock 成功”代替真实链路。

### 28.5 统一交付格式

每个 AI 交付必须包含：

1. 变更摘要（不超过 10 行）。
2. 变更文件列表。
3. 已通过测试列表。
4. 未完成事项与阻塞项。
5. 风险等级（低/中/高）与回滚建议。
