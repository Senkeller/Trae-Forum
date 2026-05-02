import 'package:freezed_annotation/freezed_annotation.dart';
import 'discourse_post.dart';
import 'discourse_topic.dart';

// 导出 DiscourseUserBasic 以便在生成的代码中使用
export 'discourse_topic.dart' show DiscourseUserBasic, DiscourseParticipant, DiscoursePrimaryGroup, DiscourseFlairGroup;

part 'discourse_private_message.freezed.dart';
part 'discourse_private_message.g.dart';

/// Discourse 私信会话模型
///
/// 用于表示私信话题列表中的单个会话
@freezed
class DiscoursePrivateMessage with _$DiscoursePrivateMessage {
  /// 构造函数
  ///
  /// [id] 私信话题ID
  /// [title] 私信标题
  /// [fancyTitle] 格式化后的标题
  /// [slug] URL别名
  /// [postsCount] 帖子数量
  /// [replyCount] 回复数量
  /// [highestPostNumber] 最高楼层号
  /// [createdAt] 创建时间
  /// [lastPostedAt] 最后回复时间
  /// [bumpedAt] 被顶起时间
  /// [unseen] 是否未读
  /// [unreadPosts] 未读帖子数量
  /// [lastReadPostNumber] 最后阅读的帖子编号
  /// [participants] 参与者列表
  /// [allowedUsers] 允许访问的用户列表
  const factory DiscoursePrivateMessage({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'fancy_title') String? fancyTitle,
    @JsonKey(name: 'slug') required String slug,
    @JsonKey(name: 'posts_count') @Default(0) int postsCount,
    @JsonKey(name: 'reply_count') @Default(0) int replyCount,
    @JsonKey(name: 'highest_post_number') @Default(0) int highestPostNumber,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'last_posted_at') String? lastPostedAt,
    @JsonKey(name: 'bumped_at') String? bumpedAt,
    @JsonKey(name: 'unseen') @Default(false) bool unseen,
    @JsonKey(name: 'unread_posts') @Default(0) int unreadPosts,
    @JsonKey(name: 'last_read_post_number') @Default(0) int lastReadPostNumber,
    @JsonKey(name: 'participants') @Default([]) List<DiscourseParticipant> participants,
    @JsonKey(name: 'allowed_users') @Default([]) List<DiscourseUserBasic> allowedUsers,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'excerpt') String? excerpt,
    @JsonKey(name: 'closed') @Default(false) bool closed,
    @JsonKey(name: 'archived') @Default(false) bool archived,
  }) = _DiscoursePrivateMessage;

  /// 从JSON解析私信会话对象
  ///
  /// [json] JSON数据
  /// @return DiscoursePrivateMessage实例
  factory DiscoursePrivateMessage.fromJson(Map<String, dynamic> json) =>
      _$DiscoursePrivateMessageFromJson(json);
}

/// 私信会话列表响应模型
@freezed
class DiscoursePrivateMessageListResponse with _$DiscoursePrivateMessageListResponse {
  const factory DiscoursePrivateMessageListResponse({
    @JsonKey(name: 'users') @Default([]) List<DiscourseUserBasic> users,
    @JsonKey(name: 'primary_groups') @Default([]) List<DiscoursePrimaryGroup> primaryGroups,
    @JsonKey(name: 'flair_groups') @Default([]) List<DiscourseFlairGroup> flairGroups,
    @JsonKey(name: 'topic_list') DiscoursePrivateMessageList? topicList,
  }) = _DiscoursePrivateMessageListResponse;

  factory DiscoursePrivateMessageListResponse.fromJson(Map<String, dynamic> json) =>
      _$DiscoursePrivateMessageListResponseFromJson(json);
}

/// 私信话题列表模型
@freezed
class DiscoursePrivateMessageList with _$DiscoursePrivateMessageList {
  const factory DiscoursePrivateMessageList({
    @JsonKey(name: 'can_create_topic') @Default(false) bool canCreateTopic,
    @JsonKey(name: 'more_topics_url') String? moreTopicsUrl,
    @JsonKey(name: 'per_page') @Default(30) int perPage,
    @JsonKey(name: 'topics') @Default([]) List<DiscoursePrivateMessage> topics,
  }) = _DiscoursePrivateMessageList;

  factory DiscoursePrivateMessageList.fromJson(Map<String, dynamic> json) =>
      _$DiscoursePrivateMessageListFromJson(json);
}

/// 私信详情响应模型
@freezed
class DiscoursePrivateMessageDetailResponse with _$DiscoursePrivateMessageDetailResponse {
  const factory DiscoursePrivateMessageDetailResponse({
    @JsonKey(name: 'post_stream') DiscoursePostStream? postStream,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'fancy_title') String? fancyTitle,
    @JsonKey(name: 'posts_count') int? postsCount,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'views') int? views,
    @JsonKey(name: 'reply_count') int? replyCount,
    @JsonKey(name: 'like_count') int? likeCount,
    @JsonKey(name: 'last_posted_at') String? lastPostedAt,
    @JsonKey(name: 'visible') bool? visible,
    @JsonKey(name: 'closed') bool? closed,
    @JsonKey(name: 'archived') bool? archived,
    @JsonKey(name: 'has_summary') bool? hasSummary,
    @JsonKey(name: 'archetype') String? archetype,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'word_count') int? wordCount,
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(name: 'pinned_globally') bool? pinnedGlobally,
    @JsonKey(name: 'pinned') bool? pinned,
    @JsonKey(name: 'details') DiscourseTopicDetails? details,
    @JsonKey(name: 'highest_post_number') int? highestPostNumber,
    @JsonKey(name: 'last_read_post_number') int? lastReadPostNumber,
    @JsonKey(name: 'unread_posts') int? unreadPosts,
    @JsonKey(name: 'actions_summary') @Default([]) List<Map<String, dynamic>> actionsSummary,
    @JsonKey(name: 'chunk_size') int? chunkSize,
    @JsonKey(name: 'bookmarked') bool? bookmarked,
    @JsonKey(name: 'tags') @Default([]) List<String> tags,
    @JsonKey(name: 'participants') @Default([]) List<DiscourseParticipant> participants,
    @JsonKey(name: 'allowed_users') @Default([]) List<DiscourseUserBasic> allowedUsers,
  }) = _DiscoursePrivateMessageDetailResponse;

  factory DiscoursePrivateMessageDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$DiscoursePrivateMessageDetailResponseFromJson(json);
}

