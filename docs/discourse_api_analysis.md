# TRAE 论坛 Discourse API 分析报告

## 文档信息
- **分析目标**: https://forum.trae.cn/u/{username}/activity/read
- **分析日期**: 2026-04-26
- **API 类型**: Discourse 论坛 API
- **文档用途**: 为「我的」页面浏览历史功能提供 API 参考

---

## 一、用户活动相关 API

### 1.1 获取用户活动列表

| 属性 | 值 |
|------|-----|
| **API端点** | `https://forum.trae.cn/user_actions.json` |
| **请求方法** | GET |
| **认证要求** | 可选（部分数据需登录） |

#### 请求参数

| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| `offset` | Integer | 否 | 分页偏移量，默认为0 |
| `username` | String | 是 | 目标用户名（需URL编码） |
| `filter` | String | 否 | 活动类型过滤，多个类型用逗号分隔 |

#### Filter 类型值

| 值 | 含义 |
|----|------|
| `1` | 点赞的活动 (likes) |
| `4` | 创建的话题 (topics) |
| `5` | 回复/发帖 (posts) |
| `4,5` | 话题和回复组合 |

#### 响应数据结构

```json
{
  "user_actions": [
    {
      "excerpt": "帖子内容摘要",
      "action_type": 5,
      "created_at": "2026-04-25T05:22:20.272Z",
      "avatar_template": "/letter_avatar_proxy/v4/letter/{letter}/{color}/{size}.png",
      "slug": "topic",
      "topic_id": 5,
      "target_user_id": 52589,
      "target_name": "",
      "target_username": "指着月亮念嫦娥",
      "post_number": 241,
      "post_id": 60389,
      "reply_to_post_number": null,
      "username": "指着月亮念嫦娥",
      "name": "",
      "user_id": 52589,
      "acting_username": "指着月亮念嫦娥",
      "acting_name": "",
      "acting_user_id": 52589,
      "title": "📢 社区公告｜欢迎来到 TRAE 官方中文社区！",
      "deleted": false,
      "hidden": false,
      "post_type": 1,
      "action_code": null,
      "category_id": 4,
      "closed": false,
      "archived": false
    }
  ]
}
```

#### 响应字段说明

| 字段名 | 类型 | 说明 |
|--------|------|------|
| `excerpt` | String | 帖子内容摘要 |
| `action_type` | Integer | 活动类型 (1=点赞, 4=创建话题, 5=回复/发帖) |
| `created_at` | String (ISO8601) | 活动时间 |
| `avatar_template` | String | 用户头像模板URL |
| `topic_id` | Integer | 话题ID |
| `post_id` | Integer | 帖子ID |
| `post_number` | Integer | 帖子楼层号 |
| `username` | String | 用户名 |
| `user_id` | Integer | 用户ID |
| `title` | String | 话题标题 |
| `category_id` | Integer | 分类ID |
| `deleted` | Boolean | 是否已删除 |
| `hidden` | Boolean | 是否隐藏 |
| `closed` | Boolean | 是否已关闭 |
| `archived` | Boolean | 是否已归档 |

---

### 1.2 获取用户详细信息

| 属性 | 值 |
|------|-----|
| **API端点** | `https://forum.trae.cn/u/{username}.json` |
| **请求方法** | GET |
| **认证要求** | 可选 |

#### 响应数据结构

```json
{
  "user_badges": [],
  "user": {
    "id": 52589,
    "username": "指着月亮念嫦娥",
    "name": "",
    "avatar_template": "/letter_avatar_proxy/v4/letter/{letter}/{color}/{size}.png",
    "last_posted_at": "2026-04-25T05:22:20.272Z",
    "last_seen_at": "2026-04-25T18:03:55.459Z",
    "created_at": "2026-04-23T00:20:39.875Z",
    "ignored": false,
    "muted": false,
    "trust_level": 1,
    "moderator": false,
    "admin": false,
    "title": "",
    "badge_count": 0,
    "time_read": 3836,
    "recent_time_read": 3836,
    "profile_view_count": 14,
    "gamification_score": 17,
    "accepted_answers": 0,
    "groups": []
  }
}
```

