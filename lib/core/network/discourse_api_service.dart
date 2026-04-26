import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/search.dart';
import 'dio_client.dart';
import 'interceptors/csrf_token_manager.dart';
import 'native_cookie_bridge.dart';

part 'discourse_api_service.g.dart';

@riverpod
DiscourseApiService discourseApiService(Ref ref) {
  return DiscourseApiService();
}

class DiscourseApiService {
  static const String _baseUrl = 'https://forum.trae.cn';
  static const Map<int, String> _categoryPathById = {
    4: 'c/4-category/4',
    17: 'c/4-category/17-category/17',
    18: 'c/4-category/18-category/18',
    19: 'c/4-category/19-category/19',
    20: 'c/4-category/20-category/20',
    29: 'c/29-category/29',
  };
  final Dio _dio;

  DiscourseApiService() : _dio = DioClient.dio;

  Future<void> _ensureForumSessionReady() async {
    // 优先从系统 CookieManager 同步，避免 Dio CookieJar 与 WebView 会话漂移
    await NativeCookieBridge.syncCookiesToDio(_baseUrl);
    await DiscourseCsrfToken.ensureValid(_dio);
  }

  bool _isNotLoggedInResponse(Response<dynamic>? response) {
    if (response == null || response.statusCode != 403) return false;
    final data = response.data;
    if (data is Map<String, dynamic>) {
      final type = data['error_type']?.toString();
      if (type == 'not_logged_in') return true;
      final errors = data['errors'];
      if (errors is List && errors.isNotEmpty) {
        return errors.first.toString().contains('需要登录');
      }
    }
    return false;
  }

  Future<Response> getLatestTopics({int page = 0}) async {
    return _dio.get('$_baseUrl/latest.json', queryParameters: {'page': page});
  }

  Future<Response> getTopicsByCategory(int categoryId, {int page = 0}) async {
    final path = _categoryPathById[categoryId] ?? 'c/$categoryId';
    return _dio.get('$_baseUrl/$path.json', queryParameters: {'page': page});
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
    return _dio.get('$_baseUrl/search.json', queryParameters: {'q': query});
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
    return _dio.get('$_baseUrl/search/query', queryParameters: {'term': term});
  }

  Future<Response> getUserInfo(String username) async {
    return _dio.get('$_baseUrl/u/$username.json');
  }

