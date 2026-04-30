import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/utils/draft_normalizer.dart';
import '../../data/models/reply_result.dart';
import '../../data/models/draft_model.dart';
import '../../data/models/comment.dart';
import '../../data/repositories/comment_repository.dart';

part 'reply_provider.freezed.dart';
part 'reply_provider.g.dart';

/// 回复操作类型
///
/// 用于区分不同的回复操作类型
enum ReplyOperationType {
  /// 发送回复
  send,

  /// 编辑回复
  edit,

  /// 删除回复
  delete,

  /// 保存草稿
  saveDraft,

  /// 加载草稿
  loadDraft,
}

/// 加载状态
///
/// 更详细的加载状态枚举
enum LoadingState {
  /// 空闲状态
  idle,

  /// 正在加载
  loading,

  /// 加载成功
  success,

  /// 加载失败
  error,

  /// 正在重试
  retrying,
}

/// 回复状态
///
/// 管理回复操作的状态，包括加载状态、错误信息和成功状态
@freezed
class ReplyState with _$ReplyState {
  /// 构造函数
  ///
  /// [isLoading] 是否正在发送
  /// [loadingState] 详细的加载状态
  /// [error] 错误信息
  /// [errorCode] 错误码
  /// [success] 是否发送成功
  /// [postId] 创建的帖子ID
  /// [draftSaved] 草稿是否已保存
  /// [retryCount] 当前重试次数
  /// [maxRetries] 最大重试次数
  /// [operationType] 当前操作类型
  const factory ReplyState({
    @Default(false) bool isLoading,
    @Default(LoadingState.idle) LoadingState loadingState,
    String? error,
    String? errorCode,
    @Default(false) bool success,
    int? postId,
    @Default(false) bool draftSaved,
    @Default(0) int retryCount,
    @Default(3) int maxRetries,
    ReplyOperationType? operationType,
  }) = _ReplyState;

  /// 初始状态
  factory ReplyState.initial() => const ReplyState();
}

/// 回复目标状态
///
/// 用于管理当前回复的目标（楼中楼回复）
@freezed
class ReplyTarget with _$ReplyTarget {
  /// 构造函数
  ///
  /// [postNumber] 目标帖子编号
  /// [username] 目标用户名
  /// [content] 目标内容预览
  const factory ReplyTarget({
    required int postNumber,
    required String username,
    String? content,
  }) = _ReplyTarget;
}

/// 回复状态管理器
///
/// 处理回复相关的业务逻辑，包括发送回复、保存草稿等
@riverpod
class ReplyNotifier extends _$ReplyNotifier {
  @override
  ReplyState build() {
    return ReplyState.initial();
  }

  /// 错误码映射表
  ///
  /// 将技术错误码/错误信息映射为用户友好的文案
  static const Map<String, String> _errorCodeMap = {
    // HTTP 状态码
    '401': '登录已过期，请重新登录后再试',
    '403': '权限验证失败，请刷新页面后重试',
    '404': '内容不存在或已被删除',
    '422': '回复内容验证失败，请检查内容后重试',
    '429': '操作过于频繁，请稍后再试',
    '500': '服务器内部错误，请稍后重试',
    '502': '网关错误，请稍后重试',
    '503': '服务暂时不可用，请稍后重试',
    '504': '网关超时，请稍后重试',
    // 网络错误
    'timeout': '网络连接超时，请检查网络后重试',
    'connection_error': '网络连接失败，请检查网络设置',
    'network_error': '网络异常，请检查网络连接',
    // 业务错误
    'empty_content': '回复内容不能为空',
    'content_too_short': '回复内容过短，请补充后重试',
    'content_too_long': '回复内容过长，请精简后重试',
    'rate_limited': '操作过于频繁，请稍后再试',
    'not_authorized': '当前账号暂无操作权限',
    'csrf_error': '安全验证失败，请刷新页面后重试',
  };

