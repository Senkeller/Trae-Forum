import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../config/constants.dart';
import '../../core/network/discourse_api_service.dart';
import '../../core/recommendation/recommendation_engine.dart';
import '../../core/utils/tag_util.dart';
import '../../data/models/feed.dart';

part 'home_provider.g.dart';

enum FeedType {
  recommended,
  latest,
  hot,
  aiNews,
  official,
  help,
  suggestions,
  tips,
  showcase,
  discussion,
  welfare,
  events,
}

const List<FeedType> homeFeedTabs = [
  FeedType.recommended,
  FeedType.latest,
  FeedType.hot,
  FeedType.aiNews,
  FeedType.official,
  FeedType.help,
  FeedType.suggestions,
  FeedType.tips,
  FeedType.showcase,
  FeedType.discussion,
  FeedType.welfare,
  FeedType.events,
];

const Map<FeedType, String> homeFeedTabLabels = {
  FeedType.recommended: '推荐',
  FeedType.latest: '最新',
  FeedType.hot: '热门',
  FeedType.aiNews: 'AI快讯',
  FeedType.official: '官方',
  FeedType.help: '求助',
  FeedType.suggestions: '建议',
  FeedType.tips: '技巧',
  FeedType.showcase: '作品',
  FeedType.discussion: '交流',
  FeedType.welfare: '福利活动',
  FeedType.events: '活动',
};

const Map<int, String> _categoryLabelById = {
  4: '官方',
  17: '产品更新',
  18: '模型更新',
  19: '政策公告',
  20: '社区动态',
  7: '帮助与支持',
  8: '产品建议',
  9: '基础技巧',
  10: '作品展示',
  11: '互动交流',
  29: '福利活动',
  35: 'SOLO挑战赛专区',
};

/// Feed 项数据模型
class FeedItem {
  /// 动态ID
  final String id;

  /// 话题ID（用于评论API）
  final int topicId;

  /// 作者UID
  final String uid;

  /// 作者用户名
  final String username;

  /// 作者头像
  final String avatarUrl;

  /// 标题
  final String title;

  /// 摘要内容
  final String content;

  /// 分类文案
  final String category;

  /// 分类ID
  final int categoryId;

  /// 发布时间
  final String createTime;

  /// 点赞数
  final int likeCount;

  /// 评论数
  final int replyCount;

  /// 浏览数
  final int viewCount;

  /// 是否已点赞
  final bool isLiked;

  /// 图片列表
  final List<String> images;

  /// 动态类型
  final String type;

  /// 标签
  final List<String> tags;

  /// 是否置顶
  final bool isPinned;

  /// 精选评论
  final TopComment? topComment;

  const FeedItem({
    required this.id,
    required this.topicId,
    required this.uid,
    required this.username,
    required this.avatarUrl,
    required this.title,
    required this.content,
    required this.category,
    required this.categoryId,
    required this.createTime,
    this.likeCount = 0,
    this.replyCount = 0,
    this.viewCount = 0,
    this.isLiked = false,
    this.images = const [],
    this.type = 'topic',
    this.tags = const [],
    this.isPinned = false,
    this.topComment,
  });

  /// 从 JSON 创建
  factory FeedItem.fromJson(Map<String, dynamic> json) {
    TopComment? topComment;
    if (json['topComment'] != null &&
        json['topComment'] is Map<String, dynamic>) {
      try {
        topComment = TopComment.fromJson(
          json['topComment'] as Map<String, dynamic>,
        );
      } catch (_) {
        topComment = null;
      }
    }

    return FeedItem(
      id: json['id']?.toString() ?? '',
      topicId: _parseInt(json['topicId']),
      uid: json['uid']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      avatarUrl: json['avatarUrl']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      categoryId: _parseInt(json['categoryId']),
      createTime: json['createTime']?.toString() ?? '',
      likeCount: _parseInt(json['likeCount']),
      replyCount: _parseInt(json['replyCount']),
      viewCount: _parseInt(json['viewCount']),
      isLiked: json['isLiked'] == true,
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      type: json['type']?.toString() ?? 'topic',
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
          const [],
      isPinned: json['isPinned'] == true,
      topComment: topComment,
    );
  }

