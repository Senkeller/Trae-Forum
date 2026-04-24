import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/search.dart';
import '../../data/models/discourse/discourse_notification.dart';
import 'dio_client.dart';

part 'discourse_api_service.g.dart';

@riverpod
DiscourseApiService discourseApiService(DiscourseApiServiceRef ref) {
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
}
