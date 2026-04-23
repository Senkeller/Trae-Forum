import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/api_service.dart';
import '../../core/network/dio_client.dart';
import 'home_provider.dart';

part 'search_provider.g.dart';

/// 搜索类型枚举
enum SearchType {
  /// 全部
  all,
  /// 动态
  feed,
  /// 用户
  user,
  /// 应用
  apk,
  /// 话题
  topic,
}

/// 搜索排序类型枚举
enum SearchSortType {
  /// 默认排序
  defaultSort,
  /// 最新发布
  latest,
  /// 最多回复
  mostReplies,
  /// 最多点赞
  mostLikes,
}

/// 搜索结果数据模型
class SearchResult {
  /// 结果ID
  final String id;
  /// 结果类型
  final String type;
  /// 标题/内容
  final String title;
  /// 描述
  final String? description;
  /// 图片URL
  final String? imageUrl;
  /// 附加信息
  final Map<String, dynamic>? extra;

  const SearchResult({
    required this.id,
    required this.type,
    required this.title,
    this.description,
    this.imageUrl,
    this.extra,
  });

  /// 从 JSON 创建
  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      id: json['id']?.toString() ?? '',
      type: json['entityType'] ?? json['type'] ?? 'feed',
      title: json['title'] ?? json['message'] ?? '',
      description: json['description'] ?? json['username'],
      imageUrl: json['logo'] ?? json['pic'] ?? json['userAvatar'],
      extra: json,
    );
  }
}

/// 搜索状态类
class SearchState {
  /// 搜索关键词
  final String keyword;
  /// 搜索结果列表
  final List<SearchResult> results;
  /// 搜索历史
  final List<String> searchHistory;
  /// 当前搜索类型
  final SearchType searchType;
  /// 当前排序类型
  final SearchSortType sortType;
  /// 是否正在搜索
  final bool isSearching;
  /// 是否正在加载更多
  final bool isLoadingMore;
  /// 当前页码
  final int currentPage;
  /// 是否还有更多结果
  final bool hasMore;
  /// 错误信息
  final String? errorMessage;
  /// 最后加载标识
  final String? lastItem;

  const SearchState({
    this.keyword = '',
    this.results = const [],
    this.searchHistory = const [],
    this.searchType = SearchType.all,
    this.sortType = SearchSortType.defaultSort,
    this.isSearching = false,
    this.isLoadingMore = false,
    this.currentPage = 1,
    this.hasMore = true,
    this.errorMessage,
    this.lastItem,
  });

  /// 复制并修改
  SearchState copyWith({
    String? keyword,
    List<SearchResult>? results,
    List<String>? searchHistory,
    SearchType? searchType,
    SearchSortType? sortType,
    bool? isSearching,
    bool? isLoadingMore,
    int? currentPage,
    bool? hasMore,
    String? errorMessage,
    String? lastItem,
  }) {
    return SearchState(
      keyword: keyword ?? this.keyword,
      results: results ?? this.results,
      searchHistory: searchHistory ?? this.searchHistory,
      searchType: searchType ?? this.searchType,
      sortType: sortType ?? this.sortType,
      isSearching: isSearching ?? this.isSearching,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage,
      lastItem: lastItem ?? this.lastItem,
    );
  }
}

/// 搜索状态 Notifier
@riverpod
class SearchNotifier extends _$SearchNotifier {
  static const String _searchHistoryKey = 'search_history';
  static const int _maxHistoryCount = 20;

  late ApiService _apiService;

  /// 构建搜索状态
  @override
  SearchState build() {
    _apiService = ref.read(apiServiceProvider);
    _loadSearchHistory();
    return const SearchState();
  }

