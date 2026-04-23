# TRAE 论坛 Flutter 应用 - Discourse API 对接规格文档

## 项目概述

基于现有 Flutter 项目结构，对接 TRAE 官方中文社区论坛 (`https://forum.trae.cn/`) 的 Discourse API，将论坛网站原生化为 Flutter 应用。

**核心原则**: 保留当前项目的 UI 组件、页面结构和状态管理模式，仅替换数据层为 Discourse API 适配器。

---

## 参考来源分析

### 1. TRAE 论坛技术栈

- **论坛软件**: Discourse (开源论坛软件)
- **前端框架**: Ember.js
- **CDN**: `trae-forum-cdn.trae.com.cn`
- **API 基础**: RESTful API (Discourse 标准)

### 2. 论坛分类结构 (基于 MCP 分析)

| ID | 名称 | 描述 | 主题数 | 帖子数 | 颜色 |
|----|------|------|--------|--------|------|
| 4 | 官方公告 | TRAE 官方通知、产品更新、模型更新、政策公告 | 5 | 347 | #BF1E2E |
| 7 | 帮助与支持 | 问题解答、技术支持 | 909 | 5618 | #3AB54A |
| 8 | 产品建议 | 功能建议、使用场景 | 737 | 2709 | #25AAE2 |
| 9 | 技巧分享 | 使用技巧、经验分享 | 319 | 1599 | #12A89D |
| 10 | 案例与作品 | 项目展示、作品分享 | 231 | 1146 | #9EB83B |
| 11 | 互动交流 | 开放讨论区 | 3178 | 15572 | #F1592A |
| 29 | 福利活动 | 社区活动、福利发放 | 10 | 12868 | #8C6238 |
| 33 | 社区伙伴 | 合作伙伴、社区生态 | 7 | 150 | #92278F |
| 35 | SOLO挑战赛专区 | 作品提交区 | 1531 | 4106 | #0088CC |

**子分类**:
- Bug 反馈 (ID: 22) - 619主题, 4298帖子
- 使用咨询 (ID: 23) - 273主题, 1637帖子
- 产品订阅问题 (ID: 24) - 183主题, 1206帖子
- 项目实战 (ID: 25) - 48主题, 306帖子
- 作品分享 (ID: 26) - 53主题, 232帖子
- 本周精选 (ID: 31) - 6主题, 34帖子
- 共学直播 (ID: 32) - 7主题, 12帖子

### 3. 标签系统
- SOLO赛事速递
- 新SOLO初体验
- 新人必看
- featured (精选)
- Code-with-SOLO
- Hello-AI-科技致善
- More-than-Codin

### 4. Discourse API 端点

```
# 获取分类列表
GET /categories.json

# 获取话题列表
GET /latest.json
GET /c/{category_id}.json
GET /c/{category_slug}/{category_id}.json

# 获取话题详情
GET /t/{topic_id}.json
GET /t/{topic_slug}/{topic_id}.json

# 获取帖子 (回复)
GET /t/{topic_id}/posts.json

# 搜索
GET /search.json?q={query}

# 用户信息
GET /u/{username}.json
GET /u/{username}/summary.json

# 通知/消息
GET /notifications.json

# 创建话题 (需要认证)
POST /posts

# 创建回复 (需要认证)
POST /posts
```

### 5. 数据结构映射

**Discourse Topic → 现有 Feed 模型**:
```javascript
// Discourse Topic
{
  id: 4988,
  title: "帖子标题",
  category_id: 35,
  posts_count: 86,
  views: 3600,
  like_count: 249,
  created_at: "2026-04-02T10:00:00.000Z",
  last_posted_at: "2026-04-23T15:30:00.000Z",
  pinned: true,
  visible: true,
  closed: false,
  archived: false,
  tags: ["SOLO赛事速递", "featured"],
  vote_count: 249,
  posters: [...], // 参与者列表
  details: {
    created_by: { username, avatar_template },
    last_poster: { username, avatar_template }
  }
}

// 映射到现有 HomeFeedData
{
  id: "4988",
  entityType: "feed",
  title: "帖子标题",
  message: "帖子内容摘要",
  username: "作者名",
  userAvatar: "头像URL",
  replynum: 86,
  view_count: 3600,
  likenum: "249",
  dateline: 时间戳,
  tags: ["SOLO赛事速递", "featured"],
  category_id: 35
}
```

