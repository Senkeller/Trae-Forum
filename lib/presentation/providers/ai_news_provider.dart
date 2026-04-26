import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/ai_news.dart';
import '../../data/repositories/ai_news_repository.dart';

part 'ai_news_provider.g.dart';

/// AI快讯状态类
class AINewsState {
  /// 新闻列表
  final List<AINews> newsList;

  /// 是否正在刷新
  final bool isRefreshing;

  /// 是否正在加载更多
  final bool isLoadingMore;

  /// 当前页码
  final int currentPage;

  /// 是否有更多数据
  final bool hasMore;

  /// 错误信息
  final String? errorMessage;

  const AINewsState({
    this.newsList = const [],
    this.isRefreshing = false,
    this.isLoadingMore = false,
    this.currentPage = 1,
    this.hasMore = true,
    this.errorMessage,
  });

  AINewsState copyWith({
    List<AINews>? newsList,
    bool? isRefreshing,
    bool? isLoadingMore,
    int? currentPage,
    bool? hasMore,
    String? errorMessage,
  }) {
    return AINewsState(
      newsList: newsList ?? this.newsList,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage,
    );
  }
}

/// AI快讯Notifier
@riverpod
class AINewsNotifier extends _$AINewsNotifier {
  @override
  AINewsState build() {
    return const AINewsState();
  }

  /// 刷新AI快讯列表
  Future<void> refreshNews() async {
    if (state.isRefreshing) return;

    state = state.copyWith(
      isRefreshing: true,
      errorMessage: null,
      currentPage: 1,
      hasMore: true,
    );

    try {
      final repository = ref.read(aiNewsRepositoryProvider);
      final response = await repository.getAINewsList(page: 1);

      state = state.copyWith(
        newsList: response.newsList,
        isRefreshing: false,
        hasMore: response.hasMore,
        currentPage: 1,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isRefreshing: false,
        errorMessage: '获取AI快讯失败: $e',
      );
    }
  }

  /// 加载更多AI快讯
  Future<void> loadMoreNews() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(
      isLoadingMore: true,
      errorMessage: null,
    );

    try {
      final nextPage = state.currentPage + 1;
      final repository = ref.read(aiNewsRepositoryProvider);
      final response = await repository.getAINewsList(page: nextPage);

      if (response.newsList.isEmpty) {
        state = state.copyWith(
          isLoadingMore: false,
          hasMore: false,
        );
        return;
      }

      // 去重
      final existingIds = state.newsList.map((e) => e.id).toSet();
      final newNews = response.newsList
          .where((e) => !existingIds.contains(e.id))
          .toList();

      state = state.copyWith(
        newsList: [...state.newsList, ...newNews],
        isLoadingMore: false,
        currentPage: nextPage,
        hasMore: response.hasMore,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: '加载更多失败: $e',
      );
    }
  }

  /// 清空错误信息
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// AI快讯列表Provider
@riverpod
List<AINews> aiNewsList(AiNewsListRef ref) {
  return ref.watch(aINewsNotifierProvider).newsList;
}

/// 是否正在刷新Provider
@riverpod
bool isAINewsRefreshing(IsAINewsRefreshingRef ref) {
  return ref.watch(aINewsNotifierProvider).isRefreshing;
}

/// 是否正在加载更多Provider
@riverpod
bool isAINewsLoadingMore(IsAINewsLoadingMoreRef ref) {
  return ref.watch(aINewsNotifierProvider).isLoadingMore;
}

/// 是否有更多数据Provider
@riverpod
bool hasMoreAINews(HasMoreAINewsRef ref) {
  return ref.watch(aINewsNotifierProvider).hasMore;
}

/// AI快讯错误信息Provider
@riverpod
String? aiNewsErrorMessage(AiNewsErrorMessageRef ref) {
  return ref.watch(aINewsNotifierProvider).errorMessage;
}
