# Feed 卡片增强功能任务列表

## Phase 1: 精选评论展示（快速见效）

### Task 1: 修改 Feed 数据模型
**描述:** 修改 Feed 数据模型以支持精选评论功能
**文件:** `lib/data/models/feed.dart`
**子任务:**
- [ ] 在 `FeedItem` 类中添加 `topComment` 字段（类型：`TopComment?`）
- [ ] 创建 `TopComment` 数据类，包含 id、username、content、likeCount、avatarUrl 字段
- [ ] 更新 Freezed 代码生成
- [ ] 在 `TopicAdapter` 中添加从 Discourse Post 到 TopComment 的映射逻辑

**实现逻辑:**
```dart
// 从话题详情接口获取 posts
// 筛选 post_number > 1 的回复
// 按 like_count 降序排序
// 取第一条作为 topComment
```

### Task 2: 创建精选评论展示组件
**描述:** 创建 `FeaturedComment` 组件用于展示精选评论
**文件:** `lib/presentation/widgets/feed/featured_comment.dart`
**子任务:**
- [ ] 创建 `FeaturedComment` StatelessWidget
- [ ] 实现高赞标签 UI（绿色背景、白色文字）
- [ ] 实现评论内容展示（用户名 + 内容摘要）
- [ ] 添加点击事件处理
- [ ] 实现空值安全处理（无评论时不渲染）

**UI 规范:**
- 背景色: `surfaceVariant.withOpacity(0.3)`
- 高赞标签背景: `AppTheme.primaryColor`
- 用户名颜色: `AppTheme.primaryColor`
- 内边距: 12px
- 圆角: 8px

### Task 3: 修改 FeedCard 组件
**描述:** 在 FeedCard 中集成精选评论组件
**文件:** `lib/presentation/widgets/feed/feed_card.dart`
**子任务:**
- [ ] 在 `FeedCardData` 中添加 `topComment` 参数
- [ ] 在内容区与互动区之间插入 `FeaturedComment`
- [ ] 添加点击精选评论跳转到详情页的逻辑
- [ ] 更新简洁版卡片 `FeedCardSimple`（可选展示）

### Task 4: 更新首页 Feed 列表
**描述:** 修改首页以传递精选评论数据
**文件:** `lib/presentation/pages/home/home_page.dart`
**子任务:**
- [ ] 修改 `_FeedCard` 组件，传递 `topComment` 数据
- [ ] 确保数据从 API 响应正确映射到组件
- [ ] 处理加载状态和错误状态

---

## Phase 2: 快速输入栏（提升互动）

### Task 5: 创建快速输入栏组件
**描述:** 创建 `QuickCommentBar` 组件
**文件:** `lib/presentation/widgets/feed/quick_comment_bar.dart`
**子任务:**
- [ ] 创建 `QuickCommentBar` StatelessWidget
- [ ] 实现胶囊形输入框 UI
- [ ] 显示当前用户头像（从 UserProvider 获取）
- [ ] 实现占位文案「说点什么吧...」
- [ ] 添加表情图标

**UI 规范:**
- 背景色: `surfaceVariant`
- 圆角: 20px（胶囊形）
- 高度: 40px
- 内边距: 水平12px

### Task 6: 创建快速评论输入面板
**描述:** 创建底部弹出的评论输入面板
**文件:** `lib/presentation/widgets/comment/quick_comment_sheet.dart`
**子任务:**
- [ ] 创建 `QuickCommentSheet` StatefulWidget
- [ ] 实现底部面板布局（使用 `showModalBottomSheet`）
- [ ] 添加多行文本输入框
- [ ] 实现发送按钮和表情按钮
- [ ] 输入框自动获取焦点
- [ ] 实现发送逻辑和加载状态

**交互逻辑:**
- 面板高度: 屏幕高度的 40%
- 输入框最大高度: 120px
-