  /// 将原始错误转换为用户友好的错误信息
  ///
  /// [error] 原始错误对象或错误信息
  /// [errorCode] 可选的错误码
  /// @return 用户友好的错误信息
  String _mapErrorToUserMessage(dynamic error, {String? errorCode}) {
    final errorString = error.toString().toLowerCase();

    // 优先使用错误码映射
    if (errorCode != null && _errorCodeMap.containsKey(errorCode)) {
      return _errorCodeMap[errorCode]!;
    }

    // 根据错误内容匹配
    if (errorString.contains('401') ||
        errorString.contains('unauthorized') ||
        errorString.contains('未登录')) {
      return _errorCodeMap['401']!;
    }
    if (errorString.contains('403') ||
        errorString.contains('forbidden') ||
        errorString.contains('权限')) {
      return _errorCodeMap['403']!;
    }
    if (errorString.contains('404') || errorString.contains('not found')) {
      return _errorCodeMap['404']!;
    }
    if (errorString.contains('422') || errorString.contains('validation')) {
      return _errorCodeMap['422']!;
    }
    if (errorString.contains('429') ||
        errorString.contains('rate limit') ||
        errorString.contains('too many requests')) {
      return _errorCodeMap['429']!;
    }
    if (errorString.contains('timeout') || errorString.contains('超时')) {
      return _errorCodeMap['timeout']!;
    }
    if (errorString.contains('connection') ||
        errorString.contains('连接失败') ||
        errorString.contains('socket')) {
      return _errorCodeMap['connection_error']!;
    }
    if (errorString.contains('too short') || errorString.contains('过短')) {
      return _errorCodeMap['content_too_short']!;
    }
    if (errorString.contains('csrf')) {
      return _errorCodeMap['csrf_error']!;
    }

    // 默认错误信息
    return '操作失败，请稍后重试';
  }

  /// 提取错误码
  ///
  /// [error] 错误对象
  /// @return 错误码字符串
  String? _extractErrorCode(dynamic error) {
    final errorString = error.toString();

    // 尝试提取 HTTP 状态码
    final statusCodeMatch = RegExp(r'(\d{3})').firstMatch(errorString);
    if (statusCodeMatch != null) {
      final code = statusCodeMatch.group(1);
      if (code != null &&
          [
            '401',
            '403',
            '404',
            '422',
            '429',
            '500',
            '502',
            '503',
            '504',
          ].contains(code)) {
        return code;
      }
    }

    // 根据错误内容判断
    final lowerError = errorString.toLowerCase();
    if (lowerError.contains('timeout')) return 'timeout';
    if (lowerError.contains('connection')) return 'connection_error';
    if (lowerError.contains('csrf')) return 'csrf_error';

    return null;
  }

  /// 发送回复
  ///
  /// [topicId] 话题ID
  /// [content] 回复内容
  /// [replyToPostNumber] 回复的目标楼层号（可选，用于楼中楼）
  /// [enableRetry] 是否启用自动重试，默认 true
  /// @return 操作结果
  Future<ReplyResult> sendReply({
    required int topicId,
    required String content,
    int? replyToPostNumber,
    bool enableRetry = true,
  }) async {
    if (content.trim().isEmpty) {
      final errorMessage = _errorCodeMap['empty_content']!;
      state = state.copyWith(
        isLoading: false,
        loadingState: LoadingState.error,
        error: errorMessage,
        errorCode: 'empty_content',
        success: false,
        operationType: ReplyOperationType.send,
      );
      return ReplyResult.failure(errorMessage);
    }

    state = state.copyWith(
      isLoading: true,
      loadingState: LoadingState.loading,
      error: null,
      errorCode: null,
      success: false,
      retryCount: 0,
      operationType: ReplyOperationType.send,
    );

    return _executeWithRetry(
      operation: () async {
        final repository = ref.read(commentRepositoryProvider);
        return await repository.createComment(
          topicId: topicId,
          content: content.trim(),
          replyToPostNumber: replyToPostNumber,
        );
      },
      onSuccess: (result) {
        state = state.copyWith(
          isLoading: false,
          loadingState: LoadingState.success,
          success: true,
          postId: result.postId,
          draftSaved: false,
          retryCount: 0,
        );
        return ReplyResult.success(postId: result.postId);
      },
      onError: (error, errorCode) {
        final userMessage = _mapErrorToUserMessage(error, errorCode: errorCode);
        state = state.copyWith(
          isLoading: false,
          loadingState: LoadingState.error,
          error: userMessage,
          errorCode: errorCode,
          success: false,
        );
        return ReplyResult.failure(userMessage);
      },
      enableRetry: enableRetry,
    );
  }

