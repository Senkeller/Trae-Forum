import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/network/api_service.dart' as api;
import '../../core/network/discourse_api_service.dart';
import '../models/comment.dart';
import '../models/draft_model.dart';

part 'comment_repository.g.dart';

/// 评论仓库
/// 负责处理评论相关的数据操作，包括获取评论列表、发布评论、点赞评论、获取楼中楼回复等
@riverpod
CommentRepository commentRepository(CommentRepositoryRef ref) {
  final apiService = ref.read(api.apiServiceProvider);
  final discourseApi = ref.read(discourseApiServiceProvider);
  return CommentRepository(apiService, discourseApi);
}

/// 评论仓库类
class CommentRepository {
  final api.ApiService _apiService;
  final DiscourseApiService _discourseApi;

  CommentRepository(this._apiService, this._discourseApi);

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

  /// 创建评论（Discourse API）
  ///
  /// [topicId] 话题ID
  /// [content] 评论内容
  /// [replyToPostNumber] 回复的帖子编号（可选，用于楼中楼回复）
  /// 返回 [CommentResult] 包含操作结果和帖子ID
  Future<CommentResult> createComment({
    required int topicId,
    required String content,
    int? replyToPostNumber,
  }) async {
    // 最大重试次数
    const maxRetries = 3;
    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        final response = await _discourseApi.createPost(
          topicId: topicId,
          raw: content,
          replyToPostNumber: replyToPostNumber,
        );

        // 解析响应数据
        final data = response.data is Map<String, dynamic>
            ? response.data as Map<String, dynamic>
            : null;

        if (response.statusCode == 200 || response.statusCode == 201) {
          final postId = _extractPostId(response.data);
          // 有些 Discourse 变体不会在响应体返回 id，但 HTTP 成功即表示发布成功。
          return CommentResult.success(postId: postId);
        } else if (response.statusCode == 403) {
          // CSRF Token 错误或权限不足
          return CommentResult.failure('权限不足或会话已过期，请重新登录');
        } else if (response.statusCode == 422) {
          // 验证错误
          final errors = data?['errors'];
          if (errors != null && errors is List && errors.isNotEmpty) {
            return CommentResult.failure(
              _buildFriendlyCreateErrorMessage(
                errors.first.toString(),
                content: content,
              ),
            );
          }
          return CommentResult.failure(
            _buildFriendlyCreateErrorMessage('请求参数错误', content: content),
          );
        } else if (response.statusCode == 429) {
          // 请求过于频繁
          return CommentResult.failure(
            _buildFriendlyCreateErrorMessage('操作过于频繁，请稍后再试', content: content),
          );
        } else {
          // 其他错误
          return CommentResult.failure(
            _buildFriendlyCreateErrorMessage(
              '创建评论失败: HTTP ${response.statusCode}',
              content: content,
            ),
          );
        }
      } on DioException catch (e) {
        retryCount++;

        if (retryCount >= maxRetries) {
          // 达到最大重试次数，返回错误
          return _handleDioError(e, content: content);
        }

        // 判断是否需要重试
        if (_shouldRetry(e)) {
          // 指数退避策略：等待时间随重试次数增加
          await Future.delayed(Duration(milliseconds: 500 * retryCount));
          continue;
        } else {
          // 不需要重试的错误，直接返回
          return _handleDioError(e, content: content);
        }
      } catch (e) {
        // 其他异常
        return CommentResult.failure(
          _buildFriendlyCreateErrorMessage('创建评论时发生错误: $e', content: content),
        );
      }
    }

    return CommentResult.failure(
      _buildFriendlyCreateErrorMessage('创建评论失败，已达到最大重试次数', content: content),
    );
  }

  int? _extractPostId(dynamic rawData) {
    if (rawData is! Map) return null;

    int? toInt(dynamic value) {
      if (value is int) return value;
      if (value is String) return int.tryParse(value);
      return null;
    }

    final directId = toInt(rawData['id']);
    if (directId != null) return directId;

    final post = rawData['post'];
    if (post is Map) {
      final postId = toInt(post['id']);
      if (postId != null) return postId;
    }

    final data = rawData['data'];
    if (data is Map) {
      final dataId = toInt(data['id'] ?? data['post_id']);
      if (dataId != null) return dataId;
    }

    final postId = toInt(rawData['post_id']);
    if (postId != null) return postId;

    return null;
  }

  /// 判断是否需要重试
  ///
  /// [error] Dio 异常
  /// 返回 true 表示需要重试
  bool _shouldRetry(DioException error) {
    // 网络连接错误、超时错误、服务器错误需要重试
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return true;
      case DioExceptionType.badResponse:
        // 服务器错误（5xx）需要重试
        final statusCode = error.response?.statusCode;
        return statusCode != null && statusCode >= 500 && statusCode < 600;
      default:
        return false;
    }
  }

  /// 处理 Dio 异常
  ///
  /// [error] Dio 异常
  /// 返回 [CommentResult] 失败结果
  CommentResult _handleDioError(DioException error, {String? content}) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return CommentResult.failure(
          _buildFriendlyCreateErrorMessage('网络连接超时，请检查网络后重试', content: content),
        );
      case DioExceptionType.connectionError:
        return CommentResult.failure(
          _buildFriendlyCreateErrorMessage('网络连接失败，请检查网络设置', content: content),
        );
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data as Map<String, dynamic>?;

        if (statusCode == 401) {
          return CommentResult.failure(
            _buildFriendlyCreateErrorMessage(
              '未登录或登录已过期，请重新登录',
              content: content,
            ),
          );
        } else if (statusCode == 403) {
          // 可能是 CSRF Token 问题
          return CommentResult.failure(
            _buildFriendlyCreateErrorMessage(
              '权限验证失败，请刷新页面后重试',
              content: content,
            ),
          );
        } else if (statusCode == 422) {
          final errors = data?['errors'];
          if (errors != null && errors is List && errors.isNotEmpty) {
            return CommentResult.failure(
              _buildFriendlyCreateErrorMessage(
                errors.first.toString(),
                content: content,
              ),
            );
          }
          return CommentResult.failure(
            _buildFriendlyCreateErrorMessage('请求参数验证失败', content: content),
          );
        } else if (statusCode == 429) {
          return CommentResult.failure(
            _buildFriendlyCreateErrorMessage('操作过于频繁，请稍后再试', content: content),
          );
        } else {
          return CommentResult.failure(
            _buildFriendlyCreateErrorMessage(
              '服务器错误: HTTP $statusCode',
              content: content,
            ),
          );
        }
      case DioExceptionType.cancel:
        return CommentResult.failure(
          _buildFriendlyCreateErrorMessage('请求已取消', content: content),
        );
      default:
        return CommentResult.failure(
          _buildFriendlyCreateErrorMessage(
            '网络请求失败: ${error.message}',
            content: content,
          ),
        );
    }
  }

  /// 上传评论图片（照片/表情包）
  Future<CommentImageUploadResult> uploadCommentImage({
    required String filePath,
    String? fileName,
  }) async {
    try {
      final response = await _discourseApi.uploadImage(
        filePath: filePath,
        fileName: fileName,
      );
      final statusCode = response.statusCode ?? 0;

      if (statusCode != 200 && statusCode != 201) {
        return CommentImageUploadResult.failure('图片上传失败，请稍后重试。');
      }

      final data = response.data;
      if (data is! Map<String, dynamic>) {
        return CommentImageUploadResult.failure('图片上传失败，服务器返回格式异常。');
      }

      final markdown = _extractUploadMarkdown(data, fileName: fileName);
      if (markdown == null || markdown.isEmpty) {
        return CommentImageUploadResult.failure('图片上传失败，未获取到可用图片地址。');
      }

      return CommentImageUploadResult.success(markdown);
    } on DioException catch (error) {
      return CommentImageUploadResult.failure(
        _buildFriendlyUploadErrorMessage(error),
      );
    } catch (_) {
      return CommentImageUploadResult.failure('图片上传失败，请稍后重试。');
    }
  }

  String? _extractUploadMarkdown(
    Map<String, dynamic> payload, {
    String? fileName,
  }) {
    final markdown = payload['markdown'];
    if (markdown is String && markdown.trim().isNotEmpty) {
      return markdown.trim();
    }

    String? toImageUrl(dynamic value) {
      if (value is! String || value.trim().isEmpty) return null;
      final text = value.trim();
      if (text.startsWith('http://') || text.startsWith('https://')) {
        return text;
      }
      if (text.startsWith('/')) {
        return 'https://forum.trae.cn$text';
      }
      return text;
    }

    final candidates = <dynamic>[
      payload['url'],
      payload['short_url'],
      payload['upload_url'],
      payload['secure_upload_url'],
    ];
    final imageUrl = candidates
        .map(toImageUrl)
        .firstWhere((item) => item != null, orElse: () => null);
    if (imageUrl == null) {
      return null;
    }

    final alt = (fileName == null || fileName.trim().isEmpty)
        ? 'image'
        : fileName.trim();
    return '![$alt]($imageUrl)';
  }

  bool _containsImageContent(String? content) {
    if (content == null || content.trim().isEmpty) {
      return false;
    }
    final text = content.trim();
    final lower = text.toLowerCase();
    return lower.contains('upload://') ||
        RegExp(r'!\[[^\]]*]\([^)]+\)').hasMatch(text) ||
        RegExp(r'https?://\S+\.(png|jpe?g|gif|webp|bmp)').hasMatch(lower);
  }

  String _buildFriendlyCreateErrorMessage(
    String? rawMessage, {
    String? content,
  }) {
    final isImageContent = _containsImageContent(content);
    final fallback = isImageContent ? '发送表情包失败，请稍后重试。' : '回复发送失败，请稍后重试。';
    final message = rawMessage?.trim() ?? '';
    if (message.isEmpty) {
      return fallback;
    }

    final lower = message.toLowerCase();
    if (lower.contains('too short')) {
      return isImageContent ? '发送表情包失败，内容过短，请补充文字后重试。' : '回复发送失败，内容过短，请补充后重试。';
    }
    if (lower.contains('rate limit') || lower.contains('too many requests')) {
      return isImageContent ? '发送表情包失败，操作过于频繁，请稍后再试。' : '回复发送失败，操作过于频繁，请稍后再试。';
    }
    if (lower.contains('not authorized') ||
        lower.contains('forbidden') ||
        lower.contains('permission')) {
      return isImageContent ? '发送表情包失败，当前账号暂无上传权限。' : '回复发送失败，当前操作权限不足。';
    }

    final hasPunctuation = RegExp(r'[。！？.!?]$').hasMatch(message);
    final normalized = hasPunctuation ? message : '$message。';
    if (normalized.startsWith('发送表情包失败') || normalized.startsWith('回复发送失败')) {
      return normalized;
    }
    return isImageContent ? '发送表情包失败：$normalized' : '回复发送失败：$normalized';
  }

  String _buildFriendlyUploadErrorMessage(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return '上传表情包失败，网络连接超时，请稍后重试。';
      case DioExceptionType.connectionError:
        return '上传表情包失败，请检查网络连接后重试。';
      case DioExceptionType.badResponse:
        final code = error.response?.statusCode;
        if (code == 401 || code == 403) {
          return '上传表情包失败，请先登录并确认上传权限。';
        }
        if (code == 413) {
          return '上传表情包失败，图片体积过大，请压缩后重试。';
        }
        if (code == 415 || code == 422) {
          return '上传表情包失败，请选择受支持的图片格式。';
        }
        if (code == 429) {
          return '上传表情包失败，操作过于频繁，请稍后再试。';
        }
        return '上传表情包失败，服务器暂时不可用（HTTP $code）。';
      default:
        return '上传表情包失败，请稍后重试。';
    }
  }

  /// 点赞评论
  ///
  /// [id] 评论 ID
  Future<api.LikeReplyResponse> likeComment({required String id}) async {
    return await _apiService.postLikeReply(url: '', id: id);
  }

  /// 取消点赞评论
  ///
  /// [id] 评论 ID
  Future<api.LikeReplyResponse> unlikeComment({required String id}) async {
    return await _apiService.postLikeReply(url: '', id: id);
  }

  /// 删除评论
  ///
  /// [id] 评论 ID
  Future<api.LikeReplyResponse> deleteComment({required String id}) async {
    return await _apiService.postDelete(url: '', id: id);
  }

  // ==================== 草稿相关方法 ====================

  /// 保存草稿
  ///
  /// [topicId] 话题ID
  /// [content] 草稿内容
  /// [replyToPostNumber] 回复目标楼层号（可选）
  /// @return 是否保存成功
  Future<bool> saveDraft({
    required int topicId,
    required String content,
    int? replyToPostNumber,
  }) async {
    try {
      final draftKey = replyToPostNumber != null
          ? 'topic_${topicId}_$replyToPostNumber'
          : 'topic_$topicId';

      final response = await _discourseApi.saveDraft(
        draftKey: draftKey,
        data: content,
        sequence: DraftSequence.next(),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// 获取草稿
  ///
  /// [topicId] 话题ID
  /// [replyToPostNumber] 回复目标楼层号（可选）
  /// @return 草稿模型，如果没有则返回null
  Future<DraftModel?> getDraft({
    required int topicId,
    int? replyToPostNumber,
  }) async {
    try {
      final draftKey = replyToPostNumber != null
          ? 'topic_${topicId}_$replyToPostNumber'
          : 'topic_$topicId';

      final response = await _discourseApi.getDraft(draftKey);

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>?;
        final draftData = data?['draft'] as String?;

        if (draftData != null && draftData.isNotEmpty) {
          return DraftModel.create(
            topicId: topicId,
            content: draftData,
            replyToPostNumber: replyToPostNumber,
          );
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// 删除草稿
  ///
  /// [topicId] 话题ID
  /// [replyToPostNumber] 回复目标楼层号（可选）
  Future<void> deleteDraft({
    required int topicId,
    int? replyToPostNumber,
  }) async {
    try {
      final draftKey = replyToPostNumber != null
          ? 'topic_${topicId}_$replyToPostNumber'
          : 'topic_$topicId';

      await _discourseApi.deleteDraft(
        draftKey: draftKey,
        sequence: DraftSequence.next(),
      );
    } catch (e) {
      // 忽略删除错误
    }
  }

  // ==================== 编辑相关方法 ====================

  /// 编辑评论
  ///
  /// [postId] 帖子ID
  /// [content] 新的评论内容
  /// [editReason] 编辑原因（可选）
  /// @return 操作结果
  Future<CommentResult> editComment({
    required int postId,
    required String content,
    String? editReason,
  }) async {
    try {
      final response = await _discourseApi.editPost(
        postId: postId,
        raw: content,
        editReason: editReason,
      );

      final data = response.data as Map<String, dynamic>?;

      if (response.statusCode == 200 && data != null) {
        // 处理 id 可能是字符串或整数的情况
        final idValue = data['id'];
        int? updatedPostId;
        if (idValue is int) {
          updatedPostId = idValue;
        } else if (idValue is String) {
          updatedPostId = int.tryParse(idValue);
        }
        return CommentResult.success(postId: updatedPostId);
      } else if (response.statusCode == 403) {
        return CommentResult.failure('权限不足，无法编辑此评论');
      } else if (response.statusCode == 422) {
        final errors = data?['errors'];
        if (errors != null && errors is List && errors.isNotEmpty) {
          return CommentResult.failure(errors.first.toString());
        }
        return CommentResult.failure('请求参数错误');
      } else {
        return CommentResult.failure('编辑失败: HTTP ${response.statusCode}');
      }
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return CommentResult.failure('编辑评论时发生错误: $e');
    }
  }

  /// 删除评论（使用Discourse API）
  ///
  /// [postId] 帖子ID
  /// [forceDestroy] 是否强制删除（管理员使用）
  /// @return 操作结果
  Future<CommentResult> deletePost({
    required int postId,
    bool forceDestroy = false,
  }) async {
    try {
      final response = await _discourseApi.deletePost(
        postId: postId,
        forceDestroy: forceDestroy,
      );

      if (response.statusCode == 200) {
        return CommentResult.success();
      } else if (response.statusCode == 403) {
        return CommentResult.failure('权限不足，无法删除此评论');
      } else if (response.statusCode == 404) {
        return CommentResult.failure('评论不存在或已被删除');
      } else {
        return CommentResult.failure('删除失败: HTTP ${response.statusCode}');
      }
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return CommentResult.failure('删除评论时发生错误: $e');
    }
  }

  // ==================== 点赞相关方法 ====================

  /// 点赞帖子
  ///
  /// [postId] 帖子ID
  /// @return 操作结果
  Future<CommentResult> likePost(int postId) async {
    try {
      final response = await _discourseApi.likePost(postId);

      if (response.statusCode == 200) {
        return CommentResult.success();
      } else {
        return CommentResult.failure('点赞失败: HTTP ${response.statusCode}');
      }
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return CommentResult.failure('点赞时发生错误: $e');
    }
  }

  /// 取消点赞帖子
  ///
  /// [postId] 帖子ID
  /// @return 操作结果
  Future<CommentResult> unlikePost(int postId) async {
    try {
      final response = await _discourseApi.unlikePost(postId);

      if (response.statusCode == 200) {
        return CommentResult.success();
      } else {
        return CommentResult.failure('取消点赞失败: HTTP ${response.statusCode}');
      }
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return CommentResult.failure('取消点赞时发生错误: $e');
    }
  }
}
