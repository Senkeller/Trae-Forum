# TRAE Forum 论坛客户端功能升级规格说明（90%+ 目标）

## Why

当前应用仅为"可读为主的论坛客户端"，存在以下核心问题：
1. GoRouter 30 个路由中约 21 个仍是占位页面
2. ApiService 多项写接口返回 `Not implemented`
3. 详情页底部输入未接真实发送链路
4. 关注/取关逻辑调用旧 `/v6/*` 路径，与 Discourse 不一致
5. 消息页详情跳转到占位 TopicDetailPage

目标：将应用升级为"读写完整、消息完整、账号完整"的 Discourse 客户端，达到原站核心功能 90%+ 可用覆盖。

## What Changes

### 里程碑规划

| 里程碑 | 时间 | 目标 |
|--------|------|------|
| M1 基础修复 | 1-1.5 周 | 清理假实现、修复路由、登录会话、CSRF 打通 |
| M2 核心读写闭环 | 1.5-2 周 | 发帖、回复、详情写操作、分类标签、关注粉丝 |
| M3 二级页与消息体系 | 1.5 周 | 消息详情、通知、私信聊天、设置子页、收藏历史 |
| M4 收敛与发布 | 1 周 | 性能优化、全量测试、回归、90% 覆盖评分 |

### 功能覆盖率目标

| 模块 | 权重 | 目标完成度 |
|------|------|-----------|
| 信息流/列表 | 15% | >=90% |
| 帖子详情/回复 | 15% | >=90% |
| 发帖/回复编辑删除 | 15% | >=90% |
| 搜索 | 8% | >=90% |
| 分类/标签导航 | 8% | >=90% |
| 消息通知 | 12% | >=90% |
| 私信/聊天 | 8% | >=80% |
| 用户主页与社交关系 | 8% | >=90% |
| 登录与会话管理 | 6% | >=95% |
| 设置与偏好 | 3% | >=90% |

**目标总覆盖率: >=90%**

### 占位页补完清单（21 个必须完成）

1. FeedCreatePage - 新建话题页
2. FeedReplyPage - 独立回复编辑器
3. UserEditPage - 编辑用户资料
4. FollowListPage - 关注列表
5. FanListPage - 粉丝列表
6. TopicListPage - 综合话题流
7. TopicDetailPage - 标签/话题流详情
8. ProductDetailPage - 专题页（可映射）
9. SearchResultPage - 搜索结果页
10. MessageDetailPage - 消息详情
11. NotificationsPage - 独立通知页
12. ThemeSettingsPage - 主题设置
13. FontSettingsPage - 字体设置
14. BlacklistPage - 黑名单
15. AboutPage - 关于页
16. RegisterPage - 注册页
17. ForgotPasswordPage - 找回密码页
18. HistoryPage - 浏览历史
19. FavoritesPage - 收藏列表
20. ImagePreviewPage - 图片预览
21. ErrorPage - 统一错误中心

### 核心写接口必须打通

| 操作 | 接口 | 状态 |
|------|------|------|
| 发帖 | `POST /posts` | 必须实现 |
| 回复 | `POST /posts` | 必须实现 |
| 编辑 | `PUT /posts/{postId}` | 必须实现 |
| 删除 | `DELETE /posts/{postId}` | 必须实现 |
| 点赞 | `POST /post_actions` | 必须实现 |
| 取消点赞 | `DELETE /post_actions/{postId}?post_action_type_id=2` | 必须实现 |
| 收藏 | `POST /bookmarks` | 必须实现 |
| 取消收藏 | `DELETE /bookmarks/{postId}` | 必须实现 |
| 标记已读 | `PUT /notifications/mark-read` | 必须实现 |
| 关注 | Discourse 兼容接口 | 必须实现 |

### 会话与安全要求

