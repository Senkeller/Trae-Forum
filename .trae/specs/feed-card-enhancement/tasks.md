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
- 发送后自动关闭面板并刷新数据

### Task 7: 处理登录态检查
**描述:** 实现登录状态检查和引导
**文件:** `lib/presentation/widgets/feed/quick_comment_bar.dart`
**子任务:**
- [ ] 集成 `AuthProvider` 检查登录状态
- [ ] 未登录时显示登录引导弹窗
- [ ] 弹窗提供「去登录」和「取消」按钮
- [ ] 「去登录」跳转到登录页面

### Task 8: 实现评论提交 API
**描述:** 实现提交评论的 API 调用
**文件:** `lib/data/repositories/comment_repository.dart`
**子任务:**
- [ ] 添加 `createComment` 方法
- [ ] 实现 POST /posts 接口调用
- [ ] 处理 CSRF Token 和 Cookie
- [ ] 实现错误处理和重试逻辑

**API 参数:**
```dart
{
  "raw": "评论内容",
  "topic_id": topicId,
  "reply_to_post_number": null
}
```

### Task 9: 集成快速输入栏到 FeedCard
**描述:** 在 FeedCard 底部集成快速输入栏
**文件:** `lib/presentation/widgets/feed/feed_card.dart`
**子任务:**
- [ ] 在互动数据下方添加 `QuickCommentBar`
- [ ] 传递 topicId 和当前用户头像
- [ ] 实现评论成功后的回调（刷新评论数）
- [ ] 确保与精选评论区域的间距合适

---

## Phase 3: 内容展开优化

### Task 10: 优化内容截断逻辑
**描述:** 实现精确的内容截断和「查看更多」功能
**文件:** `lib/presentation/widgets/feed/feed_content.dart`
**子任务:**
- [ ] 使用 `TextPainter` 计算文本行数
- [ ] 实现 4 行截断逻辑
- [ ] 在截断处添加「...查看更多」
- [ ] 「查看更多」使用品牌主色
- [ ] 点击「查看更多」进入详情页

**实现逻辑:**
```dart
// 使用 LayoutBuilder 获取可用宽度
// 使用 TextPainter 计算实际行数
// 如果超过 4 行，截断并添加展开按钮
```

### Task 11: 更新 FeedContent 组件
**描述:** 修改 FeedContent 以支持展开控制
**文件:** `lib/presentation/widgets/feed/feed_content.dart`
**子任务:**
- [ ] 添加 `maxLines` 参数（默认 4）
- [ ] 添加 `onExpand` 回调
- [ ] 实现文本测量和截断逻辑
- [ ] 确保图片和文本的布局协调

### Task 12: 集成到 FeedCard
**描述:** 在 FeedCard 中使用新的 FeedContent
**文件:** `lib/presentation/widgets/feed/feed_card.dart`
**子任务:**
- [ ] 更新 FeedContent 调用，传入展开回调
- [ ] 确保展开后跳转到详情页
- [ ] 测试长内容和短内容的显示效果

---

## Phase 4: 测试和优化

### Task 13: 单元测试
**描述:** 为新组件编写单元测试
**文件:** `test/widgets/featured_comment_test.dart`, `test/widgets/quick_comment_bar_test.dart`
**子任务:**
- [ ] 测试 FeaturedComment 组件渲染
- [ ] 测试 QuickCommentBar 点击事件
- [ ] 测试内容截断逻辑
- [ ] 测试登录态检查

### Task 14: 集成测试
**描述:** 验证整体功能流程
**子任务:**
- [ ] 测试精选评论显示和点击
- [ ] 测试快速评论提交流程
- [ ] 测试内容展开功能
- [ ] 测试未登录场景

### Task 15: UI 优化和 Bug 修复
**描述:** 修复测试中发现的问题
**子任务:**
- [ ] 修复深色模式下的颜色问题
- [ ] 优化长文本的截断位置
- [ ] 修复快速输入栏的键盘遮挡问题
- [ ] 优化性能（减少不必要的重建）

---

## 任务依赖关系

```
Phase 1:
  Task 1 (数据模型) → Task 2 (组件) → Task 3 (集成) → Task 4 (首页)

Phase 2:
  Task 5 (输入栏UI) → Task 6 (输入面板) → Task 7 (登录检查) → Task 9 (集成)
  Task 8 (API) → Task 9 (集成)

Phase 3:
  Task 10 (截断逻辑) → Task 11 (组件更新) → Task 12 (集成)

Phase 4:
  Task 13/14/15 (测试和优化) 依赖所有前面任务
```

## 并行开发建议

可以同时进行的任务组：
- **Group A:** Task 1, Task 2, Task 5（UI 组件开发）
- **Group B:** Task 8（API 层开发）
- **Group C:** Task 10（内容截断逻辑）

Group A 和 Group B 完全独立，可以并行开发。
Group C 也相对独立，可以与其他组并行。
