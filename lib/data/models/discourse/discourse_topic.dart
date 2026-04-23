import 'package:freezed_annotation/freezed_annotation.dart';

part 'discourse_topic.freezed.dart';
part 'discourse_topic.g.dart';

/// Discourse 话题模型
/// 
/// 用于接收 Discourse API 返回的话题数据
@freezed
class DiscourseTopic with _$DiscourseTopic {
  /// 构造函数
  /// 
  /// [id] 话题ID
  /// [title] 话题标题
  /// [fancyTitle] 格式化后的标题
  /// [slug] URL别名
  /// [categoryId] 分类ID
  /// [postsCount] 帖子数量
  /// [replyCount] 回复数量（不含首帖）
  /// [highestPostNumber] 最高楼层号
  /// [createdAt] 创建时间
  /// [lastPostedAt] 最后回复时间
  /// [bumped] 是否被顶起
  /// [bumpedAt] 被顶起时间
  /// [archetype] 话题类型（regular, private_message等）
  /// [unseen] 是否未读
  /// [pinned] 是否置顶
  /// [unpinned] 是否被取消置顶
  /// [visible] 是否可见
  /// [closed] 是否关闭
  /// [archived] 是否归档
  /// [bookmarked] 是否被当前用户收藏
  /// [liked] 是否被当前用户点赞
  /// [views] 浏览次数
  /// [likeCount] 点赞数量
  /// [hasSummary] 是否有摘要
  /// [lastPosterUsername] 最后回复者用户名
  /// [tags] 标签列表
  /// [tagsDescriptions] 标签描述
  /// [participants] 参与者列表（简要信息）
  /// [posters] 发帖者列表
  const factory DiscourseTopic({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'fancy_title') String? fancyTitle,
    @JsonKey(name: 'slug') required String slug,
    @JsonKey(name: 'category_id') required int categoryId,
    @JsonKey(name: 'posts_count') @Default(0) int postsCount,
    @JsonKey(name: 'reply_count') @Default(0) int replyCount,
    @JsonKey(name: 'highest_post_number') @Default(0) int highestPostNumber,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'last_posted_at') String? lastPostedAt,
    @JsonKey(name: 'bumped') @Default(false) bool bumped,
    @JsonKey(name: 'bumped_at') String? bumpedAt,
    @JsonKey(name: 'archetype') @Default('regular') String archetype,
    @JsonKey(name: 'unseen') @Default(false) bool unseen,
    @JsonKey(name: 'pinned') @Default(false) bool pinned,
    @JsonKey(name: 'unpinned') bool? unpinned,
    @JsonKey(name: 'visible') @Default(true) bool visible,
    @JsonKey(name: 'closed') @Default(false) bool closed,
    @JsonKey(name: 'archived') @Default(false) bool archived,
    @JsonKey(name: 'bookmarked') @Default(false) bool bookmarked,
    @JsonKey(name: 'liked') @Default(false) bool liked,
    @JsonKey(name: 'views') @Default(0) int views,
    @JsonKey(name: 'like_count') @Default(0) int likeCount,
    @JsonKey(name: 'has_summary') @Default(false) bool hasSummary,
    @JsonKey(name: 'last_poster_username') String? lastPosterUsername,
    @JsonKey(name: 'tags') @Default([]) List<String> tags,
    @JsonKey(name: 'tags_descriptions') Map<String, dynamic>? tagsDescriptions,
    @JsonKey(name: 'participants') @Default([]) List<DiscourseParticipant> participants,
    @JsonKey(name: 'posters') @Default([]) List<DiscoursePoster> posters,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'excerpt') String? excerpt,
  }) = _DiscourseTopic;

  /// 从JSON解析话题对象
  /// 
  /// [json] JSON数据
  /// @return DiscourseTopic实例
  factory DiscourseTopic.fromJson(Map<String, dynamic> json) =>
      _$DiscourseTopicFromJson(json);
}

