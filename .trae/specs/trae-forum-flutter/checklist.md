# TRAE 论坛 Discourse API 对接验收检查清单

**最后更新**: 2026-04-23
**规格版本**: Discourse API 对接版

---

## 第一阶段：Discourse API 适配层

### Task 1: 创建 Discourse 数据模型
- [ ] `lib/data/models/discourse/discourse_topic.dart` 创建完成
  - [ ] DiscourseTopic 模型定义正确
  - [ ] DiscourseTopicListResponse 模型定义正确
  - [ ] 所有字段与 Discourse API 响应匹配
- [ ] `lib/data/models/discourse/discourse_post.dart` 创建完成
  - [ ] DiscoursePost 模型定义正确
  - [ ] DiscoursePostListResponse 模型定义正确
- [ ] `lib/data/models/discourse/discourse_category.dart` 创建完成
  - [ ] DiscourseCategory 模型定义正确
  - [ ] DiscourseCategoryListResponse 模型定义正确
- [ ] `lib/data/models/discourse/discourse_user.dart` 创建完成
  - [ ] DiscourseUser 模型定义正确
  - [ ] DiscourseUserSummary 模型定义正确
- [ ] `lib/data/models/discourse/discourse_search_result.dart` 创建完成
- [ ] 运行 `build_runner` 生成 .g.dart 文件成功
- [ ] JSON 序列化/反序列化测试通过

### Task 2: 创建数据适配器
- [ ] `lib/data/adapters/discourse_adapter.dart` 创建完成
  - [ ] 定义适配器接口
- [ ] `lib/data/adapters/topic_adapter.dart` 创建完成
  - [ ] `adaptTopicToFeed()` 方法实现正确
  - [ ] posters 到 userInfo 映射正确
  - [ ] 时间格式转换正确（ISO 8601 → Unix 时间戳）
  - [ ] 标签映射正确
  - [ ] 边界情况处理（null 值、空字段）
- [ ] `lib/data/adapters/post_adapter.dart` 创建完成
  - [ ] `adaptPostToReply()` 方法实现正确
  - [ ] HTML 内容处理正确
  - [ ] 楼层信息映射正确
  - [ ] 回复关系映射正确
- [ ] `lib/data/adapters/category_adapter.dart` 创建完成
  - [ ] `adaptCategory()` 方法实现正确
  - [ ] 颜色值映射正确
  - [ ] 父分类关系处理正确
- [ ] `lib/data/adapters/user_adapter.dart` 创建完成
  - [ ] `adaptUser()` 方法实现正确
  - [ ] 头像 URL 模板解析正确
  - [ ] 用户等级映射正确

### Task 3: 更新 API 配置
- [ ] `lib/config/constants.dart` 修改完成
  - [ ] `baseUrl` 更新为 `https://forum.trae.cn`
  - [ ] `cdnUrl` 配置添加正确
  - [ ] Discourse API 路径常量定义正确
- [ ] Dio 配置验证通过
  - [ ] 基础 URL 配置正确
  - [ ] 超时配置合理
  - [ ] 拦截器工作正常

---

## 第二阶段：API Service 重构

### Task 4: 实现 Discourse API 服务
- [ ] `lib/core/network/discourse_api_service.dart` 创建完成
  - [ ] `getLatestTopics()` 方法实现正确
    - [ ] 调用 `/latest.json` 端点
    - [ ] 分页参数处理正确
    - [ ] 返回数据解析正确
  - [ ] `getTopicsByCategory()` 方法实现正确
    - [ ] 调用 `/c/{category_id}.json` 端点
    - [ ] 分类 ID 参数传递正确
  - [ ] `getTopicDetail()` 方法实现正确
    - [ ] 调用 `/t/{topic_id}.json` 端点
    - [ ] 话题 ID 参数传递正确
  - [ ] `getTopicPosts()` 方法实现正确
    - [ ] 调用 `/t/{topic_id}/posts.json` 端点
    - [ ] 分页参数处理正确
  - [ ] `getCategories()` 方法实现正确
    - [ ] 调用 `/categories.json` 端点
    - [ ] 返回分类列表正确
  - [ ] `searchTopics()` 方法实现正确
    - [ ] 调用 `/search.json?q={query}` 端点
    - [ ] 搜索关键词编码正确
  - [ ] `getUserInfo()` 方法实现正确
    - [ ] 调用 `/u/{username}.json` 端点
    - [ ] 用户名参数传递正确