  /// 带重试机制的执行器
  ///
  /// [operation] 实际执行的操作
  /// [onSuccess] 成功回调
  /// [onError] 错误回调
  /// [enableRetry] 是否启用重试
  /// @return 操作结果
  Future<ReplyResult> _executeWithRetry({
    required Future<CommentResult> Function() operation,
    required ReplyResult Function(CommentResult result) onSuccess,
    required ReplyResult Function(dynamic error, String? errorCode) onError,
    bool enableRetry = true,
  }) async {
    int attempts = 0;
    const maxAttempts = 3;

    while (attempts < maxAttempts) {
      try {
        attempts++;
        final result = await operation();

        if (result.success) {
          return onSuccess(result);
        } else {
          // 业务逻辑错误，不重试
          final errorCode = _extractErrorCode(result.errorMessage);
          return onError(result.errorMessage, errorCode);
        }
      } catch (e) {
        final errorCode = _extractErrorCode(e);

        // 判断是否可重试
        if (enableRetry &&
            attempts < maxAttempts &&
            _isRetryableError(errorCode, e)) {
          state = state.copyWith(
            loadingState: LoadingState.retrying,
            retryCount: attempts,
          );

          // 指数退避策略
          await Future.delayed(Duration(milliseconds: 500 * attempts));
          continue;
        }

        // 不可重试或已达到最大重试次数
        return onError(e, errorCode);
      }
    }

    return onError('已达到最大重试次数', 'max_retries_exceeded');
  }

  /// 判断错误是否可重试
  ///
  /// [errorCode] 错误码
  /// [error] 错误对象
  /// @return 是否可重试
  bool _isRetryableError(String? errorCode, dynamic error) {
    // 网络超时、连接错误可重试
    if (errorCode == 'timeout' || errorCode == 'connection_error') {
      return true;
    }

    // 服务器错误（5xx）可重试
    if (errorCode != null && ['500', '502', '503', '504'].contains(errorCode)) {
      return true;
    }

    // 限流错误可重试
    if (errorCode == '429') {
      return true;
    }

    final errorString = error.toString().toLowerCase();
    if (errorString.contains('timeout') ||
        errorString.contains('connection') ||
        errorString.contains('socket')) {
      return true;
    }

    return false;
  }

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
    if (content.trim().isEmpty) {
      state = state.copyWith(
        loadingState: LoadingState.error,
        error: '草稿内容不能为空',
        errorCode: 'empty_content',
        operationType: ReplyOperationType.saveDraft,
      );
      return false;
    }

    state = state.copyWith(
      isLoading: true,
      loadingState: LoadingState.loading,
      error: null,
      errorCode: null,
      operationType: ReplyOperationType.saveDraft,
    );

