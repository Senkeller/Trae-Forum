/// 搜索相关数据模型
///
/// 包含搜索请求、搜索结果、搜索建议等模型定义
/// 对应 TRAE 论坛搜索 API 的数据结构

// ignore_for_file: dangling_library_doc_comments

/// 搜索排序方式
enum SearchOrder {
  /// 按最新发布时间排序
  latest('latest'),

  /// 按点赞数排序
  likes('likes'),

  /// 按浏览量排序
  views('views'),

  /// 按回复数排序
  posts('posts'),

  /// 默认排序（相关性）
  relevance('relevance');

  final String value;
  const SearchOrder(this.value);

  static SearchOrder fromString(String? value) {
    return SearchOrder.values.firstWhere(
      (e) => e.value == value,
      orElse: () => SearchOrder.relevance,
    );
  }
}

/// 搜索类型
enum SearchType {
  /// 搜索话题
  topic('topic'),

  /// 搜索帖子
  post('post'),

  /// 搜索用户
  user('user'),

  /// 搜索分类
  category('category');

  final String value;
  const SearchType(this.value);
}

/// 话题状态
enum TopicStatus {
  /// 开放状态
  open('open'),

  /// 已关闭
  closed('closed'),

  /// 已归档
  archived('archived');

  final String value;
  const TopicStatus(this.value);
}

/// 搜索请求参数
///
/// 用于构建搜索 API 的请求参数
class SearchRequest {
  /// 搜索关键词（必填）
  final String keyword;

  /// 页码（从1开始，默认1）
  final int page;

  /// 分类ID筛选
  final int? categoryId;

  /// 标签筛选列表
  final List<String>? tags;

  /// 搜索类型
  final SearchType? type;

  /// 排序方式
  final SearchOrder? order;

  /// 发布日期之后（YYYY-MM-DD）
  final DateTime? after;

  /// 发布日期之前（YYYY-MM-DD）
  final DateTime? before;

  /// 最小帖子数
  final int? minPosts;

  /// 最大帖子数
  final int? maxPosts;

  /// 最小浏览量
  final int? minViews;

  /// 最大浏览量
  final int? maxViews;

  /// 搜索范围（title/posts/all）
  final String? searchIn;

  /// 包含内容（images/videos）
  final String? withContent;

  /// 话题状态
  final TopicStatus? status;

  const SearchRequest({
    required this.keyword,
    this.page = 1,
    this.categoryId,
    this.tags,
    this.type,
    this.order,
    this.after,
    this.before,
    this.minPosts,
    this.maxPosts,
    this.minViews,
    this.maxViews,
    this.searchIn,
    this.withContent,
    this.status,
  });

  /// 转换为查询参数 Map
  Map<String, dynamic> toQueryParameters() {
    return {
      'q': keyword,
      'page': page.toString(),
      if (categoryId != null) 'category': categoryId.toString(),
      if (tags != null && tags!.isNotEmpty) 'tags': tags!.join(','),
      if (type != null) 'type': type!.value,
      if (order != null) 'order': order!.value,
      if (after != null) 'after': _formatDate(after!),
      if (before != null) 'before': _formatDate(before!),
      if (minPosts != null) 'min_posts': minPosts.toString(),
      if (maxPosts != null) 'max_posts': maxPosts.toString(),
      if (minViews != null) 'min_views': minViews.toString(),
      if (maxViews != null) 'max_views': maxViews.toString(),
      if (searchIn != null) 'in': searchIn,
      if (withContent != null) 'with': withContent,
      if (status != null) 'status': status!.value,
    };
  }

  /// 格式化日期为 YYYY-MM-DD
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// 复制并修改部分字段
  SearchRequest copyWith({
    String? keyword,
    int? page,
    int? categoryId,
    List<String>? tags,
    SearchType? type,
    SearchOrder? order,
    DateTime? after,
    DateTime? before,
    int? minPosts,
    int? maxPosts,
    int? minViews,
    int? maxViews,
    String? searchIn,
    String? withContent,
    TopicStatus? status,
  }) {
    return SearchRequest(
      keyword: keyword ?? this.keyword,
      page: page ?? this.page,
      categoryId: categoryId ?? this.categoryId,
      tags: tags ?? this.tags,
      type: type ?? this.type,
      order: order ?? this.order,
      after: after ?? this.after,
      before: before ?? this.before,
      minPosts: minPosts ?? this.minPosts,
      maxPosts: maxPosts ?? this.maxPosts,
      minViews: minViews ?? this.minViews,
      maxViews: maxViews ?? this.maxViews,
      searchIn: searchIn ?? this.searchIn,
      withContent: withContent ?? this.withContent,
      status: status ?? this.status,
    );
  }
}

