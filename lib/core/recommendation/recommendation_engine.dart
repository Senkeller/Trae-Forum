import 'dart:math' as math;

import '../../presentation/providers/home_provider.dart';
import '../network/discourse_api_service.dart';

/// 推荐引擎
///
/// 实现混合多数据源的推荐算法，通过加权评分生成个性化推荐流
class RecommendationEngine {
  final DiscourseApiService _apiService;

  /// 推荐分数权重配置
  static const Map<String, double> _weights = {
    'viewCount': 0.001, // 浏览数权重
    'likeCount': 0.5, // 点赞数权重
    'replyCount': 0.3, // 回复数权重
    'official': 1.5, // 官方内容加权
    'pinned': 2.0, // 置顶内容加权
    'timeDecay': 48.0, // 时间衰减因子（小时）
  };

  /// 构造函数
  ///
  /// [apiService] Discourse API 服务实例
  RecommendationEngine(this._apiService);

  /// 获取推荐内容
  ///
  /// [page] 页码，从1开始
  /// [pageSize] 每页返回数量
  /// @return 按推荐分数排序的 FeedItem 列表
  Future<List<FeedItem>> getRecommendedFeeds({
    int page = 1,
    int pageSize = 20,
  }) async {
    // 并行获取多个数据源
    final responses = await Future.wait([
      _apiService.getHotTopics(page: page),
      _apiService.getTopTopics(page: page),
      _apiService.getLatestTopics(page: page),
      _apiService.getTopicsByCategory(
        _getOfficialCategoryId(),
        page: page,
      ),
    ]);

    // 合并并去重
    final merged = <String, ScoredFeedItem>{};

    for (final response in responses) {
      final items = _parseResponse(response);
      for (final item in items) {
        if (!merged.containsKey(item.id)) {
          final score = _calculateScore(item);
          merged[item.id] = ScoredFeedItem(item: item, score: score);
        }
      }
    }

    // 转换为列表并按分数排序
    final scoredList = merged.values.toList();
    scoredList.sort((a, b) => b.score.compareTo(a.score));

    // 返回指定数量的推荐内容
    return scoredList.take(pageSize).map((e) => e.item).toList();
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
  double _calculateScore(FeedItem item) {
    double score = 0;

    // 热门度权重
    score += item.viewCount * _weights['viewCount']!;
    score += item.likeCount * _weights['likeCount']!;
    score += item.replyCount * _weights['replyCount']!;

    // 时间衰减因子（新内容加分）
    final createTime = int.tryParse(item.createTime) ?? 0;
    if (createTime > 0) {
      final age = DateTime.now()
          .difference(DateTime.fromMillisecondsSinceEpoch(createTime * 1000))
          .inHours;
      score *= math.exp(-age / _weights['timeDecay']!);
    }

    // 官方内容加权
    if (item.categoryId == _getOfficialCategoryId()) {
      score *= _weights['official']!;
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
        .replaceAll(RegExp(r'<[^