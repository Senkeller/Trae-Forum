import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/search.dart';
import 'dio_client.dart';

part 'discourse_api_service.g.dart';

@riverpod
DiscourseApiService discourseApiService(Ref ref) {
  return DiscourseApiService();
}

class DiscourseApiService {
  static const String _baseUrl = 'https://forum.trae.cn';
  final Dio _dio;

  DiscourseApiService() : _dio = DioClient.dio;

  Future<Response> getLatestTopics({int page = 0}) async {
    return _dio.get(
      '$_baseUrl/latest.json',
      queryParameters: {'page': page},
    );
  }

  Future<Response> getTopicsByCategory(int categoryId, {int page = 0}) async {
    return _dio.get(
      '$_baseUrl/c/$categoryId.json',
      queryParameters: {'page': page},
    );
  }

  Future<Response> getTopicDetail(int topicId) async {
    return _dio.get('$_baseUrl/t/$topicId.json');
  }

  Future<Response> getTopicPosts(int topicId, {int page = 0}) async {
    return _dio.get(
      '$_baseUrl/t/$topicId/posts.json',
      queryParameters: {'page': page},
    );
  }

  Future<Response> getCategories() async {
    return _dio.get('$_baseUrl/categories.json');
  }

  /// 基础搜索 - 仅关键词
  Future<Response> searchTopics(String query) async {
    return _dio.get(
      '$_baseUrl/search.json',
      queryParameters: {'q': query},
    );
  }

  /// 高级搜索 - 完整参数支持
  ///
  /// [request] 搜索请求参数对象，包含关键词、分页、筛选等
  /// 支持分类筛选、标签筛选、日期范围、排序等高级功能
  Future<Response> searchAdvanced(SearchRequest request) async {
    return _dio.get(
      '$_baseUrl/search.json',
      queryParameters: request.toQueryParameters(),
    );
  }

  /// 搜索建议/自动完成
  ///
  /// [term] 输入的关键词前缀
  /// 返回话题、用户、分类的建议列表
  Future<Response> getSearchSuggestions(String term) async {
    return _dio.get(
      '$_baseUrl/search/query',
      queryParameters: {'term': term},
    );
  }

  Future<Response> getUserInfo(String username) async {
    return _dio.get('$_baseUrl/u/$username.json');
  }

  Future<Response> getUserTopics(String username, {int page = 0}) async {
    return _dio.get(
      '$_baseUrl/u/$username/activity/topics.json',
      queryParameters: {'page': page},
    );
  }

  Future<Response> getUserSummary(String username) async {
    return _dio.get('$_baseUrl/u/$username/summary.json');
  }

  Future<Response> getUserActivity(String username, {int page = 0}) async {
    return _dio.get(
      '$_baseUrl/u/$username/activity.json',
      queryParameters: {'page': page},
    );
  }

  Future<Response> getUserActivityTopics(String username, {int page = 0}) async {
    return _dio.get(
      '$_baseUrl/u/$username/activity/topics.json',
      queryParameters: {'page': page},
    );
  }

  Future<Response> getUserActivityReplies(String username, {int page = 0}) async {
    return _dio.get(
      '$_baseUrl/u/$username/activity/replies.json',
      queryParameters: {'page': page},
    );
  }

  Future<Response> getUserActivityLikes(String username, {int page = 0}) async {
    return _dio.get(
      '$_baseUrl/u/$username/activity/likes-given.json',
      queryParameters: {'page': page},
    );
  }

  Future<Response> getUserActivitySolved(String username, {int page = 0}) async {
    return _dio.get(
      '$_baseUrl/u/$username/activity/solved.json',
      queryParameters: {'page': page},
    );
  }

  Future<Response> getUserActivityVotes(String username, {int page = 0}) async {
    return _dio.get(
      '$_baseUrl/u/$username/activity/votes.json',
      queryParameters: {'page': page},
    );
  }

  Future<Response> getHotTopics({int page = 0}) async {
    return _dio.get(
      '$_baseUrl/hot.json',
      queryParameters: {'page': page},
    );
  }

  Future<Response> getTopTopics({int page = 0}) async {
    return _dio.get(
      '$_baseUrl/top.json',
      queryParameters: {'page': page},
    );
  }

  // ==================== 通知相关 API ====================