/// Discourse 参与者模型
/// 
/// 用于表示话题的参与者（简要信息）
@freezed
class DiscourseParticipant with _$DiscourseParticipant {
  /// 构造函数
  /// 
  /// [id] 用户ID
  /// [username] 用户名
  /// [name] 显示名称
  /// [avatarTemplate] 头像URL模板
  /// [postCount] 发帖数量
  /// [primaryGroupName] 主要用户组名称
  /// [flairName] 徽章名称
  /// [flairUrl] 徽章URL
  /// [flairBgColor] 徽章背景色
  /// [flairColor] 徽章颜色
  /// [admin] 是否管理员
  /// [moderator] 是否版主
  /// [trustLevel] 信任等级
  const factory DiscourseParticipant({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') required String avatarTemplate,
    @JsonKey(name: 'post_count') @Default(0) int postCount,
    @JsonKey(name: 'primary_group_name') String? primaryGroupName,
    @JsonKey(name: 'flair_name') String? flairName,
    @JsonKey(name: 'flair_url') String? flairUrl,
    @JsonKey(name: 'flair_bg_color') String? flairBgColor,
    @JsonKey(name: 'flair_color') String? flairColor,
    @JsonKey(name: 'admin') @Default(false) bool admin,
    @JsonKey(name: 'moderator') @Default(false) bool moderator,
    @JsonKey(name: 'trust_level') @Default(1) int trustLevel,
  }) = _DiscourseParticipant;

  /// 从JSON解析参与者对象
  /// 
  /// [json] JSON数据
  /// @return DiscourseParticipant实例
  factory DiscourseParticipant.fromJson(Map<String, dynamic> json) =>
      _$DiscourseParticipantFromJson(json);
}

/// Discourse 发帖者模型
/// 
/// 用于表示话题的发帖者信息
@freezed
class DiscoursePoster with _$DiscoursePoster {
  /// 构造函数
  /// 
  /// [extras] 额外信息
  /// [description] 描述
  /// [userId] 用户ID
  /// [primaryGroupId] 主要用户组ID
  /// [primaryGroupName] 主要用户组名称
  /// [flairGroupId] 徽章组ID
  /// [flairName] 徽章名称
  /// [flairUrl] 徽章URL
  /// [flairBgColor] 徽章背景色
  /// [flairColor] 徽章颜色
  const factory DiscoursePoster({
    @JsonKey(name: 'extras') String? extras,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'primary_group_id') int? primaryGroupId,
    @JsonKey(name: 'primary_group_name') String? primaryGroupName,
    @JsonKey(name: 'flair_group_id') int? flairGroupId,
    @JsonKey(name: 'flair_name') String? flairName,
    @JsonKey(name: 'flair_url') String? flairUrl,
    @JsonKey(name: 'flair_bg_color') String? flairBgColor,
    @JsonKey(name: 'flair_color') String? flairColor,
  }) = _DiscoursePoster;

  /// 从JSON解析发帖者对象
  /// 
  /// [json] JSON数据
  /// @return DiscoursePoster实例
  factory DiscoursePoster.fromJson(Map<String, dynamic> json) =>
      _$DiscoursePosterFromJson(json);
}

/// Discourse 话题列表响应模型
@freezed
class DiscourseTopicListResponse with _$DiscourseTopicListResponse {
  const factory DiscourseTopicListResponse({
    @JsonKey(name: 'users') @Default([]) List<DiscourseUserBasic> users,
    @JsonKey(name: 'primary_groups') @Default([]) List<DiscoursePrimaryGroup> primaryGroups,
    @JsonKey(name: 'flair_groups') @Default([]) List<DiscourseFlairGroup> flairGroups,
    @JsonKey(name: 'topic_list') DiscourseTopicList? topicList,
  }) = _DiscourseTopicListResponse;

  factory DiscourseTopicListResponse.fromJson(Map<String, dynamic> json) =>
      _$DiscourseTopicListResponseFromJson(json);
}

