import 'dart:math' as math;

import '../../presentation/providers/home_provider.dart';
import '../network/discourse_api_service.dart';

/// 推荐引擎
///
/// 实现混合多数据源的推荐算法，通过加权评分生成个性化推荐流
/// 针对社区冷启动阶段优化：降低互动数据权重，增加新内容和时间权重
/// 增加随机性：每次刷新展示不同的内容组合
class RecommendationEngine {
  final DiscourseApiService _apiService;
  final math.Random _random;

  /// 推荐分数权重配置
  /// 针对低互动社区优化：
  /// - 降低 view/like/reply 权重（数据少，参考价值低）
  /// - 增加新内容基础分（鼓励新帖曝光）
  /// - 缩短时间衰减周期（让新内容更快被看到）
  /// - 重点推荐7天内内容
  static const Map<String, double> _weights = {
    'viewCount': 0.0008, // 浏览数权重
    'likeCount': 0.35, // 点赞数权重
    'replyCount': 0.28, // 回复数权重
    'newContentBase': 45.0, // 新内容基础分
    'pinned': 2.4, // 置顶内容加权
    'timeDecay': 30.0, // 时间衰减因子
    'maxTimeBoost': 60.0, // 最大时间加成（2.5天）
    'maxAgeHours': 168.0, // 最大内容年龄（7天 = 168小时）
    'sourceConsensusBoost': 0.08, // 多来源共同出现加权
    'imageBoost': 1.08, // 带图内容加权
    'tagBoost': 1.05, // 带标签内容加权
  };

  /// 分类多样性配置
  /// 每个分类在推荐中的最大占比，确保内容多样性
  static const Map<int, double> _categoryMaxRatio = {
    7: 0.28, // Help
    8: 0.22, // Suggestions
    9: 0.22, // Tips
    10: 0.28, // Showcase
    11: 0.28, // Discussion
    29: 0.22, // 福利活动
    35: 0.28, // SOLO 挑战赛专区
  };

  static const Map<String, double> _sourceBoost = {
    'hot': 1.08,
    'top': 1.06,
    'latest': 1.03,
    'new': 1.10,
    'cat_help': 1.04,
    'cat_suggestions': 1.03,
    'cat_tips': 1.03,
    'cat_showcase': 1.06,
    'cat_discussion': 1.03,
    'cat_welfare': 1.02,
    'cat_events': 1.03,
  };

  /// 构造函数
  ///
  /// [apiService] Discourse API 服务实例
  RecommendationEngine(this._apiService) : _random = math.Random();

