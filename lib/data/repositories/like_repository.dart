import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/network/discourse_api_service.dart';

part 'like_repository.g.dart';

/// 点赞操作结果
class LikeResult {
  final bool success;
  final String? errorMessage;
  final int? likeCount;
  final bool? isLiked;

  LikeResult({
    required this.success,
    this.errorMessage,
    this.likeCount,
    this.isLiked,
  });

  factory LikeResult.success({int? likeCount, bool? isLiked}) {
    return LikeResult(
      success: true,
      likeCount: likeCount,
      isLiked: isLiked,
    );
  }

  factory LikeResult.failure(String message) {
    return LikeResult(
      success: false,
      errorMessage: message,
    );
  }
}

/// 点赞仓库
/// 负责处理帖子点赞相关的数据操作
@riverpod
LikeRepository likeRepository(Ref ref) {
  final discourseApi = ref.read(discourseApiServiceProvider);
  return LikeRepository(discourseApi);
}

/// 点赞仓库类
class LikeRepository {
  final DiscourseApiService _discourseApi;

  LikeRepository(this._discourseApi);

  /// 点赞帖子
  ///
  /// [postId] 帖子ID
  /// 返回点赞操作结果
  Future<LikeResult> likePost(int postId) async {
    try {
      final response = await _discourseApi.likePost(postId);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>?;
        final actionsSummary = data?['actions_summary'] as List<dynamic>?;
        int? likeCount;
        bool? isLiked;

        if (actionsSummary != null) {
          final likeAction = actionsSummary.firstWhere(
            (action) => action['id'] == 2,
            orElse: () => null,
          );
          if (likeAction != null) {
            likeCount = likeAction['count'] as int?;
            isLiked = likeAction['acted'] as bool? ?? true;
          }
        }

        return LikeResult.success(
          likeCount: likeCount,
          isLiked: isLiked ?? true,
        );
      } else if (response.statusCode == 403) {
        return LikeResult.failure('权限不足或会话已过期，请重新登录');
      } else if (response.statusCode == 422) {
        final errors = response.data?['errors'];
        if (errors != null && errors is List && errors.isNotEmpty) {
          return LikeResult.failure(errors.first.toString());
        }
        return LikeResult.failure('请求参数错误');
      } else if (response.statusCode == 429) {
        return LikeResult.failure('操作过于频繁，请稍后再试');
      } else {
        return LikeResult.failure('点赞失败: HTTP ${response.statusCode}');
      }
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return LikeResult.failure('点赞时发生错误: $e');
    }
  }

  /// 取消点赞帖子
  ///
  /// [postId] 帖子ID
  /// 返回取消点赞操作结果
  Future<LikeResult> unlikePost(int postId) async {
    try {
      final response = await _discourseApi.unlikePost(postId);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>?;
        final actionsSummary = data?['actions_summary'] as List<dynamic>?;
        int? likeCount;
        bool? isLiked;

        if (actionsSummary != null) {
          final likeAction = actionsSummary.firstWhere(
            (action) => action['id'] == 2,
            orElse: () => null,
          );
          if (likeAction != null) {
            likeCount = likeAction['count'] as int?;
            isLiked = likeAction['acted'] as bool? ?? false;
          }
        }

        return LikeResult.success(
          likeCount: likeCount,
          isLiked: isLiked ?? false,
        );
      } else if (response.statusCode == 403) {
        return LikeResult.failure('权限不足或会话已过期，请重新登录');
      } else if (response.statusCode == 404) {
        return LikeResult.failure('点赞记录不存在');
      } else if (response.statusCode == 429) {
        return LikeResult.failure('操作过于频繁，请稍后再试');
      } else {
        return LikeResult.failure('取消点赞失败: HTTP ${response.statusCode}');
      }
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return LikeResult.failure('取消点赞时发生错误: $e');
    }
  }

  /// 切换点赞状态
  ///
  /// [postId] 帖子ID
  /// [isCurrentlyLiked] 当前是否已点赞
  /// 返回操作结果
  Future<LikeResult> toggleLike(int postId, bool isCurrentlyLiked) async {
    if (isCurrentlyLiked) {
      return unlikePost(postId);
    } else {
      return likePost(postId);
    }
  }

  /// 从actions_summary中提取点赞信息
  ///
  /// [actionsSummary] 操作摘要列表
  /// 返回包含点赞数和是否已点赞的Map
  static Map<String, dynamic> extractLikeInfo(List<dynamic>? actionsSummary) {
    if (actionsSummary == null || actionsSummary.isEmpty) {
      return {'count': 0, 'isLiked': false};
    }

    final likeAction = actionsSummary.firstWhere(
      (action) => action['id'] == 2,
      orElse: () => null,
    );

    if (likeAction == null) {
      return {'count': 0, 'isLiked': false};
    }

    return {
      'count': likeAction['count'] ?? 0,
      'isLiked': likeAction['acted'] ?? false,
    };
  }

  /// 处理 Dio 错误
  LikeResult _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return LikeResult.failure('网络连接超时，请检查网络后重试');
      case DioExceptionType.connectionError:
        return LikeResult.failure('网络连接失败，请检查网络设置');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final data = e.response?.data as Map<String, dynamic>?;

        if (statusCode == 401) {
          return LikeResult.failure('未登录或登录已过期，请重新登录');
        } else if (statusCode == 403) {
          return LikeResult.failure('权限验证失败，请刷新页面后重试');
        } else if (statusCode == 422) {
          final errors = data?['errors'];
          if (errors != null && errors is List && errors.isNotEmpty) {
            return LikeResult.failure(errors.first.toString());
          }
          return LikeResult.failure('请求参数验证失败');
        } else if (statusCode == 429) {
          return LikeResult.failure('操作过于频繁，请稍后再试');
        } else {
          return LikeResult.failure('服务器错误: HTTP $statusCode');
        }
      case DioExceptionType.cancel:
        return LikeResult.failure('请求已取消');
      default:
        return LikeResult.failure('网络请求失败: ${e.message}');
    }
  }
}
