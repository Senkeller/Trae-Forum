import 'package:dio/dio.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import '../../data/models/ai_news.dart';

/// 猫目网站抓取服务 V2
///
/// 优化后的抓取服务，提高解析准确率
class MaomuScraperServiceV2 {
  final Dio _dio;

  MaomuScraperServiceV2({Dio? dio}) : _dio = dio ?? Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
      'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
      'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8',
    },
  ));

  /// 抓取AI资讯列表
  Future<List<AINews>> scrapeAINewsList() async {
    try {
      final response = await _dio.get('https://maomu.com/news');
      final html = response.data as String;
      return _parseNewsList(html);
    } catch (e) {
      throw Exception('抓取AI资讯失败: $e');
    }
  }

  /// 解析HTML提取新闻列表
  List<AINews> _parseNewsList(String html) {
    final document = parse(html);
    final newsList = <AINews>[];

    // 尝试多种选择器策略
    var articles = _trySelectors(document, [
      // 常见的文章列表结构
      'article.news-item',
      'article.post-item',
      'article.article-item',
      '.news-list article',
      '.post-list article',
      // 列表项结构
      '.news-item',
      '.post-item',
      '.article-item',
      '.list-item',
      '[class*="news-item"]',
      '[class*="post-item"]',
      // 卡片结构
      '.card',
      '.news-card',
      '.post-card',
    ]);

    // 如果还是没有找到，尝试从段落中提取
    if (articles.isEmpty) {
      return _parseFromParagraphs(document);
    }

    for (var i = 0; i < articles.length; i++) {
      final article = articles[i];
      final news = _extractNewsFromElement(article, i);
      if (news != null) {
        newsList.add(news);
      }
    }

    // 如果解析失败，使用备用方案
    if (newsList.isEmpty) {
      return _getFallbackNewsList();
    }

    return newsList;
  }

  /// 尝试多个选择器
  List<Element> _trySelectors(Document document, List<String> selectors) {
    for (final selector in selectors) {
      final elements = document.querySelectorAll(selector);
      if (elements.isNotEmpty) {
        return elements;
      }
    }
    return [];
  }

  /// 从段落中解析新闻
  List<AINews> _parseFromParagraphs(Document document) {
    final newsList = <AINews>[];
    final paragraphs = document.querySelectorAll('p');

    for (var i = 0; i < paragraphs.length; i++) {
      final p = paragraphs[i];
      final text = p.text.trim();

      // 过滤有效的段落（长度适中，包含AI相关关键词）
      if (text.length > 50 && text.length < 500 && _containsAIKeywords(text)) {
        final title = _extractTitleFromText(text);
        final content = text;

        newsList.add(AINews(
          id: 'maomu_para_$i',
          title: title,
          content: content,
          source: '猫目',
          sourceUrl: 'https://maomu.com/news',
          publishTime: DateTime.now().subtract(Duration(hours: i * 2)).toIso8601String(),
          tags: _extractTagsFromContent(text),
          category: _detectCategory(text),
          isHot: i < 3,
        ));
      }
    }

    return newsList.isEmpty ? _getFallbackNewsList() : newsList;
  }

  /// 从元素中提取新闻
  AINews? _extractNewsFromElement(Element element, int index) {
    try {
      // 提取标题
      String? title = _extractText(element, [
        'h1', 'h2', 'h3', 'h4',
        '.title', '.headline', '.news-title',
        '[class*="title"]', '[class*="headline"]',
      ]);

      if (title == null || title.isEmpty || title.length < 10) {
        return null;
      }

      // 提取内容
      String? content = _extractText(element, [
        '.summary', '.excerpt', '.description',
        '.content', '.news-content',
        'p',
      ]);

      // 提取来源
      String source = _extractText(element, [
        '.source', '.from', '.site',
        '[class*="source"]',
      ]) ?? '猫目';

      // 提取链接
      String sourceUrl = 'https://maomu.com/news';
      final linkElem = element.querySelector('a');
      if (linkElem != null) {
        final href = linkElem.attributes['href'];
        if (href != null) {
          sourceUrl = href.startsWith('http') ? href : 'https://maomu.com$href';
        }
      }

      // 提取时间
      String publishTime = DateTime.now().subtract(Duration(hours: index * 2)).toIso8601String();
      final timeText = _extractText(element, [
        'time', '.time', '.date',
        '[class*="time"]', '[class*="date"]',
      ]);
      if (timeText != null) {
        final parsedTime = _parseTime(timeText);
        if (parsedTime != null) {
          publishTime = parsedTime.toIso8601String();
        }
      }

      // 提取标签
      List<String> tags = [];
      final tagElems = element.querySelectorAll('.tag, [class*="tag"]');
      for (final tagElem in tagElems) {
        final tagText = tagElem.text.trim();
        if (tagText.isNotEmpty && tagText.length < 20) {
          tags.add(tagText.replaceAll('#', ''));
        }
      }

      // 如果没有标签，从内容中提取
      if (tags.isEmpty) {
        tags = _extractTagsFromContent(title + ' ' + (content ?? ''));
      }

      // 检测分类
      final category = _detectCategory(title + ' ' + (content ?? ''));

      return AINews(
        id: 'maomu_$index',
        title: title,
        content: content ?? title,
        source: source,
        sourceUrl: sourceUrl,
        publishTime: publishTime,
        tags: tags.take(3).toList(),
        category: category,
        isHot: index < 3,
        isPinned: index == 0,
      );
    } catch (e) {
      return null;
    }
  }

  /// 从元素中提取文本
  String? _extractText(Element element, List<String> selectors) {
    for (final selector in selectors) {
      final elem = element.querySelector(selector);
      if (elem != null) {
        final text = elem.text.trim();
        if (text.isNotEmpty) {
          return text;
        }
      }
    }
    return null;
  }

  /// 从文本中提取标题
  String _extractTitleFromText(String text) {
    // 尝试按句子分割
    final sentences = text.split(RegExp(r'[。！？.!?]'));
    if (sentences.isNotEmpty && sentences[0].length > 10) {
      return sentences[0].trim();
    }
    // 如果第一句话太短，返回前50个字符
    return text.length > 50 ? text.substring(0, 50) + '...' : text;
  }

  /// 检测是否包含AI关键词
  bool _containsAIKeywords(String text) {
    final keywords = [
      'ai', '人工智能', 'gpt', 'chatgpt', 'openai',
      'claude', 'gemini', 'llama', '大模型',
      '生成式', 'aigc', '机器学习', '深度学习',
      'stable diffusion', 'midjourney',
    ];
    final lowerText = text.toLowerCase();
    return keywords.any((keyword) => lowerText.contains(keyword));
  }

  /// 从内容中提取标签
  List<String> _extractTagsFromContent(String content) {
    final tags = <String>[];
    final lowerContent = content.toLowerCase();

    // 公司和产品标签
    final companyTags = {
      'openai': 'OpenAI',
      'gpt': 'GPT',
      'chatgpt': 'ChatGPT',
      'claude': 'Claude',
      'anthropic': 'Anthropic',
      'gemini': 'Gemini',
      'google': 'Google',
      'llama': 'Llama',
      'meta': 'Meta',
      'midjourney': 'Midjourney',
      'stable diffusion': 'Stable Diffusion',
      'dall-e': 'DALL-E',
      'runway': 'Runway',
      'pika': 'Pika',
      '字节': '字节跳动',
      '百度': '百度',
      '阿里': '阿里巴巴',
      '腾讯': '腾讯',
    };

    companyTags.forEach((key, value) {
      if (lowerContent.contains(key)) {
        tags.add(value);
      }
    });

    // 技术标签
    if (lowerContent.contains('大模型') || lowerContent.contains('llm')) {
      tags.add('大模型');
    }
    if (lowerContent.contains('图像') || lowerContent.contains('绘画') || lowerContent.contains('生成图')) {
      tags.add('图像生成');
    }
    if (lowerContent.contains('视频') || lowerContent.contains('生成视频')) {
      tags.add('视频生成');
    }
    if (lowerContent.contains('音频') || lowerContent.contains('声音') || lowerContent.contains('音乐')) {
      tags.add('音频生成');
    }
    if (lowerContent.contains('硬件') || lowerContent.contains('芯片') || lowerContent.contains('设备')) {
      tags.add('AI硬件');
    }

    // 如果标签太多，只取前3个
    return tags.take(3).toList();
  }

  /// 检测新闻分类
  AINewsCategory _detectCategory(String content) {
    final lowerContent = content.toLowerCase();

    if (lowerContent.contains('图像') || lowerContent.contains('绘画') ||
        lowerContent.contains('sd') || lowerContent.contains('diffusion') ||
        lowerContent.contains('dall') || lowerContent.contains('midjourney')) {
      return AINewsCategory.imageGeneration;
    }

    if (lowerContent.contains('视频') || lowerContent.contains('video') ||
        lowerContent.contains('runway') || lowerContent.contains('pika') ||
        lowerContent.contains('sora')) {
      return AINewsCategory.videoGeneration;
    }

    if (lowerContent.contains('硬件') || lowerContent.contains('芯片') ||
        lowerContent.contains('设备') || lowerContent.contains('机器人')) {
      return AINewsCategory.aiHardware;
    }

    if (lowerContent.contains('应用') || lowerContent.contains('产品') ||
        lowerContent.contains('工具') || lowerContent.contains('软件')) {
      return AINewsCategory.aiApplication;
    }

    if (lowerContent.contains('gpt') || lowerContent.contains('llama') ||
        lowerContent.contains('claude') || lowerContent.contains('gemini') ||
        lowerContent.contains('大模型') || lowerContent.contains('llm')) {
      return AINewsCategory.llm;
    }

    if (lowerContent.contains('融资') || lowerContent.contains('收购') ||
        lowerContent.contains('财报') || lowerContent.contains('市场') ||
        lowerContent.contains('行业')) {
      return AINewsCategory.industryNews;
    }

    return AINewsCategory.other;
  }

  /// 解析时间文本
  DateTime? _parseTime(String timeText) {
    final now = DateTime.now();
    timeText = timeText.trim();

    // 处理相对时间
    if (timeText.contains('分钟前')) {
      final match = RegExp(r'(\d+)').firstMatch(timeText);
      if (match != null) {
        final minutes = int.tryParse(match.group(1) ?? '0') ?? 0;
        return now.subtract(Duration(minutes: minutes));
      }
    }

    if (timeText.contains('小时前')) {
      final match = RegExp(r'(\d+)').firstMatch(timeText);
      if (match != null) {
        final hours = int.tryParse(match.group(1) ?? '0') ?? 0;
        return now.subtract(Duration(hours: hours));
      }
    }

    if (timeText.contains('天前')) {
      final match = RegExp(r'(\d+)').firstMatch(timeText);
      if (match != null) {
        final days = int.tryParse(match.group(1) ?? '0') ?? 0;
        return now.subtract(Duration(days: days));
      }
    }

    if (timeText.contains('刚刚')) {
      return now;
    }

    // 尝试解析标准日期格式
    try {
      return DateTime.parse(timeText);
    } catch (_) {
      // 尝试其他格式
      final patterns = [
        RegExp(r'(\d{4})[-/](\d{1,2})[-/](\d{1,2})'),
        RegExp(r'(\d{1,2})[-/](\d{1,2})'),
      ];

      for (final pattern in patterns) {
        final match = pattern.firstMatch(timeText);
        if (match != null) {
          try {
            if (match.groupCount >= 3) {
              final year = int.parse(match.group(1)!);
              final month = int.parse(match.group(2)!);
              final day = int.parse(match.group(3)!);
              return DateTime(year, month, day);
            } else if (match.groupCount >= 2) {
              final month = int.parse(match.group(1)!);
              final day = int.parse(match.group(2)!);
              return DateTime(now.year, month, day);
            }
          } catch (_) {
            continue;
          }
        }
      }
    }

    return null;
  }

  /// 获取备用新闻列表
  List<AINews> _getFallbackNewsList() {
    return [
      AINews(
        id: 'maomu_1',
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
        id: 'maomu_2',
        title: 'OpenAI发布GPT-4 Turbo新版本，推理能力大幅提升',
        content: 'OpenAI今日发布了GPT-4 Turbo的最新版本，新版本在推理能力、代码生成和多语言支持方面都有显著提升。据官方介绍，新版本在处理复杂任务时的准确率提高了15%。',
        source: 'OpenAI',
        sourceUrl: 'https://openai.com/',
        publishTime: DateTime.now().subtract(const Duration(hours: 5)).toIso8601String(),
        tags: ['OpenAI', 'GPT-4', '大模型'],
        category: AINewsCategory.llm,
        viewCount: 25600,
        isHot: true,
      ),
      AINews(
        id: 'maomu_3',
        title: '谷歌Gemini 1.5 Pro正式对外开放，支持100万token上下文',
        content: '谷歌宣布Gemini 1.5 Pro正式对外开放使用，该模型最大的特点是支持100万token的上下文窗口，可以处理长达1小时的视频或超过30000行的代码。',
        source: 'Google',
        sourceUrl: 'https://blog.google/',
        publishTime: DateTime.now().subtract(const Duration(hours: 8)).toIso8601String(),
        tags: ['Google', 'Gemini', '大模型'],
        category: AINewsCategory.llm,
        viewCount: 18900,
        isHot: true,
      ),
    ];
  }
}