  /// 获取当前会话用户信息
  ///
  /// 已登录时返回 current_user，未登录时通常为 null
  Future<Response> getCurrentSession() async {
    return _dio.get('$_baseUrl/session/current.json');
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

  Future<Response> getUserActivityTopics(
    String username, {
    int page = 0,
  }) async {
    return _dio.get(
      '$_baseUrl/u/$username/activity/topics.json',
      queryParameters: {'page': page},
    );
  }

  Future<Response> getUserActivityReplies(
    String username, {
    int page = 0,
  }) async {
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

  Future<Response> getUserActivitySolved(
    String username, {
    int page = 0,
  }) async {
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
    return _dio.get('$_baseUrl/hot.json', queryParameters: {'page': page});
  }

  Future<Response> getTopTopics({int page = 0}) async {
    return _dio.get('$_baseUrl/top.json', queryParameters: {'page': page});
  }

  /// 获取最新话题（按创建时间排序）
  ///
  /// [page] 页码，从0开始
  /// 调用 Discourse GET /new.json API
  Future<Response> getNewTopics({int page = 0}) async {
    return _dio.get('$_baseUrl/new.json', queryParameters: {'page': page});
  }

  /// 根据标签获取话题列表
  ///
  /// [tag] 标签名称
  /// [page] 页码，从0开始
  /// 调用 Discourse GET /tag/{tag}.json API
  Future<Response> getTopicsByTag(String tag, {int page = 0}) async {
    // 先处理 % 字符避免双重编码，然后进行 URL 编码
    final sanitizedTag = tag.replaceAll('%', '%25');
    final encodedTag = Uri.encodeComponent(sanitizedTag);
    return _dio.get(
      '$_baseUrl/tag/$encodedTag.json',
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
  /// [offset] 分页偏移量
  Future<Response> getNotifications({
    int limit = 30,
    bool recent = true,
    bool bumpLastSeen = true,
    String? filterByTypes,
    int? offset,
  }) async {
    final queryParams = <String, dynamic>{
      'limit': limit,
      'recent': recent,
      'bump_last_seen_reviewable': bumpLastSeen,
    };

    if (filterByTypes != null && filterByTypes.isNotEmpty) {
      queryParams['filter_by_types'] = filterByTypes;
    }
    if (offset != null && offset > 0) {
      queryParams['offset'] = offset;
    }

    return _dio.get('$_baseUrl/notifications', queryParameters: queryParams);
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
    return _dio.get(
      '$_baseUrl/u/$username/private-message-topic-tracking-state',
    );
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

  /// 删除通知
  Future<Response> deleteNotification(int notificationId) async {
    return _dio.delete('$_baseUrl/notifications/$notificationId');
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
    await _ensureForumSessionReady();
    final csrfToken = DiscourseCsrfToken.token;
    final data = <String, dynamic>{'raw': raw, 'topic_id': topicId};

    if (replyToPostNumber != null) {
      data['reply_to_post_number'] = replyToPostNumber;
    }

    final options = Options(
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Discourse-Logged-In': 'true',
        'Discourse-Present': 'true',
        if (csrfToken != null) 'X-CSRF-Token': csrfToken,
      },
    );

    try {
      return await _dio.post('$_baseUrl/posts', data: data, options: options);
    } on DioException catch (error) {
      if (_isNotLoggedInResponse(error.response)) {
        await _ensureForumSessionReady();
        final retryToken = DiscourseCsrfToken.token;
        return _dio.post(
          '$_baseUrl/posts',
          data: data,
          options: Options(
            headers: {
              'X-Requested-With': 'XMLHttpRequest',
              'Discourse-Logged-In': 'true',
              'Discourse-Present': 'true',
              if (retryToken != null) 'X-CSRF-Token': retryToken,
            },
          ),
        );
      }
      rethrow;
    }
  }

  /// 上传图片（评论/回复使用）
  ///
  /// [filePath] 本地文件路径
  /// [fileName] 文件名（可选）
  /// 调用 Discourse POST /uploads.json API
  Future<Response> uploadImage({
    required String filePath,
    String? fileName,
  }) async {
    await DiscourseCsrfToken.ensureValid(_dio);
    final csrfToken = DiscourseCsrfToken.token;

    FormData buildFormData({required bool useArrayField}) {
      final fieldName = useArrayField ? 'files[]' : 'file';
      return FormData.fromMap({
        'type': 'composer',
        'synchronous': true,
        fieldName: MultipartFile.fromFileSync(filePath, filename: fileName),
      });
    }

    Options buildOptions() {
      return Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Discourse-Logged-In': 'true',
          'Discourse-Present': 'true',
          if (csrfToken != null) 'X-CSRF-Token': csrfToken,
        },
      );
    }

    try {
      return await _dio.post(
        '$_baseUrl/uploads.json',
        data: buildFormData(useArrayField: true),
        options: buildOptions(),
      );
    } on DioException catch (error) {
      final statusCode = error.response?.statusCode;
      // 不同 Discourse 部署对上传字段名要求不同，失败时回退另一种格式重试一次
      if (statusCode == 400 || statusCode == 422) {
        return _dio.post(
          '$_baseUrl/uploads.json',
          data: buildFormData(useArrayField: false),
          options: buildOptions(),
        );
      }
      rethrow;
    }
  }

  // ==================== 点赞相关 API ====================

  /// 点赞帖子
  ///
  /// [postId] 帖子ID
  /// 调用 Discourse POST /post_actions API
  /// 成功返回200，失败返回相应错误码
  Future<Response> likePost(int postId) async {
    // 确保 CSRF Token 有效
    print('🔍 [DiscourseApiService] likePost: 调用 ensureValid');
    await DiscourseCsrfToken.ensureValid(_dio);

    final csrfToken = DiscourseCsrfToken.token;
    print(
      '🔍 [DiscourseApiService] likePost: CSRF Token = ${csrfToken != null ? "存在 (${csrfToken.length} 字符)" : "不存在"}',
    );

    final response = await _dio.post(
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
          if (csrfToken != null) 'X-CSRF-Token': csrfToken,
        },
      ),
    );

    if (response.statusCode == 404) {
      print(
        '⚠️ [DiscourseApiService] likePost: 404, 尝试将 $postId 视为 topicId 解析首帖 postId 后重试',
      );
      final firstPostId = await _resolveFirstPostIdFromTopicId(postId);
      if (firstPostId != null && firstPostId != postId) {
        return _dio.post(
          '$_baseUrl/post_actions',
          data: {
            'id': firstPostId,
            'post_action_type_id': 2, // 2 = like
          },
          options: Options(
            headers: {
              'X-Requested-With': 'XMLHttpRequest',
              'Discourse-Logged-In': 'true',
              'Discourse-Present': 'true',
              if (csrfToken != null) 'X-CSRF-Token': csrfToken,
            },
          ),
        );
      }
    }

    return response;
  }

