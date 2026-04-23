import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/network/api_service.dart';
import 'auth_provider.dart';
import 'home_provider.dart';

part 'feed_provider.g.dart';

/// 评论数据模型
class CommentItem {
  /// 评论ID
  final String id;
  /// 作者UID
  final String uid;
  /// 作者用户名
  final String username;
  /// 作者头像
  final String avatarUrl;
  /// 评论内容
  final String content;
  /// 发布时间
  final String createTime;
  /// 点赞数
  final int likeCount;
  /// 是否已点赞
  final bool isLiked;
  /// 回复数（楼中楼）
  final int replyCount;
  /// 父评论ID
  final String? parentId;
  /// 被回复者用户名
  final String? replyToUsername;

  const CommentItem({
    required this.id,
    required this.uid,
    required this.username,
    required this.avatarUrl,
    required this.content,
    required this.createTime,
    this.likeCount = 0,
    this.isLiked = false,
    this.replyCount = 0,
    this.parentId,
    this.replyToUsername,
  });

  /// 从 JSON 创建
  factory CommentItem.fromJson(Map<String, dynamic> json) {
    return CommentItem(
      id: json['id']?.toString() ?? '',
      uid: json['uid']?.toString() ?? '',
      username: json['username'] ?? json['userInfo']?['username'] ?? '',
      avatarUrl: json['userAvatar'] ?? json['userInfo']?['userAvatar'] ?? '',
      content: json['message'] ?? json['content'] ?? '',
      createTime: json['dateline'] ?? json['createTime'] ?? '',
      likeCount: json['likenum'] ?? json['likeCount'] ?? 0,
      isLiked: json['userAction']?['like'] == 1,
      replyCount: json['replynum'] ?? json['replyCount'] ?? 0,
      parentId: json['rid']?.toString(),
      replyToUsername: json['replyTo']?['username'],
    );
  }

  /// 复制并修改
  CommentItem copyWith({
    String? id,
    String? uid,
    String? username,
    String? avatarUrl,
    String? content,
    String? createTime,
    int? likeCount,
    bool? isLiked,
    int? replyCount,
    String? parentId,
    String? replyToUsername,
  }) {
    return CommentItem(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      content: content ?? this.content,
      createTime: createTime ?? this.createTime,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      replyCount: replyCount ?? this.replyCount,
      parentId: parentId ?? this.parentId,
      replyToUsername: replyToUsername ?? this.replyToUsername,
    );
  }
}

/// 动态详情状态类
class FeedDetailState {
  /// 动态ID
  final String feedId;
  /// 动态详情
  final FeedItem? feedDetail;
  /// 评论列表
  final List<CommentItem> comments;
  /// 是否正在加载动态详情
  final bool isLoadingFeed;
  /// 是否正在加载评论
  final bool isLoadingComments;
  /// 是否正在刷新评论
  final bool isRefreshingComments;
  /// 评论当前页码
  final int commentPage;
  /// 是否还有更多评论
  final bool hasMoreComments;
  /// 错误信息
  final String? errorMessage;
  /// 评论排序类型
  final String commentSortType;

  const FeedDetailState({
    required this.feedId,
    this.feedDetail,
    this.comments = const [],
    this.isLoadingFeed = false,
    this.isLoadingComments = false,
    this.isRefreshingComments = false,
    this.commentPage = 1,
    this.hasMoreComments = true,
    this.errorMessage,
    this.commentSortType = '',
  });

  /// 复制并修改
  FeedDetailState copyWith({
    String? feedId,
    FeedItem? feedDetail,
    List<CommentItem>? comments,
    bool? isLoadingFeed,
    bool? isLoadingComments,
    bool? isRefreshingComments,
    int? commentPage,
    bool? hasMoreComments,
    String? errorMessage,
    String? commentSortType,
  }) {
    return FeedDetailState(
      feedId: feedId ?? this.feedId,
      feedDetail: feedDetail ?? this.feedDetail,
      comments: comments ?? this.comments,
      isLoadingFeed: isLoadingFeed ?? this.isLoadingFeed,
      isLoadingComments: isLoadingComments ?? this.isLoadingComments,
      isRefreshingComments: isRefreshingComments ?? this.isRefreshingComments,
      commentPage: commentPage ?? this.commentPage,
      hasMoreComments: hasMoreComments ?? this.hasMoreComments,
      errorMessage: errorMessage,
      commentSortType: commentSortType ?? this.commentSortType,
    );
  }
}

