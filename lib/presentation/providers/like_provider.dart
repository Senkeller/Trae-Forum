import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/like_repository.dart';

/// 帖子点赞状态
class PostLikeState {
  final int postId;
  final int likeCount;
  final bool isLiked;
  final bool isLoading;
  final String? errorMessage;

  PostLikeState({
    required this.postId,
    this.likeCount = 0,
    this.isLiked = false,
    this.isLoading = false,
    this.errorMessage,
  });

  PostLikeState copyWith({
    int? postId,
    int? likeCount,
    bool? isLiked,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PostLikeState(
      postId: postId ?? this.postId,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

/// 点赞状态管理器
class LikeNotifier extends StateNotifier<Map<int, PostLikeState>> {
  final LikeRepository _likeRepository;

  LikeNotifier(this._likeRepository) : super({});

  /// 初始化帖子点赞状态
  void initializePost(int postId, {int likeCount = 0, bool isLiked = false}) {
    if (!state.containsKey(postId)) {
      state = {
        ...state,
        postId: PostLikeState(
          postId: postId,
          likeCount: likeCount,
          isLiked: isLiked,
        ),
      };
    }
  }

  /// 从actions_summary初始化点赞状态
  void initializeFromActionsSummary(int postId, List<dynamic>? actionsSummary) {
    final likeInfo = LikeRepository.extractLikeInfo(actionsSummary);
    initializePost(
      postId,
      likeCount: likeInfo['count'] ?? 0,
      isLiked: likeInfo['isLiked'] ?? false,
    );
  }

  /// 切换点赞状态
  Future<void> toggleLike(int postId) async {
    final currentState = state[postId];
    if (currentState == null || currentState.isLoading) return;

    // 设置加载状态
    state = {
      ...state,
      postId: currentState.copyWith(isLoading: true, errorMessage: null),
    };

    // 执行点赞/取消点赞操作
    final result = await _likeRepository.toggleLike(
      postId,
      currentState.isLiked,
    );

    if (result.success) {
      // 更新状态为成功
      state = {
        ...state,
        postId: currentState.copyWith(
          isLoading: false,
          isLiked: result.isLiked ?? !currentState.isLiked,
          likeCount: result.likeCount ??
              (result.isLiked == true
                  ? currentState.likeCount + 1
                  : currentState.likeCount - 1),
          errorMessage: null,
        ),
      };
    } else {
      // 更新状态为失败
      state = {
        ...state,
        postId: currentState.copyWith(
          isLoading: false,
          errorMessage: result.errorMessage,
        ),
      };
    }
  }

  /// 点赞
  Future<void> like(int postId) async {
    final currentState = state[postId];
    if (currentState == null || currentState.isLoading || currentState.isLiked) {
      return;
    }
    await toggleLike(postId);
  }

  /// 取消点赞
  Future<void> unlike(int postId) async {
    final currentState = state[postId];
    if (currentState == null || currentState.isLoading || !currentState.isLiked) {
      return;
    }
    await toggleLike(postId);
  }

  /// 获取帖子点赞状态
  PostLikeState? getPostState(int postId) => state[postId];

  /// 清除错误信息
  void clearError(int postId) {
    final currentState = state[postId];
    if (currentState != null) {
      state = {
        ...state,
        postId: currentState.copyWith(errorMessage: null),
      };
    }
  }
}

/// 点赞Provider
final likeProvider = StateNotifierProvider<LikeNotifier, Map<int, PostLikeState>>((ref) {
  final likeRepository = ref.watch(likeRepositoryProvider);
  return LikeNotifier(likeRepository);
});

/// 单个帖子点赞状态Provider
final postLikeStateProvider = Provider.family<PostLikeState?, int>((ref, postId) {
  final likeStates = ref.watch(likeProvider);
  return likeStates[postId];
});
