import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/network/api_service.dart' as api;
import '../models/feed.dart';

part 'feed_repository.g.dart';

/// 动态仓库
/// 负责处理动态相关的数据操作，包括获取 Feed 列表、动态详情、发布动态、点赞等
@riverpod
FeedRepository feedRepository(FeedRepositoryRef ref) {
  final apiService = ref.read(api.apiServiceProvider);
  return FeedRepository(apiService);
}

/// 动态仓库类
class FeedRepository {
  final api.ApiService _apiService;

  FeedRepository(this._apiService);

  /// 获取首页 Feed 列表
  ///
  /// [page] 页码，从 1 开始
  /// [firstLaunch] 是否首次启动，0 或 1
  /// [installTime] 安装时间戳
  /// [firstItem] 第一条数据的 ID，用于刷新
  /// [lastItem] 最后一条数据的 ID，用于加载更多
  /// [ids] 已加载的数据 ID 列表，逗号分隔
  /// 返回首页 Feed 响应数据
  /// 抛出 [ApiException] 或 [NetworkException] 当请求失败时
  Future<HomeFeedResponse> getHomeFeed({
    required int page,
    int firstLaunch = 0,
    required String installTime,
    String? firstItem,
    String? lastItem,
    String ids = '',
  }) async {
    try {
      final response = await _apiService.getHomeFeed(
        page: page,
        firstLaunch: firstLaunch,
        installTime: installTime,
        firstItem: firstItem,
        lastItem: lastItem,
        ids: ids,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('获取首页 Feed 失败: $e');
    }
  }

  /// 获取动态详情
  ///
  /// [id] 动态 ID
  /// [rid] 回复 ID，可选
  /// 返回动态详情响应数据
  /// 抛出 [ApiException] 或 [NetworkException] 当请求失败时
  Future<FeedContentResponse> getFeedDetail({
    required String id,
    String? rid,
  }) async {
    try {
      final response = await _apiService.getFeedContent(
        id: id,
        rid: rid,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('获取动态详情失败: $e');
    }
  }

  /// 发布动态
  ///
  /// [data] 动态内容数据，包含消息、图片等信息
  /// [tags] 话题标签列表（可选）
  /// 返回发布动态响应数据
  /// 抛出 [ApiException] 或 [NetworkException] 当请求失败时
  Future<api.CreateFeedResponse> createFeed({
    required Map<String, String> data,
    List<String>? tags,
  }) async {
    try {
      final response = await _apiService.postCreateFeed(
        data: data,
        tags: tags,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('发布动态失败: $e');
    }
  }

  /// 点赞动态
  ///
  /// [id] 动态 ID
  /// 返回点赞响应数据
  /// 抛出 [ApiException] 或 [NetworkException] 当请求失败时
  Future<api.LikeFeedResponse> likeFeed({
    required String id,
  }) async {
    try {
      final response = await _apiService.likeFeed(
        id: id,
        isLike: true,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('点赞动态失败: $e');
    }
  }

  /// 取消点赞动态
  ///
  /// [id] 动态 ID
  /// 返回取消点赞响应数据
  /// 抛出 [ApiException] 或 [NetworkException] 当请求失败时
  Future<api.LikeFeedResponse> unlikeFeed({
    required String id,
  }) async {
    try {
      final response = await _apiService.likeFeed(
        id: id,
        isLike: false,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('取消点赞动态失败: $e');
    }
  }

  /// 删除动态
  ///
  /// [id] 动态 ID
  /// 返回删除响应数据
  /// 抛出 [ApiException] 或 [NetworkException] 当请求失败时
  Future<api.LikeReplyResponse> deleteFeed({
    required String id,
  }) async {
    try {
      final response = await _apiService.postDelete(
        url: '',
        id: id,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('删除动态失败: $e');
    }
  }

  /// 转发动态
  ///
  /// [id] 动态 ID
  /// 返回转发响应数据
  /// 抛出 [ApiException] 或 [NetworkException] 当请求失败时
  Future<dynamic> forwardFeed({
    required String id,
  }) async {
    try {
      final response = await _apiService.postLikeFeed(
        url: '',
        id: id,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('转发动态失败: $e');
    }
  }

  /// 收藏动态
  ///
  /// [id] 动态 ID
  /// 返回收藏响应数据
  /// 抛出 [ApiException] 或 [NetworkException] 当请求失败时
  Future<dynamic> favoriteFeed({
    required String id,
  }) async {
    try {
      final response = await _apiService.postLikeFeed(
        url: '',
        id: id,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('收藏动态失败: $e');
    }
  }

  /// 取消收藏动态
  ///
  /// [id] 动态 ID
  /// 返回取消收藏响应数据
  /// 抛出 [ApiException] 或 [NetworkException] 当请求失败时
  Future<dynamic> unfavoriteFeed({
    required String id,
  }) async {
    try {
      final response = await _apiService.postLikeFeed(
        url: '',
        id: id,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('取消收藏动态失败: $e');
    }
  }

  /// 处理 Dio 错误
  ///
  /// [e] Dio 异常对象
  /// 返回转换后的异常对象
  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          type: NetworkExceptionType.connectTimeout,
          message: '连接超时，请检查网络',
          error: e,
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.statusMessage ?? '服务器响应错误';
        return ApiException(
          code: statusCode,
          message: message,
          data: e.response?.data,
        );
      case DioExceptionType.cancel:
        return NetworkException(
          type: NetworkExceptionType.cancel,
          message: '请求已取消',
          error: e,
        );
      default:
        return NetworkException(
          type: NetworkExceptionType.other,
          message: '网络错误: ${e.message}',
          error: e,
        );
    }
  }
}

/// API 异常类
class ApiException implements Exception {
  final int? code;
  final String message;
  final dynamic data;

  ApiException({
    this.code,
    required this.message,
    this.data,
  });

  @override
  String toString() => 'ApiException: $message (code: $code)';
}

/// 网络异常类
class NetworkException implements Exception {
  final NetworkExceptionType type;
  final String message;
  final dynamic error;

  NetworkException({
    required this.type,
    required this.message,
    this.error,
  });

  @override
  String toString() => 'NetworkException: $message';
}

/// 网络异常类型枚举
enum NetworkExceptionType {
  connectTimeout,
  sendTimeout,
  receiveTimeout,
  cancel,
  other,
}