  /// 复制并修改
  FeedItem copyWith({
    String? id,
    int? topicId,
    String? uid,
    String? username,
    String? avatarUrl,
    String? title,
    String? content,
    String? category,
    int? categoryId,
    String? createTime,
    int? likeCount,
    int? replyCount,
    int? viewCount,
    bool? isLiked,
    List<String>? images,
    String? type,
    List<String>? tags,
    bool? isPinned,
    TopComment? topComment,
  }) {
    return FeedItem(
      id: id ?? this.id,
      topicId: topicId ?? this.topicId,
      uid: uid ?? this.uid,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      createTime: createTime ?? this.createTime,
      likeCount: likeCount ?? this.likeCount,
      replyCount: replyCount ?? this.replyCount,
      viewCount: viewCount ?? this.viewCount,
      isLiked: isLiked ?? this.isLiked,
      images: images ?? this.images,
      type: type ?? this.type,
      tags: tags ?? this.tags,
      isPinned: isPinned ?? this.isPinned,
      topComment: topComment ?? this.topComment,
    );
  }
}

/// Tab Feed 列表状态
class TabFeedState {
  final List<FeedItem> feedList;
  final bool isRefreshing;
  final bool isLoadingMore;
  final int currentPage;
  final bool hasMore;
  final String? errorMessage;

  const TabFeedState({
    this.feedList = const [],
    this.isRefreshing = false,
    this.isLoadingMore = false,
    this.currentPage = 1,
    this.hasMore = true,
    this.errorMessage,
  });

  TabFeedState copyWith({
    List<FeedItem>? feedList,
    bool? isRefreshing,
    bool? isLoadingMore,
    int? currentPage,
    bool? hasMore,
    String? errorMessage,
  }) {
    return TabFeedState(
      feedList: feedList ?? this.feedList,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage,
    );
  }
}

/// 首页状态类
class HomeState {
  /// 当前 Tab 索引
  final int currentTabIndex;

  /// 各 Tab 的 Feed 列表
  final Map<FeedType, TabFeedState> tabStates;

  const HomeState({this.currentTabIndex = 0, this.tabStates = const {}});

  FeedType get currentFeedType {
    final index = currentTabIndex.clamp(0, homeFeedTabs.length - 1);
    return homeFeedTabs[index];
  }

  TabFeedState get currentTabState {
    return tabStates[currentFeedType] ?? const TabFeedState();
  }

  List<FeedItem> get feedList => currentTabState.feedList;
  bool get isRefreshing => currentTabState.isRefreshing;
  bool get isLoadingMore => currentTabState.isLoadingMore;
  int get currentPage => currentTabState.currentPage;
  bool get hasMore => currentTabState.hasMore;
  String? get errorMessage => currentTabState.errorMessage;

  HomeState copyWith({
    int? currentTabIndex,
    Map<FeedType, TabFeedState>? tabStates,
  }) {
    return HomeState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      tabStates: tabStates ?? this.tabStates,
    );
  }
}

/// 首页状态 Notifier
@riverpod
class HomeNotifier extends _$HomeNotifier {
  late DiscourseApiService _discourseApiService;
  late RecommendationEngine _recommendationEngine;

  @override
  HomeState build() {
    _discourseApiService = ref.read(discourseApiServiceProvider);
    _recommendationEngine = RecommendationEngine(_discourseApiService);
    return const HomeState();
  }

  FeedType _indexToFeedType(int index) {
    final safeIndex = index.clamp(0, homeFeedTabs.length - 1);
    return homeFeedTabs[safeIndex];
  }

  TabFeedState _getTabState(FeedType type) {
    return state.tabStates[type] ?? const TabFeedState();
  }

  void _updateTabState(FeedType type, TabFeedState newState) {
    final updatedTabStates = Map<FeedType, TabFeedState>.from(state.tabStates);
    updatedTabStates[type] = newState;
    state = state.copyWith(tabStates: updatedTabStates);
  }

  TabFeedState getTabStateByIndex(int index) {
    return _getTabState(_indexToFeedType(index));
  }

  /// 切换 Tab
  ///
  /// [index] 要切换到的 Tab 索引
  void switchTab(int index) {
    if (index == state.currentTabIndex) return;
    state = state.copyWith(currentTabIndex: index);

    final feedType = _indexToFeedType(index);
    final tabState = _getTabState(feedType);
    if (tabState.feedList.isEmpty && !tabState.isRefreshing) {
      refreshFeeds();
    }
  }

