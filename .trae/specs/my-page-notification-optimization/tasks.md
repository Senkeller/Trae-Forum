# 我的页面常用功能 + 消息通知完善与优化 - 任务清单

## 任务概览

本规格包含 5 个主要任务模块，涉及我的页面、常用功能、消息通知和分页优化。任务间存在一定依赖关系，建议按顺序执行。

## 任务列表

### Task 1: 我的页面未读角标实现
**描述**: 在 ProfilePageNew 顶部消息图标显示真实未读通知数角标，首次进入时自动拉取通知。

- [x] SubTask 1.1: 在 ProfilePageNew 中添加通知未读数监听
  - 读取 NotificationProvider 的未读计数
  - 仅登录且未读 > 0 时显示角标
- [x] SubTask 1.2: 首次进入登录态"我的"页时自动触发通知拉取
  - 在 initState 或 didChangeDependencies 中检查登录状态
  - 调用 NotificationNotifier.fetchNotifications()
- [x] SubTask 1.3: 角标 UI 实现
  - 使用 Badge 或自定义角标组件
  - 位置：消息图标右上角
  - 样式与主题一致

**依赖**: 无

---

### Task 2: 消息通知分组真实跳转
**描述**: 将"消息通知"卡片各分组项改为跳转到消息页并自动筛选对应类型。

- [x] SubTask 2.1: 修改消息通知卡片各分组项的 onTap 回调
  - @我的动态 -> `/messages?filter=replies`
  - @我的评论 -> `/messages?filter=replies`
  - 我收到的赞 -> `/messages?filter=likes`
  - 好友关注 -> `/messages?filter=others`
- [x] SubTask 2.2: 计算并显示分组未读数
  - 从通知列表中按类型统计未读数
  - 在分组项右侧显示未读角标
- [x] SubTask 2.3: 移除"开发中"占位提示
  - 将"更换头像"的占位提示替换为真实跳转

**依赖**: Task 4（消息页需要支持 filter 参数）

---

### Task 3: 常用功能路由修复
**描述**: 修复"我的赞"和"我的回复"入口，跳转到用户资料页活动 Tab 对应分类。

- [x] SubTask 3.1: 修改"我的赞"入口跳转
  - 目标: `/user/{current_user}?tab=activity&category=likes`
  - 需要获取当前登录用户名
- [x] SubTask 3.2: 修改"我的回复"入口跳转
  - 目标: `/user/{current_user}?tab=activity&category=replies`
- [x] SubTask 3.3: 路由层支持 query 参数透传
  - 修改 RoutePaths 和 GoRouter 配置
  - 确保 query 参数能传递到 UserProfilePage
- [x] SubTask 3.4: UserProfilePage 支持初始状态注入
  - 解析 `tab` 和 `category` query 参数
  - 根据参数设置初始 Tab 和分类筛选

**依赖**: Task 4 完成后可并行执行

---

### Task 4: 消息通知页优化
**描述**: 消息页支持 query 初始化筛选，修复 Tab 滑动切换问题。

- [x] SubTask 4.1: 消息页支持 filter query 参数
  - 在 MessagesPage 中解析 `filter` 参数
  - 根据参数初始化当前 Tab 索引
  - 触发对应类型的通知筛选
- [x] SubTask 4.2: 增加 TabController 监听
  - 监听 TabController 的 index 变化
  - 滑动切换时同步更新筛选状态
  - 确保状态与 UI 一致
- [x] SubTask 4.3: 统一通知筛选匹配逻辑
  - 复用模型层扩展方法
  - 减少重复判断逻辑
- [x] SubTask 4.4: 消息设置入口路径修复
  - 统一使用 RoutePaths.notificationSettings
  - 检查并替换所有硬编码路径

**依赖**: 无（可最先执行）

---

### Task 5: 通知分页优化
**描述**: 优化通知分页行为，增加 offset 参数支持，修复 hasMore 判定逻辑。

- [x] SubTask 5.1: DiscourseApiService.getNotifications 增加 offset 参数
  - 修改方法签名，添加可选 offset 参数
  - 在请求中传递 offset 到服务端
- [x] SubTask 5.2: NotificationNotifier.loadMoreNotifications 传递 offset
  - 按当前列表长度计算 offset
  - 调用 API 时传入 offset 参数
- [x] SubTask 5.3: 修复 hasMore 判定逻辑
  - 基于服务端返回条数与 page size 比较
  - 返回条数 < page size 时设置 hasMore = false
- [x] SubTask 5.4: 加载更多后同步更新未读计数
  - 确保 UI 统计与实际数据一致

**依赖**: 无（可最先执行）

---

## 任务依赖关系

```
Task 4 (消息页优化)
    │
    ├──> Task 2 (消息通知分组跳转)
    │
    └──> Task 3 (常用功能路由)

Task 1 (我的页角标) ──> 独立执行

Task 5 (分页优化) ──> 独立执行
```

## 建议执行顺序

1. **第一批（无依赖）**: Task 4, Task 5, Task 1
2. **第二批（依赖 Task 4）**: Task 2, Task 3

## 验证方式

每个子任务完成后，应进行以下验证：

- **UI 验证**: 界面显示是否符合预期
- **功能验证**: 点击、跳转、筛选是否正常
- **数据验证**: 未读数、分页数据是否正确
- **边界验证**: 未登录、空数据、错误态是否正常

## 注意事项

1. 所有修改应保持向后兼容，不破坏现有功能
2. 优先复用现有架构和组件，不引入重依赖
3. 每个任务完成后及时更新 checklist
4. 如遇 Discourse API offset 不支持，可快速回退到无 offset 方案