- [ ] API 错误处理完善
  - [ ] 网络错误处理
  - [ ] HTTP 错误码处理
  - [ ] 超时处理

### Task 5: 适配现有 ApiService
- [ ] `lib/core/network/api_service.dart` 修改完成
  - [ ] DiscourseApiService 注入正确
  - [ ] `getHomeFeed()` 重写完成
    - [ ] 调用 Discourse API
    - [ ] 使用适配器转换数据
    - [ ] 返回 HomeFeedResponse
  - [ ] `getFeedContent()` 重写完成
    - [ ] 调用 Discourse API
    - [ ] 使用适配器转换数据
    - [ ] 返回 FeedContentResponse
  - [ ] `getFeedContentReply()` 重写完成
    - [ ] 调用 Discourse API
    - [ ] 使用适配器转换数据
    - [ ] 返回 TotalReplyResponse
  - [ ] `getSearch()` 重写完成
    - [ ] 调用 Discourse API
    - [ ] 使用适配器转换数据
  - [ ] `getUserSpace()` 重写完成
    - [ ] 调用 Discourse API
    - [ ] 使用适配器转换数据
  - [ ] 数据格式转换正确
  - [ ] 错误处理完善

---

## 第三阶段：数据仓库更新

### Task 6: 更新 FeedRepository
- [ ] `lib/data/repositories/feed_repository.dart` 修改完成
  - [ ] `getHomeFeed()` 更新完成
    - [ ] 调用新 API 服务
    - [ ] 错误处理完善
    - [ ] 缓存策略合理
  - [ ] `getFeedContent()` 更新完成
  - [ ] `getFeedContentReply()` 更新完成
  - [ ] `getTopicsByCategory()` 添加完成
  - [ ] 单元测试通过

### Task 7: 更新 UserRepository
- [ ] `lib/data/repositories/user_repository.dart` 修改完成
  - [ ] `getUserSpace()` 更新完成
  - [ ] `getProfile()` 更新完成
  - [ ] 登录相关方法更新（如需要）
  - [ ] 单元测试通过

### Task 8: 更新 SearchRepository
- [ ] `lib/data/repositories/search_repository.dart` 修改完成
  - [ ] `getSearch()` 更新完成
  - [ ] `getSearchTag()` 更新完成
  - [ ] 单元测试通过

### Task 9: 更新其他 Repository
- [ ] `lib/data/repositories/topic_repository.dart` 修改完成
- [ ] `lib/data/repositories/message_repository.dart` 修改完成
- [ ] `lib/data/repositories/comment_repository.dart` 修改完成

---

## 第四阶段：验证与测试

### Task 10: 单元测试 - 适配器
- [ ] `test/adapters/topic_adapter_test.dart` 创建完成
  - [ ] Topic 到 Feed 映射测试通过
  - [ ] 边界情况测试通过
- [ ] `test/adapters/post_adapter_test.dart` 创建完成
  - [ ] Post 到 Reply 映射测试通过
- [ ] `test/adapters/category_adapter_test.dart` 创建完成
- [ ] `test/adapters/user_adapter_test.dart` 创建完成
- [ ] 所有适配器测试通过率 100%

### Task 11: 单元测试 - API Service
- [ ] `test/network/discourse_api_service_test.dart` 创建完成
  - [ ] API 调用测试通过
  - [ ] 错误处理测试通过
  - [ ] Mock 数据测试通过