---

## 二、浏览历史 API

### 2.1 获取用户浏览历史

| 属性 | 值 |
|------|-----|
| **API端点** | `https://forum.trae.cn/read.json` |
| **请求方法** | GET |
| **认证要求** | **需要登录** |

#### 错误响应（未登录）

```json
{
  "errors": ["您需要登录才能执行此操作。"],
  "error_type": "not_logged_in"
}
```

> **注意**: 浏览历史 API 需要用户登录后才能访问。对于未登录用户，应用需要在本地存储浏览历史。

---

## 三、项目现有实现分析

### 3.1 当前浏览历史实现

项目当前使用 **本地存储** 方式实现浏览历史功能：

**数据模型** (`lib/data/models/user_activity.dart`):
```dart
@HiveType(typeId: 2)
@freezed
class BrowseHistory with _$BrowseHistory {
  const factory BrowseHistory({
    @HiveField(0) required String id,
    @HiveField(1) required String feedId,
    @HiveField(2) required String uid,
    @HiveField(3) required String username,
    @HiveField(4) required String avatarUrl,
    @HiveField(5) required String deviceTitle,
    @HiveField(6) required String message,
    @HiveField(7) required String dateline,
    @HiveField(8) required DateTime viewedAt,
  }) = _BrowseHistory;
}
```

**仓库实现** (`lib/data/repositories/user_activity_repository.dart`):
- 使用 Hive 本地数据库
- 支持添加、删除、清空浏览历史
- 自动去重（相同 feedId 会更新到最新）

### 3.2 现有 API 服务封装

**DiscourseApiService** (`lib/core/network/discourse_api_service.dart`) 已封装的相关 API:

| 方法 | API 端点 | 说明 |
|------|----------|------|
| `getUserActivity` | `/u/{username}/activity.json` | 获取用户活动 |
| `getUserActivityTopics` | `/u/{username}/activity/topics.json` | 获取用户话题 |
| `getUserActivityReplies` | `/u/{username}/activity/replies.json` | 获取用户回复 |
| `getUserActivityLikes` | `/u/{username}/activity/likes-given.json` | 获取用户点赞 |
| `getUserBookmarks` | `/user_activity_bookmarks.json` | 获取用户书签 |

**ApiService** (`lib/core/network/api_service.dart`) 已封装的方法:

| 方法 | 说明 |
|------|------|
| `getUserActivity` | 获取用户活动列表 |
| `getUserActivityTopics` | 获取用户话题活动 |
| `getUserActivityReplies` | 获取用户回复活动 |
| `getUserActivityLikes` | 获取用户点赞活动 |
| `getUserActivitySolved` | 获取已解决活动 |
| `getUserActivityVotes` | 获取投票活动 |

---

## 四、Action Type 枚举值

用户活动类型 (`action_type`) 的可能值：

| 值 | 含义 |
|----|------|
| 1 | 点赞 (like) |
| 2 | 被点赞/收到回复 |
| 4 | 创建话题 (new topic) |
| 5 | 发帖/回复 (post/reply) |
| 6 | 被回复 |

---

## 五、API 调用示例

### 5.1 获取用户活动（话题和回复）

```
GET https://forum.trae.cn/user_actions.json?offset=0&username=%E6%8C%87%E7%9D%80%E6%9C%88%E4%BA%AE%E5%BF%B5%E5%AB%A6%E5%A8%A5&filter=4,5
```

### 5.2 获取用户详细信息

```
GET https://forum.trae.cn/u/%E6%8C%87%E7%9D%80%E6%9C%88%E4%BA%AE%E5%BF%B5%E5%AB%A6%E5%A8%A5.json
```

### 5.3 获取用户浏览历史（需登录）

```
GET https://forum.trae.cn/read.json
```

---

## 六、注意事项