**Discourse Post → 现有 ReplyData 模型**:
```javascript
// Discourse Post
{
  id: 12345,
  post_number: 1, // 楼层
  username: "TRAE-小阳",
  avatar_template: "/user_avatar/forum.trae.cn/{username}/{size}/{avatar_id}.png",
  created_at: "2026-04-02T10:00:00.000Z",
  cooked: "<p>HTML内容</p>", // 富文本内容
  like_count: 10,
  reply_count: 5,
  reads: 100,
  reply_to_post_number: null // 回复哪一楼
}

// 映射到现有 ReplyData
{
  id: "12345",
  uid: "用户ID",
  username: "TRAE-小阳",
  message: "HTML内容",
  dateline: 时间戳,
  like_count: 10,
  reply_count: 5
}
```

---

## 技术栈 (保留现有)

- **框架**: Flutter 3.x
- **语言**: Dart
- **状态管理**: Riverpod
- **网络请求**: Dio
- **本地存储**: Hive CE + SharedPreferences
- **图片加载**: CachedNetworkImage
- **路由管理**: GoRouter
- **代码生成**: build_runner, freezed, json_serializable

---

## ADDED Requirements

### Requirement: Discourse API 适配层

系统 SHALL 提供 Discourse API 的完整适配层，将论坛数据映射到现有数据模型。

#### Scenario: 获取话题列表
- **WHEN** 用户打开首页
- **THEN** 应用 SHALL 调用 Discourse `/latest.json` 或 `/c/{id}.json` API
- **AND** 将返回数据映射到 `HomeFeedResponse` 模型
- **AND** 在 Feed 列表中展示

#### Scenario: 获取话题详情
- **WHEN** 用户点击话题卡片
- **THEN** 应用 SHALL 调用 Discourse `/t/{id}.json` API
- **AND** 将返回数据映射到 `FeedContentResponse` 模型
- **AND** 展示话题完整内容和回复列表

#### Scenario: 获取回复列表
- **WHEN** 用户查看话题详情
- **THEN** 应用 SHALL 调用 Discourse `/t/{id}/posts.json` API
- **AND** 将返回数据映射到 `TotalReplyResponse` 模型
- **AND** 展示评论/回复列表

#### Scenario: 获取分类列表
- **WHEN** 应用启动或用户切换分类
- **THEN** 应用 SHALL 调用 Discourse `/categories.json` API
- **AND** 将返回数据映射到现有分类模型
- **AND** 在首页 Tab 中展示分类

#### Scenario: 搜索话题
- **WHEN** 用户在搜索页输入关键词
- **THEN** 应用 SHALL 调用 Discourse `/search.json?q={query}` API
- **AND** 将返回数据映射到 `HomeFeedResponse` 模型
- **AND** 展示搜索结果

### Requirement: 数据模型适配

系统 SHALL 保持现有数据模型不变，通过适配器将 Discourse 数据格式转换为现有格式。

#### Scenario: Topic 到 Feed 的映射
- **GIVEN** Discourse Topic JSON 数据
- **WHEN** 数据到达应用层
- **THEN** 适配器 SHALL 提取字段并映射到 `HomeFeedData`
- **AND** 处理字段差异（如 posters → userInfo）

#### Scenario: Post 到 Reply 的映射
- **GIVEN** Discourse Post JSON 数据
- **WHEN** 数据到达应用层
- **THEN** 适配器 SHALL 提取字段并映射到 `ReplyData`
- **AND** 处理 HTML 内容渲染

### Requirement: 用户系统适配

系统 SHALL 对接 Discourse 用户系统，支持登录、用户信息获取等功能。

#### Scenario: 用户登录
- **WHEN** 用户使用 Discourse 账号登录
- **THEN** 应用 SHALL 调用 Discourse 认证 API
- **AND** 存储用户 Session
- **AND** 更新应用登录状态

#### Scenario: 获取用户信息
- **WHEN** 应用需要展示用户信息
- **THEN** 应用 SHALL 调用 Discourse `/u/{username}.json` API
- **AND** 将数据映射到 `UserInfo` 模型

---

## MODIFIED Requirements

### Requirement: API 基础配置

**原配置**: 酷安 API (`api.coolapk.com`)

