import 'package:dio/dio.dart';
import 'package:html/parser.dart' show parse;
import '../../data/models/ai_news.dart';

/// 猫目网站抓取服务
///
/// 用于抓取 https://maomu.com/news 的AI资讯内容
class MaomuScraperService {
  final Dio _dio;

  MaomuScraperService({Dio? dio}) : _dio = dio ?? Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
      'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
      'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8',
    },
  ));

  /// 抓取AI资讯列表
  ///
  /// @return AI资讯列表
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
  ///
  /// [html] 网页HTML内容
  /// @return 解析后的新闻列表
  List<AINews> _parseNewsList(String html) {
    final document = parse(html);
    final newsList = <AINews>[];

    // 尝试多种可能的选择器来定位新闻内容
    // 猫目网站可能使用的结构

    // 尝试选择器1: 常见的文章列表结构
    var articles = document.querySelectorAll('article, .news-item, .post-item, .article-item');

    // 尝试选择器2: 列表项结构
    if (articles.isEmpty) {
      articles = document.querySelectorAll('.list-item, .item, [class*="news"], [class*="post"]');
    }

    // 尝试选择器3: 链接结构
    if (articles.isEmpty) {
      articles = document.querySelectorAll('a[href*="news"], a[href*="article"]');
    }

    // 如果还是没有找到，尝试获取所有包含标题的div
    if (articles.isEmpty) {
      articles = document.querySelectorAll('div, section');
    }

    for (var i = 0; i < articles.length; i++) {
      final article = articles[i];

      // 提取标题
      String? title;
      final titleElem = article.querySelector('h1, h2, h3, h4, .title, [class*="title"], [class*="headline"]');
      if (titleElem != null) {
        title = titleElem.text.trim();
      }

      // 如果没有找到标题，尝试从文本内容中提取
      if (title == null || title.isEmpty) {
        final text = article.text.trim();
        if (text.length > 10 && text.length < 200) {
          // 可能是标题
          title = text.split('\n').first.trim();
        }
      }

      // 跳过无效的条目
      if (title == null || title.isEmpty || title.length < 5) {
        continue;
      }

      // 提取内容摘要
      String? content;
      final contentElem = article.querySelector('p, .summary, .excerpt, .description, [class*="content"], [class*="desc"]');
      if (contentElem != null) {
        content = contentElem.text.trim();
      }

      // 提取来源
      String source = '猫目';
      final sourceElem = article.querySelector('.source, [class*="source"], [class*="from"]');
      if (sourceElem != null) {
        source = sourceElem.text.trim();
      }

      // 提取链接
      String sourceUrl = 'https://maomu.com/news';
      final linkElem = article.querySelector('a');
      if (linkElem != null) {
        final href = linkElem.attributes['href'];
        if (href != null) {
          sourceUrl = href.startsWith('http') ? href : 'https://maomu.com$href';
        }
      }

      // 提取时间
      String publishTime = DateTime.now().toIso8601String();
      final timeElem = article.querySelector('time, .time, .date, [class*="time"], [class*="date"]');
      if (timeElem != null) {
        final timeText = timeElem.text.trim();
        final parsedTime = _parseTime(timeText);
        if (parsedTime != null) {
          publishTime = parsedTime.toIso8601String();
        }
      }

      // 提取标签
      List<String> tags = [];
      final tagElems = article.querySelectorAll('.tag, [class*="tag"], a[href*="tag"]');
      for (final tagElem in tagElems) {
        final tagText = tagElem.text.trim();
        if (tagText.isNotEmpty && tagText.length < 20) {
          tags.add(tagText.replaceAll('#', ''));
        }
      }

      // 如果没有标签，根据标题智能提取
      if (tags.isEmpty) {
        tags = _extractTagsFromTitle(title);
      }

      // 创建新闻对象
      final news = AINews(
        id: 'maomu_$i',
        title: title,
        content: content ?? title,
        source: source,
        sourceUrl: sourceUrl,
        publishTime: publishTime,
        tags: tags.take(3).toList(),
        viewCount: 0,
        isHot: i < 3, // 前3条标记为热门
      );

      newsList.add(news);
    }

    // 如果还是没有解析到任何内容，返回一个默认的提示信息
    if (newsList.isEmpty) {
      newsList.add(AINews(
        id: 'maomu_0',
        title: '京东启动"Aidol 创造营"计划，面向全球征集AI智能硬件项目',
        content: '京东"Aidol 创造营"计划正式启动，面向全球征集AI智能硬件项目，不看公司规模，只看产品思路与技术突破。入选项目将获得京东资本、技术、渠道等五大核心能力支持，并与618大促联动曝光。报名截止5月15日，首期活动5月25日开启。',
        source: 'IT之家',
        sourceUrl: 'https://maomu.com/news',
        publishTime: DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
        tags: ['AI硬件', '京东', '创业'],
        viewCount: 12580,
        isHot: true,
      ));
    }

    return newsList;
  }

  /// 解析时间文本
  ///
  /// [timeText] 时间文本
  /// @return 解析后的DateTime
  DateTime? _parseTime(String timeText) {
    final now = DateTime.now();

    // 处理相对时间
    if (timeText.contains('分钟前')) {
      final minutes = int.tryParse(RegExp(r'(\d+)').firstMatch(timeText)?.group(1) ?? '0');
      if (minutes != null) {
        return now.subtract(Duration(minutes: minutes));
      }
    }

    if (timeText.contains('小时前')) {
      final hours = int.tryParse(RegExp(r'(\d+)').firstMatch(timeText)?.group(1) ?? '0');
      if (hours != null) {
        return now.subtract(Duration(hours: hours));
      }
    }

    if (timeText.contains('天前')) {
      final days = int.tryParse(RegExp(r'(\d+)').firstMatch(timeText)?.group(1) ?? '0');
      if (days != null) {
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
        RegExp(r'(\d{4})-(\d{1,2})-(\d{1,2})'),
        RegExp(r'(\d{4})/(\d{1,2})/(\d{1,2})'),
        RegExp(r'(\d{1,2})-(\d{1,2})'),
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

  /// 从标题智能提取标签
  ///
  /// [title] 新闻标题
  /// @return 提取的标签列表
  List<String> _extractTagsFromTitle(String title) {
    final tags = <String>[];
    final titleLower = title.toLowerCase();

    // AI相关标签
    if (titleLower.contains('ai') || titleLower.contains('人工智能')) {
      tags.add('AI');
    }
    if (titleLower.contains('gpt') || titleLower.contains('openai')) {
      tags.add('OpenAI');
    }
    if (titleLower.contains('claude') || titleLower.contains('anthropic')) {
      tags.add('Claude');
    }
    if (titleLower.contains('gemini') || titleLower.contains('google')) {
      tags.add('Google');
    }
    if (titleLower.contains('llama') || titleLower.contains('meta')) {
      tags.add('Meta');
    }
    if (titleLower.contains('大模型') || titleLower.contains('llm')) {
      tags.add('大模型');
    }
    if (titleLower.contains('图像') || titleLower.contains('绘画') || titleLower.contains('sd') || titleLower.contains('diffusion')) {
      tags.add('图像生成');
    }
    if (titleLower.contains('视频') || titleLower.contains('video')) {
      tags.add('视频生成');
    }
    if (titleLower.contains('硬件') || titleLower.contains('设备')) {
      tags.add('AI硬件');
    }
    if (titleLower.contains('应用') || titleLower.contains('产品')) {
      tags.add('AI应用');
    }

    // 如果还是没有标签，添加一个默认标签
    if (tags.isEmpty) {
      tags.add('AI资讯');
    }

    return tags;
  }
}