  /// 刷新 Feed 列表
  ///
  /// 清空当前列表并重新加载第一页数据
  Future<void> refreshFeeds() async {
    final feedType = _indexToFeedType(state.currentTabIndex);
    final currentTabState = _getTabState(feedType);
    final previousFeedIds = currentTabState.feedList.map((e) => e.id).toSet();
    if (currentTabState.isRefreshing) return;

    _updateTabState(
      feedType,
      currentTabState.copyWith(
        isRefreshing: true,
        errorMessage: null,
        currentPage: 1,
        hasMore: true,
      ),
    );

    try {
      final feeds = await _fetchFeedItems(
        feedType,
        1,
        avoidIds: feedType == FeedType.recommended ? previousFeedIds : null,
      );
      final latestState = _getTabState(feedType);

      _updateTabState(
        feedType,
        latestState.copyWith(
          feedList: feeds,
          isRefreshing: false,
          hasMore: feeds.length >= AppConstants.pageSize,
          currentPage: 1,
          errorMessage: null,
        ),
      );
    } catch (e) {
      final latestState = _getTabState(feedType);
      _updateTabState(
        feedType,
        latestState.copyWith(
          isRefreshing: false,
          errorMessage: _resolveErrorMessage(feedType, e),
        ),
      );
    }
  }

  /// 加载更多 Feed
  ///
  /// 加载下一页数据并追加到列表
  Future<void> loadMoreFeeds() async {
    final feedType = _indexToFeedType(state.currentTabIndex);
    final currentTabState = _getTabState(feedType);
    if (currentTabState.isLoadingMore || !currentTabState.hasMore) return;

    _updateTabState(
      feedType,
      currentTabState.copyWith(isLoadingMore: true, errorMessage: null),
    );

    final nextPage = currentTabState.currentPage + 1;

    try {
      final newFeeds = await _fetchFeedItems(feedType, nextPage);
      final latestState = _getTabState(feedType);

      if (newFeeds.isEmpty) {
        _updateTabState(
          feedType,
          latestState.copyWith(isLoadingMore: false, hasMore: false),
        );
        return;
      }

      final existingIds = latestState.feedList.map((e) => e.id).toSet();
      final dedupedNewFeeds = newFeeds
          .where((e) => !existingIds.contains(e.id))
          .toList();

      _updateTabState(
        feedType,
        latestState.copyWith(
          feedList: [...latestState.feedList, ...dedupedNewFeeds],
          isLoadingMore: false,
          currentPage: nextPage,
          hasMore: newFeeds.length >= AppConstants.pageSize,
          errorMessage: null,
        ),
      );
    } catch (e) {
      final latestState = _getTabState(feedType);
      _updateTabState(
        feedType,
        latestState.copyWith(
          isLoadingMore: false,
          errorMessage: _resolveErrorMessage(feedType, e),
        ),
      );
    }
  }

  String _resolveErrorMessage(FeedType feedType, Object error) {
    if (_isNotLoggedInError(error)) {
      if (feedType == FeedType.latest) {
        return '最新内容需要登录后查看，请先登录';
      }
      return '请先登录后继续';
    }
    return '网络错误: $error';
  }

  bool _isNotLoggedInError(Object error) {
    if (error is! DioException) return false;

    final response = error.response;
    if (response?.statusCode != 403) return false;

    final data = response?.data;
    if (data is Map<String, dynamic>) {
      final errorType = data['error_type']?.toString();
      if (errorType == 'not_logged_in') return true;

      final errors = data['errors'];
      if (errors is List && errors.isNotEmpty) {
        return errors.first.toString().contains('需要登录');
      }
    }

    return false;
  }