/// 私信消息模型（单条消息）
@freezed
class DiscoursePrivateMessageItem with _$DiscoursePrivateMessageItem {
  const factory DiscoursePrivateMessageItem({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'topic_id') required int topicId,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') required String avatarTemplate,
    @JsonKey(name: 'cooked') required String cooked,
    @JsonKey(name: 'raw') String? raw,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'post_number') required int postNumber,
    @JsonKey(name: 'reply_to_post_number') int? replyToPostNumber,
    @JsonKey(name: 'like_count') @Default(0) int likeCount,
    @JsonKey(name: 'reads') @Default(0) int reads,
    @JsonKey(name: 'readers_count') @Default(0) int readersCount,
    @JsonKey(name: 'version') @Default(1) int version,
    @JsonKey(name: 'can_edit') @Default(false) bool canEdit,
    @JsonKey(name: 'can_delete') @Default(false) bool canDelete,
    @JsonKey(name: 'can_recover') @Default(false) bool canRecover,
    @JsonKey(name: 'can_wiki') @Default(false) bool canWiki,
    @JsonKey(name: 'user_title') String? userTitle,
    @JsonKey(name: 'title_is_group') @Default(false) bool titleIsGroup,
    @JsonKey(name: 'reply_to_user') Map<String, dynamic>? replyToUser,
    @JsonKey(name: 'actions_summary') @Default([]) List<Map<String, dynamic>> actionsSummary,
    @JsonKey(name: 'moderator') @Default(false) bool moderator,
    @JsonKey(name: 'admin') @Default(false) bool admin,
    @JsonKey(name: 'staff') @Default(false) bool staff,
    @JsonKey(name: 'user_trust_level') @Default(1) int userTrustLevel,
    @JsonKey(name: 'bookmarked') @Default(false) bool bookmarked,
  }) = _DiscoursePrivateMessageItem;

  factory DiscoursePrivateMessageItem.fromJson(Map<String, dynamic> json) =>
      _$DiscoursePrivateMessageItemFromJson(json);
}

/// 私信会话摘要模型（用于会话列表显示）
@freezed
class PrivateMessageConversation with _$PrivateMessageConversation {
  const factory PrivateMessageConversation({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'slug') required String slug,
    @JsonKey(name: 'last_message') String? lastMessage,
    @JsonKey(name: 'last_posted_at') String? lastPostedAt,
    @JsonKey(name: 'unread_count') @Default(0) int unreadCount,
    @JsonKey(name: 'total_messages') @Default(0) int totalMessages,
    @JsonKey(name: 'participants') @Default([]) List<DiscourseUserBasic> participants,
    @JsonKey(name: 'other_participant') DiscourseUserBasic? otherParticipant,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'closed') @Default(false) bool closed,
    @JsonKey(name: 'archived') @Default(false) bool archived,
  }) = _PrivateMessageConversation;

  factory PrivateMessageConversation.fromJson(Map<String, dynamic> json) =>
      _$PrivateMessageConversationFromJson(json);
}

/// 发送私信响应模型
@freezed
class SendPrivateMessageResponse with _$SendPrivateMessageResponse {
  const factory SendPrivateMessageResponse({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'topic_id') int? topicId,
    @JsonKey(name: 'topic_slug') String? topicSlug,
    @JsonKey(name: 'post_number') int? postNumber,
    @JsonKey(name: 'username') String? username,
    @JsonKey(name: 'cooked') String? cooked,
    @JsonKey(name: 'raw') String? raw,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'errors') List<String>? errors,
    @JsonKey(name: 'error_type') String? errorType,
    @JsonKey(name: 'message') String? message,
    @JsonKey(name: 'success') bool? success,
  }) = _SendPrivateMessageResponse;

  factory SendPrivateMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$SendPrivateMessageResponseFromJson(json);
}

/// 私信未读计数模型
@freezed
class PrivateMessageUnreadCount with _$PrivateMessageUnreadCount {
  const factory PrivateMessageUnreadCount({
    @JsonKey(name: 'topic_id') required int topicId,
    @JsonKey(name: 'unread_count') @Default(0) int unreadCount,
    @JsonKey(name: 'highest_post_number') @Default(0) int highestPostNumber,
    @JsonKey(name: 'last_read_post_number') @Default(0) int lastReadPostNumber,
  }) = _PrivateMessageUnreadCount;

  factory PrivateMessageUnreadCount.fromJson(Map<String, dynamic> json) =>
      _$PrivateMessageUnreadCountFromJson(json);
}

/// 私信追踪状态响应模型
@freezed
class PrivateMessageTrackingStateResponse with _$PrivateMessageTrackingStateResponse {
  const factory PrivateMessageTrackingStateResponse({
    @JsonKey(name: 'private_message_topic_tracking_state')
    @Default([])
    List<PrivateMessageUnreadCount> trackingStates,
  }) = _PrivateMessageTrackingStateResponse;

  factory PrivateMessageTrackingStateResponse.fromJson(Map<String, dynamic> json) =>
      _$PrivateMessageTrackingStateResponseFromJson(json);
}
