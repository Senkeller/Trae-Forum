import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/bookmark_repository.dart';

/// 帖子收藏状态
class PostBookmarkState {
  final int topicId;
  final int? bookmarkId;
  final bool isBookmarked;
  final bool isLoading;
  final String? errorMessage;

  PostBookmarkState({
    required this.topicId,
    this.bookmarkId,
    this.isBookmarked = false,
    this.isLoading = false,
    this.errorMessage,
  });

  PostBookmarkState copyWith({
    int? topicId,
    int? bookmarkId,
    bool? isBookmarked,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PostBookmarkState(
      topicId: topicId ?? this.topicId,
      bookmarkId: bookmarkId ?? this.bookmarkId,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

/// 收藏状态管理器
class BookmarkNotifier extends StateNotifier<Map<int, PostBookmarkState>> {
  final BookmarkRepository _bookmarkRepository;

  BookmarkNotifier(this._bookmarkRepository) : super({});

  /// 初始化帖子收藏状态
  void initializePost(int topicId, {int? bookmarkId, bool isBookmarked = false}) {
    if (!state.containsKey(topicId)) {
      state = {
        ...state,
        topicId: PostBookmarkState(
          topicId: topicId,
          bookmarkId: bookmarkId,
          isBookmarked: isBookmarked,
        ),
      };
    }
  }

  /// 同步帖子收藏状态（存在则更新，不存在则创建）
  void syncPost(int topicId, {int? bookmarkId, required bool isBookmarked}) {
    final currentState = state[topicId];
    final nextState = (currentState ?? PostBookmarkState(topicId: topicId))
        .copyWith(
          bookmarkId: bookmarkId,
          isBookmarked: isBookmarked,
          isLoading: false,
          errorMessage: null,
        );

    state = {
      ...state,
      topicId: nextState,
    };
  }

  /// 切换收藏状态
  Future<void> toggleBookmark(int topicId, {int? bookmarkId}) async {
    final currentState = state[topicId];
    if (currentState == null || currentState.isLoading) return;

    // 如果已收藏，执行删除
    if (currentState.isBookmarked) {
      final resolvedBookmarkId = currentState.bookmarkId ??
          bookmarkId ??
          await _bookmarkRepository.findBookmarkIdByTopicId(topicId);
      if (resolvedBookmarkId != null) {
        await _deleteBookmark(topicId, resolvedBookmarkId);
      } else {
        state = {
          ...state,
          topicId: currentState.copyWith(
            isBookmarked: false,
            isLoading: false,
            bookmarkId: null,
            errorMessage: null,
          ),
        };
      }
    } else {
      // 如果未收藏，执行添加
      await _createBookmark(topicId);
    }
  }

  /// 添加收藏
  Future<void> _createBookmark(int topicId) async {
    final currentState = state[topicId] ?? PostBookmarkState(topicId: topicId);

    state = {
      ...state,
      topicId: currentState.copyWith(isLoading: true, errorMessage: null),
    };

    final result = await _bookmarkRepository.createBookmark(topicId: topicId);

    if (result.success) {
      state = {
        ...state,
        topicId: currentState.copyWith(
          isLoading: false,
          isBookmarked: true,
          bookmarkId: result.bookmarkId,
          errorMessage: null,
        ),
      };
    } else {
      state = {
        ...state,
        topicId: currentState.copyWith(
          isLoading: false,
          errorMessage: result.errorMessage,
        ),
      };
    }
  }

  /// 删除收藏
  Future<void> _deleteBookmark(int topicId, int bookmarkId) async {
    final currentState = state[topicId] ?? PostBookmarkState(topicId: topicId);

    state = {
      ...state,
      topicId: currentState.copyWith(isLoading: true, errorMessage: null),
    };

    final result = await _bookmarkRepository.deleteBookmark(bookmarkId);

    if (result.success) {
      state = {
        ...state,
        topicId: currentState.copyWith(
          isLoading: false,
          isBookmarked: false,
          bookmarkId: null,
          errorMessage: null,
        ),
      };
    } else {
      state = {
        ...state,
        topicId: currentState.copyWith(
          isLoading: false,
          errorMessage: result.errorMessage,
        ),
      };
    }
  }

  /// 收藏
  Future<void> bookmark(int topicId) async {
    final currentState = state[topicId];
    if (currentState == null || currentState.isLoading || currentState.isBookmarked) {
      return;
    }
    await _createBookmark(topicId);
  }

  /// 取消收藏
  Future<void> removeBookmark(int topicId) async {
    final currentState = state[topicId];
    if (currentState == null || currentState.isLoading || !currentState.isBookmarked) {
      return;
    }
    if (currentState.bookmarkId != null) {
      await _deleteBookmark(topicId, currentState.bookmarkId!);
    }
  }

  /// 获取帖子收藏状态
  PostBookmarkState? getPostState(int topicId) => state[topicId];

  /// 清除错误信息
  void clearError(int topicId) {
    final currentState = state[topicId];
    if (currentState != null) {
      state = {
        ...state,
        topicId: currentState.copyWith(errorMessage: null),
      };
    }
  }
}

/// 收藏Provider
final bookmarkProvider = StateNotifierProvider<BookmarkNotifier, Map<int, PostBookmarkState>>((ref) {
  final bookmarkRepository = ref.watch(bookmarkRepositoryProvider);
  return BookmarkNotifier(bookmarkRepository);
});

/// 单个帖子收藏状态Provider
final postBookmarkStateProvider = Provider.family<PostBookmarkState?, int>((ref, topicId) {
  final bookmarkStates = ref.watch(bookmarkProvider);
  return bookmarkStates[topicId];
});
