# 我的页面常用功能 + 消息通知完善与优化 规格文档

## 背景与问题

当前项目在"我的页面"和"消息通知"链路中存在以下可用性问题：

1. 我的页通知入口红点为静态展示，未真实绑定未读状态。
2. 我的页"消息通知"分组入口为占位行为（仅提示"开发中"），未可用。
3. 常用功能里的"我的赞 / 我的回复"指向未落地路由，存在跳转失败风险。
4. 消息页 Tab 在滑动切换时未稳定触发筛选切换，存在状态不一致风险。
5. 通知分页未显式带 offset，可能导致重复数据请求与分页体验不稳定。

## 目标

1. 提升"我的页面"入口可用性与可感知性（未读角标、真实跳转）。
2. 打通"消息通知"分组入口到消息筛选页（按类型直达）。
3. 修复常用功能关键入口路由，确保"我的赞 / 我的回复"可达。
4. 优化通知列表分页行为，降低重复加载概率。

## What Changes

### 我的页面优化

- `ProfilePageNew` 顶部消息图标显示真实未读角标（仅登录且未读 > 0 时显示）。
- 首次进入登录态"我的"页时自动触发通知拉取，避免未读统计长期为 0。
- "消息通知"卡片改为真实跳转：
  - `@我的动态` -> `/messages?filter=replies`
  - `@我的评论` -> `/messages?filter=replies`
  - `我收到的赞` -> `/messages?filter=likes`
  - `好友关注` -> `/messages?filter=others`
- 分组未读数由当前通知列表计算并展示。

### 常用功能完善

- "我的赞"改为跳转 `current_user` 资料页活动 Tab + `likes` 分类。
- "我的回复"改为跳转 `current_user` 资料页活动 Tab + `replies` 分类。
- 路由层支持将 query 参数透传到 `UserProfilePage`，用于设置初始 tab/category。
- `UserProfilePage` 支持初始状态注入：
  - `tab=activity`
  - `category=likes/replies/...`

### 消息通知优化

- 消息页支持 query 初始化筛选（`filter` 参数）。
- 增加 TabController 监听，修复"滑动切换 Tab 不触发筛选切换"的问题。
- 通知筛选匹配逻辑统一复用模型层扩展，减少重复判断逻辑。
- "消息设置"入口统一改为 `RoutePaths.notificationSettings`，避免硬编码路径偏差。

### 通知分页优化

- `DiscourseApiService.getNotifications` 增加 `offset` 参数支持。
- `NotificationNotifier.loadMoreNotifications` 按当前列表长度传递 offset。
- `hasMore` 判定基于服务端返回条数（与 page size 对齐）而非去重后数量。
- 加载更多后同步更新未读计数，保证 UI 统计一致。

## Impact

### 受影响规格
- 现有用户资料页规格（需支持 query 参数初始化）
- 消息通知页规格（需支持 filter 参数）

### 受影响代码
- `lib/presentation/pages/user/profile_page_new.dart` - 我的页面优化
- `lib/presentation/pages/user/user_profile_page.dart` - 支持 query 参数
- `lib/presentation/pages/message/messages_page.dart` - 消息页优化
- `lib/core/network/discourse_api_service.dart` - 通知接口增加 offset
- `lib/presentation/providers/notification_provider.dart` - 分页逻辑优化
- `lib/config/routes.dart` - 路由 query 参数支持

## ADDED Requirements

### Requirement: 我的页真实未读角标
系统 SHALL 在"我的"页面顶部消息图标显示真实未读通知数角标。

#### Scenario: 登录用户有未读通知
- **GIVEN** 用户已登录且有未读通知
- **WHEN** 用户进入"我的"页面
- **THEN** 消息图标 SHALL 显示未读数量角标
- **AND** 角标数字 SHALL 等于真实未读通知数

#### Scenario: 登录用户无未读通知
- **GIVEN** 用户已登录且无未读通知
- **WHEN** 用户进入"我的"页面
- **THEN** 消息图标 SHALL 不显示角标

#### Scenario: 未登录用户
- **GIVEN** 用户未登录
- **WHEN** 用户进入"我的"页面
- **THEN** 消息图标 SHALL 不显示角标

### Requirement: 消息通知分组真实跳转
系统 SHALL 将"消息通知"卡片各分组项改为真实可跳转。

#### Scenario: 点击@我的动态
- **WHEN** 用户点击"@我的动态"
- **THEN** 应用 SHALL 跳转到消息页
- **AND** 消息页 SHALL 自动筛选显示"回复"类型通知

