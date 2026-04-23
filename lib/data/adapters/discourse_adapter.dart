import '../models/discourse/discourse_topic.dart';
import '../models/discourse/discourse_category.dart';
import '../models/discourse/discourse_user.dart';
import '../models/feed.dart';
import '../models/comment.dart';
import '../models/user.dart';

/// Discourse 数据适配器
/// 
/// 负责将 Discourse API 数据转换为应用数据模型
class DiscourseAdapter {
  /// 将 Discourse Topic 转换为 Feed 数据
  /// 
  /// [topic] Discourse 话题数据
  /// [users] 用户列表（用于解析头像）
  /// @return HomeFeedData 实例
  static HomeFeedData adaptTopicToFeed(
    DiscourseTopic topic,
    List<DiscourseUserBasic> users,
  ) {
    final createdBy = _findUserById(topic.posters.isNotEmpty ? topic.posters.first.userId : 0, users);
    
    final userInfo = UserInfo(
      uid: createdBy?.id.toString() ?? '0',
      username: createdBy?.username ?? 'unknown',
      avatar: _formatAvatarUrl(createdBy?.avatarTemplate ?? '', createdBy?.username ?? ''),
      level: createdBy?.trustLevel ?? 1,
    );

    return HomeFeedData(
      id: topic.id.toString(),
      entityType: 'feed',
      title: topic.title,
      message: topic.excerpt ?? '',
      picArr: topic.imageUrl != null ? [topic.imageUrl!] : [],
      userInfo: userInfo,
      dateline: _parseIso8601ToTimestamp(topic.createdAt).toString(),
      replyNum: topic.postsCount - 1,
      forwardNum: 0,
    );
  }

  /// 将 Discourse Topic 列表转换为 Feed 响应
  /// 
  /// [response] Discourse 话题列表响应
  /// @return HomeFeedResponse 实例
  static HomeFeedResponse adaptTopicListResponse(DiscourseTopicListResponse response) {
    final feeds = response.topicList?.topics
        .map((topic) => adaptTopicToFeed(topic, response.users))
        .toList() ?? [];
    
    return HomeFeedResponse(
      status: 200,
      message: 'success',
      data: feeds,
      total: feeds.length,
    );
  }

  /// 将 Discourse Topic 详情转换为 Feed 内容响应
  /// 
  /// [response] Discourse 话题详情响应
  /// @return FeedContentResponse 实例
  static FeedContentResponse adaptTopicDetailResponse(DiscourseTopicDetailResponse response) {
    if (response.postStream == null || response.postStream!.posts.isEmpty) {
      return FeedContentResponse(
        status: 200,
        message: 'success',
        data: null,
      );
    }

    final firstPost = response.postStream!.posts.first;

    final userInfo = UserInfo(
      uid: firstPost.userId?.toString() ?? '0',
      username: firstPost.username,
      avatar: _formatAvatarUrl(firstPost.avatarTemplate, firstPost.username),
      level: firstPost.trustLevel ?? 1,
    );

    final feedData = FeedContentData(
      id: response.id?.toString() ?? '0',
      entityType: 'feed',
      title: response.title ?? '',
      message: firstPost.cooked ?? '',
      picArr: [],
      userInfo: userInfo,
      dateline: _parseIso8601ToTimestamp(response.createdAt ?? '').toString(),
      replyNum: response.replyCount ?? 0,
      forwardNum: 0,
      isTop: response.pinned ?? false,
    );

    return FeedContentResponse(
      status: 200,
      message: 'success',
      data: feedData,
    );
  }

  /// 将 Discourse Post 转换为 Reply 数据
  /// 
  /// [post] Discourse 帖子数据
  /// @return ReplyData 实例
  static ReplyData adaptPostToReply(DiscoursePost post) {
    return ReplyData(
      id: post.id.toString(),
      uid: post.userId?.toString() ?? '0',
      username: post.username,
      avatar: _formatAvatarUrl(post.avatarTemplate, post.username),
      message: post.cooked ?? '',
      dateline: _parseIso8601ToTimestamp(post.createdAt).toString(),
      likeNum: post.likeCount,
      replyNum: post.replyCount,
    );
  }

  /// 将 Discourse Post 列表转换为 Reply 响应
  /// 
  /// [posts] Discourse 帖子列表
  /// [topicId] 话题 ID
  /// @return TotalReplyResponse 实例
  static TotalReplyResponse adaptPostListResponse(List<DiscoursePost> posts, String topicId) {
    final replies = posts
        .skip(1)
        .map((post) => adaptPostToReply(post))
        .toList();
    
    return TotalReplyResponse(
      status: 1,
      message: 'success',
      data: replies,
      total: replies.length,
    );
  }

  /// 将 Discourse Category 适配为分类模型
  /// 
  /// [category] Discourse 分类数据
  /// @return 适配后的分类数据
  static Map<String, dynamic> adaptCategory(DiscourseCategory category) {
    return {
      'id': category.id.toString(),
      'name': category.name,
      'slug': category.slug,
      'description': category.description ?? '',
      'color': category.color,
      'topicCount': category.topicCount,
      'postCount': category.postCount,
    };
  }

  /// 将 Discourse User Basic 适配为 UserInfo
  /// 
  /// [user] Discourse 用户数据
  /// @return UserInfo 实例
  static UserInfo adaptUser(DiscourseUserBasic user) {
    return UserInfo(
      uid: user.id.toString(),
      username: user.username,
      avatar: _formatAvatarUrl(user.avatarTemplate, user.username),
      level: user.trustLevel,
    );
  }

  /// 将 Discourse User 详情适配为 UserInfo
  /// 
  /// [user] Discourse 用户详情数据
  /// @return UserInfo 实例
  static UserInfo adaptUserFromDetail(DiscourseUser user) {
    return UserInfo(
      uid: user.id.toString(),
      username: user.username,
      avatar: _formatAvatarUrl(user.avatarTemplate, user.username),
      level: user.trustLevel,
      bio: user.title ?? '',
    );
  }

  /// 格式化 Discourse 头像 URL
  /// 
  /// [template] 头像模板
  /// [username] 用户名
  /// @return 完整的头像 URL
  static String _formatAvatarUrl(String template, String username) {
    if (template.isEmpty) {
      return 'https://forum.trae.cn/user_avatar/forum.trae.cn/$username/120/0_2.png';
    }
    
    String url = template;
    url = url.replaceAll('{username}', username);
    url = url.replaceAll('{size}', '120');
    
    if (!url.startsWith('http')) {
      url = 'https://forum.trae.cn$url';
    }
    
    return url;
  }

  /// 查找用户 by ID
  static DiscourseUserBasic? _findUserById(int userId, List<DiscourseUserBasic> users) {
    if (userId == 0) return users.isNotEmpty ? users.first : null;
    try {
      return users.firstWhere((u) => u.id == userId);
    } catch (_) {
      return users.isNotEmpty ? users.first : null;
    }
  }

  /// 解析 ISO 8601 时间字符串为 Unix 时间戳
  /// 
  /// [isoString] ISO 8601 格式的时间字符串
  /// @return Unix 时间戳（秒）
  static int _parseIso8601ToTimestamp(String isoString) {
    if (isoString.isEmpty) return 0;
    try {
      final dateTime = DateTime.parse(isoString);
      return dateTime.millisecondsSinceEpoch ~/ 1000;
    } catch (_) {
      return 0;
    }
  }
}
