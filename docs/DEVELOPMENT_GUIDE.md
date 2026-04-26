# TRAE Forum 开发指南

## 目录

1. [项目概述](#项目概述)
2. [API接口文档](#api接口文档)
3. [登录模块](#登录模块)
4. [Feed模块](#feed模块)
5. [评论模块](#评论模块)
6. [Banner模块](#banner模块)
7. [开发工具与命令](#开发工具与命令)

## 项目概述

TRAE Forum 是一款基于 Flutter 开发的 Discourse 社区客户端应用，提供话题浏览、搜索、用户互动等功能。

### 技术栈

- **Flutter**: 3.10+
- **Dart**: 3.0+
- **状态管理**: flutter_riverpod
- **网络请求**: dio + dio_cookie_manager
- **本地存储**: hive_ce + shared_preferences
- **路由管理**: go_router

### 项目结构

```
lib/
├── config/          # 配置文件
├── core/            # 核心功能
│   ├── network/     # 网络层
│   ├── services/    # 核心服务
│   └── utils/       # 工具类
├── data/            # 数据层
│   ├── models/      # 数据模型
│   ├── repositories/ # 数据仓库
│   └── adapters/    # 数据适配器
└── presentation/    # 表现层
    ├── pages/       # 页面
    ├── widgets/     # 组件
    └── providers/   # 状态提供者
```

## API接口文档

### DiscourseApiService

位置：`lib/core/network/discourse_api_service.dart`

这是核心API服务类，封装了与Discourse论坛的所有接口通信。

#### 话题相关

##### 获取最新话题

```dart
Future<Response> getLatestTopics({int page = 0})
```

- **API路径**: `GET /latest.json`
- **参数**: 
  - `page`: 分页页码，从0开始
- **返回**: 话题列表响应

##### 获取分类话题

```dart
Future<Response> getTopicsByCategory(int categoryId, {int page = 0})
```

- **API路径**: `GET /c/{categoryId}.json`
- **参数**:
  - `categoryId`: 分类ID
  - `page`: 分页页码
- **返回**: 分类下的话题列表

##### 获取话题详情

```dart
Future<Response> getTopicDetail(int topicId)
```

- **API路径**: `GET /t/{topicId}.json`
- **参数**:
  - `topicId`: 话题ID
- **返回**: 话题详细信息

##### 获取话题帖子

```dart
Future<Response> getTopicPosts(int topicId, {int page = 0})
```

- **API路径**: `GET /t/{topicId}/posts.json`
- **参数**:
  - `topicId`: 话题ID
  - `page`: 分页页码
- **返回**: 话题下的帖子（评论）列表

#### 搜索相关

##### 基础搜索

```dart
Future<Response> searchTopics(String query)
```

- **API路径**: `GET /search.json`
- **参数**:
  - `query`: 搜索关键词
- **返回**: 搜索结果

##### 高级搜索

```dart
Future<Response> searchAdvanced(SearchRequest request)
```

- **API路径**: `GET /search.json`
- **参数**:
  - `request`: 搜索请求对象，包含完整的搜索参数
- **返回**: 搜索结果

##### 搜索建议

```dart
Future<Response> getSearchSuggestions(String term)
```

- **API路径**: `GET /search/query`
- **参数**:
  - `term`: 输入的关键词前缀
- **返回**: 话题、用户、分类的建议列表

#### 用户相关

##### 获取用户信息

```dart
Future<Response> getUserInfo(String username)
```

- **API路径**: `GET /u/{username}.json`
- **参数**:
  - `username`: 用户名
- **返回**: 用户详细信息

##### 获取当前会话用户

```dart
Future<Response> getCurrentSession()
```

- **API路径**: `GET /session/current.json`
- **返回**: 当前登录用户信息，未登录则返回null

##### 获取用户话题

```dart
Future<Response> getUserTopics(String username, {int page = 0})
```

- **API路径**: `GET /u/{username}/activity/topics.json`
- **参数**:
  - `username`: 用户名
  - `page`: 分页页码
- **返回**: 用户创建的话题列表

##### 获取用户活动

```dart
Future<Response> getUserActivity(String username, {int page = 0})
```

- **API路径**: `GET /u/{username}/activity.json`
- **参数**:
  - `username`: 用户名
  - `page`: 分页页码
- **返回**: 用户活动列表

##### 获取用户话题活动

```dart
Future<Response> getUserActivityTopics(String username, {int page = 0})
```

- **API路径**: `GET /u/{username}/activity/topics.json`
- **参数**:
  - `username`: 用户名
  - `page`: 分页页码
- **返回**: 用户的话题活动

##### 获取用户回复活动

```dart
Future<Response> getUserActivityReplies(String username, {int page = 0})
```

- **API路径**: `GET /u/{username}/activity/replies.json`
- **参数**:
  - `username`: 用户名
  - `page`: 分页页码
- **返回**: 用户的回复活动

##### 获取用户点赞活动

```dart
Future<Response> getUserActivityLikes(String username, {int page = 0})
```

- **API路径**: `GET /u/{username}/activity/likes-given.json`
- **参数**:
  - `username`: 用户名
  - `page`: 分页页码
- **返回**: 用户的点赞活动

##### 获取用户已解决活动

```dart
Future<Response> getUserActivitySolved(String username, {int page = 0})
```

- **API路径**: `GET /u/{username}/activity/solved.json`
- **参数**:
  - `username`: 用户名
  - `page`: 分页页码
- **返回**: 用户的已解决活动

##### 获取用户投票活动

```dart
Future<Response> getUserActivityVotes(String username, {int page = 0})
```

- **API路径**: `GET /u/{username}/activity/votes.json`
- **参数**:
  - `username`: 用户名
  - `page`: 分页页码
- **返回**: 用户的投票活动

##### 获取用户摘要

```dart
Future<Response> getUserSummary(String username)
```

- **API路径**: `GET /u/{username}/summary.json`
- **参数**:
  - `username`: 用户名
- **返回**: 用户摘要信息

#### 热门话题相关

##### 获取热门话题

```dart
Future<Response> getHotTopics({int page = 0})
```

- **API路径**: `GET /hot.json`
- **参数**:
  - `page`: 分页页码
- **返回**: 热门话题列表

##### 获取精选话题

```dart
Future<Response> getTopTopics({int page = 0})
```

- **API路径**: `GET /top.json`
- **参数**:
  - `page`: 分页页码
- **返回**: 精选话题列表

##### 获取新话题

```dart
Future<Response> getNewTopics({int page = 0})
```

- **API路径**: `GET /new.json`
- **参数**:
  - `page`: 分页页码
- **返回**: 新话题列表

#### 标签相关

##### 根据标签获取话题

```dart
Future<Response> getTopicsByTag(String tag, {int page = 0})
```

- **API路径**: `GET /tag/{tag}.json`
- **参数**:
  - `tag`: 标签名称（会进行URL编码）
  - `page`: 分页页码
- **返回**: 标签下的话题列表

#### 通知相关

##### 获取通知列表

```dart
Future<Response> getNotifications({
  int limit = 30,
  bool recent = true,
  bool bumpLastSeen = true,
  String? filterByTypes,
})
```

- **API路径**: `GET /notifications`
- **参数**:
  - `limit`: 返回数量限制，默认30
  - `recent`: 是否只返回最近通知
  - `bumpLastSeen`: 是否更新最后查看时间
  - `filterByTypes`: 通知类型筛选，多个类型用逗号分隔
- **返回**: 通知列表

##### 获取用户菜单私信

```dart
Future<Response> getUserMenuPrivateMessages(String username)
```

- **API路径**: `GET /u/{username}/user-menu-private-messages`
- **参数**:
  - `username`: 用户名
- **返回**: 私信菜单数据

##### 获取用户菜单书签

```dart
Future<Response> getUserMenuBookmarks(String username)
```

- **API路径**: `GET /u/{username}/user-menu-bookmarks`
- **参数**:
  - `username`: 用户名
- **返回**: 书签菜单数据

##### 获取私信话题列表

```dart
Future<Response> getPrivateMessages(String username)
```

- **API路径**: `GET /topics/private-messages/{username}.json`
- **参数**:
  - `username`: 用户名
- **返回**: 私信话题列表

##### 获取私信追踪状态

```dart
Future<Response> getPrivateMessageTrackingState(String username)
```

- **API路径**: `GET /u/{username}/private-message-topic-tracking-state`
- **参数**:
  - `username`: 用户名
- **返回**: 私信追踪状态

##### 标记通知已读

```dart
Future<Response> markNotificationsRead(List<int> notificationIds)
```

- **API路径**: `PUT /notifications/mark-read`
- **参数**:
  - `notificationIds`: 通知ID列表
- **返回**: 操作结果

##### 标记所有通知已读

```dart
Future<Response> markAllNotificationsRead()
```

- **API路径**: `PUT /notifications/mark-read`
- **返回**: 操作结果

##### 删除通知

```dart
Future<Response> deleteNotification(int notificationId)
```

- **API路径**: `DELETE /notifications/{notificationId}`
- **参数**:
  - `notificationId`: 通知ID
- **返回**: 操作结果

#### 帖子/评论相关

##### 创建帖子/评论

```dart
Future<Response> createPost({
  required int topicId,
  required String raw,
  int? replyToPostNumber,
})
```

- **API路径**: `POST /posts`
- **参数**:
  - `topicId`: 话题ID
  - `raw`: 评论内容（Markdown格式）
  - `replyToPostNumber`: 回复的帖子编号（楼中楼回复）
- **返回**: 创建成功的帖子信息
- **认证**: 需要登录
- **注意**: 会自动确保会话准备和CSRF token有效

##### 上传图片

```dart
Future<Response> uploadImage({
  required String filePath,
  String? fileName,
})
```

- **API路径**: `POST /uploads.json`
- **参数**:
  - `filePath`: 本地文件路径
  - `fileName`: 文件名（可选）
- **返回**: 上传结果，包含图片URL
- **认证**: 需要登录
- **注意**: 会尝试两种字段名格式兼容不同Discourse部署

##### 获取帖子详情

```dart
Future<Response> getPostDetail(int postId)
```

- **API路径**: `GET /posts/{postId}.json`
- **参数**:
  - `postId`: 帖子ID
- **返回**: 帖子详细信息，包含点赞状态等

##### 编辑帖子/评论

```dart
Future<Response> editPost({
  required int postId,
  required String raw,
  String? editReason,
})
```

- **API路径**: `PUT /posts/{postId}`
- **参数**:
  - `postId`: 帖子ID
  - `raw`: 新的评论内容（Markdown格式）
  - `editReason`: 编辑原因（可选）
- **返回**: 操作结果
- **认证**: 需要登录

##### 删除帖子/评论

```dart
Future<Response> deletePost({
  required int postId,
  bool forceDestroy = false,
})
```

- **API路径**: `DELETE /posts/{postId}`
- **参数**:
  - `postId`: 帖子ID
  - `forceDestroy`: 是否强制删除（管理员使用）
- **返回**: 操作结果
- **认证**: 需要登录

#### 点赞相关

##### 点赞帖子

```dart
Future<Response> likePost(int postId)
```

- **API路径**: `POST /post_actions`
- **参数**:
  - `postId`: 帖子ID
- **请求体**:
  ```json
  {
    "id": postId,
    "post_action_type_id": 2
  }
  ```
  (post_action_type_id=2表示点赞)
- **返回**: 操作结果
- **认证**: 需要登录

##### 取消点赞帖子

```dart
Future<Response> unlikePost(int postId)
```

- **API路径**: `DELETE /post_actions/{postId}`
- **参数**:
  - `postId`: 帖子ID
- **查询参数**:
  ```json
  {
    "post_action_type_id": 2
  }
  ```
- **返回**: 操作结果
- **认证**: 需要登录

#### 草稿相关

##### 保存草稿

```dart
Future<Response> saveDraft({
  required String draftKey,
  required String data,
  int sequence = 1,
})
```

- **API路径**: `POST /drafts`
- **参数**:
  - `draftKey`: 草稿标识符，如'topic_123'或'new_private_message'
  - `data`: 草稿数据（序列化内容）
  - `sequence`: 草稿序列号，用于版本控制
- **返回**: 操作结果
- **认证**: 需要登录

##### 获取草稿

```dart
Future<Response> getDraft(String draftKey)
```

- **API路径**: `GET /drafts/{draftKey}`
- **参数**:
  - `draftKey`: 草稿标识符
- **返回**: 草稿数据，没有则返回空
- **认证**: 需要登录

##### 删除草稿

```dart
Future<Response> deleteDraft({
  required String draftKey,
  int sequence = 1,
})
```

- **API路径**: `DELETE /drafts/{draftKey}`
- **参数**:
  - `draftKey`: 草稿标识符
  - `sequence`: 草稿序列号
- **返回**: 操作结果
- **认证**: 需要登录

#### 关注/粉丝相关

##### 关注用户

```dart
Future<Response> followUser(String username)
```

- **API路径**: `PUT /u/{username}/follow`
- **参数**:
  - `username`: 要关注的用户名
- **返回**: 操作结果
- **认证**: 需要登录

##### 取消关注用户

```dart
Future<Response> unfollowUser(String username)
```

- **API路径**: `DELETE /u/{username}/follow`
- **参数**:
  - `username`: 要取消关注的用户名
- **返回**: 操作结果
- **认证**: 需要登录

##### 获取用户关注列表

```dart
Future<Response> getUserFollowing(String username)
```

- **API路径**: `GET /u/{username}/following.json`
- **参数**:
  - `username`: 用户名
- **返回**: 用户关注列表

##### 获取用户粉丝列表

```dart
Future<Response> getUserFollowers(String username)
```

- **API路径**: `GET /u/{username}/followers.json`
- **参数**:
  - `username`: 用户名
- **返回**: 用户粉丝列表

#### 创建话题相关

##### 创建新话题

```dart
Future<Response> createTopic({
  required String title,
  required String raw,
  int? category,
  List<String>? tags,
  int? replyToPostNumber,
})
```

- **API路径**: `POST /posts`
- **参数**:
  - `title`: 话题标题
  - `raw`: 话题内容（Markdown格式）
  - `category`: 分类ID（可选）
  - `tags`: 话题标签列表（可选）
  - `replyToPostNumber`: 回复的帖子编号（可选，用于楼中楼回复）
- **返回**: 创建成功的话题信息
- **认证**: 需要登录
- **注意**: 会自动确保会话准备和CSRF token有效

#### 收藏/书签相关

##### 添加话题到书签

```dart
Future<Response> createBookmark({
  required int topicId,
  String bookmarkableType = 'Topic',
  String? reminderAt,
  int autoDeletePreference = 3,
})
```

- **API路径**: `POST /bookmarks.json`
- **参数**:
  - `topicId`: 话题ID
  - `bookmarkableType`: 收藏类型，默认'Topic'
  - `reminderAt`: 提醒时间（可选，ISO8601格式）
  - `autoDeletePreference`: 自动删除偏好，默认3
- **返回**: 操作结果
- **认证**: 需要登录

##### 删除书签

```dart
Future<Response> deleteBookmark(int bookmarkId)
```

- **API路径**: `DELETE /bookmarks/{bookmarkId}.json`
- **参数**:
  - `bookmarkId`: 书签ID
- **返回**: 操作结果
- **认证**: 需要登录

##### 获取当前用户的书签列表

```dart
Future<Response> getUserBookmarks({int page = 0})
```

- **API路径**: `GET /user_activity_bookmarks.json`
- **参数**:
  - `page`: 分页页码，从0开始
- **返回**: 书签列表
- **认证**: 需要登录

##### 更新书签提醒时间

```dart
Future<Response> updateBookmarkReminder({
  required int bookmarkId,
  String? reminderAt,
  int autoDeletePreference = 3,
})
```

- **API路径**: `PUT /bookmarks/{bookmarkId}.json`
- **参数**:
  - `bookmarkId`: 书签ID
  - `reminderAt`: 新的提醒时间（ISO8601格式），传空字符串可清除提醒
  - `autoDeletePreference`: 自动删除偏好
- **返回**: 操作结果
- **认证**: 需要登录

#### 分类相关

##### 获取分类列表

```dart
Future<Response> getCategories()
```

- **API路径**: `GET /categories.json`
- **返回**: 分类列表

### ApiService

位置：`lib/core/network/api_service.dart`

这是高级API服务类，在DiscourseApiService基础上提供了更高级的功能封装。

（注：此文件主要包含getHomeFeed、createPost等高级方法，用于更便捷地处理业务逻辑）

## 登录模块

### 概述

TRAE Forum 采用WebView + Cookie同步的方式实现登录，通过访问TRAE主站登录页面，然后跳转到论坛页面建立会话。

### 核心文件

| 文件 | 位置 | 说明 |
|------|------|------|
| WebViewLoginPage | `lib/presentation/pages/user/webview_login_page.dart` | WebView登录页面 |
| DioClient | `lib/core/network/dio_client.dart` | Dio客户端配置，管理Cookie持久化 |
| NativeCookieBridge | `lib/core/network/native_cookie_bridge.dart` | 原生Cookie桥接 |
| TraeCookieManager | `lib/core/network/cookie_manager.dart` | Cookie管理器 |
| AuthProvider | `lib/presentation/providers/auth_provider.dart` | 认证状态管理 |

### 登录流程

```
┌─────────────┐      ┌──────────────────┐      ┌───────────────┐
│  用户点击登录│────▶│  加载TRAE主站登录 │────▶│  用户输入凭证 │
└─────────────┘      └──────────────────┘      └───────┬───────┘
                                                         │
                                                         ▼
┌─────────────────┐      ┌─────────────────┐      ┌──────────────┐
│  更新登录状态   │◀────│  同步Cookie到Dio │◀────│  跳转到论坛页 │
└────────┬────────┘      └─────────────────┘      └──────────────┘
         │
         ▼
┌─────────────────┐
│  提取用户信息   │
└─────────────────┘
```

### WebViewLoginPage 主要功能

#### 初始化

```dart
void initState() {
  super.initState();
  _initWebView();
}
```

初始化WebView，设置导航委托，加载登录页面。

#### 页面加载完成处理

```dart
Future<void> _checkLoginStatus(String url) async
```

在每次页面加载完成时检查是否登录成功：
1. 检查是否命中论坛SSO回调页
2. 检查是否在论坛普通页面（已登录状态）
3. 检查是否在TRAE主站dashboard（登录成功后的页面）

#### Cookie同步

```dart
Future<void> _syncForumCookiesToDio() async
```

将WebView中的Cookie同步到Dio客户端，确保API请求能使用正确的认证信息。

#### 会话验证

```dart
Future<bool> _validateForumSession() async
```

验证论坛会话是否有效：
1. 检查是否有会话Cookie
2. 通过`session/current.json`API验证登录状态

#### 用户信息提取

```dart
Future<Map<String, dynamic>?> _extractUserInfo() async
```

通过多种方式从页面提取用户信息：
1. 尝试从Discourse全局对象获取
2. 尝试从meta标签获取
3. 尝试从PreloadStore获取
4. 尝试从页面中的用户菜单获取

#### 登录成功处理

```dart
Future<void> _handleLoginSuccess({...}) async
```

处理登录成功后的所有操作：
1. 同步论坛Cookie到Dio
2. 验证论坛会话
3. 同步TRAE主站Cookie
4. 提取并保存用户信息
5. 更新认证状态
6. 跳转到首页

### Cookie管理

#### DioClient

```dart
static Future<void> initPersistentCookieManager() async
```

初始化持久化Cookie管理器，使用`PersistCookieJar`将Cookie保存到本地存储。

#### TraeCookieManager

```dart
static Future<bool> extractAndSaveCookies(WebViewController controller) async
static Future<bool> syncCookiesFromNativeBridge() async
static Future<bool> hasValidCookies() async
```

提供Cookie提取、同步和验证功能。

### AuthProvider

认证状态管理：

```dart
final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(...)
```

主要状态：
- 用户信息
- 登录状态
- 会话状态

主要方法：
- `setUserInfo()`: 设置用户信息
- `refreshFromSession()`: 从会话刷新用户信息
- `logout()`: 登出

## Feed模块

### 概述

Feed模块负责展示话题列表，是应用的核心功能之一。包含话题卡片、分类标签、用户信息等元素。

### 核心文件

| 文件 | 位置 | 说明 |
|------|------|------|
| HomePage | `lib/presentation/pages/home/home_page.dart` | 首页，包含Feed列表Tab |
| HomeProvider | `lib/presentation/providers/home_provider.dart` | 首页状态管理 |
| FeedCard | `lib/presentation/pages/home/home_page.dart` | Feed卡片组件 |
| FeaturedComment | `lib/presentation/widgets/feed/featured_comment.dart` | 精选评论组件 |
| QuickCommentBar | `lib/presentation/widgets/feed/quick_comment_bar.dart` | 快速评论栏 |
| LikeButton | `lib/presentation/widgets/common/like_button.dart` | 点赞按钮 |

### 首页结构

```dart
NestedScrollView(
  headerSliverBuilder: [SliverAppBar(...), TabBar(...)]
  body: TabBarView([
    // 不同Feed类型的列表
    PinnedTopicsBanner(),  // Banner在第一个位置
    ListView.builder([FeedCard, FeedCard, ...])
  ])
)
```

### Feed类型

应用支持多种Feed类型：

| 类型 | 说明 |
|------|------|
| latest | 最新话题 |
| hot | 热门话题 |
| official | 官方话题（包含分类分组） |
| help | 帮助与支持 |
| suggestions | 产品建议 |
| tips | 技巧分享 |
| showcase | 案例与作品 |
| discussion | 互动交流 |
| welfare | 福利活动 |
| aiNews | AI快讯 |

### Feed卡片结构

每个Feed卡片包含以下部分：

```dart
FeedCard
├── 用户信息区（头像、用户名、时间）
├── 标题
├── 内容预览
├── 图片预览（如有）
├── 元标签（分类、标签、置顶标识）
├── 精选评论（如有）
├── 操作栏（点赞、评论、浏览、收藏、分享）
└── 快速评论栏
```

### Feed状态管理

```dart
class TabFeedState {
  final List<FeedItem> feedList;
  final bool isRefreshing;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
}
```

### Feed加载流程

1. **初始化加载**：页面加载时自动加载第一页
2. **下拉刷新**：用户下拉时刷新列表
3. **上拉加载更多**：滚动到底部时加载下一页
4. **Tab切换**：切换Tab时加载对应类型的Feed

### Feed卡片主要功能

#### 1. 用户信息展示

```dart
Widget _buildUserInfo(BuildContext context, ColorScheme colorScheme)
```

展示用户头像、用户名和发布时间。

#### 2. 内容展示

```dart
// 标题
Text(widget.feed.title, maxLines: 2, ...)

// 内容
Text(widget.feed.content, maxLines: 3, ...)

// 图片
InkWell(onTap: _openImagePreview, ...)
```

#### 3. 标签展示

```dart
Widget _buildMetaTags(BuildContext context)
```

展示分类标签、普通标签和置顶标识，支持点击跳转。

#### 4. 互动功能

```dart
// 点赞
LikeButton(postId: widget.feed.topicId, ...)

// 评论
QuickCommentBar(onTap: _openQuickCommentSheet, ...)

// 收藏
_toggleBookmarkFromFeed()

// 分享
_showShareOptions()
```

### 标签本地化

应用内置了标签汉化映射：

```dart
const Map<String, String> _tagLocalizationMap = {
  'code-with-solo': 'Code-with-SOLO',
  'solo': 'SOLO赛',
  'solo-news': 'SOLO赛事速递',
  'solo-beginner': '新SOLO初体验',
  'event': '活动',
  'announcement': '公告',
  'help': '求助',
  'suggestion': '建议',
  'tips': '技巧',
  'showcase': '作品',
  'discussion': '讨论',
  // ... 更多映射
};
```

### 官方分类分组

官方分类Tab会将话题按子分类分组展示：

```dart
List<_OfficialFeedRow> _buildOfficialRows(List<FeedItem> feedList)
```

分组规则：
- 产品更新 (categoryId=17)
- 模型更新 (categoryId=18)
- 政策公告 (categoryId=19)
- 社区动态 (categoryId=20)
- 其他官方内容

### 时间格式化

```dart
String _formatTime(String timestamp)
```

将时间戳格式化为友好的相对时间：
- 刚刚（<1分钟）
- X分钟前
- X小时前
- X天前
- 月/日（>=7天）

## 评论模块

### 概述

评论模块提供了话题详情页的评论展示、发送、点赞等功能，是用户互动的核心部分。

### 核心文件

| 文件 | 位置 | 说明 |
|------|------|------|
| FeedDetailPage | `lib/presentation/pages/feed/feed_detail_page.dart` | 话题详情页 |
| ReplyProvider | `lib/presentation/providers/reply_provider.dart` | 评论状态管理 |
| QuickCommentSheet | `lib/presentation/widgets/comment/quick_comment_sheet.dart` | 快速评论面板 |
| CommentRepository | `lib/data/repositories/comment_repository.dart` | 评论数据仓库 |
| PostReplyList | `lib/presentation/widgets/post/post_reply_list.dart` | 评论列表组件 |
| ComposerEditor | `lib/presentation/widgets/editor/composer_editor.dart` | 评论编辑器 |

### FeedDetailPage 结构

```dart
FeedDetailPage
├── 话题标题区
├── 话题内容区（富文本渲染）
├── 目录导航（可选）
├── 评论输入区
└── 评论列表区
```

### 评论加载流程

1. **初始加载**：进入详情页时加载第一页评论
2. **分页加载**：滚动到底部时加载下一页
3. **实时更新**：发送评论后立即更新列表

### 评论数据结构

```dart
class ReplyData {
  final String id;
  final int postId;
  final int postNumber;
  final String uid;
  final String username;
  final String avatarUrl;
  final String content;
  final String dateline;
  final int likeCount;
  final bool isLiked;
  final int? replyToPostNumber;
  final List<ReplyData>? replies; // 楼中楼回复
}
```

### 评论发送

#### 快速评论

```dart
QuickCommentSheet.show(
  context: context,
  topicId: widget.feed.topicId,
  onSubmit: (content) => _handleCommentSuccess(content),
)
```

快速评论面板提供了简洁的输入界面，支持纯文本评论。

#### 完整评论编辑器

```dart
ComposerEditor(
  controller: _commentController,
  focusNode: _commentFocusNode,
  onImageTap: _handleImageUpload,
  onEmojiTap: _handleEmojiInsert,
)
```

完整编辑器支持：
- Markdown输入
- 图片上传
- 表情插入

#### 创建评论API调用

```dart
discourseApiService.createPost({
  required int topicId,
  required String raw,
  int? replyToPostNumber,
})
```

### 评论展示

#### 评论列表

```dart
ListView.builder(
  controller: _scrollController,
  itemCount: _comments.length,
  itemBuilder: (context, index) => CommentCard(comment: _comments[index]),
)
```

#### 楼中楼回复

支持在评论下展示回复：

```dart
// 评论卡片中
if (comment.replies != null && comment.replies!.isNotEmpty) {
  Column(
    children: comment.replies!.map((reply) => CommentCard(
      comment: reply,
      isReply: true,
    )).toList(),
  )
}
```

### 评论互动功能

#### 1. 点赞评论

```dart
LikeButton(postId: comment.postId, ...)
```

使用与Feed点赞相同的组件，支持取消点赞。

#### 2. 回复评论

```dart
_replyToUsername = comment.username;
_replyToPostNumber = comment.postNumber;
_commentFocusNode.requestFocus();
```

点击回复按钮时：
- 设置回复对象用户名
- 设置回复的帖子编号
- 聚焦到评论输入框

#### 3. 编辑评论（仅限作者）

```dart
discourseApiService.editPost({
  required int postId,
  required String raw,
  String? editReason,
})
```

#### 4. 删除评论（仅限作者/管理员）

```dart
discourseApiService.deletePost({
  required int postId,
  bool forceDestroy = false,
})
```

### 图片上传

```dart
Future<Response> uploadImage({
  required String filePath,
  String? fileName,
})
```

上传流程：
1. 用户选择图片
2. 调用上传API
3. 获取图片URL
4. 将图片URL插入到评论内容中（Markdown格式）

### 草稿功能

评论支持草稿保存：

```dart
// 保存草稿
discourseApiService.saveDraft({
  required String draftKey,
  required String data,
  int sequence = 1,
})

// 恢复草稿
discourseApiService.getDraft(draftKey)
```

## Banner模块

### 概述

Banner模块负责在首页顶部展示置顶话题，采用横向轮播卡片形式，是重要的内容展示入口。

### 核心文件

| 文件 | 位置 | 说明 |
|------|------|------|
| PinnedTopicsBanner | `lib/presentation/widgets/home/pinned_topics_banner.dart` | 置顶话题Banner组件 |
| PinnedTopicsProvider | `lib/presentation/providers/pinned_topics_provider.dart` | 置顶话题状态管理 |
| PinnedTopic | `lib/data/models/pinned_topic.dart` | 置顶话题数据模型 |

### Banner结构

```dart
PinnedTopicsBanner
├── 轮播内容区（PageView）
│   └── [PinnedTopicCard, PinnedTopicCard, ...]
└── 指示器区（页面切换动画）
```

### PinnedTopicsBanner 主要功能

#### 数据加载

```dart
Future<void> _loadData() async
```

根据是否指定分类ID：
- `null`: 使用全局置顶聚合逻辑
- 非`null`: 只展示指定分类中的置顶话题

```dart
Future<void> _loadCategoryPinnedTopics(int categoryId) async
```

加载指定分类的置顶话题：
1. 调用`getTopicsByCategory`API
2. 筛选出置顶话题
3. 转换为`PinnedTopic`模型
4. 更新状态

#### 置顶话题筛选

```dart
bool _isTopicPinned(Map<String, dynamic> topic)
```

判断话题是否为置顶：
- 检查`pinned`字段
- 检查`pinned_globally`字段
- 支持bool、int、String多种类型

#### 轮播控制

```dart
PageController _pageController = PageController(viewportFraction: 0.92)
```

使用`PageView`实现轮播：
- `viewportFraction: 0.92` 使卡片两侧露出
- 自动监听页面切换更新指示器

#### 指示器动画

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 200),
  width: _currentPage == index ? 16 : 6,
  height: 6,
  // ...
)
```

当前页指示器变宽，其他为圆点。

### PinnedTopicCard 卡片结构

```dart
_PinnedTopicCard
├── 顶部行
│   ├── 置顶标签
│   ├── 浏览数
│   └── 评论数
├── 话题标题
└── 底部用户信息行
    ├── 用户头像
    ├── 用户名
    └── 箭头指示
```

### 卡片设计特点

1. **渐变背景**：`LinearGradient`从左上到右下渐变
2. **阴影效果**：`elevation: 2`提升层次感
3. **圆角设计**：`BorderRadius.circular(16)`圆润美观
4. **统计标签**：使用`Container`包装浏览和评论数
5. **头像边框**：`Border.all()`添加边框装饰

### 数字格式化

```dart
String _formatNumber(int num)
```

格式化大数字：
- >=10000: X.Xw
- >=1000: X.Xk
- <1000: 原数字

### Banner位置

在首页Feed列表的第一个位置：

```dart
// HomePage中的FeedListView
itemBuilder: (context, index) {
  // 如果是第一个位置且需要显示Banner
  if (showBanner && index == 0) {
    return PinnedTopicsBanner(categoryId: bannerCategoryId);
  }
  // 计算实际的feed索引
  final feedIndex = showBanner ? index - 1 : index;
  // ...
}
```

### 空状态处理

```dart
// 如果没有置顶话题且不加载中，不显示Banner
if (pinnedTopics.isEmpty && !isLoading && errorMessage == null) {
  return const SizedBox.shrink();
}
```

空状态不占用空间，避免影响页面布局。

### 加载状态和错误状态

```dart
// 加载中
_buildLoadingPlaceholder() // 显示加载占位

// 加载失败
_buildErrorPlaceholder(errorMessage) // 显示错误提示
```

## 开发工具与命令

### 环境要求

- **Flutter**: >= 3.10.0
- **Dart**: >= 3.0.0
- **Android**: minSdkVersion 21
- **iOS**: iOS 11.0+

### 常用命令

#### 依赖管理

```bash
# 获取依赖
flutter pub get

# 更新依赖
flutter pub upgrade

# 清理并重新获取依赖
flutter clean
flutter pub get
```

#### 代码生成

项目使用代码生成工具（freezed, json_serializable, riverpod_generator）：

```bash
# 一次性生成代码
flutter pub run build_runner build --delete-conflicting-outputs

# 监听模式（开发时自动重新生成）
flutter pub run build_runner watch --delete-conflicting-outputs

# 清理生成文件
flutter pub run build_runner clean
```

#### 运行应用

```bash
# 运行应用（调试模式）
flutter run

# 指定设备运行
flutter devices
flutter run -d <device_id>

# 运行在Chrome浏览器
flutter run -d chrome

# 运行在macOS
flutter run -d macos
```

#### 构建应用

```bash
# Android APK（调试版）
flutter build apk --debug

# Android APK（发布版）
flutter build apk --release

# Android App Bundle（发布版）
flutter build appbundle --release

# iOS（发布版）
flutter build ios --release
```

#### 测试

```bash
# 运行所有测试
flutter test

# 运行特定测试文件
flutter test test/pages/login_page_test.dart

# 运行集成测试
flutter test integration_test/app_test.dart

# 生成测试覆盖率报告
flutter test --coverage
```

#### 代码分析

```bash
# 静态分析
flutter analyze

# 格式化代码
flutter format lib/
```

### Git提交规范

项目推荐使用以下提交信息格式：

```
<type>(<scope>): <subject>

<type> 类型：
- feat: 新功能
- fix: 修复bug
- docs: 文档更新
- style: 代码格式调整
- refactor: 重构
- test: 测试相关
- chore: 构建/工具链相关

<scope> 影响范围：
- api: API相关
- auth: 登录相关
- feed: Feed相关
- comment: 评论相关
- banner: Banner相关
- ui: UI相关
- ...
```

示例：
```
feat(feed): 添加新的Feed分类标签
fix(auth): 修复登录后Cookie同步问题
docs: 更新开发指南文档
```

### 常见问题解决

#### 1. 构建失败 - ApiException未定义

**问题**：构建时提示`ApiException`类型不存在

**解决方案**：检查`api_service.dart`文件，删除对`ApiException`的引用

#### 2. 登录问题 - Cookie同步失败

**问题**：WebView登录后无法同步Cookie

**解决方案**：
1. 检查`DioClient.initPersistentCookieManager()`是否在应用启动时调用
2. 检查`WebViewLoginPage`中的Cookie同步逻辑
3. 查看日志中的Cookie同步信息

#### 3. 网络请求 - 403/401错误

**可能原因**：
- Cookie过期或无效
- CSRF Token验证失败

**解决方案**：
- 清除应用数据后重新登录
- 检查`CsrfTokenManager`是否正常工作

#### 4. iOS - CocoaPods问题

**问题**：CocoaPods安装或更新失败

**解决方案**：
```bash
cd ios
pod deintegrate
pod repo update
pod install
cd ..
```

### 调试技巧

#### 1. 日志输出

项目使用`logger`库进行日志输出，不同级别有不同颜色：

```dart
import 'package:logger/logger.dart';

final logger = Logger();
logger.d('调试信息');
logger.i('普通信息');
logger.w('警告信息');
logger.e('错误信息');
```

#### 2. DevTools

```bash
# 启动DevTools
flutter pub global activate devtools
flutter pub global run devtools
```

或者在运行应用时直接打开：
```bash
flutter run --dart-define=FLUTTER_DEVTOOLS=true
```

#### 3. 性能分析

```bash
# 运行性能分析模式
flutter run --profile

# 或使用DevTools的性能面板
```

## 附录

### 参考资源

- [Flutter官方文档](https://docs.flutter.dev/)
- [Riverpod文档](https://riverpod.dev/)
- [Discourse API文档](https://docs.discourse.org/)
- [TRAE官方社区](https://forum.trae.cn)

### 相关文件快速索引

| 功能模块 | 主要文件位置 |
|----------|-------------|
| API服务 | `lib/core/network/discourse_api_service.dart` |
| 登录 | `lib/presentation/pages/user/webview_login_page.dart` |
| Feed列表 | `lib/presentation/pages/home/home_page.dart` |
| Feed详情 | `lib/presentation/pages/feed/feed_detail_page.dart` |
| Banner | `lib/presentation/widgets/home/pinned_topics_banner.dart` |
| 数据模型 | `lib/data/models/` |
| 状态管理 | `lib/presentation/providers/` |

---

**注意**：本文档会随着项目发展而更新，请保持关注！