  /// 获取推荐内容
  ///
  /// [page] 页码，从1开始
  /// [pageSize] 每页返回数量
  /// [randomize] 是否启用随机排序（默认true，每次刷新内容不同）
  /// @return 按推荐分数排序或随机排序的 FeedItem 列表
  ///
  /// 优化策略：
  /// 1. 重点推荐7天以内的新内容
  /// 2. 确保内容多样性（不同分类都有曝光机会）
  /// 3. 限制每个分类的最大占比
  /// 4. 增加随机性：每次刷新展示不同的内容组合
  Future<List<FeedItem>> getRecommendedFeeds({
    int page = 1,
    int pageSize = 20,
    bool randomize = true,
    Set<String>? avoidIds,
  }) async {
    final discoursePage = page > 0 ? page - 1 : 0;
    final sources = <String, Future<dynamic>>{
      'hot': _safeFetch(() => _apiService.getHotTopics(page: discoursePage)),
      'top': _safeFetch(() => _apiService.getTopTopics(page: discoursePage)),
      'latest': _safeFetch(
        () => _apiService.getLatestTopics(page: discoursePage),
      ),
      'new': _safeFetch(() => _apiService.getNewTopics(page: discoursePage)),
      'cat_help': _safeFetch(
        () => _apiService.getTopicsByCategory(7, page: discoursePage),
      ),
      'cat_suggestions': _safeFetch(
        () => _apiService.getTopicsByCategory(8, page: discoursePage),
      ),
      'cat_tips': _safeFetch(
        () => _apiService.getTopicsByCategory(9, page: discoursePage),
      ),
      'cat_showcase': _safeFetch(
        () => _apiService.getTopicsByCategory(10, page: discoursePage),
      ),
      'cat_discussion': _safeFetch(
        () => _apiService.getTopicsByCategory(11, page: discoursePage),
      ),
      'cat_welfare': _safeFetch(
        () => _apiService.getTopicsByCategory(29, page: discoursePage),
      ),
      'cat_events': _safeFetch(
        () => _apiService.getTopicsByCategory(35, page: discoursePage),
      ),
    };

    final sourceNames = sources.keys.toList();
    final responses = await Future.wait(sources.values);

    final merged = <String, _CandidateInfo>{};
    final now = DateTime.now();
    final maxAge = Duration(hours: _weights['maxAgeHours']!.toInt());

    for (int sourceIndex = 0; sourceIndex < responses.length; sourceIndex++) {
      final response = responses[sourceIndex];
      if (response == null) continue;
      final source = sourceNames[sourceIndex];
      final items = _parseResponse(response as dynamic);
      for (final item in items) {
        // 推荐流显式排除官方分类，官方内容走独立 tab。
        if (item.categoryId == _getOfficialCategoryId()) continue;

        // 检查内容是否在7天以内（置顶内容除外）
        final createTime = int.tryParse(item.createTime) ?? 0;
        final itemDate = DateTime.fromMillisecondsSinceEpoch(createTime * 1000);
        final age = now.difference(itemDate);
        if (!item.isPinned && age > maxAge) continue;

        final baseScore = _calculateScore(item) * (_sourceBoost[source] ?? 1.0);
        final candidate = merged[item.id];
        if (candidate == null) {
          merged[item.id] = _CandidateInfo(
            item: item,
            score: baseScore,
            sources: {source},
          );
          continue;
        }

        if (baseScore > candidate.score) {
          candidate.score = baseScore;
          candidate.item = item;
        }
        candidate.sources.add(source);
      }
    }

    // 转换为列表并应用最终分数（包含一致性加权与轻随机扰动）
    final allItems = merged.values.map((candidate) {
      final sourceBoost =
          1 +
          (candidate.sources.length - 1) * _weights['sourceConsensusBoost']!;
      var score = candidate.score * sourceBoost;

      if (candidate.item.images.isNotEmpty) {
        score *= _weights['imageBoost']!;
      }
      if (candidate.item.tags.isNotEmpty) {
        score *= _weights['tagBoost']!;
      }

      // 随机扰动只做轻微探索，不再直接打散高分内容。
      if (randomize) {
        final jitter = 0.94 + _random.nextDouble() * 0.12;
        score *= jitter;
      }

      return ScoredFeedItem(item: candidate.item, score: score);
    }).toList();

    // 分离置顶内容和普通内容
    final pinnedItems = allItems.where((s) => s.item.isPinned).toList();
    final normalItems = allItems.where((s) => !s.item.isPinned).toList();
    final avoidSet = avoidIds ?? const <String>{};

    // 统一按分数排序，保证高质量内容稳定靠前。
    pinnedItems.sort((a, b) => b.score.compareTo(a.score));
    normalItems.sort((a, b) => b.score.compareTo(a.score));

    // 组合结果：先少量置顶，再普通内容（分类+作者多样性约束）
    final result = <FeedItem>[];
    final addedIds = <String>{};
    final categoryCount = <int, int>{};
    final authorCount = <String, int>{};

    for (final item in pinnedItems.take(2)) {
      _appendIfAllowed(
        result: result,
        addedIds: addedIds,
        categoryCount: categoryCount,
        authorCount: authorCount,
        pageSize: pageSize,
        feed: item.item,
        bypassCategoryLimit: true,
      );
    }

    // 刷新时优先注入“上次未出现过”的内容，保证每次刷新都有新鲜感。
    final preferredItems = normalItems
        .where((e) => !avoidSet.contains(e.item.id))
        .toList();
    final fallbackItems = normalItems
        .where((e) => avoidSet.contains(e.item.id))
        .toList();
    final minFreshTarget = math.max(1, (pageSize * 0.35).round());
    var freshAdded = 0;

    for (final item in preferredItems) {
      if (result.length >= pageSize) break;
      final beforeLen = result.length;
      _appendIfAllowed(
        result: result,
        addedIds: addedIds,
        categoryCount: categoryCount,
        authorCount: authorCount,
        pageSize: pageSize,
        feed: item.item,
      );
      if (result.length > beforeLen) {
        freshAdded++;
      }
      if (freshAdded >= minFreshTarget) {
        break;
      }
    }

    for (final item in preferredItems) {
      if (result.length >= pageSize) break;
      _appendIfAllowed(
        result: result,
        addedIds: addedIds,
        categoryCount: categoryCount,
        authorCount: authorCount,
        pageSize: pageSize,
        feed: item.item,
      );
    }

    for (final item in fallbackItems) {
      if (result.length >= pageSize) break;
      _appendIfAllowed(
        result: result,
        addedIds: addedIds,
        categoryCount: categoryCount,
        authorCount: authorCount,
        pageSize: pageSize,
        feed: item.item,
      );
    }

    // 第二轮放宽限制，补齐页容量。
    if (result.length < pageSize) {
      for (final item in [...preferredItems, ...fallbackItems]) {
        if (result.length >= pageSize) break;
        if (!addedIds.contains(item.item.id)) {
          result.add(item.item);
          addedIds.add(item.item.id);
        }
      }
    }

    return result.take(pageSize).toList();
  }

  Future<dynamic> _safeFetch(Future<dynamic> Function() request) async {
    try {
      return await request();
    } catch (_) {
      return null;
    }
  }

