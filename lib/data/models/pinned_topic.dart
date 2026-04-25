/// 置顶话题数据模型
///
/// 用于展示在首页Banner区域的社区置顶贴
class PinnedTopic {
  /// 话题ID
  final int id;

  /// 话题标题
  final String title;

  /// 作者用户名
  final String username;

  /// 作者头像URL
  final String avatarUrl;

  /// 分类名称
  final String categoryName;

  /// 分类颜色
  final String? categoryColor;

  /// 是否置顶
  final bool pinned;

  /// 置顶级别
  final int? pinnedGlobally;

  /// 浏览数
  final int views;

  /// 回复数
  final int replyCount;

  /// 创建时间
  final String createdAt;

  /// 话题图片
  final String? imageUrl;

  /// 标签列表
  final List<String> tags;

  const PinnedTopic({
    required this.id,
    required this.title,
    required this.username,
    required this.avatarUrl,
    required this.categoryName,
    this.categoryColor,
    this.pinned = false,
    this.pinnedGlobally,
    this.views = 0,
    this.replyCount = 0,
    required this.createdAt,
    this.imageUrl,
    this.tags = const [],
  });

  /// 从JSON创建
  factory PinnedTopic.fromJson(Map<String, dynamic> json) {
    return PinnedTopic(
      id: _parseInt(json['id']),
      title: json['title']?.toString() ?? '',
      username: json['last_poster_username']?.toString() ??
          json['username']?.toString() ??
          '',
      avatarUrl: '',
      categoryName: '',
      categoryColor: json['category_color']?.toString(),
      pinned: json['pinned'] == true || json['pinned_globally'] == true,
      pinnedGlobally: json['pinned_globally'] == true ? 1 : null,
      views: _parseInt(json['views']),
      replyCount: _parseInt(json['reply_count']),
      createdAt: json['created_at']?.toString() ?? '',
      imageUrl: json['image_url']?.toString(),
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }

  /// 从话题数据创建（包含用户信息）
  factory PinnedTopic.fromTopicData(
    Map<String, dynamic> topic,
    Map<int, Map<String, dynamic>> userMap,
    Map<int, Map<String, dynamic>> categoryMap,
  ) {
    final posterList = (topic['posters'] as List<dynamic>? ?? const [])
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();

    final firstPosterUserId =
        posterList.isNotEmpty ? _parseInt(posterList.first['user_id']) : 0;
    final author = userMap[firstPosterUserId] ?? const <String, dynamic>{};

    final categoryId = _parseInt(topic['category_id']);
    final category = categoryMap[categoryId];

    final username =
        (author['username'] ?? topic['last_poster_username'] ?? '').toString();

    return PinnedTopic(
      id: _parseInt(topic['id']),
      title: topic['title']?.toString() ?? '',
      username: username.isNotEmpty ? username : 'unknown',
      avatarUrl: _formatAvatarUrl(
        (author['avatar_template'] ?? '').toString(),
        username,
      ),
      categoryName: category?['name']?.toString() ?? '',
      categoryColor: category?['color']?.toString(),
      pinned: topic['pinned'] == true || topic['pinned_globally'] == true,
      pinnedGlobally:
          topic['pinned_globally'] == true ? 1 : _parseInt(topic['pinned']),
      views: _parseInt(topic['views']),
      replyCount: _parseInt(topic['reply_count']),
      createdAt: topic['created_at']?.toString() ?? '',
      imageUrl: topic['image_url']?.toString(),
      tags: (topic['tags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }

  PinnedTopic copyWith({
    int? id,
    String? title,
    String? username,
    String? avatarUrl,
    String? categoryName,
    String? categoryColor,
    bool? pinned,
    int? pinnedGlobally,
    int? views,
    int? replyCount,
    String? createdAt,
    String? imageUrl,
    List<String>? tags,
  }) {
    return PinnedTopic(
      id: id ?? this.id,
      title: title ?? this.title,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      categoryName: categoryName ?? this.categoryName,
      categoryColor: categoryColor ?? this.categoryColor,
      pinned: pinned ?? this.pinned,
      pinnedGlobally: pinnedGlobally ?? this.pinnedGlobally,
      views: views ?? this.views,
      replyCount: replyCount ?? this.replyCount,
      createdAt: createdAt ?? this.createdAt,
      imageUrl: imageUrl ?? this.imageUrl,
      tags: tags ?? this.tags,
    );
  }
}

int _parseInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString()) ?? 0;
}

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