**修改为**: TRAE 论坛 Discourse API (`https://forum.trae.cn`)

```dart
// lib/config/constants.dart
class AppConstants {
  // 原配置
  // static const String baseUrl = 'https://api.coolapk.com';
  
  // 新配置
  static const String baseUrl = 'https://forum.trae.cn';
  static const String forumUrl = 'https://forum.trae.cn';
  static const String cdnUrl = 'https://trae-forum-cdn.trae.com.cn';
}
```

### Requirement: API Service 实现

**原实现**: 酷安 API 接口 (`/v6/main/indexV8`, `/v6/feed/detail` 等)

**修改为**: Discourse API 接口适配

```dart
// lib/core/network/api_service.dart
class ApiService {
  // 原接口
  // Future<HomeFeedResponse> getHomeFeed({...})
  
  // 新接口 - 适配 Discourse
  Future<HomeFeedResponse> getLatestTopics({int page = 0});
  Future<HomeFeedResponse> getTopicsByCategory(int categoryId, {int page = 0});
  Future<FeedContentResponse> getTopicDetail(int topicId);
  Future<TotalReplyResponse> getTopicPosts(int topicId, {int page = 0});
  Future<dynamic> getCategories();
  Future<HomeFeedResponse> searchTopics(String query);
}
```

---

## 项目结构 (保留现有)

```
lib/
├── main.dart                          # 应用入口 (不变)
├── app.dart                           # 应用配置 (不变)
├── config/                            # 配置文件
│   ├── constants.dart                 # 修改: API URL 改为 Discourse
│   ├── routes.dart                    # 不变
│   └── theme.dart                     # 不变
├── core/                              # 核心功能
│   ├── network/                       # 网络层
│   │   ├── dio_client.dart            # 不变
│   │   ├── api_service.dart           # 修改: 适配 Discourse API
│   │   └── interceptors/              # 不变
│   ├── storage/                       # 本地存储 (不变)
│   └── utils/                         # 工具类 (不变)
├── data/                              # 数据层
│   ├── models/                        # 数据模型 (不变)
│   │   ├── user.dart                  # 不变
│   │   ├── feed.dart                  # 不变
│   │   ├── comment.dart               # 不变
│   │   └── ...                        # 不变
│   └── repositories/                  # 数据仓库
│       ├── feed_repository.dart       # 修改: 使用 Discourse API
│       ├── user_repository.dart       # 修改: 使用 Discourse API
│       └── ...                        # 相应修改
├── presentation/                      # 表现层 (基本不变)
│   ├── providers/                     # 状态管理 (不变)
│   ├── pages/                         # 页面 (不变)
│   └── widgets/                       # 组件 (不变)
└── data/adapters/                     # 新增: Discourse 数据适配器
    ├── discourse_adapter.dart         # 主适配器
    ├── topic_adapter.dart             # Topic 适配
    ├── post_adapter.dart              # Post 适配
    ├── user_adapter.dart              # User 适配
    └── category_adapter.dart          # Category 适配
```

---

## 开发阶段规划

### 第一阶段：Discourse API 适配层 ⏳ 当前
- [ ] 创建 Discourse API 适配器
- [ ] 实现 Topic → Feed 数据映射
- [ ] 实现 Post → Reply 数据映射
- [ ] 实现 Category 数据映射
- [ ] 实现 User 数据映射

### 第二阶段：API Service 重构
- [ ] 修改 ApiService 使用 Discourse 端点
- [ ] 实现话题列表获取
- [ ] 实现话题详情获取
- [ ] 实现回复列表获取
- [ ] 实现分类列表获取
- [ ] 实现搜索功能

### 第三阶段：数据仓库更新
- [ ] 更新 FeedRepository 使用新 API
- [ ] 更新 UserRepository 使用新 API
- [ ] 更新其他 Repository

### 第四阶段：验证与测试
- [ ] 验证首页话题列表正常加载
- [ ] 验证话题详情页正常展示
- [ ] 验证评论/回复列表正常加载
- [ ] 验证分类筛选功能正常
- [ ] 验证搜索功能正常

---

## 验收标准

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
- [ ] 列表滑动流畅
- [ ] 图片加载正常

### 兼容性
- [ ] 保留所有现有 UI 组件功能
- [ ] 保留所有现有页面功能
- [ ] 保留所有现有状态管理功能