1. WebView SSO 登录主链路保留
2. Dio CookieJar 与 WebView Cookie 同步
3. CSRF Token 自动注入写请求
4. 移除所有 `/v6/*` 旧路径
5. 移除 `Not implemented` 伪实现
6. 移除 `status:404` 假成功逻辑

## Impact

### 受影响规格
- 现有只读 MVP 规格需要扩展写操作能力
- 路由系统需要从 9/30 可用提升到 27/30+ 可用
- 网络层需要支持写操作和会话管理

### 受影响代码
- `lib/core/network/api_service.dart` - 写接口实现
- `lib/config/routes.dart` - 路由补全
- `lib/presentation/pages/feed/feed_detail_page.dart` - 底部输入
- `lib/presentation/providers/user_provider.dart` - 关注逻辑
- `lib/presentation/pages/message/` - 消息详情
- `test/` - 失真测试修复

## ADDED Requirements

### Requirement: 占位页全量替换
系统 SHALL 将所有 21 个占位页面替换为真实可用页面，每个页面必须包含：空态、加载态、错误态、登录态、无权限态。

#### Scenario: 占位页访问
- **WHEN** 用户访问任意占位路由
- **THEN** 页面 SHALL 展示真实数据或明确的功能状态
- **AND** 不得出现"页面建设中"或类似占位文案

### Requirement: 写操作完整闭环
系统 SHALL 支持发帖、回复、编辑、删除、点赞、收藏、关注的完整闭环。

#### Scenario: 登录后发回复
- **WHEN** 用户已登录且点击详情页底部回复栏
- **THEN** 系统 SHALL 调用 `POST /posts` 发送回复
- **AND** 2 秒内可见回复（乐观更新 + 实际回写）
- **AND** 失败时有明确错误提示

### Requirement: 消息通知闭环
系统 SHALL 支持通知列表、分类筛选、标记已读、点击跳转详情。

#### Scenario: 通知点击跳转
- **WHEN** 用户点击通知项
- **THEN** 系统 SHALL 跳转到对应帖子详情页
- **AND** 不再跳转到占位页

### Requirement: 关注粉丝列表
系统 SHALL 支持查看关注列表、粉丝列表、关注/取关操作。

#### Scenario: 关注用户
- **WHEN** 用户点击关注按钮
- **THEN** 系统 SHALL 调用 Discourse 兼容接口
- **AND** 状态在刷新后保持一致
- **AND** 不得调用旧 `/v6/*` 路径

## MODIFIED Requirements

### Requirement: 会话管理统一
**原要求**: WebView 登录与 Cookie 同步已有基础实现
**新要求**: 会话必须统一 - WebView Cookie -> Dio CookieJar -> API 可鉴权，CSRF Token 自动注入

### Requirement: 错误处理
**原要求**: API 错误有基本提示
**新要求**: 统一错误模型（网络错误、鉴权错误、业务错误、限流错误），429 实现退避重试

## REMOVED Requirements

### Requirement: 旧版 /v6 接口
**Reason**: 与 Discourse 体系不一致，已过时
**Migration**: 全部替换为 Discourse 标准接口

### Requirement: Not implemented 伪实现
**Reason**: 违反验收标准，必须清理
**Migration**: 实现真实接口或移除该功能入口

### Requirement: 假成功响应
**Reason**: status:404 返回伪成功会导致数据不一致
**Migration**: 正确返回错误状态

## 验收标准

1. 功能覆盖评分 >=90%
2. 占位页清零，或剩余 <=3 个且有书面延期理由
3. 关键写操作可用：发帖、回帖、点赞、已读、关注
4. 核心链路自动化测试全绿
5. 用户可在登录状态下完整完成"浏览 -> 互动 -> 消息回流"
6. `flutter analyze` 无 error
7. 提交发布说明

## 技术栈约束

- Flutter + Riverpod + GoRouter + Dio + WebView
- 不新增重依赖，优先复用现有架构
- 每个 PR 限制单模块，保持可回滚
- 每个 PR 必带对应测试
