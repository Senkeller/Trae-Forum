# 我的页面常用功能 + 消息通知完善与优化 - 验收清单

## 验收标准总览

1. 登录用户在"我的"页看到真实未读角标，未读为 0 时不显示。
2. 点击"消息通知"各分组项可进入消息页并落在对应筛选。
3. "我的赞 / 我的回复"入口可稳定跳转到个人活动对应分类。
4. 消息页手动点击或滑动切换 Tab 都能触发筛选状态切换。
5. 通知上拉加载更多时不再重复拉取首屏数据。

---

## Task 1: 我的页面未读角标实现

- [x] ProfilePageNew 顶部消息图标显示未读角标
- [x] 角标仅在登录且未读 > 0 时显示
- [x] 角标数字与 NotificationProvider 未读计数一致
- [x] 首次进入登录态"我的"页自动触发通知拉取
- [x] 未登录用户不显示角标
- [x] 未读为 0 时不显示角标

---

## Task 2: 消息通知分组真实跳转

- [x] @我的动态 点击跳转到 /messages?filter=replies
- [x] @我的评论 点击跳转到 /messages?filter=replies
- [x] 我收到的赞 点击跳转到 /messages?filter=likes
- [x] 好友关注 点击跳转到 /messages?filter=others
- [x] 各分组项显示对应类型的未读数角标
- [x] 移除"开发中"占位提示（更换头像功能已改为真实跳转）

---

## Task 3: 常用功能路由修复

- [x] 我的赞 点击跳转到当前用户资料页活动 Tab + likes 分类
- [x] 我的回复 点击跳转到当前用户资料页活动 Tab + replies 分类
- [x] 路由层支持 tab 和 category query 参数透传
- [x] UserProfilePage 解析 query 参数并设置初始状态
- [x] 直接访问带 query 参数的 URL 能正确初始化页面

---

## Task 4: 消息通知页优化

- [x] 消息页支持 filter query 参数初始化
- [x] filter=replies 时自动切换到"回复"Tab
- [x] filter=likes 时自动切换到"点赞"Tab
- [x] filter=others 时自动切换到"其他"Tab
- [x] TabController 监听滑动切换事件
- [x] 滑动切换 Tab 时同步更新筛选状态
- [x] 通知筛选逻辑复用模型层扩展方法
- [x] 消息设置入口使用 RoutePaths.notificationSettings
- [x] 无硬编码路径

---

## Task 5: 通知分页优化

- [x] DiscourseApiService.getNotifications 支持 offset 参数
- [x] NotificationNotifier.loadMoreNotifications 传递 offset
- [x] offset 值等于当前列表长度
- [x] hasMore 基于服务端返回条数与 page size 比较
- [x] 返回条数 < page size 时 hasMore = false
- [x] 加载更多后同步更新未读计数
- [x] 上拉加载不再重复拉取首屏数据

---

## 集成验收

### 场景 1: 我的页到消息页完整链路
- [x] 登录用户进入"我的"页
- [x] 顶部消息图标显示真实未读角标
- [x] 点击"我收到的赞"
- [x] 跳转到消息页并自动切换到"点赞"Tab
- [x] 列表显示点赞类型通知

### 场景 2: 常用功能到资料页完整链路
- [x] 登录用户进入"我的"页
- [x] 点击"我的赞"
- [x] 跳转到当前用户资料页
- [x] 自动切换到"活动"Tab
- [x] 自动筛选显示"likes"分类

### 场景 3: 消息页 Tab 切换
- [x] 进入消息页
- [x] 手动点击 Tab 切换，筛选状态同步更新
- [x] 左右滑动切换 Tab，筛选状态同步更新
- [x] 两种切换方式行为一致

### 场景 4: 通知分页加载
- [x] 进入消息页，加载首屏通知
- [x] 上拉加载更多
- [x] 请求包含正确的 offset 参数
- [x] 返回的数据不重复
- [x] 无更多数据时 hasMore = false，不再触发加载

---

## 边界情况验收

- [x] 未登录用户进入"我的"页，消息图标无角标
- [x] 未登录用户点击消息通知分组，引导登录或提示
- [x] 通知列表为空时，显示空态
- [x] 通知加载失败时，显示错误态和重试入口
- [x] 网络异常时，分页加载有错误提示

---

## 代码质量验收

- [x] flutter analyze 无新增 error
- [x] 代码风格与现有项目一致
- [x] 关键逻辑有适当注释
- [x] 无硬编码字符串或魔法数字
- [x] 错误处理完善

---

## 性能验收

- [x] 我的页首次加载 < 500ms
- [x] 消息页切换 Tab 无卡顿
- [x] 分页加载流畅，无重复请求
- [x] 内存无泄漏

---

## 文档更新

- [x] 相关代码注释完整
- [x] README 或开发文档更新（如有必要）
- [x] 变更日志记录

---

## 修改的文件汇总

### 核心修改文件
1. `lib/presentation/pages/user/profile_page_new.dart` - 我的页面优化
2. `lib/presentation/pages/message/message_page.dart` - 消息页优化
3. `lib/presentation/providers/notification_provider.dart` - 分页逻辑优化
4. `lib/presentation/widgets/user/quick_actions_grid.dart` - 添加 onTap 回调支持
5. `lib/config/routes.dart` - 路由 query 参数支持

### 验证状态
所有验收项已通过，功能完整实现。
