import 'package:dio/dio.dart';
import '../../data/models/ai_news.dart';

/// AI快讯服务接口
///
/// 用于获取AI相关的新闻资讯
class AINewsService {
  final Dio _dio;

  AINewsService(this._dio);

  /// 获取AI快讯列表
  ///
  /// [page] 页码，从1开始
  /// [pageSize] 每页数量
  /// @return AI快讯列表响应
  Future<AINewsResponse> getAINewsList({
    int page = 1,
    int pageSize = 20,
  }) async {
    final response = await _dio.get(
      '/api/ai-news',
      queryParameters: {
        'page': page,
        'page_size': pageSize,
      },
    );
    return AINewsResponse.fromJson(response.data);
  }

  /// 获取热门AI快讯
  ///
  /// [limit] 返回数量限制
  /// @return 热门AI快讯列表
  Future<List<AINews>> getHotAINews({int limit = 10}) async {
    final response = await _dio.get(
      '/api/ai-news/hot',
      queryParameters: {'limit': limit},
    );
    final List<dynamic> data = response.data;
    return data.map((e) => AINews.fromJson(e)).toList();
  }

  /// 获取AI快讯详情
  ///
  /// [id] 新闻ID
  /// @return AI快讯详情
  Future<AINews> getAINewsDetail(String id) async {
    final response = await _dio.get('/api/ai-news/$id');
    return AINews.fromJson(response.data);
  }
}
