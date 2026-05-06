import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/network/api_service.dart' as api;
import '../models/feed.dart';

part 'search_repository.g.dart';

/// 搜索仓库
/// 负责处理搜索相关的数据操作，包括搜索动态/用户/话题、搜索历史管理等
@riverpod
SearchRepository searchRepository(SearchRepositoryRef ref) {
  final apiService = ref.read(api.apiServiceProvider);
  return SearchRepository(apiService);
}

/// 搜索仓库类
class SearchRepository {
  final api.ApiService _apiService;

  SearchRepository(this._apiService);

  /// 搜索
  ///
  /// [keyWord] 搜索关键词
  /// [type] 搜索类型
  Future<HomeFeedResponse> search({
    required String keyWord,
    String type = 'all',
    required int page,
    String? lastItem,
  }) async {
    return await _apiService.getSearch(
      keyWord: keyWord,
      type: type,
      feedType: 'all',
      sort: 'default',
      page: page,
      lastItem: lastItem,
    );
  }

  /// 获取搜索历史
  Future<List<String>> getSearchHistory() async {
    return [];
  }

  /// 清空搜索历史
  Future<void> clearSearchHistory() async {
  }

  /// 添加搜索历史
  Future<void> addSearchHistory(String keyword) async {
  }

  /// 获取热门搜索
  Future<List<String>> getHotSearch() async {
    return [];
  }
}