#### Scenario: 点击@我的评论
- **WHEN** 用户点击"@我的评论"
- **THEN** 应用 SHALL 跳转到消息页
- **AND** 消息页 SHALL 自动筛选显示"回复"类型通知

#### Scenario: 点击我收到的赞
- **WHEN** 用户点击"我收到的赞"
- **THEN** 应用 SHALL 跳转到消息页
- **AND** 消息页 SHALL 自动筛选显示"点赞"类型通知

#### Scenario: 点击好友关注
- **WHEN** 用户点击"好友关注"
- **THEN** 应用 SHALL 跳转到消息页
- **AND** 消息页 SHALL 自动筛选显示"其他"类型通知

### Requirement: 常用功能路由修复
系统 SHALL 修复"我的赞"和"我的回复"入口的路由跳转。

#### Scenario: 点击我的赞
- **WHEN** 用户点击"我的赞"
- **THEN** 应用 SHALL 跳转到当前用户资料页
- **AND** 资料页 SHALL 自动切换到"活动"Tab
- **AND** 活动 Tab SHALL 自动筛选显示"likes"分类

#### Scenario: 点击我的回复
- **WHEN** 用户点击"我的回复"
- **THEN** 应用 SHALL 跳转到当前用户资料页
- **AND** 资料页 SHALL 自动切换到"活动"Tab
- **AND** 活动 Tab SHALL 自动筛选显示"replies"分类

### Requirement: 消息页 Query 参数支持
系统 SHALL 支持通过 URL query 参数初始化消息页筛选状态。

#### Scenario: 通过 filter 参数初始化
- **GIVEN** URL 包含 `?filter=likes`
- **WHEN** 用户进入消息页
- **THEN** 消息页 SHALL 自动切换到"点赞"Tab
- **AND** 列表 SHALL 显示点赞类型通知

### Requirement: Tab 滑动切换修复
系统 SHALL 修复消息页 Tab 滑动切换时不触发筛选切换的问题。

#### Scenario: 滑动切换 Tab
- **GIVEN** 用户在消息页
- **WHEN** 用户左右滑动切换 Tab
- **THEN** TabController SHALL 触发筛选状态更新
- **AND** 通知列表 SHALL 切换到对应类型

### Requirement: 通知分页 Offset 支持
系统 SHALL 在通知分页请求中传递 offset 参数，避免重复加载。

#### Scenario: 加载更多通知
- **GIVEN** 用户已加载 20 条通知
- **WHEN** 用户上拉加载更多
- **THEN** 请求 SHALL 包含 `offset=20` 参数
- **AND** 服务端 SHALL 返回第 21 条及之后的数据

#### Scenario: HasMore 判定
- **GIVEN** 服务端返回通知列表
- **WHEN** 返回条数小于 page size
- **THEN** hasMore SHALL 设为 false
- **AND** 不再触发加载更多请求

## MODIFIED Requirements

### Requirement: UserProfilePage 初始化状态
**原要求**: 页面默认显示"帖子"Tab
**新要求**: 支持通过 query 参数指定初始 Tab 和分类

**变更内容**:
- 支持 `tab` 参数: `posts` | `activity`
- 支持 `category` 参数: `likes` | `replies` | ...

### Requirement: 通知分页逻辑
**原要求**: 分页基于去重后数量判定 hasMore
**新要求**: hasMore 基于服务端返回条数与 page size 比较

## REMOVED Requirements

无

## 非目标

1. 不引入新的消息中心页面信息架构。
2. 不改造后端 API 协议，仅基于现有接口参数增强。
3. 不在本次中新增推送系统（APNs/FCM）能力。

## 验收标准

1. 登录用户在"我的"页看到真实未读角标，未读为 0 时不显示。
2. 点击"消息通知"各分组项可进入消息页并落在对应筛选。
3. "我的赞 / 我的回复"入口可稳定跳转到个人活动对应分类。
4. 消息页手动点击或滑动切换 Tab 都能触发筛选状态切换。
5. 通知上拉加载更多时不再重复拉取首屏数据。

## 风险与回滚

1. **风险**: 不同 Discourse 实例对 `offset` 支持程度差异。
2. **回滚策略**: 若分页异常，可快速回退到无 offset 方案（接口兼容，不涉及数据库迁移）。
3. **风险**: 分类未读统计目前基于已拉取通知集合，不等于服务端全量未读。

## 后续建议

1. 接入后端"按类型未读统计"接口，替换前端聚合逻辑。
2. 增加"我的页面常用功能"与"消息筛选直达"组件测试。
3. 增加通知分页去重与 offset 行为的 provider 级单测。
