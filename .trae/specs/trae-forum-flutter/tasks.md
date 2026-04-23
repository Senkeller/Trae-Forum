# TRAE 论坛 Discourse API 对接任务清单

## 第一阶段：Discourse API 适配层

### Task 1: 创建 Discourse 数据模型
**描述**: 创建 Discourse API 原始数据模型，用于接收 API 响应
- [ ] 创建 `lib/data/models/discourse/discourse_topic.dart` - Discourse Topic 原始模型
- [ ] 创建 `lib/data/models/discourse/discourse_post.dart` - Discourse Post 原始模型
- [ ] 创建 `lib/data/models/discourse/discourse_category.dart` - Discourse Category 原始模型
- [ ] 创建 `lib/data/models/discourse/discourse_user.dart` - Discourse User 原始模型
- [ ] 创建 `lib/data/models/discourse/discourse_search_result.dart` - 搜索结果模型
- [ ] 运行 `build_runner` 生成代码

### Task 2: 创建数据适配器
**描述**: 创建适配器将 Discourse 数据格式转换为现有应用数据格式
- [ ] 创建 `lib/data/adapters/discourse_adapter.dart` - 主适配器接口
- [ ] 创建 `lib/data/adapters/topic_adapter.dart` - Topic → Feed 适配
  - [ ] 实现 `adaptTopicToFeed()` 方法
  - [ ] 处理 posters 到 userInfo 的映射
  - [ ] 处理时间格式转换
  - [ ] 处理标签映射
- [ ] 创建 `lib/data/adapters/post_adapter.dart` - Post → Reply 适配
  - [ ] 实现 `adaptPostToReply()` 方法
  - [ ] 处理 HTML 内容
  - [ ] 处理楼层信息
- [ ] 创建 `lib/data/adapters/category_adapter.dart` - Category 适配
  - [ ] 实现 `adaptCategory()` 方法
  - [ ] 处理颜色映射
- [ ] 创建 `lib/data/adapters/user_adapter.dart` - User 适配
  - [ ] 实现 `adaptUser()` 方法
  - [ ] 处理头像 URL 模板

### Task 3: 更新 API 配置
**描述**: 修改 API 基础配置指向 Discourse 论坛
- [ ] 修改 `lib/config/constants.dart`
  - [ ] 更新 `baseUrl` 为 `https://forum.trae.cn`
  - [ ] 添加 `cdnUrl` 配置
  - [ ] 添加 Discourse API 路径常量
- [ ] 验证 Dio 配置支持 Discourse API

## 第二阶段：API Service 重构

### Task 4: 实现 Discourse API 服务
**描述**: 创建新的 API 服务类调用 Discourse 端点
- [ ] 创建 `lib/core/network/discourse_api_service.dart`
  - [ ] 实现 `getLatestTopics()` - 获取最新话题
  - [ ] 实现 `getTopicsByCategory()` - 按分类获取话题
  - [ ] 实现 `getTopicDetail()` - 获取话题详情
  - [ ] 实现 `getTopicPosts()` - 获取话题回复
  - [ ] 实现 `getCategories()` - 获取分类列表
  - [ ] 实现 `searchTopics()` - 搜索话题
  - [ ] 实现 `getUserInfo()` - 获取用户信息

### Task 5: 适配现有 ApiService
**描述**: 修改现有 ApiService 使用 Discourse 适配器
- [ ] 修改 `lib/core/network/api_service.dart`
  - [ ] 注入 DiscourseApiService
  - [ ] 重写 `getHomeFeed()` 调用 Discourse API
  - [ ] 重写 `getFeedContent()` 调用 Discourse API
  - [ ] 重写 `getFeedContentReply()` 调用 Discourse API
  - [ ] 重写 `getSearch()` 调用 Discourse API
  - [ ] 重写 `getUserSpace()` 调用 Discourse API
  - [ ] 使用适配器转换数据格式

## 第三阶段：数据仓库更新

