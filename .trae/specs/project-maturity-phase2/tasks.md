# Tasks - TraeU 项目完善 Phase 2

## 任务概览

基于完善度分析报告，Phase 2 目标是将完善度从 **90/100** 提升到 **95+**，重点解决测试覆盖、动画体验、无障碍支持、私信和推送功能。

---

## Task 1: 核心页面测试覆盖提升（+3 分）

### 目标
为核心页面补充 Widget 测试，确保核心流程可验证。

- [x] 建立测试基类和工具类
  - [x] 创建 `test/test_utils.dart` 测试工具类
  - [x] 创建 Mock 数据生成器
  - [x] 创建测试用的 Provider 容器包装器
- [x] Feed 页面测试
  - [x] 测试 Feed 列表加载和显示
  - [x] 测试下拉刷新功能
  - [x] 测试上拉加载更多
  - [x] 测试 Feed 卡片点击跳转
- [x] 话题详情页测试
  - [x] 测试话题内容加载
  - [x] 测试评论列表显示
  - [x] 测试回复功能
  - [x] 测试点赞/收藏操作
- [x] 用户资料页测试
  - [x] 测试用户信息加载
  - [x] 测试关注/取关功能
  - [x] 测试资料编辑入口
- [x] 设置页面测试
  - [x] 测试设置项加载
  - [x] 测试设置变更和持久化
- [x] 用户任务链集成测试
  - [x] 任务链1: 我的页 -> 编辑资料 -> 保存成功
  - [x] 任务链2: 发布回复 -> 列表刷新可见
  - [x] 任务链3: 设置变更 -> 重启后状态一致

---

## Task 2: 动画体验增强（+1 分）

### 目标
添加页面过渡动画和微交互动画，提升用户体验。

- [x] 页面过渡动画
  - [x] 创建 `lib/core/animations/page_transitions.dart`
  - [x] 实现 Slide 过渡动画
  - [x] 实现 Fade 过渡动画
  - [x] 实现 Hero 动画（图片预览）
  - [x] 在路由配置中应用过渡动画
- [x] 微交互动画
  - [x] 优化 LikeButton 动画效果
  - [x] 添加收藏按钮动画
  - [x] 添加分享按钮动画
  - [x] 添加关注按钮动画
- [x] 列表动画
  - [x] 添加列表项入场动画
  - [x] 优化下拉刷新动画
  - [x] 优化上拉加载动画
  - [x] 添加空状态过渡动画
- [x] 其他动画
  - [x] 添加底部导航栏切换动画
  - [x] 添加 Tab 切换动画
  - [x] 添加 SnackBar 动画优化

---

## Task 3: 无障碍支持（+1 分）

### 目标
为核心组件和页面添加无障碍支持。

- [x] 核心组件无障碍化
  - [x] 为 FeedCard 添加 Semantics 标签
  - [x] 为 LikeButton 添加语义标签
  - [x] 为 ActionButtons 添加语义标签
  - [x] 为底部导航栏添加语义标签
- [x] 页面无障碍化
  - [x] 为 HomePage 添加页面语义标签
  - [x] 为 TopicDetailPage 添加语义标签
  - [x] 为 ProfilePage 添加语义标签
  - [x] 为 SettingsPage 添加语义标签
- [x] 表单无障碍化
  - [x] 为输入框添加标签和提示
  - [x] 为按钮添加操作说明
  - [x] 为错误提示添加语义标签
- [x] 无障碍测试
  - [x] 测试屏幕阅读器导航
  - [x] 验证所有可交互元素可访问
  - [x] 修复发现的问题

---

## Task 4: 私信功能基础实现（+2 分）

### 目标
实现基础私信功能，支持用户间沟通。

- [x] Discourse 私信 API 集成
  - [x] 研究 Discourse 私信相关 API
  - [x] 在 `discourse_api_service.dart` 添加私信 API 方法
  - [x] 创建私信相关数据模型
  - [x] 创建私信 Repository
- [x] 私信会话列表页面
  - [x] 创建 `lib/presentation/pages/message/conversation_list_page.dart`
  - [x] 实现会话列表 UI
  - [x] 实现会话列表数据加载
  - [x] 添加未读消息提示
