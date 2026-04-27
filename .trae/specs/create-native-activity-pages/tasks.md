# Tasks

- [x] Task 1: 创建用户话题页面 (UserTopicsPage): 展示用户发布的话题列表
  - [x] SubTask 1.1: 创建页面文件 `user_topics_page.dart`
  - [x] SubTask 1.2: 实现页面 UI，包含 AppBar 和话题列表
  - [x] SubTask 1.3: 集成 API 获取用户话题数据

- [x] Task 2: 创建用户回复页面 (UserRepliesPage): 展示用户的回复列表
  - [x] SubTask 2.1: 创建页面文件 `user_replies_page.dart`
  - [x] SubTask 2.2: 实现页面 UI，包含 AppBar 和回复列表
  - [x] SubTask 2.3: 集成 API 获取用户回复数据

- [x] Task 3: 创建用户已读页面 (UserReadPage): 展示用户已读的内容
  - [x] SubTask 3.1: 创建页面文件 `user_read_page.dart`
  - [x] SubTask 3.2: 实现页面 UI
  - [x] SubTask 3.3: 集成 API 获取已读数据

- [x] Task 4: 创建用户草稿页面 (UserDraftsPage): 展示用户的草稿
  - [x] SubTask 4.1: 创建页面文件 `user_drafts_page.dart`
  - [x] SubTask 4.2: 实现页面 UI
  - [x] SubTask 4.3: 集成 API 获取草稿数据

- [x] Task 5: 创建用户赞页面 (UserLikesPage): 展示用户点赞的内容
  - [x] SubTask 5.1: 创建页面文件 `user_likes_page.dart`
  - [x] SubTask 5.2: 实现页面 UI
  - [x] SubTask 5.3: 集成 API 获取点赞数据

- [x] Task 6: 创建用户书签页面 (UserBookmarksPage): 展示用户的书签
  - [x] SubTask 6.1: 创建页面文件 `user_bookmarks_page.dart`
  - [x] SubTask 6.2: 实现页面 UI
  - [x] SubTask 6.3: 集成 API 获取书签数据

- [x] Task 7: 创建用户已解决页面 (UserSolvedPage): 展示用户标记为已解决的内容
  - [x] SubTask 7.1: 创建页面文件 `user_solved_page.dart`
  - [x] SubTask 7.2: 实现页面 UI
  - [x] SubTask 7.3: 集成 API 获取已解决数据

- [x] Task 8: 创建用户投票页面 (UserVotesPage): 展示用户投票的内容
  - [x] SubTask 8.1: 创建页面文件 `user_votes_page.dart`
  - [x] SubTask 8.2: 实现页面 UI
  - [x] SubTask 8.3: 集成 API 获取投票数据

- [x] Task 9: 添加路由配置: 在 routes.dart 中添加 8 个新页面的路由
  - [x] SubTask 9.1: 定义路由路径常量
  - [x] SubTask 9.2: 配置 GoRouter 路由

- [x] Task 10: 修改常用功能入口: 更新 `profile_page_new.dart` 中的快捷功能入口
  - [x] SubTask 10.1: 移除 WebView 相关的代码
  - [x] SubTask 10.2: 修改 8 个功能入口的 onTap，使用应用内路由
  - [x] SubTask 10.3: 删除未使用的 `_openForumWebView` 和 `_buildForumActivityUrl` 方法

- [x] Task 11: 验证功能实现: 验证所有页面都能正确导航和显示
  - [x] SubTask 11.1: 检查路由配置是否正确
  - [x] SubTask 11.2: 验证页面导航是否正常
  - [x] SubTask 11.3: 检查代码是否有错误

# Task Dependencies
- Tasks 1-8 可以并行执行
- Task 9 依赖于 Tasks 1-8
- Task 10 依赖于 Task 9
- Task 11 依赖于 Task 10