  Future<List<FeedItem>> _fetchFeedItems(
    FeedType type,
    int page, {
    Set<String>? avoidIds,
  }) async {
    switch (type) {
      case FeedType.recommended:
        // 使用推荐引擎获取混合推荐内容
        return _recommendationEngine.getRecommendedFeeds(
          page: page,
          pageSize: AppConstants.pageSize,
          avoidIds: avoidIds,
        );
      case FeedType.latest:
        final discoursePage = page > 0 ? page - 1 : 0;
        return _fetchFromResponse(
          await _discourseApiService.getNewTopics(page: discoursePage),
        );
      case FeedType.hot:
        try {
          return _fetchFromResponse(
            await _discourseApiService.getHotTopics(page: page),
          );
        } catch (_) {
          return _fetchFromResponse(
            await _discourseApiService.getTopTopics(page: page),
          );
        }
      case FeedType.aiNews:
        // AI快讯使用独立的Provider和数据源，不在此处处理
        return [];
      case FeedType.official:
        return _fetchOfficial(page);
      case FeedType.help:
        return _fetchFromResponse(
          await _discourseApiService.getTopicsByCategory(
            AppConstants.forumCategoryIds['help']!,
            page: page,
          ),
        );
      case FeedType.suggestions:
        return _fetchFromResponse(
          await _discourseApiService.getTopicsByCategory(
            AppConstants.forumCategoryIds['suggestions']!,
            page: page,
          ),
        );
      case FeedType.tips:
        return _fetchFromResponse(
          await _discourseApiService.getTopicsByCategory(
            AppConstants.forumCategoryIds['tips']!,
            page: page,
          ),
        );
      case FeedType.showcase:
        return _fetchFromResponse(
          await _discourseApiService.getTopicsByCategory(
            AppConstants.forumCategoryIds['showcase']!,
            page: page,
          ),
        );
      case FeedType.discussion:
        return _fetchFromResponse(
          await _discourseApiService.getTopicsByCategory(
            AppConstants.forumCategoryIds['discussion']!,
            page: page,
          ),
        );
      case FeedType.welfare:
        return _fetchFromResponse(
          await _discourseApiService.getTopicsByCategory(
            AppConstants.forumCategoryIds['events']!,
            page: page,
          ),
        );
      case FeedType.events:
        return _fetchEvents(page);
    }
  }

  Future<List<FeedItem>> _fetchEvents(int page) async {
    final primary = AppConstants.forumCategoryIds['events']!;
    final secondary = AppConstants.forumCategoryIds['solo']!;

    final responses = await Future.wait([
      _discourseApiService.getTopicsByCategory(primary, page: page),
      _discourseApiService.getTopicsByCategory(secondary, page: page),
    ]);

    final merged = <FeedItem>[];
    final seen = <String>{};

    for (final response in responses) {
      for (final item in _fetchFromResponse(response)) {
        if (seen.add(item.id)) {
          merged.add(item);
        }
      }
    }

    merged.sort(
      (a, b) =>
          int.tryParse(
            b.createTime,
          )?.compareTo(int.tryParse(a.createTime) ?? 0) ??
          0,
    );
    return merged;
  }

  Future<List<FeedItem>> _fetchOfficial(int page) async {
    // Discourse 分类列表分页从 0 开始，首页刷新使用 page=1 时需要映射到 0。
    final discoursePage = page > 0 ? page - 1 : 0;

    final responses = await Future.wait(
      AppConstants.officialSubCategoryIds.map(
        (categoryId) => _discourseApiService.getTopicsByCategory(
          categoryId,
          page: discoursePage,
        ),
      ),
    );

    final merged = <FeedItem>[];
    final seen = <String>{};

    for (final response in responses) {
      for (final item in _fetchFromResponse(response)) {
        if (seen.add(item.id)) {
          merged.add(item);
        }
      }
    }

    merged.sort(
      (a, b) =>
          int.tryParse(
            b.createTime,
          )?.compareTo(int.tryParse(a.createTime) ?? 0) ??
          0,
    );

    return merged;
  }

  List<FeedItem> _fetchFromResponse(dynamic response) {
    final raw = response.data;
    final data = raw is Map<String, dynamic>
        ? raw
        : Map<String, dynamic>.from(raw as Map);

    final topicListMap = data['topic_list'] as Map<String, dynamic>?;
    final topics = (topicListMap?['topics'] as List<dynamic>? ?? const [])
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
    final users = (data['users'] as List<dynamic>? ?? const [])
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();

    final userMap = <int, Map<String, dynamic>>{};
    for (final user in users) {
      final id = _parseInt(user['id']);
      if (id > 0) {
        userMap[id] = user;
      }
    }

    return topics
        .map((topic) => _adaptTopicToFeedItem(topic, userMap))
        .toList();
  }