- [ ] 所有 API Service 测试通过率 100%

### Task 12: 集成测试
- [ ] `integration_test/app_test.dart` 更新完成
  - [ ] 首页加载话题列表测试通过
  - [ ] 话题详情页加载测试通过
  - [ ] 分类筛选测试通过
  - [ ] 搜索功能测试通过
- [ ] 所有集成测试通过率 100%

### Task 13: 手动验证
- [ ] 首页话题列表从 Discourse API 加载正常
  - [ ] 列表展示正确
  - [ ] 分页加载正常
  - [ ] 下拉刷新正常
  - [ ] 上拉加载更多正常
- [ ] 话题详情页展示正确
  - [ ] 标题显示正确
  - [ ] 内容显示正确
  - [ ] 作者信息显示正确
  - [ ] 标签显示正确
- [ ] 评论/回复列表加载正常
  - [ ] 回复列表展示正确
  - [ ] 楼层信息显示正确
  - [ ] 点赞数显示正确
- [ ] 分类列表和筛选正常
  - [ ] 分类列表加载正确
  - [ ] 分类筛选功能正常
  - [ ] 分类颜色显示正确
- [ ] 搜索功能正常
  - [ ] 搜索结果加载正确
  - [ ] 搜索关键词匹配正确
- [ ] 用户信息加载正常
  - [ ] 用户资料加载正确
  - [ ] 用户头像加载正确
- [ ] 图片加载正常
  - [ ] 头像图片加载正确
  - [ ] 封面图片加载正确
  - [ ] 图片缓存正常工作

---

## 最终验收标准

### 功能完整性
- [ ] 首页 Feed 列表从 Discourse API 加载正常
- [ ] 话题详情页从 Discourse API 加载正常
- [ ] 评论/回复列表从 Discourse API 加载正常
- [ ] 分类列表从 Discourse API 加载正常
- [ ] 搜索功能调用 Discourse API 正常
- [ ] 用户信息从 Discourse API 加载正常

### 数据映射正确性
- [ ] Discourse Topic 正确映射到 HomeFeedData
- [ ] Discourse Post 正确映射到 ReplyData
- [ ] Discourse Category 正确映射到分类模型
- [ ] Discourse User 正确映射到 UserInfo

### 性能要求
- [ ] API 响应时间 < 2 秒
- [ ] 列表滑动流畅（帧率 > 50fps）
- [ ] 图片加载流畅，无闪烁
- [ ] 应用启动时间 < 3 秒

### 兼容性
- [ ] 保留所有现有 UI 组件功能
- [ ] 保留所有现有页面功能
- [ ] 保留所有现有状态管理功能
- [ ] 现有测试用例通过

### 代码质量
- [ ] 代码结构清晰
- [ ] 函数级注释完整
- [ ] 无严重代码警告
- [ ] 测试覆盖率 > 60%

---

## 当前项目状态总结

### 已完成 ✅
- 项目基础框架搭建
- UI 组件开发
- 页面结构实现
- 状态管理配置

### 进行中 🔄
- Discourse API 对接规格制定

### 待开始 ⏳
- Discourse 数据模型创建
- 数据适配器实现
- API Service 重构
- Repository 更新
- 测试验证

### 重要提醒 ⚠️
1. **API 配置**: 需要将 `baseUrl` 从酷安 API 改为 Discourse API
2. **数据映射**: Discourse 数据格式与现有模型差异较大，需要仔细设计适配器
3. **用户系统**: Discourse 认证方式可能与现有不同，需要重新设计
4. **图片加载**: Discourse 头像使用 URL 模板，需要特殊处理

### 实际进度估算
- **第一阶段**: 0% 完成
- **第二阶段**: 0% 完成
- **第三阶段**: 0% 完成
- **第四阶段**: 0% 完成

**总体完成度**: ~5% (规格制定阶段)