  /// 取消点赞帖子
  ///
  /// [postId] 帖子ID
  /// 调用 Discourse DELETE /post_actions/{postId} API
  /// 成功返回200，失败返回相应错误码
  Future<Response> unlikePost(int postId) async {
    // 确保 CSRF Token 有效
    print('🔍 [DiscourseApiService] unlikePost: 调用 ensureValid');
    await DiscourseCsrfToken.ensureValid(_dio);

    final csrfToken = DiscourseCsrfToken.token;
    print(
      '🔍 [DiscourseApiService] unlikePost: CSRF Token = ${csrfToken != null ? "存在 (${csrfToken.length} 字符)" : "不存在"}',
    );

    final response = await _dio.delete(
      '$_baseUrl/post_actions/$postId',
      queryParameters: {
        'post_action_type_id': 2, // 2 = like
      },
      options: Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Discourse-Logged-In': 'true',
          'Discourse-Present': 'true',
          if (csrfToken != null) 'X-CSRF-Token': csrfToken,
        },
      ),
    );

    if (response.statusCode == 404) {
      print(
        '⚠️ [DiscourseApiService] unlikePost: 404, 尝试将 $postId 视为 topicId 解析首帖 postId 后重试',
      );
      final firstPostId = await _resolveFirstPostIdFromTopicId(postId);
      if (firstPostId != null && firstPostId != postId) {
        return _dio.delete(
          '$_baseUrl/post_actions/$firstPostId',
          queryParameters: {
            'post_action_type_id': 2, // 2 = like
          },
          options: Options(
            headers: {
              'X-Requested-With': 'XMLHttpRequest',
              'Discourse-Logged-In': 'true',
              'Discourse-Present': 'true',
              if (csrfToken != null) 'X-CSRF-Token': csrfToken,
            },
          ),
        );
      }
    }

    return response;
  }

  /// 获取帖子详情（包含点赞状态）
  ///
  /// [postId] 帖子ID
  /// 返回帖子详细信息，包括actions_summary等
  Future<Response> getPostDetail(int postId) async {
    return _dio.get('$_baseUrl/posts/$postId.json');
  }

  Future<int?> _resolveFirstPostIdFromTopicId(int topicId) async {
    if (topicId <= 0) {
      return null;
    }

    try {
      final detail = await _dio.get('$_baseUrl/t/$topicId.json');
      final data = detail.data;
      if (data is! Map<String, dynamic>) {
        return null;
      }

      final postStream = data['post_stream'];
      if (postStream is! Map<String, dynamic>) {
        return null;
      }

      final posts = postStream['posts'];
      if (posts is! List || posts.isEmpty) {
        return null;
      }

      final first = posts.first;
      if (first is Map<String, dynamic>) {
        final idValue = first['id'];
        if (idValue is int) return idValue;
        if (idValue is String) return int.tryParse(idValue);
      }
      return null;
    } catch (error) {
      print(
        '⚠️ [DiscourseApiService] _resolveFirstPostIdFromTopicId($topicId) 失败: $error',
      );
      return null;
    }
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
    await DiscourseCsrfToken.ensureValid(_dio);
    final csrfToken = DiscourseCsrfToken.token;

    final data = <String, dynamic>{'raw': raw};

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
          if (csrfToken != null) 'X-CSRF-Token': csrfToken,
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
    await DiscourseCsrfToken.ensureValid(_dio);
    final csrfToken = DiscourseCsrfToken.token;

    return _dio.delete(
      '$_baseUrl/posts/$postId',
      queryParameters: {if (forceDestroy) 'force_destroy': 'true'},
      options: Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Discourse-Logged-In': 'true',
          'Discourse-Present': 'true',
          if (csrfToken != null) 'X-CSRF-Token': csrfToken,
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
    await DiscourseCsrfToken.ensureValid(_dio);
    final csrfToken = DiscourseCsrfToken.token;

    return _dio.post(
      '$_baseUrl/drafts',
      data: {'draft_key': draftKey, 'data': data, 'sequence': sequence},
      options: Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Discourse-Logged-In': 'true',
          'Discourse-Present': 'true',
          if (csrfToken != null) 'X-CSRF-Token': csrfToken,
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
    await DiscourseCsrfToken.ensureValid(_dio);
    final csrfToken = DiscourseCsrfToken.token;

    return _dio.delete(
      '$_baseUrl/drafts/$draftKey',
      queryParameters: {'sequence': sequence},
      options: Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Discourse-Logged-In': 'true',
          'Discourse-Present': 'true',
          if (csrfToken != null) 'X-CSRF-Token': csrfToken,
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
    await DiscourseCsrfToken.ensureValid(_dio);
    final csrfToken = DiscourseCsrfToken.token;

    return _dio.put(
      '$_baseUrl/u/$username/follow',
      options: Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Discourse-Logged-In': 'true',
          'Discourse-Present': 'true',
          if (csrfToken != null) 'X-CSRF-Token': csrfToken,
        },
      ),
    );
  }

  /// 取消关注用户
  ///
  /// [username] 要取消关注的用户名
  /// 调用 Discourse DELETE /u/{username}/follow API
  Future<Response> unfollowUser(String username) async {
    await DiscourseCsrfToken.ensureValid(_dio);
    final csrfToken = DiscourseCsrfToken.token;

    return _dio.delete(
      '$_baseUrl/u/$username/follow',
      options: Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Discourse-Logged-In': 'true',
          'Discourse-Present': 'true',
          if (csrfToken != null) 'X-CSRF-Token': csrfToken,
        },
      ),
    );
  }

  /// 获取用户关注列表
  ///
  /// [username] 用户名
  /// 调用 Discourse GET /u/{username}/following.json API
  Future<Response> getUserFollowing(String username) async {
    return _dio.get('$_baseUrl/u/$username/following.json');
  }

  /// 获取用户粉丝列表
  ///
  /// [username] 用户名
  /// 调用 Discourse GET /u/{username}/followers.json API
  Future<Response> getUserFollowers(String username) async {
    return _dio.get('$_baseUrl/u/$username/followers.json');
  }

  // ==================== 创建话题相关 API ====================

  /// 创建新话题
  ///
  /// [title] 话题标题
  /// [raw] 话题内容（Markdown格式）
  /// [category] 分类ID（可选）
  /// [tags] 话题标签列表（可选）
  /// [replyToPostNumber] 回复的帖子编号（可选，用于楼中楼回复）
  /// 调用 Discourse POST /posts API
  Future<Response> createTopic({
    required String title,
    required String raw,
    int? category,
    List<String>? tags,
    int? replyToPostNumber,
  }) async {
    await _ensureForumSessionReady();
    final csrfToken = DiscourseCsrfToken.token;
    final data = <String, dynamic>{'title': title, 'raw': raw};

    if (category != null) {
      data['category'] = category;
    }

    if (tags != null && tags.isNotEmpty) {
      data['tags'] = tags;
    }

    if (replyToPostNumber != null) {
      data['reply_to_post_number'] = replyToPostNumber;
    }

    final options = Options(
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Discourse-Logged-In': 'true',
        'Discourse-Present': 'true',
        if (csrfToken != null) 'X-CSRF-Token': csrfToken,
      },
    );

    try {
      return await _dio.post('$_baseUrl/posts', data: data, options: options);
    } on DioException catch (error) {
      if (_isNotLoggedInResponse(error.response)) {
        await _ensureForumSessionReady();
        final retryToken = DiscourseCsrfToken.token;
        return _dio.post(
          '$_baseUrl/posts',
          data: data,
          options: Options(
            headers: {
              'X-Requested-With': 'XMLHttpRequest',
              'Discourse-Logged-In': 'true',
              'Discourse-Present': 'true',
              if (retryToken != null) 'X-CSRF-Token': retryToken,
            },
          ),
        );
      }
      rethrow;
    }
  }

  // ==================== 收藏/书签相关 API ====================

  /// 添加话题到书签
  ///
  /// [topicId] 话题ID
  /// [bookmarkableType] 收藏类型，默认Topic
  /// [reminderAt] 提醒时间（可选，ISO8601格式）
  /// [autoDeletePreference] 自动删除偏好（可选，默认为3）
  /// 调用 Discourse POST /bookmarks.json API
  Future<Response> createBookmark({
    required int topicId,
    String bookmarkableType = 'Topic',
    String? reminderAt,
    int autoDeletePreference = 3,
  }) async {
    await DiscourseCsrfToken.ensureValid(_dio);
    final csrfToken = DiscourseCsrfToken.token;

    final data = <String, dynamic>{
      'bookmarkable_id': topicId,
      'bookmarkable_type': bookmarkableType,
      'auto_delete_preference': autoDeletePreference,
    };

    if (reminderAt != null && reminderAt.isNotEmpty) {
      data['reminder_at'] = reminderAt;
    }

    return _dio.post(
      '$_baseUrl/bookmarks.json',
      data: data,
      options: Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Discourse-Logged-In': 'true',
          'Discourse-Present': 'true',
          if (csrfToken != null) 'X-CSRF-Token': csrfToken,
        },
      ),
    );
  }

  /// 删除书签
  ///
  /// [bookmarkId] 书签ID
  /// 调用 Discourse DELETE /bookmarks/{id}.json API
  Future<Response> deleteBookmark(int bookmarkId) async {
    await DiscourseCsrfToken.ensureValid(_dio);
    final csrfToken = DiscourseCsrfToken.token;

    return _dio.delete(
      '$_baseUrl/bookmarks/$bookmarkId.json',
      options: Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Discourse-Logged-In': 'true',
          'Discourse-Present': 'true',
          if (csrfToken != null) 'X-CSRF-Token': csrfToken,
        },
      ),
    );
  }

  /// 获取当前用户的书签列表
  ///
  /// [page] 页码，从0开始
  /// 调用 Discourse GET /user_activity_bookmarks.json API
  Future<Response> getUserBookmarks({int page = 0}) async {
    return _dio.get(
      '$_baseUrl/user_activity_bookmarks.json',
      queryParameters: {'page': page},
    );
  }

  /// 更新书签提醒时间
  ///
  /// [bookmarkId] 书签ID
  /// [reminderAt] 新的提醒时间（ISO8601格式），传空字符串可清除提醒
  /// [autoDeletePreference] 自动删除偏好
  /// 调用 Discourse PUT /bookmarks/{id}.json API
  Future<Response> updateBookmarkReminder({
    required int bookmarkId,
    String? reminderAt,
    int autoDeletePreference = 3,
  }) async {
    await DiscourseCsrfToken.ensureValid(_dio);
    final csrfToken = DiscourseCsrfToken.token;

    final data = <String, dynamic>{
      'auto_delete_preference': autoDeletePreference,
    };

    if (reminderAt != null) {
      data['reminder_at'] = reminderAt;
    }

    return _dio.put(
      '$_baseUrl/bookmarks/$bookmarkId.json',
      data: data,
      options: Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Discourse-Logged-In': 'true',
          'Discourse-Present': 'true',
          if (csrfToken != null) 'X-CSRF-Token': csrfToken,
        },
      ),
    );
  }
}
