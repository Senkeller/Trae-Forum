import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive_ce/hive_ce.dart';
import '../../core/network/maomu_scraper_service_v2.dart';
import '../../data/models/ai_news.dart';

part 'ai_news_repository_v2.g.dart';

/// AI快讯仓库 V2
///
/// 优化后的仓库，添加缓存和错误处理
@riverpod
AINewsRepositoryV2 aiNewsRepositoryV2(Ref ref) {
  final scraper = MaomuScraperServiceV2();
  return AINewsRepositoryV2(scraper);
}

class AINewsRepositoryV2 {
  final MaomuScraperServiceV2 _scraper;
  Box<dynamic>? _cacheBox;

  // 缓存键名
  static const String _cacheKey = 'ai_news_cache';
  static const String _cacheTimeKey = 'ai_news_cache_time';

  // 缓存有效期（5分钟）
  static const Duration _cacheValidity = Duration(minutes: 5);

  AINewsRepositoryV2(this._scraper);

  /// 初始化缓存
  Future<void> _initCache() async {
    if (_cacheBox == null || !_cacheBox!.isOpen) {
      _cacheBox = await Hive.openBox<dynamic>('ai_news_cache_box');
    }
  }

  /// 获取缓存的新闻列表
  Future<List<AINews>?> _getCachedNews() async {
    try {
      await _initCache();

      final cachedData = _cacheBox?.get(_cacheKey) as List<dynamic>?;
      final cachedTime = _cacheBox?.get(_cacheTimeKey) as DateTime?;

      // 检查缓存是否有效
      if (cachedData != null && cachedTime != null) {
        final now = DateTime.now();
        if (now.difference(cachedTime) < _cacheValidity) {
          return cachedData.cast<AINews>();
        }
      }
    } catch (e) {
      // 缓存读取失败，返回null
    }
    return null;
  }

  /// 保存新闻列表到缓存
  Future<void> _cacheNews(List<AINews> newsList) async {
    try {
      await _initCache();
      await _cacheBox?.put(_cacheKey, newsList);
      await _cacheBox?.put(_cacheTimeKey, DateTime.now());
    } catch (e) {
      // 缓存保存失败，忽略错误
    }
  }

  /// 获取AI快讯列表（带缓存）
  ///
  /// [page] 页码
  /// [pageSize] 每页数量
  /// [forceRefresh] 强制刷新，忽略缓存
  /// @return AI快讯列表响应
  Future<AINewsResponse> getAINewsList({
    int page = 1,
    int pageSize = 20,
    bool forceRefresh = false,
  }) async {
    try {
      List<AINews> newsList;

      // 如果不是强制刷新，先尝试从缓存获取
      if (!forceRefresh && page == 1) {
        final cachedNews = await _getCachedNews();
        if (cachedNews != null && cachedNews.isNotEmpty) {
          newsList = cachedNews;
        } else {
          // 缓存不存在或已过期，从网络获取
          newsList = await _scraper.scrapeAINewsList();
          // 保存到缓存
          await _cacheNews(newsList);
        }
      } else {
        // 从网络获取
        newsList = await _scraper.scrapeAINewsList();
        // 如果是第一页，保存到缓存
        if (page == 1) {
          await _cacheNews(newsList);
        }
      }

      // 模拟分页
      final startIndex = (page - 1) * pageSize;
      final endIndex = startIndex + pageSize;
      final paginatedList = newsList.sublist(
        startIndex.clamp(0, newsList.length),
        endIndex.clamp(0, newsList.length),
      );

      return AINewsResponse(
        newsList: paginatedList,
        hasMore: endIndex < newsList.length,
        currentPage: page,
        totalPages: (newsList.length / pageSize).ceil(),
      );
    } catch (e) {
      // 如果网络请求失败，尝试返回缓存数据
      final cachedNews = await _getCachedNews();
      if (cachedNews != null && cachedNews.isNotEmpty) {
        final startIndex = (page - 1) * pageSize;
        final endIndex = startIndex + pageSize;
        final paginatedList = cachedNews.sublist(
          startIndex.clamp(0, cachedNews.length),
          endIndex.clamp(0, cachedNews.length),
        );

        return AINewsResponse(
          newsList: paginatedList,
          hasMore: endIndex < cachedNews.length,
          currentPage: page,
          totalPages: (cachedNews.length / pageSize).ceil(),
        );
      }

      // 如果没有缓存，返回备用数据
      return _getFallbackResponse(page, pageSize);
    }
  }

  /// 获取热门AI快讯
  Future<List<AINews>> getHotAINews({int limit = 10}) async {
    try {
      final response = await getAINewsList(page: 1, pageSize: limit);
      return response.newsList.where((news) => news.isHot).take(limit).toList();
    } catch (e) {
      return [];
    }
  }

  /// 清除缓存
  Future<void> clearCache() async {
    try {
      await _initCache();
      await _cacheBox?.delete(_cacheKey);
      await _cacheBox?.delete(_cacheTimeKey);
    } catch (e) {
      // 忽略错误
    }
  }

  /// 获取备用响应
  AINewsResponse _getFallbackResponse(int page, int pageSize) {
    final fallbackNews = [
      AINews(
        id: 'fallback_1',
        title: '京东启动"Aidol 创造营"计划，面向全球征集AI智能硬件项目',
        content: '京东"Aidol 创造营"计划正式启动，面向全球征集AI智能硬件项目，不看公司规模，只看产品思路与技术突破。入选项目将获得京东资本、技术、渠道等五大核心能力支持，并与618大促联动曝光。',
        source: 'IT之家',
        sourceUrl: 'https://maomu.com/news',
        publishTime: DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
        tags: ['AI硬件', '京东', '创业'],
        category: AINewsCategory.aiHardware,
        viewCount: 12580,
        isHot: true,
        isPinned: true,
      ),
      AINews(
        id: 'fallback_2',
        title: 'OpenAI发布GPT-4 Turbo新版本，推理能力大幅提升',
        content: 'OpenAI今日发布了GPT-4 Turbo的最新版本，新版本在推理能力、代码生成和多语言支持方面都有显著提升。',
        source: 'OpenAI',
        sourceUrl: 'https://openai.com/',
        publishTime: DateTime.now().subtract(const Duration(hours: 5)).toIso8601String(),
        tags: ['OpenAI', 'GPT-4', '大模型'],
        category: AINewsCategory.llm,
        viewCount: 25600,
        isHot: true,
      ),
      AINews(
        id: 'fallback_3',
        title: '谷歌Gemini 1.5 Pro正式对外开放，支持100万token上下文',
        content: '谷歌宣布Gemini 1.5 Pro正式对外开放使用，该模型最大的特点是支持100万token的上下文窗口。',
        source: 'Google',
        sourceUrl: 'https://blog.google/',
        publishTime: DateTime.now().subtract(const Duration(hours: 8)).toIso8601String(),
        tags: ['Google', 'Gemini', '大模型'],
        category: AINewsCategory.llm,
        viewCount: 18900,
        isHot: true,
      ),
    ];

    final startIndex = (page - 1) * pageSize;
    final endIndex = startIndex + pageSize;
    final paginatedList = fallbackNews.sublist(
      startIndex.clamp(0, fallbackNews.length),
      endIndex.clamp(0, fallbackNews.length),
    );

    return AINewsResponse(
      newsList: paginatedList,
      hasMore: endIndex < fallbackNews.length,
      currentPage: page,
      totalPages: (fallbackNews.length / pageSize).ceil(),
    );
  }
}