  /// 解析 API 响应
  ///
  /// [response] Dio Response 对象
  /// @return FeedItem 列表
  List<FeedItem> _parseResponse(dynamic response) {
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

  /// 将 Topic 转换为 FeedItem
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
      category: _getCategoryLabel(categoryId),
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
      tags: (topic['tags'] as List<dynamic>? ?? const [])
          .map((e) => e.toString().toLowerCase())
          .toList(),
      isPinned: topic['pinned'] == true,
      topComment: null,
    );
  }

  /// 计算推荐分数
  ///
  /// [item] FeedItem 对象
  /// @return 推荐分数
  ///
  /// 针对低互动社区优化策略：
  /// 1. 新内容给予基础分，确保有曝光机会
  /// 2. 时间衰减更平缓，24小时内内容保持较高分数
  /// 3. 互动数据作为额外加成而非主要排序依据
  /// 4. 官方和置顶内容获得更高加权
  double _calculateScore(FeedItem item) {
    // 新内容基础分（确保新帖有机会被看到）
    double score = _weights['newContentBase']!;

    // 互动数据加成（在低互动社区中权重较低）
    final engagementScore =
        item.viewCount * _weights['viewCount']! +
        item.likeCount * _weights['likeCount']! +
        item.replyCount * _weights['replyCount']!;
    score += engagementScore;

    // 时间因子计算
    final createTime = int.tryParse(item.createTime) ?? 0;
    if (createTime > 0) {
      final ageInHours = DateTime.now()
          .difference(DateTime.fromMillisecondsSinceEpoch(createTime * 1000))
          .inHours;

      if (ageInHours <= _weights['maxTimeBoost']!) {
        // 72小时内的新内容：时间越新分数越高
        // 使用反比例函数：score *= (1 + (72 - age) / 72)
        final timeBoost =
            1.0 +
            (_weights['maxTimeBoost']! - ageInHours) /
                _weights['maxTimeBoost']!;
        score *= timeBoost;
      } else {
        // 超过72小时：应用指数衰减
        score *= math.exp(
          -(ageInHours - _weights['maxTimeBoost']!) / _weights['timeDecay']!,
        );
      }
    }

    // 置顶内容加权
    if (item.isPinned) {
      score *= _weights['pinned']!;
    }

    return score;
  }

  /// 获取官方分类ID
  int _getOfficialCategoryId() => 4;

  /// 获取分类标签
  String _getCategoryLabel(int categoryId) {
    const labels = {
      4: '官方',
      7: '帮助与支持',
      8: '产品建议',
      9: '基础技巧',
      10: '作品展示',
      11: '互动交流',
      29: '福利活动',
      35: 'SOLO挑战赛专区',
    };
    return labels[categoryId] ?? 'Category $categoryId';
  }

  void _appendIfAllowed({
    required List<FeedItem> result,
    required Set<String> addedIds,
    required Map<int, int> categoryCount,
    required Map<String, int> authorCount,
    required int pageSize,
    required FeedItem feed,
    bool bypassCategoryLimit = false,
  }) {
    if (addedIds.contains(feed.id)) return;

    final categoryId = feed.categoryId;
    final categoryCurrent = categoryCount[categoryId] ?? 0;
    final categoryLimit = _categoryLimit(categoryId, pageSize);

    if (!bypassCategoryLimit && categoryCurrent >= categoryLimit) return;

    final authorKey = feed.username.trim().toLowerCase();
    if (authorKey.isNotEmpty) {
      final authorCurrent = authorCount[authorKey] ?? 0;
      if (authorCurrent >= 2) return;
      authorCount[authorKey] = authorCurrent + 1;
    }

    result.add(feed);
    addedIds.add(feed.id);
    categoryCount[categoryId] = categoryCurrent + 1;
  }

  int _categoryLimit(int categoryId, int pageSize) {
    final ratio = _categoryMaxRatio[categoryId] ?? 0.3;
    return (pageSize * ratio).ceil().clamp(2, math.max(2, pageSize - 2));
  }

  /// 格式化头像URL
  String _formatAvatarUrl(String avatarTemplate, String username) {
    if (avatarTemplate.isNotEmpty) {
      var url = avatarTemplate.replaceAll('{size}', '120');
      if (url.startsWith('//')) {
        return 'https:$url';
      }
      if (url.startsWith('/')) {
        return 'https://forum.trae.cn$url';
      }
      return url;
    }

    if (username.isEmpty) {
      return '';
    }

    return 'https://forum.trae.cn/user_avatar/forum.trae.cn/$username/120/0_2.png';
  }

  /// 转换为Unix时间戳
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

  /// 解析整数
  int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }

  /// 规范化摘要文本
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
}

/// 带分数的 FeedItem
class ScoredFeedItem {
  final FeedItem item;
  final double score;

  ScoredFeedItem({required this.item, required this.score});
}

class _CandidateInfo {
  FeedItem item;
  double score;
  final Set<String> sources;

  _CandidateInfo({
    required this.item,
    required this.score,
    required this.sources,
  });
}