/// Discourse 话题列表模型
@freezed
class DiscourseTopicList with _$DiscourseTopicList {
  const factory DiscourseTopicList({
    @JsonKey(name: 'can_create_topic') @Default(false) bool canCreateTopic,
    @JsonKey(name: 'more_topics_url') String? moreTopicsUrl,
    @JsonKey(name: 'for_period') String? forPeriod,
    @JsonKey(name: 'per_page') @Default(30) int perPage,
    @JsonKey(name: 'top_tags') @Default([]) List<String> topTags,
    @JsonKey(name: 'topics') @Default([]) List<DiscourseTopic> topics,
  }) = _DiscourseTopicList;

  factory DiscourseTopicList.fromJson(Map<String, dynamic> json) =>
      _$DiscourseTopicListFromJson(json);
}

/// Discourse 用户基本信息模型
@freezed
class DiscourseUserBasic with _$DiscourseUserBasic {
  const factory DiscourseUserBasic({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') required String avatarTemplate,
    @JsonKey(name: 'admin') @Default(false) bool admin,
    @JsonKey(name: 'moderator') @Default(false) bool moderator,
    @JsonKey(name: 'trust_level') @Default(1) int trustLevel,
    @JsonKey(name: 'primary_group_name') String? primaryGroupName,
    @JsonKey(name: 'flair_name') String? flairName,
    @JsonKey(name: 'flair_url') String? flairUrl,
    @JsonKey(name: 'flair_bg_color') String? flairBgColor,
    @JsonKey(name: 'flair_color') String? flairColor,
  }) = _DiscourseUserBasic;

  factory DiscourseUserBasic.fromJson(Map<String, dynamic> json) =>
      _$DiscourseUserBasicFromJson(json);
}

/// Discourse 主要用户组模型
@freezed
class DiscoursePrimaryGroup with _$DiscoursePrimaryGroup {
  const factory DiscoursePrimaryGroup({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
  }) = _DiscoursePrimaryGroup;

  factory DiscoursePrimaryGroup.fromJson(Map<String, dynamic> json) =>
      _$DiscoursePrimaryGroupFromJson(json);
}

/// Discourse 徽章组模型
@freezed
class DiscourseFlairGroup with _$DiscourseFlairGroup {
  const factory DiscourseFlairGroup({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'flair_url') String? flairUrl,
    @JsonKey(name: 'flair_bg_color') String? flairBgColor,
    @JsonKey(name: 'flair_color') String? flairColor,
  }) = _DiscourseFlairGroup;

  factory DiscourseFlairGroup.fromJson(Map<String, dynamic> json) =>
      _$DiscourseFlairGroupFromJson(json);
}

/// Discourse 话题详情响应模型
@freezed
class DiscourseTopicDetailResponse with _$DiscourseTopicDetailResponse {
  const factory DiscourseTopicDetailResponse({
    @JsonKey(name: 'post_stream') DiscoursePostStream? postStream,
    @JsonKey(name: 'timeline_lookup') @Default([]) List<List<dynamic>> timelineLookup,
    @JsonKey(name: 'suggested_topics') @Default([]) List<DiscourseTopic> suggestedTopics,
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
    @JsonKey(name: 'pinned_at') String? pinnedAt,
    @JsonKey(name: 'details') DiscourseTopicDetails? details,
    @JsonKey(name: 'highest_post_number') int? highestPostNumber,
    @JsonKey(name: 'last_read_post_number') int? lastReadPostNumber,
    @JsonKey(name: 'deleted_by') Map<String, dynamic>? deletedBy,
    @JsonKey(name: 'actions_summary') @Default([]) List<Map<String, dynamic>> actionsSummary,
    @JsonKey(name: 'chunk_size') int? chunkSize,
    @JsonKey(name: 'bookmarked') bool? bookmarked,
    @JsonKey(name: 'topic_timer') Map<String, dynamic>? topicTimer,
    @JsonKey(name: 'message_bus_last_id') int? messageBusLastId,
    @JsonKey(name: 'participant_count') int? participantCount,
    @JsonKey(name: 'show_read_indicator') bool? showReadIndicator,
    @JsonKey(name: 'thumbnails') @Default([]) List<Map<String, dynamic>> thumbnails,
    @JsonKey(name: 'tags') @Default([]) List<String> tags,
    @JsonKey(name: 'tags_descriptions') Map<String, dynamic>? tagsDescriptions,
    @JsonKey(name: 'image_url') String? imageUrl,
  }) = _DiscourseTopicDetailResponse;