1. **编码要求**: 用户名中包含中文字符时需要进行URL编码
2. **认证限制**: 部分API（如浏览历史 `/read.json`）需要登录才能访问
3. **分页机制**: 使用 `offset` 参数进行分页，默认每页返回约30条记录
4. **错误处理**: 错误响应包含 `errors` 数组和 `error_type` 字段
5. **时间格式**: 所有时间字段使用 ISO8601 格式 (UTC)

---

## 七、与项目现有功能的关联

### 7.1 「我的」页面常用功能

当前 `ProfilePageNew` 中定义的快捷功能入口：

| 功能 | 路由 | 登录要求 | 实现方式 |
|------|------|----------|----------|
| 本地收藏 | `/local-favorites` | 否 | Hive 本地存储 |
| **浏览历史** | `/browse-history` | 否 | **Hive 本地存储** |
| 我常去 | `/frequently-visited` | 否 | Hive 本地存储 |
| 我的收藏 | `/favorites` | 是 | Discourse API |
| 我的赞 | `/my-likes` | 是 | Discourse API |
| 我的回复 | `/my-replies` | 是 | Discourse API |

### 7.2 已完成的改进

#### 7.2.1 浏览历史自动记录功能

已在 `FeedDetailPage` 中实现浏览历史自动记录功能：

**实现位置**: `lib/presentation/pages/feed/feed_detail_page.dart`

**核心代码**:
```dart
/// 记录浏览历史
///
/// 当用户查看帖子详情时，将帖子信息保存到本地浏览历史
/// [topicDetail] 帖子详情数据
Future<void> _recordBrowseHistory(FeedContentData topicDetail) async {
  try {
    final userInfo = topicDetail.userInfo;
    if (userInfo == null) return;

    await ref.read(browseHistoriesProvider.notifier).addHistory(
      feedId: widget.feedId,
      uid: userInfo.uid,
      username: userInfo.username,
      avatarUrl: userInfo.avatar ?? '',
      deviceTitle: topicDetail.title ?? '',
      message: topicDetail.message.isNotEmpty
          ? topicDetail.message.substring(
              0,
              topicDetail.message.length > 100
                  ? 100
                  : topicDetail.message.length,
            )
          : '',
      dateline: topicDetail.dateline,
    );
  } catch (e) {
    // 记录浏览历史失败不应影响用户体验，静默处理
    debugPrint('记录浏览历史失败: $e');
  }
}
```

**触发时机**: 在 `_loadInitialData()` 方法中，当帖子详情加载成功后调用 `_recordBrowseHistory()` 记录浏览历史。

**功能特点**:
1. **自动记录**: 用户查看帖子详情时自动记录到本地浏览历史
2. **数据去重**: 相同的帖子会自动更新到最新时间（通过 `user_activity_repository.dart` 中的 `addBrowseHistory` 方法实现）
3. **容错处理**: 记录失败时静默处理，不影响用户体验
4. **数据截断**: 过长的内容会自动截断到100个字符，避免存储过多数据

### 7.3 建议的后续改进方向

1. **浏览历史同步**: 对于已登录用户，可以考虑将本地浏览历史与服务器端 `/read.json` 数据合并
2. **跨设备同步**: 登录用户的浏览历史可以通过 Discourse API 实现跨设备同步
3. **数据增强**: 可以从 `user_actions.json` API 获取更丰富的活动数据，增强浏览历史的展示效果
4. **浏览历史上限**: 可以添加浏览历史数量上限，自动清理旧的历史记录

---

## 八、参考文件

- API 服务: `lib/core/network/discourse_api_service.dart`
- API 封装: `lib/core/network/api_service.dart`
- 数据模型: `lib/data/models/user_activity.dart`
- 数据仓库: `lib/data/repositories/user_activity_repository.dart`
- 浏览历史页面: `lib/presentation/pages/user/browse_history_page.dart`
- 我的页面: `lib/presentation/pages/user/profile_page_new.dart`