/// 动态详情状态 Notifier（家族 Provider）
@riverpod
class FeedDetailNotifier extends _$FeedDetailNotifier {
  late ApiService _apiService;

  /// 构建动态详情状态
  ///
  /// [feedId] 动态ID
  @override
  FeedDetailState build(String feedId) {
    _apiService = ApiService(ref.read(dioClientProvider));
    return FeedDetailState(feedId: feedId);
  }

  /// 加载动态详情
  ///
  /// 从服务器获取动态详情数据
  Future<void> loadFeedDetail() async {
    state = state.copyWith(isLoadingFeed: true, errorMessage: null);

    try {
      final response = await _apiService.getFeedContent(id: state.feedId);

      if (response.status == 1 && response.data != null) {
        final feedData = response.data as Map<String, dynamic>;
        final feedItem = FeedItem.fromJson(feedData);

        state = state.copyWith(
          feedDetail: feedItem,
          isLoadingFeed: false,
        );
      } else {
        state = state.copyWith(
          isLoadingFeed: false,
          errorMessage: '加载动态失败',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoadingFeed: false,
        errorMessage: '网络错误: $e',
      );
    }
  }

  /// 加载评论列表
  ///
  /// [listType] 评论排序类型，空字符串为默认排序
  Future<void> loadComments({String listType = ''}) async {
    if (state.isLoadingComments) return;

    state = state.copyWith(
      isLoadingComments: true,
      errorMessage: null,
      commentPage: 1,
      commentSortType: listType,
    );

    try {
      final response = await _apiService.getFeedContentReply(
        id: state.feedId,
        listType: listType,
        page: 1,
      );

      if (response.status == 1 && response.data != null) {
        final comments = (response.data as List<dynamic>)
            .map((item) => CommentItem.fromJson(item as Map<String, dynamic>))
            .toList();

        state = state.copyWith(
          comments: comments,
          isLoadingComments: false,
          hasMoreComments: comments.length >= 20,
          commentPage: 1,
        );
      } else {
        state = state.copyWith(
          isLoadingComments: false,
          errorMessage: '加载评论失败',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoadingComments: false,
        errorMessage: '网络错误: $e',
      );
    }
  }

  /// 刷新评论列表
  Future<void> refreshComments() async {
    if (state.isRefreshingComments) return;

    state = state.copyWith(
      isRefreshingComments: true,
      errorMessage: null,
    );

    try {
      final response = await _apiService.getFeedContentReply(
        id: state.feedId,
        listType: state.commentSortType,
        page: 1,
      );

      if (response.status == 1 && response.data != null) {
        final comments = (response.data as List<dynamic>)
            .map((item) => CommentItem.fromJson(item as Map<String, dynamic>))
            .toList();

        state = state.copyWith(
          comments: comments,
          isRefreshingComments: false,
          hasMoreComments: comments.length >= 20,
          commentPage: 1,
        );
      } else {
        state = state.copyWith(
          isRefreshingComments: false,
          errorMessage: '刷新评论失败',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isRefreshingComments: false,
        errorMessage: '网络错误: $e',
      );
    }
  }

  /// 加载更多评论
  Future<void> loadMoreComments() async {
    if (state.isLoadingComments || !state.hasMoreComments) return;

    state = state.copyWith(
      isLoadingComments: true,
      errorMessage: null,
    );

    try {
      final nextPage = state.commentPage + 1;
      final lastItem = state.comments.isNotEmpty ? state.comments.last.id : null;

      final response = await _apiService.getFeedContentReply(
        id: state.feedId,
        listType: state.commentSortType,
        page: nextPage,
        lastItem: lastItem,
      );

      if (response.status == 1 && response.data != null) {
        final newComments = (response.data as List<dynamic>)
            .map((item) => CommentItem.fromJson(item as Map<String, dynamic>))
            .toList();

        if (newComments.isEmpty) {
          state = state.copyWith(
            isLoadingComments: false,
            hasMoreComments: false,
          );
        } else {
          state = state.copyWith(
            comments: [...state.comments, ...newComments],
            isLoadingComments: false,
            commentPage: nextPage,
            hasMoreComments: newComments.length >= 20,
          );
        }
      } else {
        state = state.copyWith(
          isLoadingComments: false,
          errorMessage: '加载更多评论失败',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoadingComments: false,
        errorMessage: '网络错误: $e',
      );
    }
  }

  /// 点赞/取消点赞动态
  ///
  /// 需要用户已登录
  /// 返回操作是否成功
  Future<bool> toggleFeedLike() async {
    final isAuthenticated = ref.read(isAuthenticatedProvider);
    if (!isAuthenticated) {
      state = state.copyWith(errorMessage: '请先登录');
      return false;
    }

    final feed = state.feedDetail;
    if (feed == null) return false;

    try {
      final url = feed.isLiked ? '/v6/feed/unlike' : '/v6/feed/like';
      final response = await _apiService.postLikeFeed(
        url: url,
        id: feed.id,
      );

      if (response.status == 1) {
        final newLikeCount = feed.isLiked ? feed.likeCount - 1 : feed.likeCount + 1;
        final updatedFeed = feed.copyWith(
          isLiked: !feed.isLiked,
          likeCount: newLikeCount,
        );

        state = state.copyWith(feedDetail: updatedFeed);

        // 同步更新首页列表中的点赞状态
        ref.read(homeNotifierProvider.notifier).updateFeedLike(
          feed.id,
          updatedFeed.isLiked,
          updatedFeed.likeCount,
        );

        return true;
      }
      return false;
    } catch (e) {
      state = state.copyWith(errorMessage: '操作失败: $e');
      return false;
    }
  }

  /// 点赞/取消点赞评论
  ///
  /// [commentId] 评论ID
  /// 需要用户已登录
  /// 返回操作是否成功
  Future<bool> toggleCommentLike(String commentId) async {
    final isAuthenticated = ref.read(isAuthenticatedProvider);
    if (!isAuthenticated) {
      state = state.copyWith(errorMessage: '请先登录');
      return false;
    }

    final comment = state.comments.firstWhere((c) => c.id == commentId);
    try {
      final url = comment.isLiked ? '/v6/feed/replyUnlike' : '/v6/feed/replyLike';
      final response = await _apiService.postLikeReply(
        url: url,
        id: commentId,
      );

      if (response.status == 1) {
        final updatedComments = state.comments.map((c) {
          if (c.id == commentId) {
            final newLikeCount = c.isLiked ? c.likeCount - 1 : c.likeCount + 1;
            return c.copyWith(
              isLiked: !c.isLiked,
              likeCount: newLikeCount,
            );
          }
          return c;
        }).toList();

        state = state.copyWith(comments: updatedComments);
        return true;
      }
      return false;
    } catch (e) {
      state = state.copyWith(errorMessage: '操作失败: $e');
      return false;
    }
  }

  /// 发布评论
  ///
  /// [content] 评论内容
  /// [replyId] 回复的评论ID（楼中楼）
  /// 需要用户已登录
  /// 返回操作是否成功
  Future<bool> postComment(String content, {String? replyId}) async {
    final isAuthenticated = ref.read(isAuthenticatedProvider);
    if (!isAuthenticated) {
      state = state.copyWith(errorMessage: '请先登录');
      return false;
    }

    try {
      final response = await _apiService.postReply(
        data: {'message': content},
        id: state.feedId,
        type: replyId != null ? 'reply' : 'feed',
      );

      if (response.status == 1) {
        // 刷新评论列表
        await refreshComments();
        return true;
      }
      return false;
    } catch (e) {
      state = state.copyWith(errorMessage: '发布失败: $e');
      return false;
    }
  }

  /// 清空错误信息
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// 动态详情 Provider（带参数）
///
/// [feedId] 动态ID
@riverpod
FeedItem? feedDetail(FeedDetailRef ref, String feedId) {
  return ref.watch(feedDetailNotifierProvider(feedId)).feedDetail;
}

/// 动态评论列表 Provider
///
/// [feedId] 动态ID
@riverpod
List<CommentItem> feedComments(FeedCommentsRef ref, String feedId) {
  return ref.watch(feedDetailNotifierProvider(feedId)).comments;
}

/// 动态是否正在加载 Provider
///
/// [feedId] 动态ID
@riverpod
bool isFeedDetailLoading(IsFeedDetailLoadingRef ref, String feedId) {
  return ref.watch(feedDetailNotifierProvider(feedId)).isLoadingFeed;
}

/// 评论是否正在加载 Provider
///
/// [feedId] 动态ID
@riverpod
bool isCommentsLoading(IsCommentsLoadingRef ref, String feedId) {
  return ref.watch(feedDetailNotifierProvider(feedId)).isLoadingComments;
}
