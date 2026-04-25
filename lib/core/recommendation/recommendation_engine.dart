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
    'viewCount': 0.0005, // 浏览数权重（降低）
    'likeCount': 0.2, // 点赞数权重（降低）
    'replyCount': 0.15, // 回复数权重（降低）
    'newContentBase': 50.0, // 新内容基础分（新增）
    'official': 2.0, // 官方内容加权（提高）
    'pinned': 3.0, // 置顶内容加权（提高）
    'timeDecay': 24.0, // 时间衰减因子（缩短为24小时）
    'maxTimeBoost': 72.0, // 最大时间加成（3天内新内容有加成）
    'maxAgeHours': 168.0, // 最大内容年龄（7天 = 168小时）
  };

  /// 分类多样性配置
  /// 每个分类在推荐中的最大占比，确保内容多样性
  static const Map<int, double> _categoryMaxRatio = {
    7: 0.25, // Help: 最多25%
    10: 0.25, // Showcase: 最多25%
    11: 0.25, // Discussion: 最多25%
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
  }) async {
    // 并行获取多个数据源
    // 针对冷启动社区：获取更多分类的内容，确保多样性
    // 注意：推荐内容不包含官方公告（有专门的"官方"Tab）
    final responses = await Future.wait([
      _apiService.getHotTopics(page: page),
      _apiService.getTopTopics(page: page),
      _apiService.getLatestTopics(page: page),
      _apiService.getNewTopics(page: page), // 新增：最新创建
      // 不包含官方公告分类 (ID: 4)
      _apiService.getTopicsByCategory(7, page: page), // Help
      _apiService.getTopicsByCategory(10, page: page), // Showcase
      _apiService.getTopicsByCategory(11, page: page), // Discussion
    ]);

    // 合并所有内容，并过滤7天以内的内容
    final merged = <String, ScoredFeedItem>{};
    final now = DateTime.now();
    final maxAge = Duration(hours: _weights['maxAgeHours']!.toInt());

    for (final response in responses) {
      final items = _parseResponse(response);
      for (final item in items) {
        if (!merged.containsKey(item.id)) {
          // 检查内容是否在7天以内（置顶内容除外）
          final createTime = int.tryParse(item.createTime) ?? 0;
          final itemDate = DateTime.fromMillisecondsSinceEpoch(createTime * 1000);
          final age = now.difference(itemDate);
          
          // 只保留7天以内的内容，或者置顶内容
          if (item.isPinned || age <= maxAge) {
            // 计算基础分数
            final baseScore = _calculateScore(item);
            // 添加随机因子（±20%的随机波动）
            final randomFactor = randomize ? 0.8 + _random.nextDouble() * 0.4 : 1.0;
            final finalScore = baseScore * randomFactor;

            final scoredItem = ScoredFeedItem(item: item, score: finalScore);
            merged[item.id] = scoredItem;
          }
        }
      }
    }

    // 转换为列表
    final allItems = merged.values.toList();

    // 分离置顶内容和非置顶内容
    // 置顶内容：isPinned=true 且 非官方分类
    final pinnedItems = allItems
        .where((s) => s.item.isPinned && s.item.categoryId != _getOfficialCategoryId())
        .toList();
    // 普通内容：非置顶内容（无论是否官方分类）
    // 注意：官方分类的内容已经在数据源层面被过滤，这里只需要过滤掉置顶内容
    final normalItems = allItems
        .where((s) => !s.item.isPinned)
        .toList();

    // 置顶内容按分数排序（保持置顶内容在前）
    pinnedItems.sort((a, b) => b.score.compareTo(a.score));

    // 普通内容根据randomize参数决定排序方式
    if (randomize) {
      // 随机打乱顺序
      normalItems.shuffle(_random);
    } else {
      // 按分数排序
      normalItems.sort((a, b) => b.score.compareTo(a.score));
    }

    // 组合结果：先置顶，再普通内容（带分类多样性控制）
    final result = <FeedItem>[];
    final addedIds = <String>{};
    final categoryCount = <int, int>{}; // 记录每个分类已添加的数量

    // 添加置顶内容（最多3条）
    for (final item in pinnedItems.take(3)) {
      result.add(item.item);
      addedIds.add(item.item.id);
    }

    // 添加普通内容（带分类多样性控制）
    for (final item in normalItems) {
      if (result.length >= pageSize) break;
      if (!addedIds.contains(item.item.id)) {
        final categoryId = item.item.categoryId;
        final currentCount = categoryCount[categoryId] ?? 0;
        final maxCount = (pageSize * (_categoryMaxRatio[categoryId] ?? 0.3)).ceil();
        
        // 检查是否超过该分类的最大数量限制
        if (currentCount < maxCount) {
          result.add(item.item);
          addedIds.add(item.item.id);
          categoryCount[categoryId] = currentCount + 1;
        }
      }
    }

    // 如果还不够，补充剩余内容（不限制分类）
    if (result.length < pageSize) {
      for (final item in normalItems) {
        if (result.length >= pageSize) break;
        if (!addedIds.contains(item.item.id)) {
          result.add(item.item);
          addedIds.add(item.item.id);
        }
      }
    }

    return result.take(pageSize).toList();
  }

  /// 解析 API 响应
  ///
  /// [response] Dio Response 对象
  /// @return FeedItem 列表
  List<FeedItem> _parseResponse(dynamic response) {
    final raw = response.data;
    final data =
        raw is Map<String, dynamic> ? raw : Map<String, dynamic>.from(raw as Map);

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

    return topics.map((topic) => _adaptTopicToFeedItem(topic, userMap)).toList();
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

    final firstPosterUserId =
        posterList.isNotEmpty ? _parseInt(posterList.first['user_id']) : 0;
    final author = userMap[firstPosterUserId] ?? const <String, dynamic>{};

    final username =
        (author['username'] ?? topic['last_poster_username'] ?? '').toString();
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
      createTime: _toUnixTimestamp(topic['last_posted_at'] ?? topic['created_at']),
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
    final engagementScore = item.viewCount * _weights['viewCount']! +
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
        final timeBoost = 1.0 + (_weights['maxTimeBoost']! - ageInHours) / _weights['maxTimeBoost']!;
        score *= timeBoost;
      } else {
        // 超过72小时：应用指数衰减
        score *= math.exp(-(ageInHours - _weights['maxTimeBoost']!) / _weights['timeDecay']!);
      }
    }

    // 官方内容加权（在推荐Tab中不使用，因为推荐内容已排除官方公告）
    // 注意：官方公告有专门的Tab展示，推荐Tab专注于社区内容
    // if (item.categoryId == _getOfficialCategoryId()) {
    //   score *= _weights['official']!;
    // }

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
      4: 'Official',
      7: 'Help',
      8: 'Suggestions',
      9: 'Tips',
      10: 'Showcase',
      11: 'Discussion',
      29: 'Events',
      35: 'Events',
    };
    return labels[categoryId] ?? 'Category $categoryId';
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

  ScoredFeedItem({
    required this.item,
    required this.score,
  });
}