- [x] 私信聊天页面
  - [x] 创建 `lib/presentation/pages/message/chat_page.dart`
  - [x] 实现聊天消息列表 UI
  - [x] 实现消息输入和发送
  - [x] 实现消息气泡样式
- [x] 私信状态管理
  - [x] 创建 `lib/presentation/providers/message_provider.dart`
  - [x] 实现会话列表状态管理
  - [x] 实现聊天状态管理
  - [x] 实现未读消息计数
- [x] 路由和入口
  - [x] 添加私信相关路由
  - [x] 在消息页面添加入口
  - [x] 在用户资料页添加"发私信"按钮

---

## Task 5: 实时推送基础框架（+1 分）

### 目标
集成 Firebase Cloud Messaging，实现推送消息接收。

- [x] Firebase 配置
  - [x] 在 Firebase Console 创建项目
  - [x] 下载并配置 `google-services.json` (Android)
  - [x] 下载并配置 `GoogleService-Info.plist` (iOS)
  - [x] 添加 Firebase 依赖到 `pubspec.yaml`
- [x] 推送服务实现
  - [x] 创建 `lib/core/services/push_notification_service.dart`
  - [x] 实现 FCM Token 获取和管理
  - [x] 实现前台消息接收处理
  - [x] 实现后台消息接收处理
- [x] 本地通知展示
  - [x] 集成 `flutter_local_notifications`
  - [x] 实现本地通知展示
  - [x] 配置通知图标和样式
  - [x] 处理通知点击事件
- [x] 通知跳转
  - [x] 实现点击通知跳转到对应页面
  - [x] 处理不同类型的通知（私信、回复、关注等）
  - [x] 传递通知参数到目标页面
- [x] 权限处理
  - [x] 申请通知权限（iOS）
  - [x] 处理权限被拒绝的情况
  - [x] 在设置中添加通知开关

---

## Task 6: 综合验证

- [x] 运行静态检查
  - [x] 执行 `flutter analyze`，确保无新增 error
  - [x] 修复任何新引入的 warning
- [x] 运行测试
  - [x] 执行 `flutter test`，确保所有测试通过
  - [x] 特别关注新增的 Widget 测试
- [x] 功能验证
  - [x] 验证动画效果正常
  - [x] 验证无障碍功能可用
  - [x] 验证私信功能可用
  - [x] 验证推送功能可用
- [x] 完善度评估
  - [x] 重新评估测试覆盖率
  - [x] 重新评估动画体验
  - [x] 重新评估无障碍支持
  - [x] 计算新的完善度评分

---

## 任务依赖

```
Task 1 (测试覆盖) ──┐
                   ├──→ Task 6 (综合验证)
Task 2 (动画) ──────┤
                   │
Task 3 (无障碍) ────┤
                   │
Task 4 (私信) ──────┤
                   │
Task 5 (推送) ──────┘
```

- Task 1-5 可以并行执行
- Task 6 必须在所有其他任务完成后执行

---

## 验收检查点

### Task 1 验收
- [x] 核心页面测试覆盖率达到 80%+
- [x] 新增 Widget 测试 20+ 个
- [x] 用户任务链测试全部通过

### Task 2 验收
- [x] 主要页面切换有过渡动画
- [x] 点赞、收藏等操作有反馈动画
- [x] 列表加载有入场动画

### Task 3 验收
- [x] 主要页面可通过屏幕阅读器导航
- [x] 所有按钮、链接有正确的语义标签
- [x] 通过无障碍基础检查

### Task 4 验收
- [x] 可查看私信会话列表
- [x] 可进入单一会话查看消息
- [x] 可发送新消息
- [x] 有未读消息提示

### Task 5 验收
- [x] 可接收推送消息
- [x] 推送消息显示本地通知
- [x] 点击通知可跳转到对应页面

### Phase 2 DoD
- [x] `flutter analyze` 无新增 error
- [x] `flutter test` 全部通过
- [x] 完善度评分达到 95+