/// 搜索响应结果
///
/// 包含搜索结果的所有数据
class SearchResponse {
  /// 匹配的帖子列表
  final List<SearchPost> posts;

  /// 匹配的话题列表
  final List<SearchTopic> topics;

  /// 匹配的用户列表
  final List<SearchUser> users;

  /// 匹配的分类列表
  final List<SearchCategory> categories;

  /// 搜索结果汇总信息
  final GroupedSearchResult? groupedResult;

  const SearchResponse({
    this.posts = const [],
    this.topics = const [],
    this.users = const [],
    this.categories = const [],
    this.groupedResult,
  });

  /// 是否还有更多帖子
  bool get hasMorePosts => groupedResult?.morePosts ?? false;

  /// 是否还有更多话题
  bool get hasMoreTopics => groupedResult?.moreTopics ?? false;

  /// 是否还有更多用户
  bool get hasMoreUsers => groupedResult?.moreUsers ?? false;

  /// 从 JSON 解析
  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      posts: (json['posts'] as List?)
              ?.map((e) => SearchPost.fromJson(e))
              .toList() ??
          [],
      topics: (json['topics'] as List?)
              ?.map((e) => SearchTopic.fromJson(e))
              .toList() ??
          [],
      users: (json['users'] as List?)
              ?.map((e) => SearchUser.fromJson(e))
              .toList() ??
          [],
      categories: (json['categories'] as List?)
              ?.map((e) => SearchCategory.fromJson(e))
              .toList() ??
          [],
      groupedResult: json['grouped_search_result'] != null
          ? GroupedSearchResult.fromJson(json['grouped_search_result'])
          : null,
    );
  }
}

/// 搜索结果帖子
class SearchPost {
  /// 帖子ID
  final int id;

  /// 用户显示名称
  final String? name;

  /// 用户名
  final String username;

  /// 头像模板URL（替换 {size} 为尺寸）
  final String avatarTemplate;

  /// 创建时间
  final DateTime createdAt;

  /// 点赞数
  final int likeCount;

  /// 帖子内容摘要
  final String blurb;

  /// 楼层号（1为楼主）
  final int postNumber;

  /// 所属话题ID
  final int topicId;

  /// 话题标题
  final String? topicTitle;

  /// 分类ID
  final int? categoryId;

  /// 分类名称
  final String? categoryName;

  const SearchPost({
    required this.id,
    this.name,
    required this.username,
    required this.avatarTemplate,
    required this.createdAt,
    required this.likeCount,
    required this.blurb,
    required this.postNumber,
    required this.topicId,
    this.topicTitle,
    this.categoryId,
    this.categoryName,
  });

  /// 获取头像URL
  String getAvatarUrl({int size = 96}) {
    return avatarTemplate.replaceAll('{size}', size.toString());
  }

  /// 从 JSON 解析
  factory SearchPost.fromJson(Map<String, dynamic> json) {
    return SearchPost(
      id: json['id'] ?? 0,
      name: json['name'],
      username: json['username'] ?? '',
      avatarTemplate: json['avatar_template'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      likeCount: json['like_count'] ?? 0,
      blurb: json['blurb'] ?? '',
      postNumber: json['post_number'] ?? 1,
      topicId: json['topic_id'] ?? 0,
      topicTitle: json['topic_title'],
      categoryId: json['category_id'],
      categoryName: json['category_name'],
    );
  }
}

/// 搜索结果话题
class SearchTopic {
  /// 话题ID
  final int id;

  /// 话题标题
  final String title;

  /// URL友好的话题标识
  final String slug;

  /// 总帖子数
  final int postsCount;

  /// 回复数
  final int replyCount;

  /// 浏览量
  final int views;

  /// 点赞数
  final int likeCount;

  /// 分类ID
  final int? categoryId;

  /// 标签列表
  final List<String> tags;

  /// 创建时间
  final DateTime createdAt;

  /// 最后回复时间
  final DateTime? lastPostedAt;

  const SearchTopic({
    required this.id,
    required this.title,
    required this.slug,
    required this.postsCount,
    required this.replyCount,
    required this.views,
    required this.likeCount,
    this.categoryId,
    this.tags = const [],
    required this.createdAt,
    this.lastPostedAt,
  });

  /// 从 JSON 解析
  factory SearchTopic.fromJson(Map<String, dynamic> json) {
    return SearchTopic(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      postsCount: json['posts_count'] ?? 0,
      replyCount: json['reply_count'] ?? 0,
      views: json['views'] ?? 0,
      likeCount: json['like_count'] ?? 0,
      categoryId: json['category_id'],
      tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? [],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      lastPostedAt: json['last_posted_at'] != null
          ? DateTime.tryParse(json['last_posted_at'])
          : null,
    );
  }
}

/// 搜索结果用户
class SearchUser {
  /// 用户ID
  final int id;

