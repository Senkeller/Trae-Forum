# Tasks

- [x] Task 1: 创建论坛链接构建工具函数: 创建用于构建论坛用户活动页面 URL 的工具函数
  - [x] SubTask 1.1: 在 `profile_page_new.dart` 中添加 `_buildForumActivityUrl` 方法，接收 username 和 category 参数
  - [x] SubTask 1.2: 实现 URL 编码处理，确保 username 中的特殊字符正确编码

- [x] Task 2: 创建 WebView 导航方法: 创建用于打开论坛网页的导航方法
  - [x] SubTask 2.1: 在 `profile_page_new.dart` 中添加 `_openForumWebView` 方法，接收 URL 和标题参数
  - [x] SubTask 2.2: 使用现有的 webview 路由打开页面

- [x] Task 3: 重构常用功能入口配置: 将现有的快捷功能入口替换为论坛功能链接
  - [x] SubTask 3.1: 移除现有的 6 个功能入口（本地收藏、浏览历史、我常去、我的收藏、我的赞、我的回复）
  - [x] SubTask 3.2: 添加 8 个新的论坛功能入口：话题、回复、已读、草稿、赞、书签、已解决、投票
  - [x] SubTask 3.3: 为每个入口配置适当的图标和颜色
  - [x] SubTask 3.4: 使用 onTap 回调打开对应的论坛网页链接

- [x] Task 4: 验证功能实现: 验证所有功能入口都能正确打开对应的论坛页面
  - [x] SubTask 4.1: 检查 URL 构建是否正确
  - [x] SubTask 4.2: 验证 WebView 能正常打开论坛页面

# Task Dependencies
- Task 3 depends on Task 1 and Task 2