  FeedItem _adaptTopicToFeedItem(
    Map<String, dynamic> topic,
    Map<int, Map<String, dynamic>> userMap,
  ) {
    final posterList = (topic['posters'] as List<dynamic>? ?? const [])
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();

    final firstPosterUserId = posterList.isNotEmpty
        ? _parseInt(posterList.first['user_id'])
        : 0;
    final author = userMap[firstPosterUserId] ?? const <String, dynamic>{};

    final username = (author['username'] ?? topic['last_poster_username'] ?? '')
        .toString();
    final categoryId = _parseInt(topic['category_id']);
    final title = (topic['title'] ?? '').toString();
    final excerpt = _normalizeExcerpt(topic['excerpt']);
    final postsCount = _parseInt(topic['posts_count']);
    final replyCount = _parseInt(topic['reply_count']) > 0
        ? _parseInt(topic['reply_count'])
        : (postsCount > 0 ? postsCount - 1 : 0);

    final imageUrl = (topic['image_url'] ?? '').toString();

    // 解析精选评论
    TopComment? topComment;
    final topCommentData = topic['top_comment'] ?? topic['topComment'];
    if (topCommentData != null && topCommentData is Map<String, dynamic>) {
      try {
        topComment = TopComment.fromJson(topCommentData);
      } catch (_) {
        topComment = null;
      }
    }

    return FeedItem(
      id: (topic['id'] ?? '').toString(),
      topicId: _parseInt(topic['id']),
      uid: firstPosterUserId > 0 ? firstPosterUserId.toString() : '',
      username: username.isNotEmpty ? username : 'unknown',
      avatarUrl: _formatAvatarUrl(
        (author['avatar_template'] ?? '').toString(),
        username,
      ),
      title: title,
      content: excerpt.isNotEmpty ? excerpt : title,
      category: _categoryLabelById[categoryId] ?? 'Category $categoryId',
      categoryId: categoryId,
      createTime: _toUnixTimestamp(
        topic['last_posted_at'] ?? topic['created_at'],
      ),
      likeCount: _parseInt(topic['like_count']),
      replyCount: replyCount,
      viewCount: _parseInt(topic['views']),
      isLiked: false,
      images: imageUrl.isNotEmpty ? [imageUrl] : const [],
      type: 'topic',
      tags: TagUtil.parseTagList(topic['tags']),
      isPinned: topic['pinned'] == true,
      topComment: topComment,
    );
  }

  String _normalizeExcerpt(dynamic raw) {
    if (raw == null) return '';
    final text = raw.toString();
    final noTag = text
        .replaceAll(RegExp(r'<[^>]+>'), ' ')
        .replaceAll('&hellip;', '...')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"');
    return noTag.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  String _toUnixTimestamp(dynamic value) {
    if (value == null) return '';
    final source = value.toString();
    if (source.isEmpty) return '';

    final numeric = int.tryParse(source);
    if (numeric != null) {
      return numeric.toString();
    }

    final date = DateTime.tryParse(source);
    if (date == null) {
      return source;
    }
    return (date.toUtc().millisecondsSinceEpoch ~/ 1000).toString();
  }

  String _formatAvatarUrl(String avatarTemplate, String username) {
    if (avatarTemplate.isNotEmpty) {
      var url = avatarTemplate.replaceAll('{size}', '120');
      if (url.startsWith('//')) {
        return 'https:$url';
      }
      if (url.startsWith('/')) {
        return '${AppConstants.baseUrl}$url';
      }
      return url;
    }

    if (username.isEmpty) {
      return '';
    }

    return '${AppConstants.baseUrl}/user_avatar/forum.trae.cn/$username/120/0_2.png';
  }

  /// 更新 Feed 点赞状态
  ///
  /// [feedId] 动态ID
  /// [isLiked] 新的点赞状态
  /// [likeCount] 新的点赞数
  void updateFeedLike(String feedId, bool isLiked, int likeCount) {
    final feedType = _indexToFeedType(state.currentTabIndex);
    final currentTabState = _getTabState(feedType);
    final updatedList = currentTabState.feedList.map((feed) {
      if (feed.id == feedId) {
        return feed.copyWith(isLiked: isLiked, likeCount: likeCount);
      }
      return feed;
    }).toList();

    _updateTabState(feedType, currentTabState.copyWith(feedList: updatedList));
  }

  /// 删除 Feed
  ///
  /// [feedId] 要删除的动态ID
  void removeFeed(String feedId) {
    final feedType = _indexToFeedType(state.currentTabIndex);
    final currentTabState = _getTabState(feedType);
    final updatedList = currentTabState.feedList
        .where((feed) => feed.id != feedId)
        .toList();
    _updateTabState(feedType, currentTabState.copyWith(feedList: updatedList));
  }

  /// 清空错误信息
  void clearError() {
    final feedType = _indexToFeedType(state.currentTabIndex);
    final currentTabState = _getTabState(feedType);
    _updateTabState(feedType, currentTabState.copyWith(errorMessage: null));
  }
}

int _parseInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString()) ?? 0;
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