    try {
      final repository = ref.read(commentRepositoryProvider);
      final result = await repository.saveDraft(
        topicId: topicId,
        content: content.trim(),
        replyToPostNumber: replyToPostNumber,
      );

      state = state.copyWith(
        isLoading: false,
        loadingState: result ? LoadingState.success : LoadingState.error,
        draftSaved: result,
        error: result ? null : '草稿保存失败',
        errorCode: result ? null : 'save_failed',
      );
      return result;
    } catch (e) {
      final errorCode = _extractErrorCode(e);
      final userMessage = _mapErrorToUserMessage(e, errorCode: errorCode);
      state = state.copyWith(
        isLoading: false,
        loadingState: LoadingState.error,
        error: userMessage,
        errorCode: errorCode,
      );
      return false;
    }
  }

  /// 加载草稿
  ///
  /// [topicId] 话题ID
  /// [replyToPostNumber] 回复目标楼层号（可选）
  /// @return 草稿内容，如果没有则返回null
  Future<DraftModel?> loadDraft({
    required int topicId,
    int? replyToPostNumber,
  }) async {
    state = state.copyWith(
      isLoading: true,
      loadingState: LoadingState.loading,
      error: null,
      errorCode: null,
      operationType: ReplyOperationType.loadDraft,
    );

    try {
      final repository = ref.read(commentRepositoryProvider);
      final draft = await repository.getDraft(
        topicId: topicId,
        replyToPostNumber: replyToPostNumber,
      );
      final normalizedDraft = draft == null
          ? null
          : draft.copyWith(
              content:
                  DraftNormalizer.normalize(draft.content).content?.trim() ??
                  draft.content,
            );

      state = state.copyWith(
        isLoading: false,
        loadingState: LoadingState.success,
      );
      return normalizedDraft;
    } catch (e) {
      final errorCode = _extractErrorCode(e);
      final userMessage = _mapErrorToUserMessage(e, errorCode: errorCode);
      state = state.copyWith(
        isLoading: false,
        loadingState: LoadingState.error,
        error: userMessage,
        errorCode: errorCode,
      );
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
      final repository = ref.read(commentRepositoryProvider);
      await repository.deleteDraft(
        topicId: topicId,
        replyToPostNumber: replyToPostNumber,
      );
      state = state.copyWith(draftSaved: false);
    } catch (e) {
      // 忽略删除错误
    }
  }

  /// 编辑回复
  ///
  /// [postId] 帖子ID
  /// [content] 新的内容
  /// [enableRetry] 是否启用自动重试，默认 true
  /// @return 操作结果
  Future<ReplyResult> editReply({
    required int postId,
    required String content,
    bool enableRetry = true,
  }) async {
    if (content.trim().isEmpty) {
      final errorMessage = _errorCodeMap['empty_content']!;
      state = state.copyWith(
        isLoading: false,
        loadingState: LoadingState.error,
        error: errorMessage,
        errorCode: 'empty_content',
        success: false,
        operationType: ReplyOperationType.edit,
      );
      return ReplyResult.failure(errorMessage);
    }

    state = state.copyWith(
      isLoading: true,
      loadingState: LoadingState.loading,
      error: null,
      errorCode: null,
      success: false,
      retryCount: 0,
      operationType: ReplyOperationType.edit,
    );

    return _executeWithRetry(
      operation: () async {
        final repository = ref.read(commentRepositoryProvider);
        return await repository.editComment(
          postId: postId,
          content: content.trim(),
        );
      },
      onSuccess: (result) {
        state = state.copyWith(
          isLoading: false,
          loadingState: LoadingState.success,
          success: true,
          retryCount: 0,
        );
        return ReplyResult.success();
      },
      onError: (error, errorCode) {
        final userMessage = _mapErrorToUserMessage(error, errorCode: errorCode);
        state = state.copyWith(
          isLoading: false,
          loadingState: LoadingState.error,
          error: userMessage,
          errorCode: errorCode,
          success: false,
        );
        return ReplyResult.failure(userMessage);
      },
      enableRetry: enableRetry,
    );
  }

  /// 删除回复
  ///
  /// [postId] 帖子ID
  /// [enableRetry] 是否启用自动重试，默认 true
  /// @return 操作结果
  Future<ReplyResult> deleteReply(int postId, {bool enableRetry = true}) async {
    state = state.copyWith(
      isLoading: true,
      loadingState: LoadingState.loading,
      error: null,
      errorCode: null,
      success: false,
      retryCount: 0,
      operationType: ReplyOperationType.delete,
    );

    return _executeWithRetry(
      operation: () async {
        final repository = ref.read(commentRepositoryProvider);
        return await repository.deletePost(postId: postId);
      },
      onSuccess: (result) {
        state = state.copyWith(
          isLoading: false,
          loadingState: LoadingState.success,
          success: true,
          retryCount: 0,
        );
        return ReplyResult.success();
      },
      onError: (error, errorCode) {
        final userMessage = _mapErrorToUserMessage(error, errorCode: errorCode);
        state = state.copyWith(
          isLoading: false,
          loadingState: LoadingState.error,
          error: userMessage,
          errorCode: errorCode,
          success: false,
        );
        return ReplyResult.failure(userMessage);
      },
      enableRetry: enableRetry,
    );
  }

  /// 重置状态
  void reset() {
    state = ReplyState.initial();
  }

  /// 清除错误
  void clearError() {
    state = state.copyWith(
      error: null,
      errorCode: null,
      loadingState: state.loadingState == LoadingState.error
          ? LoadingState.idle
          : state.loadingState,
    );
  }

  /// 手动重试
  ///
  /// 根据当前操作类型重新执行上一次失败的操作
  /// @return 操作结果
  Future<ReplyResult?> retry({
    required int topicId,
    String? content,
    int? replyToPostNumber,
    int? postId,
  }) async {
    final operationType = state.operationType;
    if (operationType == null) {
      return null;
    }

    switch (operationType) {
      case ReplyOperationType.send:
        if (content != null) {
          return sendReply(
            topicId: topicId,
            content: content,
            replyToPostNumber: replyToPostNumber,
          );
        }
        break;
      case ReplyOperationType.edit:
        if (postId != null && content != null) {
          return editReply(postId: postId, content: content);
        }
        break;
      case ReplyOperationType.delete:
        if (postId != null) {
          return deleteReply(postId);
        }
        break;
      case ReplyOperationType.saveDraft:
        if (content != null) {
          await saveDraft(
            topicId: topicId,
            content: content,
            replyToPostNumber: replyToPostNumber,
          );
        }
        break;
      case ReplyOperationType.loadDraft:
        await loadDraft(topicId: topicId, replyToPostNumber: replyToPostNumber);
        break;
    }
    return null;
  }

  /// 检查当前操作是否可以重试
  ///
  /// @return 是否可以重试
  bool get canRetry {
    return state.loadingState == LoadingState.error &&
        state.errorCode != null &&
        _isRetryableError(state.errorCode, state.error);
  }

  /// 获取当前加载状态描述
  ///
  /// @return 状态描述文本
  String get loadingStateText {
    switch (state.loadingState) {
      case LoadingState.idle:
        return '空闲';
      case LoadingState.loading:
        return '加载中...';
      case LoadingState.success:
        return '成功';
      case LoadingState.error:
        return '错误';
      case LoadingState.retrying:
        return '重试中 (${state.retryCount}/${state.maxRetries})...';
    }
  }
}