  /// 加载搜索历史
  Future<void> _loadSearchHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final history = prefs.getStringList(_searchHistoryKey) ?? [];
      state = state.copyWith(searchHistory: history);
    } catch (e) {
      // 加载失败，使用空列表
    }
  }

  /// 保存搜索历史
  Future<void> _saveSearchHistory(List<String> history) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_searchHistoryKey, history);
    } catch (e) {
      // 保存失败
    }
  }

  /// 设置搜索关键词
  ///
  /// [keyword] 搜索关键词
  void setKeyword(String keyword) {
    state = state.copyWith(keyword: keyword);
  }

  /// 设置搜索类型
  ///
  /// [type] 搜索类型
  void setSearchType(SearchType type) {
    state = state.copyWith(searchType: type);
  }

  /// 设置排序类型
  ///
  /// [sortType] 排序类型
  void setSortType(SearchSortType sortType) {
    state = state.copyWith(sortType: sortType);
  }

  /// 执行搜索
  ///
  /// [keyword] 搜索关键词，为空则使用当前状态中的关键词
  Future<void> search([String? keyword]) async {
    final searchKeyword = keyword ?? state.keyword;
    if (searchKeyword.trim().isEmpty) return;

    // 添加到搜索历史
    await _addToHistory(searchKeyword);

    state = state.copyWith(
      keyword: searchKeyword,
      isSearching: true,
      errorMessage: null,
      currentPage: 1,
      results: [],
      lastItem: null,
    );

    try {
      final response = await _apiService.getSearch(
        type: _getSearchTypeString(state.searchType),
        keyWord: searchKeyword,
        sort: _getSortTypeString(state.sortType),
        page: 1,
      );

      if (response.status == 1 && response.data != null) {
        final results = (response.data as List<dynamic>)
            .map((item) => SearchResult.fromJson(item as Map<String, dynamic>))
            .toList();

        state = state.copyWith(
          results: results,
          isSearching: false,
          hasMore: results.length >= 20,
          currentPage: 1,
          lastItem: results.isNotEmpty ? results.last.id : null,
        );
      } else {
        state = state.copyWith(
          isSearching: false,
          errorMessage: response.message ?? '搜索失败',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isSearching: false,
        errorMessage: '网络错误: $e',
      );
    }
  }

  /// 加载更多搜索结果
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.keyword.isEmpty) return;

    state = state.copyWith(
      isLoadingMore: true,
      errorMessage: null,
    );

    try {
      final nextPage = state.currentPage + 1;

      final response = await _apiService.getSearch(
        type: _getSearchTypeString(state.searchType),
        keyWord: state.keyword,
        sort: _getSortTypeString(state.sortType),
        page: nextPage,
        lastItem: state.lastItem,
      );

      if (response.status == 1 && response.data != null) {
        final newResults = (response.data as List<dynamic>)
            .map((item) => SearchResult.fromJson(item as Map<String, dynamic>))
            .toList();

        if (newResults.isEmpty) {
          state = state.copyWith(
            isLoadingMore: false,
            hasMore: false,
          );
        } else {
          state = state.copyWith(
            results: [...state.results, ...newResults],
            isLoadingMore: false,
            currentPage: nextPage,
            hasMore: newResults.length >= 20,
            lastItem: newResults.last.id,
          );
        }
      } else {
        state = state.copyWith(
          isLoadingMore: false,
          errorMessage: '加载更多失败',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: '网络错误: $e',
      );
    }
  }

  /// 添加到搜索历史
  ///
  /// [keyword] 要添加的关键词
  Future<void> _addToHistory(String keyword) async {
    final trimmedKeyword = keyword.trim();
    if (trimmedKeyword.isEmpty) return;

    var history = List<String>.from(state.searchHistory);
    
    // 移除已存在的相同关键词（移到最前面）
    history.remove(trimmedKeyword);
    
    // 添加到开头
    history.insert(0, trimmedKeyword);
    
    // 限制历史记录数量
    if (history.length > _maxHistoryCount) {
      history = history.sublist(0, _maxHistoryCount);
    }

    await _saveSearchHistory(history);
    state = state.copyWith(searchHistory: history);
  }

  /// 从搜索历史中删除
  ///
  /// [keyword] 要删除的关键词
  Future<void> removeFromHistory(String keyword) async {
    var history = List<String>.from(state.searchHistory);
    history.remove(keyword);
    
    await _saveSearchHistory(history);
    state = state.copyWith(searchHistory: history);
  }

  /// 清空搜索历史
  Future<void> clearHistory() async {
    await _saveSearchHistory([]);
    state = state.copyWith(searchHistory: []);
  }

  /// 清空搜索结果
  void clearResults() {
    state = state.copyWith(
      results: [],
      keyword: '',
      currentPage: 1,
      hasMore: true,
      errorMessage: null,
    );
  }

  /// 清空错误信息
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// 获取搜索类型的字符串表示
  String _getSearchTypeString(SearchType type) {
    switch (type) {
      case SearchType.all:
        return 'all';
      case SearchType.feed:
        return 'feed';
      case SearchType.user:
        return 'user';
      case SearchType.apk:
        return 'apk';
      case SearchType.topic:
        return 'topic';
    }
  }

  /// 获取排序类型的字符串表示
  String _getSortTypeString(SearchSortType type) {
    switch (type) {
      case SearchSortType.defaultSort:
        return 'default';
      case SearchSortType.latest:
        return 'dateline_desc';
      case SearchSortType.mostReplies:
        return 'reply_desc';
      case SearchSortType.mostLikes:
        return 'popular';
    }
  }
}

/// 搜索关键词 Provider
@riverpod
String searchKeyword(SearchKeywordRef ref) {
  return ref.watch(searchNotifierProvider).keyword;
}

/// 搜索结果 Provider
@riverpod
List<SearchResult> searchResults(SearchResultsRef ref) {
  return ref.watch(searchNotifierProvider).results;
}

/// 搜索历史 Provider
@riverpod
List<String> searchHistory(SearchHistoryRef ref) {
  return ref.watch(searchNotifierProvider).searchHistory;
}

/// 是否正在搜索 Provider
@riverpod
bool isSearching(IsSearchingRef ref) {
  return ref.watch(searchNotifierProvider).isSearching;
}

/// 搜索类型 Provider
@riverpod
SearchType currentSearchType(CurrentSearchTypeRef ref) {
  return ref.watch(searchNotifierProvider).searchType;
}

/// 搜索排序类型扩展
extension SearchSortTypeExtension on SearchSortType {
  /// 获取排序类型的显示名称
  String get displayName {
    switch (this) {
      case SearchSortType.defaultSort:
        return '默认排序';
      case SearchSortType.latest:
        return '最新发布';
      case SearchSortType.mostReplies:
        return '最多回复';
      case SearchSortType.mostLikes:
        return '最多点赞';
    }
  }
}

/// 搜索类型扩展
extension SearchTypeExtension on SearchType {
  /// 获取搜索类型的显示名称
  String get displayName {
    switch (this) {
      case SearchType.all:
        return '全部';
      case SearchType.feed:
        return '动态';
      case SearchType.user:
        return '用户';
      case SearchType.apk:
        return '应用';
      case SearchType.topic:
        return '话题';
    }
  }
}
