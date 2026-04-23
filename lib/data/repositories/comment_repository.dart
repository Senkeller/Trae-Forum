import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/network/api_service.dart' as api;
import '../../core/network/dio_client.dart';
import '../models/comment.dart';

part 'comment_repository.g.dart';

/// 评论仓库
/// 负责处理评论相关的数据操作，包括获取评论列表、发布评论、点赞评论、获取楼中楼回复等
@riverpod
CommentRepository commentRepository(CommentRepositoryRef ref) {
  final apiService = ref.read(api.apiServiceProvider);
  return CommentRepository(apiService);
}

/// 评论仓库类
class CommentRepository {
  final api.ApiService _apiService;

  CommentRepository(this._apiService);

  /// 获取评论列表
  ///
  /// [id] 动态或评论 ID
  /// [listType] 列表类型，默认为空
  Future<TotalReplyResponse> getCommentList({
    required String id,
    String listType = '',
    required int page,
    String? firstItem,
    String? lastItem,
    int discussMode = 0,
    String feedType = 'feed',
    int blockStatus = 0,
    int fromFeedAuthor = 0,
  }) async {
    return await _apiService.getFeedContentReply(
      id: id,
      listType: listType,
      page: page,
      firstItem: firstItem,
      lastItem: lastItem,
      discussMode: discussMode,
      feedType: feedType,
      blockStatus: blockStatus,
      fromFeedAuthor: fromFeedAuthor,
    );
  }

  /// 获取楼中楼回复
  ///
  /// [id] 回复 ID
  Future<TotalReplyResponse> getReply2ReplyList({
    required String id,
    required int page,
    String? lastItem,
  }) async {
    return await _apiService.getReply2Reply(
      id: id,
      page: page,
      lastItem: lastItem,
    );
  }

  /// 发布评论
  ///
  /// [id] 动态 ID
  /// [message] 评论内容
  /// [type] 类型
  Future<api.PostReplyResponse> sendComment({
    required String id,
    required String message,
    required String type,
  }) async {
    return await _apiService.postReply(
      data: {'message': message},
      id: id,
      type: type,
    );
  }

  /// 点赞评论
  ///
  /// [id] 评论 ID
  Future<api.LikeReplyResponse> likeComment({
    required String id,
  }) async {
    return await _apiService.postLikeReply(
      url: '',
      id: id,
    );
  }

  /// 取消点赞评论
  ///
  /// [id] 评论 ID
  Future<api.LikeReplyResponse> unlikeComment({
    required String id,
  }) async {
    return await _apiService.postLikeReply(
      url: '',
      id: id,
    );
  }

  /// 删除评论
  ///
  /// [id] 评论 ID
  Future<api.LikeReplyResponse> deleteComment({
    required String id,
  }) async {
    return await _apiService.postDelete(
      url: '',
      id: id,
    );
  }
}
