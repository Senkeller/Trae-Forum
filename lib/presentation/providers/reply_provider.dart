import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/reply_result.dart';
import '../../data/models/draft_model.dart';
import '../../data/repositories/comment_repository.dart';

part 'reply_provider.freezed.dart';
part 'reply_provider.g.dart';

/// 回复状态
///
/// 管理回复操作的状态，包括加载状态、错误信息和成功状态
@freezed
class ReplyState with _$ReplyState {
  /// 构造函数
  ///
  /// [isLoading] 是否正在发送
  /// [error] 错误信息
  /// [success] 是否发送成功
  /// [postId] 创建的帖子ID
  /// [draftSaved] 草稿是否已保存
  const factory ReplyState({
    @Default(false) bool isLoading,
    String? error,
    @Default(false) bool success,
    int? postId,
    @Default(false) bool draftSaved,
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

  /// 发送回复
  ///
  /// [topicId] 话题ID
  /// [content] 回复内容
  /// [replyToPostNumber] 回复的目标楼层号（可选，用于楼中楼）
  /// @return 操作结果
  Future<ReplyResult> sendReply({
    required int topicId,
    required String content,
    int? replyToPostNumber,
  }) async {
    if (content.trim().isEmpty) {
      state = state.copyWith(
        error: '回复内容不能为空',
        success: false,
      );
      return ReplyResult.failure('回复内容不能为空');
    }

    state = state.copyWith(isLoading: true, error: null, success: false);

    try {
      final repository = ref.read(commentRepositoryProvider);
      final result = await repository.createComment(
        topicId: topicId,
        content: content.trim(),
        replyToPostNumber: replyToPostNumber,
      );

      if (result.success) {
        state = state.copyWith(
          isLoading: false,
          success: true,
          postId: result.postId,
          draftSaved: false,
        );
        return ReplyResult.success(postId: result.postId);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result.errorMessage,
          success: false,
        );
        return ReplyResult.failure(result.errorMessage ?? '发送失败');
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        success: false,
      );
      return ReplyResult.failure(e.toString());
    }
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
      return false;
    }

    try {
      final repository = ref.read(commentRepositoryProvider);
      final result = await repository.saveDraft(
        topicId: topicId,
        content: content.trim(),
        replyToPostNumber: replyToPostNumber,
      );

      state = state.copyWith(draftSaved: result);
      return result;
    } catch (e) {
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
    try {
      final repository = ref.read(commentRepositoryProvider);
      return await repository.getDraft(
        topicId: topicId,
        replyToPostNumber: replyToPostNumber,
      );
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
  /// @return 操作结果
  Future<ReplyResult> editReply({
    required int postId,
    required String content,
  }) async {
    if (content.trim().isEmpty) {
      return ReplyResult.failure('回复内容不能为空');
    }

    state = state.copyWith(isLoading: true, error: null, success: false);

    try {
      final repository = ref.read(commentRepositoryProvider);
      final result = await repository.editComment(
        postId: postId,
        content: content.trim(),
      );

      if (result.success) {
        state = state.copyWith(
          isLoading: false,
          success: true,
        );
        return ReplyResult.success();
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result.errorMessage,
          success: false,
        );
        return ReplyResult.failure(result.errorMessage ?? '编辑失败');
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        success: false,
      );
      return ReplyResult.failure(e.toString());
    }
  }

  /// 删除回复
  ///
  /// [postId] 帖子ID
  /// @return 操作结果
  Future<ReplyResult> deleteReply(int postId) async {
    state = state.copyWith(isLoading: true, error: null, success: false);

    try {
      final repository = ref.read(commentRepositoryProvider);
      final result = await repository.deleteComment(id: postId.toString());

      // 根据现有API返回类型判断
      state = state.copyWith(isLoading: false);
      return ReplyResult.success();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return ReplyResult.failure(e.toString());
    }
  }

  /// 重置状态
  void reset() {
    state = ReplyState.initial();
  }

  /// 清除错误
  void clearError() {
    state = state.copyWith(error: null);
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
