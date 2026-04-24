import '../models/discourse/discourse_post.dart';
import '../models/discourse/discourse_topic.dart';
import '../models/feed.dart';
import '../models/user.dart';
import 'discourse_adapter.dart';

/// Topic → Feed 适配器
///
/// 负责将 Discourse Topic 数据转换为应用 Feed 数据格式
class TopicAdapter {
  /// 将 Discourse Topic 转换为 Feed 数据
  ///
  /// [topic] Discourse 话题数据
  /// [users] 用户列表（用于解析头像）
  /// [posts] 帖子列表（用于提取精选评论）
  /// @return HomeFeedData 实例
  static HomeFeedData adaptTopicToFeed(
    DiscourseTopic topic,
    List<DiscourseUserBasic> users, {
    List<DiscoursePost> posts = const [],
  }) {
    final createdBy = DiscourseAdapter.findUserById(
      topic.posters.isNotEmpty ? topic.posters.first.userId : 0,
      users,
    );

    final userInfo = UserInfo(
      uid: createdBy?.id.toString() ?? '0',
      username: createdBy?.username ?? 'unknown',
      avatar: DiscourseAdapter.formatAvatarUrl(
        createdBy?.avatarTemplate ?? '',
        createdBy?.username ?? '',
      ),
      level: createdBy?.trustLevel ?? 1,
    );

    // 提取精选评论
    final topComment = _extractTopComment(posts);

    return HomeFeedData(
      id: topic.id.toString(),
      entityType: 'feed',
      title: topic.title,
      message: topic.excerpt ?? '',
      picArr: topic.imageUrl != null ? [topic.imageUrl!] : [],
      userInfo: userInfo,
      dateline: DiscourseAdapter.parseIso8601ToTimestamp(topic.createdAt).toString(),
      replyNum: topic.postsCount - 1,
      forwardNum: 0,
      topComment: topComment,
    );
  }

  /// 从帖子列表中提取精选评论
  ///
  /// 逻辑：
  /// 1. 筛选 post_number > 1 的回复（排除主帖）
  /// 2. 按 like_count 降序排序
  /// 3. 取第一条作为精选评论
  ///
  /// [posts] Discourse 帖子列表
  /// @return TopComment? 精选评论，如果没有符合条件的评论则返回 null
  static TopComment? _extractTopComment(List<DiscoursePost> posts) {
    if (posts.isEmpty) return null;

    // 筛选 post_number > 1 的回复（排除主帖）
    final replies = posts.where((post) => post.postNumber > 1).toList();
    if (replies.isEmpty) return null;

    // 按 like_count 降序排序
    replies.sort((a, b) => b.likeCount.compareTo(a.likeCount));

    // 取第一条作为精选评论
    final topPost = replies.first;

    return TopComment(
      id: topPost.id.toString(),
      username: topPost.username,
      content: _extractPlainText(topPost.cooked ?? ''),
      likeCount: topPost.likeCount,
      avatarUrl: DiscourseAdapter.formatAvatarUrl(
        topPost.avatarTemplate,
        topPost.username,
      ),
    );
  }

  /// 从 HTML 内容中提取纯文本
  ///
  /// [html] HTML 格式的内容
  /// @return String 纯文本内容
  static String _extractPlainText(String html) {
    // 移除 HTML 标签
    var text = html.replaceAll(RegExp(r'<[^>]*>'), '');
    // 解码 HTML 实体
    text = text
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .replaceAll('&nbsp;', ' ');
    // 移除多余空白
    text = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    return text;
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
      avatar: DiscourseAdapter.formatAvatarUrl(
        firstPost.avatarTemplate,
        firstPost.username,
      ),
      level: firstPost.trustLevel ?? 1,
    );

    final feedData = FeedContentData(
      id: response.id?.toString() ?? '0',
      entityType: 'feed',
      title: response.title ?? '',
      message: DiscourseAdapter.processHtmlContent(firstPost.cooked),
      picArr: [],
      userInfo: userInfo,
      dateline: DiscourseAdapter.parseIso8601ToTimestamp(response.createdAt ?? '').toString(),
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
}