import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/network/api_service.dart';

part 'home_provider.g.dart';

/// Feed 项数据模型
class FeedItem {
  /// 动态ID
  final String id;
  /// 作者UID
  final String uid;
  /// 作者用户名
  final String username;
  /// 作者头像
  final String avatarUrl;
  /// 动态内容
  final String content;
  /// 发布时间
  final String createTime;
  /// 点赞数
  final int likeCount;
  /// 评论数
  final int replyCount;
  /// 是否已点赞
  final bool isLiked;
  /// 图片列表
  final List<String> images;
  /// 动态类型
  final String type;
  /// 标签
  final List<String> tags;

  const FeedItem({
    required this.id,
    required this.uid,
    required this.username,
    required this.avatarUrl,
    required this.content,
    required this.createTime,
    this.likeCount = 0,
    this.replyCount = 0,
    this.isLiked = false,
    this.images = const [],
    this.type = 'feed',
    this.tags = const [],
  });

  /// 从 JSON 创建
  factory FeedItem.fromJson(Map<String, dynamic> json) {
    return FeedItem(
      id: json['id']?.toString() ?? '',
      uid: json['uid']?.toString() ?? '',
      username: json['username'] ?? json['userInfo']?['username'] ?? '',
      avatarUrl: json['userAvatar'] ?? json['userInfo']?['userAvatar'] ?? '',
      content: json['message'] ?? json['content'] ?? '',
      createTime: json['dateline'] ?? json['createTime'] ?? '',
      likeCount: json['likenum'] ?? json['likeCount'] ?? 0,
      replyCount: json['replynum'] ?? json['replyCount'] ?? 0,
      isLiked: json['userAction']?['like'] == 1,
      images: (json['pic'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      type: json['entityType'] ?? json['type'] ?? 'feed',
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  /// 复制并修改
  FeedItem copyWith({
    String? id,
    String? uid,
    String? username,
    String? avatarUrl,
    String? content,
    String? createTime,
    int? likeCount,
    int? replyCount,
    bool? isLiked,
    List<String>? images,
    String? type,
    List<String>? tags,
  }) {
    return FeedItem(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      content: content ?? this.content,
      createTime: createTime ?? this.createTime,
      likeCount: likeCount ?? this.likeCount,
      replyCount: replyCount ?? this.replyCount,
      isLiked: isLiked ?? this.isLiked,
      images: images ?? this.images,
      type: type ?? this.type,
      tags: tags ?? this.tags,
    );
  }
}

/// 首页状态类
class HomeState {
  /// 当前 Tab 索引
  final int currentTabIndex;
  /// Feed 列表
  final List<FeedItem> feedList;
  /// 是否正在刷新
  final bool isRefreshing;
  /// 是否正在加载更多
  final bool isLoadingMore;
  /// 当前页码
  final int currentPage;
  /// 是否还有更多数据
  final bool hasMore;
  /// 错误信息
  final String? errorMessage;
  /// 首次加载标识
  final String? firstItem;
  /// 最后加载标识
  final String? lastItem;

  const HomeState({
    this.currentTabIndex = 0,
    this.feedList = const [],
    this.isRefreshing = false,
    this.isLoadingMore = false,
    this.currentPage = 1,
    this.hasMore = true,
    this.errorMessage,
    this.firstItem,
    this.lastItem,
  });

  /// 复制并修改
  HomeState copyWith({
    int? currentTabIndex,
    List<FeedItem>? feedList,
    bool? isRefreshing,
    bool? isLoadingMore,
    int? currentPage,
    bool? hasMore,
    String? errorMessage,
    String? firstItem,
    String? lastItem,
  }) {
    return HomeState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      feedList: feedList ?? this.feedList,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage,
      firstItem: firstItem ?? this.firstItem,
      lastItem: lastItem ?? this.lastItem,
    );
  }
}

/// 首页状态 Notifier
@riverpod
class HomeNotifier extends _$HomeNotifier {
  late ApiService _apiService;

  /// 构建首页状态
  @override
  HomeState build() {
    _apiService = ref.read(apiServiceProvider);
    return const HomeState();
  }

  /// 切换 Tab
  ///
  /// [index] 要切换到的 Tab 索引
  void switchTab(int index) {
    state = state.copyWith(currentTabIndex: index);
  }

  /// 刷新 Feed 列表
  ///
  /// 清空当前列表并重新加载第一页数据
  Future<void> refreshFeeds() async {
    if (state.isRefreshing) return;

    state = state.copyWith(
      isRefreshing: true,
      errorMessage: null,
      currentPage: 1,
      firstItem: null,
      lastItem: null,
    );

    try {
      final response = await _apiService.getHomeFeed(
        page: 1,
        firstLaunch: 0,
        installTime: DateTime.now().millisecondsSinceEpoch.toString(),
      );

      if (response.status == 1 && response.data != null) {
        // 将 HomeFeedData 转换为 FeedItem
        final feeds = response.data.map((feedData) {
          return FeedItem(
            id: feedData.id,
            uid: feedData.userInfo?.uid ?? '',
            username: feedData.userInfo?.username ?? '',
            avatarUrl: feedData.userInfo?.avatar ?? '',
            content: feedData.message ?? feedData.title ?? '',
            createTime: feedData.dateline ?? '',
            likeCount: feedData.action.likeNum,
            replyCount: feedData.replyNum,
            isLiked: feedData.action.isLike,
            images: feedData.picArr,
            type: feedData.entityType,
            tags: [],
          );
        }).toList();

        state = state.copyWith(
          feedList: feeds,
          isRefreshing: false,
          hasMore: feeds.length >= 20,
          currentPage: 1,
          firstItem: feeds.isNotEmpty ? feeds.first.id : null,
          lastItem: feeds.isNotEmpty ? feeds.last.id : null,
        );
      } else {
        state = state.copyWith(
          isRefreshing: false,
          errorMessage: response.message ?? '加载失败',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isRefreshing: false,
        errorMessage: '网络错误: $e',
      );
    }
  }

  /// 加载更多 Feed
  ///
  /// 加载下一页数据并追加到列表
  Future<void> loadMoreFeeds() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(
      isLoadingMore: true,
      errorMessage: null,
    );

    try {
      final nextPage = state.currentPage + 1;
      final response = await _apiService.getHomeFeed(
        page: nextPage,
        firstLaunch: 0,
        installTime: DateTime.now().millisecondsSinceEpoch.toString(),
        firstItem: state.firstItem,
        lastItem: state.lastItem,
      );

      if (response.status == 1 && response.data != null) {
        // 将 HomeFeedData 转换为 FeedItem
        final newFeeds = response.data.map((feedData) {
          return FeedItem(
            id: feedData.id,
            uid: feedData.userInfo?.uid ?? '',
            username: feedData.userInfo?.username ?? '',
            avatarUrl: feedData.userInfo?.avatar ?? '',
            content: feedData.message ?? feedData.title ?? '',
            createTime: feedData.dateline ?? '',
            likeCount: feedData.action.likeNum,
            replyCount: feedData.replyNum,
            isLiked: feedData.action.isLike,
            images: feedData.picArr,
            type: feedData.entityType,
            tags: [],
          );
        }).toList();

        if (newFeeds.isEmpty) {
          state = state.copyWith(
            isLoadingMore: false,
            hasMore: false,
          );
        } else {
          state = state.copyWith(
            feedList: [...state.feedList, ...newFeeds],
            isLoadingMore: false,
            currentPage: nextPage,
            hasMore: newFeeds.length >= 20,
            lastItem: newFeeds.last.id,
          );
        }
      } else {
        state = state.copyWith(
          isLoadingMore: false,
          errorMessage: response.message ?? '加载失败',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: '网络错误: $e',
      );
    }
  }

  /// 更新 Feed 点赞状态
  ///
  /// [feedId] 动态ID
  /// [isLiked] 新的点赞状态
  /// [likeCount] 新的点赞数
  void updateFeedLike(String feedId, bool isLiked, int likeCount) {
    final updatedList = state.feedList.map((feed) {
      if (feed.id == feedId) {
        return feed.copyWith(isLiked: isLiked, likeCount: likeCount);
      }
      return feed;
    }).toList();

    state = state.copyWith(feedList: updatedList);
  }

  /// 删除 Feed
  ///
  /// [feedId] 要删除的动态ID
  void removeFeed(String feedId) {
    final updatedList = state.feedList.where((feed) => feed.id != feedId).toList();
    state = state.copyWith(feedList: updatedList);
  }

  /// 清空错误信息
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// 当前 Tab 索引 Provider
@riverpod
int currentTabIndex(CurrentTabIndexRef ref) {
  return ref.watch(homeNotifierProvider).currentTabIndex;
}

/// Feed 列表 Provider
@riverpod
List<FeedItem> feedList(FeedListRef ref) {
  return ref.watch(homeNotifierProvider).feedList;
}

/// 是否正在刷新 Provider
@riverpod
bool isFeedRefreshing(IsFeedRefreshingRef ref) {
  return ref.watch(homeNotifierProvider).isRefreshing;
}

/// 是否正在加载更多 Provider
@riverpod
bool isFeedLoadingMore(IsFeedLoadingMoreRef ref) {
  return ref.watch(homeNotifierProvider).isLoadingMore;
}

/// 是否有更多数据 Provider
@riverpod
bool hasMoreFeeds(HasMoreFeedsRef ref) {
  return ref.watch(homeNotifierProvider).hasMore;
}

/// 首页错误信息 Provider
@riverpod
String? homeErrorMessage(HomeErrorMessageRef ref) {
  return ref.watch(homeNotifierProvider).errorMessage;
}
