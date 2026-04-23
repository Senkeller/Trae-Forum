import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/discourse/discourse_topic.dart';
import '../../data/models/discourse/discourse_category.dart';
import '../../data/models/discourse/discourse_user.dart';
import '../../data/models/discourse/discourse_search_result.dart';
import '../../config/constants.dart';
import 'dio_client.dart';

part 'discourse_api_service.g.dart';

/// Discourse API 异常
class DiscourseApiException implements Exception {
  final String message;
  final int? statusCode;

  DiscourseApiException(this.message, [this.statusCode]);

  @override
  String toString() => 'DiscourseApiException: $message (status: $statusCode)';
}

/// Discourse API 服务
/// 
/// 负责调用 Discourse 论坛 API 端点
@riverpod
class DiscourseApiService extends _$DiscourseApiService {
  late final Dio _dio;
  late final String _baseUrl;

  @override
  DiscourseApiService build() {
    _dio = DioClient.dio;
    _baseUrl = AppConstants.baseUrl;
    return this;
  }

  /// 获取最新话题列表
  /// 
  /// [page] 页码，从 0 开始
  /// @return 话题列表响应
  Future<DiscourseTopicListResponse> getLatestTopics({int page = 0}) async {
    try {
      final response = await _dio.get(
        '${AppConstants.forumUrl}${AppConstants.discourseLatest}',
        queryParameters: {'page': page},
      );
      return DiscourseTopicListResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw DiscourseApiException(
        e.message ?? 'Failed to fetch latest topics',
        e.response?.statusCode,
      );
    }
  }

  /// 按分类获取话题列表
  /// 
  /// [categoryId] 分类 ID
  /// [page] 页码，从 0 开始
  /// @return 话题列表响应
  Future<DiscourseTopicListResponse> getTopicsByCategory(int categoryId, {int page = 0}) async {
    try {
      final response = await _dio.get(
        '${AppConstants.forumUrl}/c/$categoryId.json',
        queryParameters: {'page': page},
      );
      return DiscourseTopicListResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw DiscourseApiException(
        e.message ?? 'Failed to fetch topics by category',
        e.response?.statusCode,
      );
    }
  }

  /// 获取话题详情
  /// 
  /// [topicId] 话题 ID
  /// @return 话题详情响应
  Future<DiscourseTopicDetailResponse> getTopicDetail(int topicId) async {
    try {
      final response = await _dio.get(
        '${AppConstants.forumUrl}${AppConstants.discourseTopic.replaceAll('{id}', topicId.toString())}',
      );
      return DiscourseTopicDetailResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw DiscourseApiException(
        e.message ?? 'Failed to fetch topic detail',
        e.response?.statusCode,
      );
    }
  }

  /// 通过 slug 获取话题详情
  /// 
  /// [slug] 话题 slug
  /// [topicId] 话题 ID
  /// @return 话题详情响应
  Future<DiscourseTopicDetailResponse> getTopicBySlug(String slug, int topicId) async {
    try {
      final response = await _dio.get(
        '${AppConstants.forumUrl}/t/$slug/$topicId.json',
      );
      return DiscourseTopicDetailResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw DiscourseApiException(
        e.message ?? 'Failed to fetch topic by slug',
        e.response?.statusCode,
      );
    }
  }

  /// 获取话题帖子/回复列表
  /// 
  /// [topicId] 话题 ID
  /// [page] 页码
  /// @return 帖子列表
  Future<List<DiscoursePost>> getTopicPosts(int topicId, {int page = 0}) async {
    try {
      final response = await _dio.get(
        '${AppConstants.forumUrl}${AppConstants.discourseTopicPosts.replaceAll('{id}', topicId.toString())}',
        queryParameters: {'post_number': page * 20 + 1},
      );
      
      final Map<String, dynamic> data = response.data;
      final List<dynamic> postsJson = data['post_stream']?['posts'] ?? [];
      
      return postsJson
          .map((json) => DiscoursePost.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw DiscourseApiException(
        e.message ?? 'Failed to fetch topic posts',
        e.response?.statusCode,
      );
    }
  }

  /// 获取分类列表
  /// 
  /// @return 分类列表响应
  Future<DiscourseCategoryListResponse> getCategories() async {
    try {
      final response = await _dio.get(
        '${AppConstants.forumUrl}${AppConstants.discourseCategories}',
      );
      return DiscourseCategoryListResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw DiscourseApiException(
        e.message ?? 'Failed to fetch categories',
        e.response?.statusCode,
      );
    }
  }

  /// 搜索话题
  /// 
  /// [query] 搜索关键词
  /// @return 搜索结果响应
  Future<DiscourseSearchResultResponse> searchTopics(String query) async {
    try {
      final response = await _dio.get(
        '${AppConstants.forumUrl}${AppConstants.discourseSearch}',
        queryParameters: {'q': query},
      );
      return DiscourseSearchResultResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw DiscourseApiException(
        e.message ?? 'Failed to search topics',
        e.response?.statusCode,
      );
    }
  }

  /// 获取用户信息
  /// 
  /// [username] 用户名
  /// @return 用户响应
  Future<DiscourseUserResponse> getUserInfo(String username) async {
    try {
      final response = await _dio.get(
        '${AppConstants.forumUrl}${AppConstants.discourseUser.replaceAll('{username}', username)}',
      );
      return DiscourseUserResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw DiscourseApiException(
        e.message ?? 'Failed to fetch user info',
        e.response?.statusCode,
      );
    }
  }
}