  factory DiscourseTopicDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$DiscourseTopicDetailResponseFromJson(json);
}

/// Discourse 帖子流模型
@freezed
class DiscoursePostStream with _$DiscoursePostStream {
  const factory DiscoursePostStream({
    @JsonKey(name: 'posts') @Default([]) List<DiscoursePost> posts,
    @JsonKey(name: 'stream') @Default([]) List<int> stream,
  }) = _DiscoursePostStream;

  factory DiscoursePostStream.fromJson(Map<String, dynamic> json) =>
      _$DiscoursePostStreamFromJson(json);
}

/// Discourse 帖子模型
@freezed
class DiscoursePost with _$DiscoursePost {
  const factory DiscoursePost({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'avatar_template') required String avatarTemplate,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'cooked') String? cooked,
    @JsonKey(name: 'raw') String? raw,
    @JsonKey(name: 'post_number') required int postNumber,
    @JsonKey(name: 'post_type') @Default(1) int postType,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'reply_count') @Default(0) int replyCount,
    @JsonKey(name: 'reply_to_post_number') int? replyToPostNumber,
    @JsonKey(name: 'quote_count') @Default(0) int quoteCount,
    @JsonKey(name: 'incoming_link_count') @Default(0) int incomingLinkCount,
    @JsonKey(name: 'reads') @Default(0) int reads,
    @JsonKey(name: 'like_count') @Default(0) int likeCount,
    @JsonKey(name: 'readers_count') @Default(0) int readersCount,
    @JsonKey(name: 'score') double? score,
    @JsonKey(name: 'yours') @Default(false) bool yours,
    @JsonKey(name: 'topic_id') required int topicId,
    @JsonKey(name: 'topic_slug') String? topicSlug,
    @JsonKey(name: 'display_username') String? displayUsername,
    @JsonKey(name: 'primary_group_name') String? primaryGroupName,
    @JsonKey(name: 'flair_name') String? flairName,
    @JsonKey(name: 'flair_url') String? flairUrl,
    @JsonKey(name: 'flair_bg_color') String? flairBgColor,
    @JsonKey(name: 'flair_color') String? flairColor,
    @JsonKey(name: 'version') @Default(1) int version,
    @JsonKey(name: 'can_edit') @Default(false) bool canEdit,
    @JsonKey(name: 'can_delete') @Default(false) bool canDelete,
    @JsonKey(name: 'can_recover') @Default(false) bool canRecover,
    @JsonKey(name: 'can_see_hidden_post') @Default(false) bool canSeeHiddenPost,
    @JsonKey(name: 'can_wiki') @Default(false) bool canWiki,
    @JsonKey(name: 'link_counts') @Default([]) List<Map<String, dynamic>> linkCounts,
    @JsonKey(name: 'actions_summary') @Default([]) List<Map<String, dynamic>> actionsSummary,
    @JsonKey(name: 'moderator') @Default(false) bool moderator,
    @JsonKey(name: 'admin') @Default(false) bool admin,
    @JsonKey(name: 'staff') @Default(false) bool staff,
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(name: 'hidden') @Default(false) bool hidden,
    @JsonKey(name: 'trust_level') @Default(0) int trustLevel,
    @JsonKey(name: 'deleted_at') String? deletedAt,
    @JsonKey(name: 'user_deleted') @Default(false) bool userDeleted,
    @JsonKey(name: 'edit_reason') String? editReason,
    @JsonKey(name: 'can_view_edit_history') @Default(false) bool canViewEditHistory,
    @JsonKey(name: 'wiki') @Default(false) bool wiki,
    @JsonKey(name: 'reviewable_id') int? reviewableId,
    @JsonKey(name: 'reviewable_score_count') int? reviewableScoreCount,
    @JsonKey(name: 'reviewable_score_pending_count') int? reviewableScorePendingCount,
    @JsonKey(name: 'mentioned_users') @Default([]) List<Map<String, dynamic>> mentionedUsers,
    @JsonKey(name: 'reactions') @Default([]) List<Map<String, dynamic>> reactions,
    @JsonKey(name: 'current_user_reaction') Map<String, dynamic>? currentUserReaction,
    @JsonKey(name: 'reaction_users_count') int? reactionUsersCount,
    @JsonKey(name: 'bookmarked') @Default(false) bool bookmarked,
    @JsonKey(name: 'bookmarked_at') String? bookmarkedAt,
  }) = _DiscoursePost;

  factory DiscoursePost.fromJson(Map<String, dynamic> json) =>
      _$DiscoursePostFromJson(json);
}