### Task 6: 更新 FeedRepository
**描述**: 更新 Feed 仓库使用新的 API 服务
- [ ] 修改 `lib/data/repositories/feed_repository.dart`
  - [ ] 更新 `getHomeFeed()` 方法
  - [ ] 更新 `getFeedContent()` 方法
  - [ ] 更新 `getFeedContentReply()` 方法
  - [ ] 添加 `getTopicsByCategory()` 方法
  - [ ] 添加错误处理

### Task 7: 更新 UserRepository
**描述**: 更新用户仓库使用 Discourse 用户 API
- [ ] 修改 `lib/data/repositories/user_repository.dart`
  - [ ] 更新 `getUserSpace()` 方法
  - [ ] 更新 `getProfile()` 方法
  - [ ] 更新登录相关方法（如需要）

### Task 8: 更新 SearchRepository
**描述**: 更新搜索仓库使用 Discourse 搜索 API
- [ ] 修改 `lib/data/repositories/search_repository.dart`
  - [ ] 更新 `getSearch()` 方法
  - [ ] 更新 `getSearchTag()` 方法

### Task 9: 更新其他 Repository
**描述**: 更新其他仓库适配 Discourse API
- [ ] 修改 `lib/data/repositories/topic_repository.dart`
- [ ] 修改 `lib/data/repositories/message_repository.dart`
- [ ] 修改 `lib/data/repositories/comment_repository.dart`

## 第四阶段：验证与测试

### Task 10: 单元测试 - 适配器
**描述**: 测试数据适配器正确性
- [ ] 创建 `test/adapters/topic_adapter_test.dart`
  - [ ] 测试 Topic 到 Feed 的映射
  - [ ] 测试边界情况（空字段、null 值）
- [ ] 创建 `test/adapters/post_adapter_test.dart`
  - [ ] 测试 Post 到 Reply 的映射
- [ ] 创建 `test/adapters/category_adapter_test.dart`
- [ ] 创建 `test/adapters/user_adapter_test.dart`

### Task 11: 单元测试 - API Service
**描述**: 测试 API 服务
- [ ] 创建 `test/network/discourse_api_service_test.dart`
  - [ ] 测试 API 调用
  - [ ] 测试错误处理
  - [ ] 使用 mock 数据测试

### Task 12: 集成测试
**描述**: 测试完整数据流
- [ ] 更新 `integration_test/app_test.dart`
  - [ ] 测试首页加载话题列表
  - [ ] 测试话题详情页加载
  - [ ] 测试分类筛选
  - [ ] 测试搜索功能

### Task 13: 手动验证
**描述**: 手动验证应用功能
- [ ] 验证首页话题列表从 Discourse API 加载
- [ ] 验证话题详情页展示正确
- [ ] 验证评论/回复列表加载
- [ ] 验证分类列表和筛选
- [ ] 验证搜索功能
- [ ] 验证用户信息加载
- [ ] 验证图片加载（头像、封面）

## 任务依赖关系

```
第一阶段 (适配层)
├── Task 1 → Task 2
└── Task 3 → Task 4

第二阶段 (API Service)
├── Task 1, Task 2, Task 3 → Task 4
└── Task 4 → Task 5

第三阶段 (Repository)
├── Task 5 → Task 6, Task 7, Task 8, Task 9

第四阶段 (测试)
├── Task 2 → Task 10
├── Task 4 → Task 11
├── Task 6, Task 7, Task 8, Task 9 → Task 12, Task 13
```

## 关键里程碑

| 阶段 | 里程碑 | 状态 |
|------|--------|------|
| 第一阶段 | Discourse 数据模型和适配器完成 | ⏳ 待开始 |
| 第二阶段 | API Service 重构完成，可调用 Discourse API | ⏳ 待开始 |
| 第三阶段 | 所有 Repository 更新完成 | ⏳ 待开始 |
| 第四阶段 | 应用可正常浏览论坛内容 | ⏳ 待开始 |
