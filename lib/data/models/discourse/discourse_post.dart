import 'package:freezed_annotation/freezed_annotation.dart';

part 'discourse_post.freezed.dart';
part 'discourse_post.g.dart';

/// Discourse 帖子模型
///
/// 用于接收 Discourse API 返回的帖子（回复）数据
@freezed
class DiscoursePost with _$DiscoursePost {
  /// 构造函数
  ///
  /// [id] 帖子ID
  /// [name] 发帖者姓名
  /// [username] 用户名
  /// [avatarTemplate] 头像URL模板
  /// [createdAt] 创建时间
  /// [cooked] HTML格式的帖子内容
  /// [raw] 原始文本内容
  /// [postNumber] 帖子编号（楼层号）
  /// [postType] 帖子类型（1为普通帖子）
  /// [updatedAt] 更新时间
  /// [replyCount] 回复数量
  /// [replyToPostNumber] 回复的目标帖子编号
  /// [quoteCount] 引用数量
  /// [incomingLinkCount] 外部链接数量
  /// [reads] 阅读次数
  /// [likeCount] 点赞数量
  /// [readersCount] 阅读者数量
  /// [score] 分数
  /// [yours] 是否为当前用户发帖
  /// [topicId] 所属话题ID
  /// [topicSlug] 所属话题URL别名
  /// [displayUsername] 显示的用户名
  /// [primaryGroupName] 主要用户组名称
  /// [flairName] 徽章名称
  /// [flairUrl] 徽章URL
  /// [flairBgColor] 徽章背景色
  /// [flairColor] 徽章颜色
  /// [version] 版本号
  /// [canEdit] 是否可编辑
  /// [canDelete] 是否可删除
  /// [canRecover] 是否可恢复
  /// [canSeeHiddenPost] 是否可见已删帖
  /// [canWiki] 是否可设为Wiki
  /// [linkCounts] 链接统计
  /// [actionsSummary] 操作统计
  /// [moderator] 是否版主
  /// [admin] 是否管理员
  /// [staff] 是否员工
  /// [userId] 用户ID
  /// [hidden] 是否隐藏
  /// [trustLevel] 信任等级
  /// [deletedAt] 删除时间
  /// [userDeleted] 用户是否已删除
  /// [editReason] 编辑原因
  /// [canViewEditHistory] 是否可查看编辑历史
  /// [wiki] 是否为Wiki帖
  /// [reviewableId] 审核ID
  /// [reviewableScoreCount] 审核分数统计
  /// [reviewableScorePendingCount] 待审核分数数量
  /// [mentionedUsers] 提及的用户列表
  /// [reactions] 反应列表
  /// [currentUserReaction] 当前用户反应
  /// [reactionUsersCount] 反应用户数量
  /// [bookmarked] 是否收藏
  /// [bookmarkedAt] 收藏时间
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

  /// 从JSON解析帖子对象
  ///
  /// [json] JSON数据
  /// @return DiscoursePost实例
  factory DiscoursePost.fromJson(Map<String, dynamic> json) =>
      _$DiscoursePostFromJson(json);
}

/// Discourse 帖子流模型
///
/// 用于话题详情中的帖子列表
@freezed
class DiscoursePostStream with _$DiscoursePostStream {
  /// 构造函数
  ///
  /// [posts] 帖子列表
  /// [stream] 帖子ID流
  const factory DiscoursePostStream({
    @JsonKey(name: 'posts') @Default([]) List<DiscoursePost> posts,
    @JsonKey(name: 'stream') @Default([]) List<int> stream,
  }) = _DiscoursePostStream;

  /// 从JSON解析帖子流对象
  ///
  /// [json] JSON数据
  /// @return DiscoursePostStream实例
  factory DiscoursePostStream.fromJson(Map<String, dynamic> json) =>
      _$DiscoursePostStreamFromJson(json);
}

/// Discourse 帖子列表响应模型
@freezed
class DiscoursePostListResponse with _$DiscoursePostListResponse {
  const factory DiscoursePostListResponse({
    @JsonKey(name: 'post_stream') DiscoursePostStream? postStream,
    @JsonKey(name: 'timeline_lookup') @Default([]) List<List<dynamic>> timelineLookup,
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
  }) = _DiscoursePostListResponse;

  factory DiscoursePostListResponse.fromJson(Map<String, dynamic> json) =>
      _$DiscoursePostListResponseFromJson(json);
}