  /// 获取通知列表
  ///
  /// [limit] 返回数量限制，默认30
  /// [recent] 是否只返回最近通知
  /// [bumpLastSeen] 是否更新最后查看时间
  /// [filterByTypes] 通知类型筛选，多个类型用逗号分隔
  Future<Response> getNotifications({
    int limit = 30,
    bool recent = true,
    bool bumpLastSeen = true,
    String? filterByTypes,
  }) async {
    final queryParams = <String, dynamic>{
      'limit': limit,
      'recent': recent,
      'bump_last_seen_reviewable': bumpLastSeen,
    };
    
    if (filterByTypes != null && filterByTypes.isNotEmpty) {
      queryParams['filter_by_types'] = filterByTypes;
    }

    return _dio.get(
      '$_baseUrl/notifications',
      queryParameters: queryParams,
    );
  }

  /// 获取私信菜单数据
  Future<Response> getUserMenuPrivateMessages(String username) async {
    return _dio.get('$_baseUrl/u/$username/user-menu-private-messages');
  }

  /// 获取书签菜单数据
  Future<Response> getUserMenuBookmarks(String username) async {
    return _dio.get('$_baseUrl/u/$username/user-menu-bookmarks');
  }

  /// 获取私信话题列表
  Future<Response> getPrivateMessages(String username) async {
    return _dio.get('$_baseUrl/topics/private-messages/$username.json');
  }

  /// 获取私信追踪状态
  Future<Response> getPrivateMessageTrackingState(String username) async {
    return _dio.get('$_baseUrl/u/$username/private-message-topic-tracking-state');
  }

  /// 标记通知已读
  Future<Response> markNotificationsRead(List<int> notificationIds) async {
    return _dio.put(
      '$_baseUrl/notifications/mark-read',
      data: {'id': notificationIds},
    );
  }

  /// 标记所有通知已读
  Future<Response> markAllNotificationsRead() async {
    return _dio.put('$_baseUrl/notifications/mark-read');
  }

  // ==================== 聊天相关 API ====================

  /// 获取当前用户聊天频道
  Future<Response> getChatChannels() async {
    return _dio.get('$_baseUrl/chat/api/me/channels');
  }

  /// 获取公开聊天频道列表
  Future<Response> getPublicChatChannels({
    int limit = 10,
    String filter = '',
    String status = 'open',
    int offset = 0,
  }) async {
    return _dio.get(
      '$_baseUrl/chat/api/channels',
      queryParameters: {
        'limit': limit,
        'filter': filter,
        'status': status,
        'offset': offset,
      },
    );
  }

  /// 更新在线状态
  Future<Response> updatePresence() async {
    return _dio.post('$_baseUrl/presence/update');
  }

  // ==================== 帖子/评论相关 API ====================