/// Discourse 话题详情模型
@freezed
class DiscourseTopicDetails with _$DiscourseTopicDetails {
  const factory DiscourseTopicDetails({
    @JsonKey(name: 'notification_level') int? notificationLevel,
    @JsonKey(name: 'notifications_reason_id') int? notificationsReasonId,
    @JsonKey(name: 'can_move_posts') bool? canMovePosts,
    @JsonKey(name: 'can_edit') bool? canEdit,
    @JsonKey(name: 'can_delete') bool? canDelete,
    @JsonKey(name: 'can_remove_allowed_users') bool? canRemoveAllowedUsers,
    @JsonKey(name: 'can_invite_to') bool? canInviteTo,
    @JsonKey(name: 'can_invite_via_email') bool? canInviteViaEmail,
    @JsonKey(name: 'can_create_post') bool? canCreatePost,
    @JsonKey(name: 'can_reply_as_new_topic') bool? canReplyAsNewTopic,
    @JsonKey(name: 'can_flag_topic') bool? canFlagTopic,
    @JsonKey(name: 'can_convert_topic') bool? canConvertTopic,
    @JsonKey(name: 'can_review_topic') bool? canReviewTopic,
    @JsonKey(name: 'can_close_topic') bool? canCloseTopic,
    @JsonKey(name: 'can_archive_topic') bool? canArchiveTopic,
    @JsonKey(name: 'can_split_merge_topic') bool? canSplitMergeTopic,
    @JsonKey(name: 'can_edit_staff_notes') bool? canEditStaffNotes,
    @JsonKey(name: 'can_toggle_topic_visibility') bool? canToggleTopicVisibility,
    @JsonKey(name: 'can_pin_unpin_topic') bool? canPinUnpinTopic,
    @JsonKey(name: 'can_moderate_category') bool? canModerateCategory,
    @JsonKey(name: 'can_remove_self_id') int? canRemoveSelfId,
    @JsonKey(name: 'participants') @Default([]) List<DiscourseParticipant> participants,
    @JsonKey(name: 'created_by') DiscourseCreatedBy? createdBy,
    @JsonKey(name: 'last_poster') DiscourseCreatedBy? lastPoster,
    @JsonKey(name: 'allowed_users') @Default([]) List<DiscourseUserBasic> allowedUsers,
    @JsonKey(name: 'allowed_groups') @Default([]) List<Map<String, dynamic>> allowedGroups,
  }) = _DiscourseTopicDetails;

  factory DiscourseTopicDetails.fromJson(Map<String, dynamic> json) =>
      _$DiscourseTopicDetailsFromJson(json);
}

/// Discourse 创建者模型
@freezed
class DiscourseCreatedBy with _$DiscourseCreatedBy {
  const factory DiscourseCreatedBy({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') required String avatarTemplate,
  }) = _DiscourseCreatedBy;

  factory DiscourseCreatedBy.fromJson(Map<String, dynamic> json) =>
      _$DiscourseCreatedByFromJson(json);
}
