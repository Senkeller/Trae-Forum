import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/discourse_api_service.dart';
import '../../data/models/search.dart';

/// 搜索状态
class SearchState {
  /// 搜索结果列表
  final List<SearchPost> posts;

  /// 搜索的话题列表
  final List<SearchTopic> topics;

  /// 是否正在加载
  final bool isLoading;

  /// 是否有更多数据
  final bool hasMore;

  /// 当前页码
  final int currentPage;

  /// 错误信息
  final String? error;

  /// 当前搜索关键词
  final String? currentKeyword;

  /// 搜索建议列表
  final List<SearchSuggestion> suggestions;

  /// 搜索历史
  final List<SearchHistory> searchHistory;

  const SearchState({
    this.posts = const [],
    this.topics = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.currentPage = 1,
    this.error,
    this.currentKeyword,
    this.suggestions = const [],
    this.searchHistory = const [],
  });

  SearchState copyWith({
    List<SearchPost>? posts,
    List<SearchTopic>? topics,
    bool? isLoading,
    bool? hasMore,
    int? currentPage,
    String? error,
    String? currentKeyword,
    List<SearchSuggestion>? suggestions,
    List<SearchHistory>? searchHistory,
  }) {
    return SearchState(
      posts: posts ?? this.posts,
      topics: topics ?? this.topics,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      error: error,
      currentKeyword: currentKeyword ?? this.currentKeyword,
      suggestions: suggestions ?? this.suggestions,
      searchHistory: searchHistory ?? this.searchHistory,
    );
  }
}

/// 搜索状态管理器
class SearchNotifier extends StateNotifier<SearchState> {
  final DiscourseApiService _apiService;

  SearchNotifier(this._apiService) : super(const SearchState());

  /// 执行搜索
  ///
  /// [keyword] 搜索关键词
  /// [categoryId] 可选的分类筛选
  /// [tags] 可选的标签筛选
  /// [order] 可选的排序方式
  Future<void> search(
    String keyword, {
    int? categoryId,
    List<String>? tags,
    SearchOrder? order,
    bool refresh = true,
  }) async {
    if (keyword.trim().isEmpty) {
      state = state.copyWith(
        error: '请输入搜索关键词',
        isLoading: false,
      );
      return;
    }

    if (refresh) {
      state = state.copyWith(
        isLoading: true,
        error: null,
        currentKeyword: keyword,
        currentPage: 1,
        posts: [],
        topics: [],
      );
    } else {
      state = state.copyWith(
        isLoading: true,
        error: null,
      );
    }

    try {
      final request = SearchRequest(
        keyword: keyword,
        page: refresh ? 1 : state.currentPage,
        categoryId: categoryId,
        tags: tags,
        order: order,
      );

      final response = await _apiService.searchAdvanced(request);
      final searchResponse = SearchResponse.fromJson(response.data);

      if (refresh) {
        state = state.copyWith(
          posts: searchResponse.posts,
          topics: searchResponse.topics,
          isLoading: false,
          hasMore: searchResponse.hasMorePosts,
          currentPage: 2,
          error: null,
        );
      } else {
        state = state.copyWith(
          posts: [...state.posts, ...searchResponse.posts],
          topics: [...state.topics, ...searchResponse.topics],
          isLoading: false,
          hasMore: searchResponse.hasMorePosts,
          currentPage: state.currentPage + 1,
          error: null,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: '搜索失败: $e',
      );
    }
  }

  /// 加载更多搜索结果
  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore || state.currentKeyword == null) {
      return;
    }

    await search(
      state.currentKeyword!,
      refresh: false,
    );
  }

  /// 获取搜索建议
  Future<void> getSuggestions(String term) async {
    if (term.trim().isEmpty) {
      state = state.copyWith(suggestions: []);
      return;
    }

    try {
      final response = await _apiService.getSearchSuggestions(term);
      final data = response.data;

      final suggestions = <SearchSuggestion>[];

      // 解析话题建议
      if (data['topics'] != null) {
        suggestions.addAll(
          (data['topics'] as List)
              .map((t) => SearchSuggestion.fromTopic(t)),
        );
      }

      // 解析用户建议
      if (data['users'] != null) {
        suggestions.addAll(
          (data['users'] as List)
              .map((u) => SearchSuggestion.fromUser(u)),
        );
      }

      // 解析分类建议
      if (data['categories'] != null) {
        suggestions.addAll(
          (data['categories'] as List)
              .map((c) => SearchSuggestion.fromCategory(c)),
        );
      }

      state = state.copyWith(suggestions: suggestions);
    } catch (e) {
      // 建议获取失败不显示错误，静默处理
      state = state.copyWith(suggestions: []);
    }
  }

  /// 清除搜索建议
  void clearSuggestions() {
    state = state.copyWith(suggestions: []);
  }

  /// 清除搜索结果
  void clearResults() {
    state = const SearchState();
  }

  /// 添加搜索历史
  void addSearchHistory(String keyword, {int? resultCount}) {
    if (keyword.trim().isEmpty) return;

    final newHistory = SearchHistory(
      keyword: keyword,
      timestamp: DateTime.now(),
      resultCount: resultCount,
    );

    // 去重并限制历史记录数量（最多20条）
    final updatedHistory = [
      newHistory,
      ...state.searchHistory.where((h) => h.keyword != keyword),
    ].take(20).toList();

    state = state.copyWith(searchHistory: updatedHistory);
  }

  /// 清除搜索历史
  void clearSearchHistory() {
    state = state.copyWith(searchHistory: []);
  }

  /// 删除单条搜索历史
  void removeSearchHistory(String keyword) {
    state = state.copyWith(
      searchHistory: state.searchHistory
          .where((h) => h.keyword != keyword)
          .toList(),
    );
  }
}

/// 搜索 Provider
final searchProvider =
    StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  final apiService = ref.watch(discourseApiServiceProvider);
  return SearchNotifier(apiService);
});

/// 搜索结果列表 Provider（用于监听帖子列表变化）
final searchPostsProvider = Provider<List<SearchPost>>((ref) {
  return ref.watch(searchProvider).posts;
});

/// 搜索话题列表 Provider（用于监听话题列表变化）
final searchTopicsProvider = Provider<List<SearchTopic>>((ref) {
  return ref.watch(searchProvider).topics;
});

/// 搜索建议 Provider
final searchSuggestionsProvider = Provider<List<SearchSuggestion>>((ref) {
  return ref.watch(searchProvider).suggestions;
});

/// 搜索历史 Provider
final searchHistoryProvider = Provider<List<SearchHistory>>((ref) {
  return ref.watch(searchProvider).searchHistory;
});

/// 是否正在搜索 Provider
final isSearchingProvider = Provider<bool>((ref) {
  return ref.watch(searchProvider).isLoading;
});

/// 是否有更多结果 Provider
final hasMoreSearchResultsProvider = Provider<bool>((ref) {
  return ref.watch(searchProvider).hasMore;
});