  /// 创建帖子/评论
  ///
  /// [topicId] 话题ID
  /// [raw] 评论内容（原始Markdown格式）
  /// [replyToPostNumber] 回复的帖子编号（楼中楼回复时使用）
  /// 调用 Discourse POST /posts API
  Future<Response> createPost({
    required int topicId,
    required String raw,
    int? replyToPostNumber,
  }) async {
    final data = <String, dynamic>{
      'raw': raw,
      'topic_id': topicId,
    };

    if (replyToPostNumber != null) {
      data['reply_to_post_number'] = replyToPostNumber;
    }

    return _dio.post(
      '$_baseUrl/posts',
      data: data,
      options: Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Discourse-Logged-In': 'true',
          'Discourse-Present': 'true',
        },
      ),
    );
  }

  // ==================== 点赞相关 API ====================

  /// 点赞帖子
  ///
  /// [postId] 帖子ID
  /// 调用 Discourse POST /post_actions API
  /// 成功返回200，失败返回相应错误码
  Future<Response> likePost(int postId) async {
    return _dio.post(
      '$_baseUrl/post_actions',
      data: {
        'id': postId,
        'post_action_type_id': 2, // 2 = like
      },
      options: Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Discourse-Logged-In': 'true',
          'Discourse-Present': 'true',
        },
      ),
    );
  }

  /// 取消点赞帖子
  ///
  /// [postId] 帖子ID
  /// 调用 Discourse DELETE /post_actions/{postId} API
  /// 成功返回200，失败返回相应错误码
  Future<Response> unlikePost(int postId) async {
    return _dio.delete(
      '$_baseUrl/post_actions/$postId',
      queryParameters: {
        'post_action_type_id': 2, // 2 = like
      },
      options: Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Discourse-Logged-In': 'true',
          'Discourse-Present': 'true',
        },
      ),
    );
  }

  /// 获取帖子详情（包含点赞状态）
  ///
  /// [postId] 帖子ID
  /// 返回帖子详细信息，包括actions_summary等
  Future<Response> getPostDetail(int postId) async {
    return _dio.get('$_baseUrl/posts/$postId.json');
  }

  /// 编辑帖子/评论
  ///
  /// [postId] 帖子ID
  /// [raw] 新的评论内容（原始Markdown格式）
  /// [editReason] 编辑原因（可选）
  /// 调用 Discourse PUT /posts/{id} API
  Future<Response> editPost({
    required int postId,
    required String raw,
    String? editReason,
  }) async {
    final data = <String, dynamic>{
      'raw': raw,
    };

    if (editReason != null && editReason.isNotEmpty) {
      data['edit_reason'] = editReason;
    }

    return _dio.put(
      '$_baseUrl/posts/$postId',
      data: data,
      options: Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Discourse-Logged-In': 'true',
          'Discourse-Present': 'true',
        },
      ),
    );
  }

  /// 删除帖子/评论
  ///
  /// [postId] 帖子ID
  /// [forceDestroy] 是否强制删除（管理员使用）
  /// 调用 Discourse DELETE /posts/{id} API
  Future<Response> deletePost({
    required int postId,
    bool forceDestroy = false,
  }) async {
    return _dio.delete(
      '$_baseUrl/posts/$postId',
      queryParameters: {
        if (forceDestroy) 'force_destroy': 'true',
      },
      options: Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Discourse-Logged-In': 'true',
          'Discourse-Present': 'true',
        },
      ),
    );
  }

  // ==================== 草稿相关 API ====================

  /// 保存草稿
  ///
  /// [draftKey] 草稿标识符，如 'topic_123' 或 'new_private_message'
  /// [data] 草稿数据（序列化后的内容）
  /// [sequence] 草稿序列号，用于版本控制
  /// 调用 Discourse POST /drafts API
  Future<Response> saveDraft({
    required String draftKey,
    required String data,
    int sequence = 1,
  }) async {
    return _dio.post(
      '$_baseUrl/drafts',
      data: {
        'draft_key': draftKey,
        'data': data,
        'sequence': sequence,
      },
      options: Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Discourse-Logged-In': 'true',
          'Discourse-Present': 'true',
        },
      ),
    );
  }

  /// 获取草稿
  ///
  /// [draftKey] 草稿标识符
  /// 调用 Discourse GET /drafts/{draft_key} API
  /// 返回草稿数据，如果没有草稿则返回空
  Future<Response> getDraft(String draftKey) async {
    return _dio.get(
      '$_baseUrl/drafts/$draftKey',
      options: Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Discourse-Logged-In': 'true',
          'Discourse-Present': 'true',
        },
      ),
    );
  }

  /// 删除草稿
  ///
  /// [draftKey] 草稿标识符
  /// [sequence] 草稿序列号
  /// 调用 Discourse DELETE /drafts/{draft_key} API
  Future<Response> deleteDraft({
    required String draftKey,
    int sequence = 1,
  }) async {
    return _dio.delete(
      '$_baseUrl/drafts/$draftKey',
      queryParameters: {
        'sequence': sequence,
      },
      options: Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Discourse-Logged-In': 'true',
          'Discourse-Present': 'true',
        },
      ),
    );
  }

  // ==================== 关注/粉丝相关 API ====================

  /// 关注用户
  ///
  /// [username] 要关注的用户名
  /// 调用 Discourse PUT /u/{username}/follow API
  Future<Response> followUser(String username) async {
    return _dio.put(
      '$_baseUrl/u/$username/follow',
      options: Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Discourse-Logged-In': 'true',
          'Discourse-Present': 'true',
        },
      ),
    );
  }

  /// 取消关注用户
  ///
  /// [username] 要取消关注的用户名
  /// 调用 Discourse DELETE /u/{username}/follow API
  Future<Response> unfollowUser(String username) async {
    return _dio.delete(
      '$_baseUrl/u/$username/follow',
      options: Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Discourse-Logged-In': 'true',
          'Discourse-Present': 'true',
        },
      ),
    );
  }

  // ==================== 创建话题相关 API ====================

  /// 创建新话题
  ///
  /// [title] 话题标题
  /// [raw] 话题内容（Markdown格式）
  /// [category] 分类ID（可选）
  /// [replyToPostNumber] 回复的帖子编号（可选，用于楼中楼回复）
  /// 调用 Discourse POST /posts API
  Future<Response> createTopic({
    required String title,
    required String raw,
    int? category,
    int? replyToPostNumber,
  }) async {
    final data = <String, dynamic>{
      'title': title,
      'raw': raw,
    };

    if (category != null) {
      data['category'] = category;
    }

    if (replyToPostNumber != null) {
      data['reply_to_post_number'] = replyToPostNumber;
    }

    return _dio.post(
      '$_baseUrl/posts',
      data: data,
      options: Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Discourse-Logged-In': 'true',
          'Discourse-Present': 'true',
        },
      ),
    );
  }
}