  /// 用户名
  final String username;

  /// 显示名称
  final String? name;

  /// 头像模板URL
  final String avatarTemplate;

  /// 信任等级
  final int trustLevel;

  const SearchUser({
    required this.id,
    required this.username,
    this.name,
    required this.avatarTemplate,
    required this.trustLevel,
  });

  /// 获取头像URL
  String getAvatarUrl({int size = 96}) {
    return avatarTemplate.replaceAll('{size}', size.toString());
  }

  /// 从 JSON 解析
  factory SearchUser.fromJson(Map<String, dynamic> json) {
    return SearchUser(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      name: json['name'],
      avatarTemplate: json['avatar_template'] ?? '',
      trustLevel: json['trust_level'] ?? 0,
    );
  }
}

/// 搜索结果分类
class SearchCategory {
  /// 分类ID
  final int id;

  /// 分类名称
  final String name;

  /// 背景颜色（十六进制）
  final String color;

  /// 文字颜色（十六进制）
  final String textColor;

  const SearchCategory({
    required this.id,
    required this.name,
    required this.color,
    required this.textColor,
  });

  /// 从 JSON 解析
  factory SearchCategory.fromJson(Map<String, dynamic> json) {
    return SearchCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      color: json['color'] ?? '0088CC',
      textColor: json['text_color'] ?? 'FFFFFF',
    );
  }
}

/// 搜索结果汇总
class GroupedSearchResult {
  /// 是否还有更多帖子
  final bool morePosts;

  /// 是否还有更多话题
  final bool moreTopics;

  /// 是否还有更多用户
  final bool moreUsers;

  /// 是否还有更多分类
  final bool moreCategories;

  /// 帖子ID列表
  final List<int> postIds;

  /// 话题ID列表
  final List<int> topicIds;

  const GroupedSearchResult({
    required this.morePosts,
    required this.moreTopics,
    required this.moreUsers,
    required this.moreCategories,
    required this.postIds,
    required this.topicIds,
  });

  /// 从 JSON 解析
  factory GroupedSearchResult.fromJson(Map<String, dynamic> json) {
    final postIdsList = (json['post_ids'] as List?)
            ?.map((e) => e as int)
            .toList() ??
        [];
    final topicIdsList = (json['topic_ids'] as List?)
            ?.map((e) => e as int)
            .toList() ??
        [];
    return GroupedSearchResult(
      morePosts: json['more_posts'] ?? false,
      moreTopics: json['more_topics'] ?? false,
      moreUsers: json['more_users'] ?? false,
      moreCategories: json['more_categories'] ?? false,
      postIds: postIdsList,
      topicIds: topicIdsList,
    );
  }
}

/// 搜索建议
class SearchSuggestion {
  /// 建议类型
  final SuggestionType type;

  /// 显示文本
  final String text;

  /// 副标题/描述
  final String? subtitle;

  /// 关联ID（话题ID/用户ID等）
  final int? id;

  /// 图标URL（头像等）
  final String? iconUrl;

  const SearchSuggestion({
    required this.type,
    required this.text,
    this.subtitle,
    this.id,
    this.iconUrl,
  });

  /// 从话题创建建议
  factory SearchSuggestion.fromTopic(Map<String, dynamic> json) {
    return SearchSuggestion(
      type: SuggestionType.topic,
      text: json['title'] ?? '',
      id: json['id'],
    );
  }

  /// 从用户创建建议
  factory SearchSuggestion.fromUser(Map<String, dynamic> json) {
    return SearchSuggestion(
      type: SuggestionType.user,
      text: json['username'] ?? '',
      subtitle: json['name'],
      iconUrl: json['avatar_template']
          ?.toString()
          .replaceAll('{size}', '48'),
    );
  }

  /// 从分类创建建议
  factory SearchSuggestion.fromCategory(Map<String, dynamic> json) {
    return SearchSuggestion(
      type: SuggestionType.category,
      text: json['name'] ?? '',
      id: json['id'],
    );
  }
}

/// 建议类型
enum SuggestionType {
  topic,
  user,
  category,
  tag,
}

/// 搜索历史记录
class SearchHistory {
  /// 搜索关键词
  final String keyword;

  /// 搜索时间
  final DateTime timestamp;

  /// 搜索结果数量（可选）
  final int? resultCount;

  const SearchHistory({
    required this.keyword,
    required this.timestamp,
    this.resultCount,
  });

  /// 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'keyword': keyword,
      'timestamp': timestamp.toIso8601String(),
      'resultCount': resultCount,
    };
  }

  /// 从 JSON 解析
  factory SearchHistory.fromJson(Map<String, dynamic> json) {
    return SearchHistory(
      keyword: json['keyword'] ?? '',
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
      resultCount: json['resultCount'],
    );
  }
}