/// 当前回复目标Provider
///
/// 用于管理当前正在回复的目标（楼中楼回复）
@riverpod
class CurrentReplyTarget extends _$CurrentReplyTarget {
  @override
  ReplyTarget? build() {
    return null;
  }

  /// 设置回复目标
  ///
  /// [postNumber] 目标帖子编号
  /// [username] 目标用户名
  /// [content] 目标内容预览
  void setTarget({
    required int postNumber,
    required String username,
    String? content,
  }) {
    state = ReplyTarget(
      postNumber: postNumber,
      username: username,
      content: content,
    );
  }

  /// 清除回复目标
  void clearTarget() {
    state = null;
  }
}

/// 回复草稿内容Provider
///
/// 用于管理回复输入框的草稿内容
@riverpod
class ReplyDraft extends _$ReplyDraft {
  @override
  String build() {
    return '';
  }

  /// 设置草稿内容
  void setContent(String content) {
    state = content;
  }

  /// 清除草稿内容
  void clear() {
    state = '';
  }
}

/// 话题回复列表刷新触发器
///
/// 用于触发回复列表的刷新
@riverpod
class ReplyListRefresh extends _$ReplyListRefresh {
  @override
  int build() {
    return 0;
  }

  /// 触发刷新
  void refresh() {
    state++;
  }
}
