import '../models/discourse/discourse_post.dart';
import '../models/comment.dart';
import 'discourse_adapter.dart';

/// Post → Reply 适配器
///
/// 负责将 Discourse Post 数据转换为应用 Reply 数据格式
class PostAdapter {
  /// 将 Discourse Post 转换为 Reply 数据
  ///
  /// [post] Discourse 帖子数据
  /// @return ReplyData 实例
  static ReplyData adaptPostToReply(DiscoursePost post) {
    return ReplyData(
      id: post.id.toString(),
      uid: post.userId?.toString() ?? '0',
      username: post.username,
      avatar: DiscourseAdapter.formatAvatarUrl(
        post.avatarTemplate,
        post.username,
      ),
      message: DiscourseAdapter.processHtmlContent(post.cooked),
      dateline: DiscourseAdapter.parseIso8601ToTimestamp(post.createdAt).toString(),
      likeNum: post.likeCount,
      replyNum: post.replyCount,
    );
  }

  /// 将 Discourse Post 列表转换为 Reply 响应
  ///
  /// [posts] Discourse 帖子列表
  /// [topicId] 话题 ID
  /// @return TotalReplyResponse 实例
  static TotalReplyResponse adaptPostListResponse(
    List<DiscoursePost> posts,
    String topicId,
  ) {
    final replies = posts.skip(1).map((post) => adaptPostToReply(post)).toList();

    return TotalReplyResponse(
      status: 1,
      message: 'success',
      data: replies,
      total: replies.length,
    );
  }
}