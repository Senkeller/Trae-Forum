import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/ai_news_service.dart';
import '../../core/network/maomu_scraper_service.dart';
import '../../data/models/ai_news.dart';
import 'package:dio/dio.dart';

part 'ai_news_repository.g.dart';

/// AI快讯仓库
///
/// 负责AI快讯数据的获取和管理
@riverpod
AINewsRepository aiNewsRepository(Ref ref) {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://maomu.com',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));
  final service = AINewsService(dio);
  final scraper = MaomuScraperService();
  return AINewsRepository(service, scraper);
}

class AINewsRepository {
  final MaomuScraperService _scraper;

  AINewsRepository(AINewsService _, this._scraper);

  /// 获取AI快讯列表
  ///
  /// [page] 页码
  /// [pageSize] 每页数量
  /// @return AI快讯列表响应
  Future<AINewsResponse> getAINewsList({int page = 1, int pageSize = 20}) async {
    try {
      // 使用网页抓取服务获取真实的猫目网站内容
      final newsList = await _scraper.scrapeAINewsList();

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
      // 如果抓取失败，返回模拟数据作为后备
      return _getMockAINewsList(page, pageSize);
    }
  }

  /// 获取热门AI快讯
  ///
  /// [limit] 返回数量限制
  /// @return 热门AI快讯列表
  Future<List<AINews>> getHotAINews({int limit = 10}) async {
    try {
      // 使用网页抓取服务获取真实的猫目网站内容
      final newsList = await _scraper.scrapeAINewsList();
      return newsList.where((news) => news.isHot).take(limit).toList();
    } catch (e) {
      // 如果抓取失败，返回模拟数据作为后备
      final response = _getMockAINewsList(1, limit);
      return response.newsList;
    }
  }

  /// 模拟AI快讯数据
  ///
  /// 用于开发和测试阶段，后续替换为真实API
  AINewsResponse _getMockAINewsList(int page, int pageSize) {
    final mockData = [
      AINews(
        id: '1',
        title: '京东启动"Aidol 创造营"计划，面向全球征集AI智能硬件项目',
        content: '京东"Aidol 创造营"计划正式启动，面向全球征集AI智能硬件项目，不看公司规模，只看产品思路与技术突破。入选项目将获得京东资本、技术、渠道等五大核心能力支持，并与618大促联动曝光。报名截止5月15日，首期活动5月25日开启。',
        source: 'IT之家',
        sourceUrl: 'https://www.ithome.com/',
        publishTime: DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
        tags: ['AI硬件', '京东', '创业'],
        coverImage: null,
        author: null,
        viewCount: 12580,
        isHot: true,
      ),
      AINews(
        id: '2',
        title: 'OpenAI发布GPT-4 Turbo新版本，性能提升显著',
        content: 'OpenAI今日发布了GPT-4 Turbo的最新版本，新版本在推理能力、代码生成和多语言支持方面都有显著提升。据官方介绍，新版本在处理复杂任务时的准确率提高了15%，同时响应速度也有所加快。',
        source: 'OpenAI',
        sourceUrl: 'https://openai.com/',
        publishTime: DateTime.now().subtract(const Duration(hours: 5)).toIso8601String(),
        tags: ['OpenAI', 'GPT-4', '大模型'],
        coverImage: null,
        author: null,
        viewCount: 25600,
        isHot: true,
      ),
      AINews(
        id: '3',
        title: '谷歌Gemini 1.5 Pro正式对外开放，支持100万token上下文',
        content: '谷歌宣布Gemini 1.5 Pro正式对外开放使用，该模型最大的特点是支持100万token的上下文窗口，可以处理长达1小时的视频或超过30000行的代码。这一突破将极大提升AI在处理长文档和视频内容时的能力。',
        source: 'Google',
        sourceUrl: 'https://blog.google/',
        publishTime: DateTime.now().subtract(const Duration(hours: 8)).toIso8601String(),
        tags: ['Google', 'Gemini', '大模型'],
        coverImage: null,
        author: null,
        viewCount: 18900,
        isHot: true,
      ),
      AINews(
        id: '4',
        title: 'Anthropic发布Claude 3系列模型，多模态能力大幅提升',
        content: 'Anthropic发布了新一代AI模型Claude 3系列，包括Claude 3 Haiku、Claude 3 Sonnet和Claude 3 Opus三个版本。新系列模型在视觉理解、推理能力和安全性方面都有显著提升，其中Opus版本在多项基准测试中超越了GPT-4。',
        source: 'Anthropic',
        sourceUrl: 'https://www.anthropic.com/',
        publishTime: DateTime.now().subtract(const Duration(hours: 12)).toIso8601String(),
        tags: ['Anthropic', 'Claude', '多模态'],
        coverImage: null,
        author: null,
        viewCount: 15200,
        isHot: false,
      ),
      AINews(
        id: '5',
        title: 'Meta发布Llama 3开源模型，性能媲美GPT-4',
        content: 'Meta正式发布Llama 3系列开源大模型，包括80亿和700亿参数两个版本。据官方测试，Llama 3在多项基准测试中表现出色，70B版本在某些任务上甚至可以与GPT-4媲美。该模型完全开源，可商用。',
        source: 'Meta',
        sourceUrl: 'https://ai.meta.com/',
        publishTime: DateTime.now().subtract(const Duration(hours: 16)).toIso8601String(),
        tags: ['Meta', 'Llama', '开源'],
        coverImage: null,
        author: null,
        viewCount: 32100,
        isHot: true,
      ),
      AINews(
        id: '6',
        title: '微软Copilot for Microsoft 365正式上线，月费30美元',
        content: '微软宣布Copilot for Microsoft 365正式面向所有企业用户开放，该服务集成了GPT-4能力，可以在Word、Excel、PowerPoint等Office应用中提供AI辅助功能。订阅费用为每用户每月30美元。',
        source: 'Microsoft',
        sourceUrl: 'https://news.microsoft.com/',
        publishTime: DateTime.now().subtract(const Duration(hours: 20)).toIso8601String(),
        tags: ['Microsoft', 'Copilot', '办公'],
        coverImage: null,
        author: null,
        viewCount: 9800,
        isHot: false,
      ),
      AINews(
        id: '7',
        title: 'Stable Diffusion 3发布，图像生成质量再创新高',
        content: 'Stability AI发布Stable Diffusion 3，新一代模型在图像生成质量、文字渲染能力和多主题合成方面都有显著提升。该模型采用了新的多模态扩散架构，可以更好地理解复杂的文本提示。',
        source: 'Stability AI',
        sourceUrl: 'https://stability.ai/',
        publishTime: DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        tags: ['Stability AI', 'SD3', '图像生成'],
        coverImage: null,
        author: null,
        viewCount: 21500,
        isHot: true,
      ),
      AINews(
        id: '8',
        title: 'Midjourney V6发布，支持更精确的图像控制和文字生成',
        content: 'Midjourney发布V6版本，新版本在图像真实感、细节表现和文字渲染方面都有重大改进。V6版本可以更好地理解复杂的描述性提示，并且支持在图像中生成清晰可读的英文文字。',
        source: 'Midjourney',
        sourceUrl: 'https://www.midjourney.com/',
        publishTime: DateTime.now().subtract(const Duration(days: 1, hours: 4)).toIso8601String(),
        tags: ['Midjourney', '图像生成', 'V6'],
        coverImage: null,
        author: null,
        viewCount: 18700,
        isHot: false,
      ),
      AINews(
        id: '9',
        title: 'Runway Gen-2更新，视频生成时长延长至16秒',
        content: 'Runway宣布Gen-2视频生成模型重大更新，单次生成视频的时长从4秒延长至16秒。同时，视频质量和一致性也得到显著提升，用户可以生成更长的连续视频片段。',
        source: 'Runway',
        sourceUrl: 'https://runwayml.com/',
        publishTime: DateTime.now().subtract(const Duration(days: 1, hours: 8)).toIso8601String(),
        tags: ['Runway', '视频生成', 'Gen-2'],
        coverImage: null,
        author: null,
        viewCount: 14200,
        isHot: false,
      ),
      AINews(
        id: '10',
        title: 'Pika Labs 1.0发布，AI视频编辑功能全面升级',
        content: 'Pika Labs发布1.0正式版，新版本在视频生成速度、质量和编辑功能方面都有显著提升。新增的"视频扩展"功能可以将现有视频延长，"区域编辑"功能允许用户精确控制视频的特定部分。',
        source: 'Pika Labs',
        sourceUrl: 'https://pika.art/',
        publishTime: DateTime.now().subtract(const Duration(days: 1, hours: 12)).toIso8601String(),
        tags: ['Pika', '视频生成', 'AI编辑'],
        coverImage: null,
        author: null,
        viewCount: 11500,
        isHot: false,
      ),
    ];

    // 模拟分页
    final startIndex = (page - 1) * pageSize;
    final endIndex = startIndex + pageSize;
    final paginatedList = mockData.sublist(
      startIndex.clamp(0, mockData.length),
      endIndex.clamp(0, mockData.length),
    );

    return AINewsResponse(
      newsList: paginatedList,
      hasMore: endIndex < mockData.length,
      currentPage: page,
      totalPages: (mockData.length / pageSize).ceil(),
    );
  }
}
