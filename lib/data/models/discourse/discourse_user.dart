import 'package:freezed_annotation/freezed_annotation.dart';

part 'discourse_user.freezed.dart';
part 'discourse_user.g.dart';

/// Discourse 用户详情模型
///
/// 用于接收 Discourse API 返回的用户详情数据
@freezed
class DiscourseUser with _$DiscourseUser {
  /// 构造函数
  ///
  /// [id] 用户ID
  /// [username] 用户名
  /// [name] 显示名称
  /// [avatarTemplate] 头像URL模板
  /// [email] 邮箱
  /// [secondaryEmails] 备用邮箱列表
  /// [unconfirmedEmails] 未确认邮箱列表
  /// [lastPostedAt] 最后发帖时间
  /// [lastSeenAt] 最后访问时间
  /// [createdAt] 创建时间
  /// [ignored] 是否被忽略
  /// [muted] 是否被静音
  /// [canIgnoreUser] 是否可以忽略该用户
  /// [canMuteUser] 是否可以静音该用户
  /// [canSendPrivateMessages] 是否可以发送私信
  /// [canSendPrivateMessageToUser] 是否可以给该用户发私信
  /// [trustLevel] 信任等级
  /// [moderator] 是否版主
  /// [admin] 是否管理员
  /// [title] 头衔
  /// [badgeCount] 徽章数量
  /// [userAuthTokens] 用户认证令牌
  /// [userNotificationSchedule] 用户通知计划
  /// [featuredTopic] 精选话题
  /// [timezone] 时区
  /// [profileHidden] 资料是否隐藏
  /// [canBeDeleted] 是否可以被删除
  /// [canDeleteAllPosts] 是否可以删除所有帖子
  /// [locale] 语言设置
  /// [mutedCategoryIds] 静音的分类ID列表
  /// [regularCategoryIds] 常规分类ID列表
  /// [watchedTags] 关注的标签
  /// [watchingFirstPostTags] 关注首帖的标签
  /// [trackedTags] 跟踪的标签
  /// [mutedTags] 静音的标签
  /// [trackedCategoryIds] 跟踪的分类ID列表
  /// [watchedCategoryIds] 关注的分类ID列表
  /// [watchedFirstPostCategoryIds] 关注首帖的分类ID列表
  /// [systemAvatarTemplate] 系统头像模板
  /// [mutedUsernames] 静音的用户名列表
  /// [ignoredUsernames] 忽略的用户名列表
  /// [allowedPmUsernames] 允许私信的用户名列表
  /// [mailingListPostsPerDay] 每日邮件列表帖子数
  /// [canChangeBio] 是否可以修改简介
  /// [canChangeLocation] 是否可以修改位置
  /// [canChangeWebsite] 是否可以修改网站
  /// [canChangeTrackingPreferences] 是否可以修改跟踪偏好
  /// [userApiKeys] 用户API密钥
  /// [userStatus] 用户状态
  /// [sidebarTags] 侧边栏标签
  /// [sidebarCategoryIds] 侧边栏分类ID
  /// [displaySidebarTags] 是否显示侧边栏标签
  /// [sidebarListDestination] 侧边栏列表目标
  const factory DiscourseUser({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') required String avatarTemplate,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'secondary_emails') @Default([]) List<String> secondaryEmails,
    @JsonKey(name: 'unconfirmed_emails') @Default([]) List<String> unconfirmedEmails,
    @JsonKey(name: 'last_posted_at') String? lastPostedAt,
    @JsonKey(name: 'last_seen_at') String? lastSeenAt,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'ignored') @Default(false) bool ignored,
    @JsonKey(name: 'muted') @Default(false) bool muted,
    @JsonKey(name: 'can_ignore_user') @Default(false) bool canIgnoreUser,
    @JsonKey(name: 'can_mute_user') @Default(false) bool canMuteUser,
    @JsonKey(name: 'can_send_private_messages') @Default(false) bool canSendPrivateMessages,
    @JsonKey(name: 'can_send_private_message_to_user') @Default(false) bool canSendPrivateMessageToUser,
    @JsonKey(name: 'trust_level') @Default(0) int trustLevel,
    @JsonKey(name: 'moderator') @Default(false) bool moderator,
    @JsonKey(name: 'admin') @Default(false) bool admin,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'badge_count') @Default(0) int badgeCount,
    @JsonKey(name: 'user_auth_tokens') @Default([]) List<dynamic> userAuthTokens,
    @JsonKey(name: 'user_notification_schedule') Map<String, dynamic>? userNotificationSchedule,
    @JsonKey(name: 'featured_topic') Map<String, dynamic>? featuredTopic,
    @JsonKey(name: 'timezone') String? timezone,
    @JsonKey(name: 'profile_hidden') @Default(false) bool profileHidden,
    @JsonKey(name: 'can_be_deleted') @Default(false) bool canBeDeleted,
    @JsonKey(name: 'can_delete_all_posts') @Default(false) bool canDeleteAllPosts,
    @JsonKey(name: 'locale') String? locale,
    @JsonKey(name: 'muted_category_ids') @Default([]) List<int> mutedCategoryIds,
    @JsonKey(name: 'regular_category_ids') @Default([]) List<int> regularCategoryIds,
    @JsonKey(name: 'watched_tags') @Default([]) List<String> watchedTags,
    @JsonKey(name: 'watching_first_post_tags') @Default([]) List<String> watchingFirstPostTags,
    @JsonKey(name: 'tracked_tags') @Default([]) List<String> trackedTags,
    @JsonKey(name: 'muted_tags') @Default([]) List<String> mutedTags,
    @JsonKey(name: 'tracked_category_ids') @Default([]) List<int> trackedCategoryIds,
    @JsonKey(name: 'watched_category_ids') @Default([]) List<int> watchedCategoryIds,
    @JsonKey(name: 'watched_first_post_category_ids') @Default([]) List<int> watchedFirstPostCategoryIds,
    @JsonKey(name: 'system_avatar_template') String? systemAvatarTemplate,
    @JsonKey(name: 'muted_usernames') @Default([]) List<String> mutedUsernames,
    @JsonKey(name: 'ignored_usernames') @Default([]) List<String> ignoredUsernames,
    @JsonKey(name: 'allowed_pm_usernames') @Default([]) List<String> allowedPmUsernames,
    @JsonKey(name: 'mailing_list_posts_per_day') int? mailingListPostsPerDay,
    @JsonKey(name: 'can_change_bio') @Default(false) bool canChangeBio,
    @JsonKey(name: 'can_change_location') @Default(false) bool canChangeLocation,
    @JsonKey(name: 'can_change_website') @Default(false) bool canChangeWebsite,
    @JsonKey(name: 'can_change_tracking_preferences') @Default(false) bool canChangeTrackingPreferences,
    @JsonKey(name: 'user_api_keys') @Default([]) List<dynamic> userApiKeys,
    @JsonKey(name: 'user_status') Map<String, dynamic>? userStatus,
    @JsonKey(name: 'sidebar_tags') @Default([]) List<dynamic> sidebarTags,
    @JsonKey(name: 'sidebar_category_ids') @Default([]) List<int> sidebarCategoryIds,
    @JsonKey(name: 'display_sidebar_tags') @Default(false) bool displaySidebarTags,
    @JsonKey(name: 'sidebar_list_destination') String? sidebarListDestination,
  }) = _DiscourseUser;

  /// 从JSON解析用户对象
  ///
  /// [json] JSON数据
  /// @return DiscourseUser实例
  factory DiscourseUser.fromJson(Map<String, dynamic> json) =>
      _$DiscourseUserFromJson(json);
}

/// Discourse 用户响应模型
@freezed
class DiscourseUserResponse with _$DiscourseUserResponse {
  const factory DiscourseUserResponse({
    @JsonKey(name: 'user_badges') @Default([]) List<dynamic> userBadges,
    @JsonKey(name: 'badges') @Default([]) List<DiscourseBadge> badges,
    @JsonKey(name: 'badge_types') @Default([]) List<DiscourseBadgeType> badgeTypes,
    @JsonKey(name: 'users') @Default([]) List<DiscourseUserBasicInfo> users,
    @JsonKey(name: 'user') DiscourseUser? user,
  }) = _DiscourseUserResponse;

  factory DiscourseUserResponse.fromJson(Map<String, dynamic> json) =>
      _$DiscourseUserResponseFromJson(json);
}

/// Discourse 徽章模型
@freezed
class DiscourseBadge with _$DiscourseBadge {
  const factory DiscourseBadge({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'grant_count') @Default(0) int grantCount,
    @JsonKey(name: 'allow_title') @Default(false) bool allowTitle,
    @JsonKey(name: 'multiple_grant') @Default(false) bool multipleGrant,
    @JsonKey(name: 'icon') String? icon,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'listable') @Default(true) bool listable,
    @JsonKey(name: 'enabled') @Default(true) bool enabled,
    @JsonKey(name: 'badge_grouping_id') int? badgeGroupingId,
    @JsonKey(name: 'system') @Default(false) bool system,
    @JsonKey(name: 'slug') required String slug,
    @JsonKey(name: 'manually_grantable') @Default(false) bool manuallyGrantable,
    @JsonKey(name: 'badge_type_id') int? badgeTypeId,
  }) = _DiscourseBadge;

  factory DiscourseBadge.fromJson(Map<String, dynamic> json) =>
      _$DiscourseBadgeFromJson(json);
}

/// Discourse 徽章类型模型
@freezed
class DiscourseBadgeType with _$DiscourseBadgeType {
  const factory DiscourseBadgeType({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
  }) = _DiscourseBadgeType;

  factory DiscourseBadgeType.fromJson(Map<String, dynamic> json) =>
      _$DiscourseBadgeTypeFromJson(json);
}

/// Discourse 用户基本信息模型（用于用户列表）
@freezed
class DiscourseUserBasicInfo with _$DiscourseUserBasicInfo {
  const factory DiscourseUserBasicInfo({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') required String avatarTemplate,
    @JsonKey(name: 'admin') @Default(false) bool admin,
    @JsonKey(name: 'moderator') @Default(false) bool moderator,
    @JsonKey(name: 'trust_level') @Default(1) int trustLevel,
  }) = _DiscourseUserBasicInfo;

  factory DiscourseUserBasicInfo.fromJson(Map<String, dynamic> json) =>
      _$DiscourseUserBasicInfoFromJson(json);
}

/// Discourse 用户摘要响应模型
@freezed
class DiscourseUserSummaryResponse with _$DiscourseUserSummaryResponse {
  const factory DiscourseUserSummaryResponse({
    @JsonKey(name: 'user_summary') DiscourseUserSummary? userSummary,
    @JsonKey(name: 'badges') @Default([]) List<DiscourseBadge> badges,
    @JsonKey(name: 'badge_types') @Default([]) List<DiscourseBadgeType> badgeTypes,
    @JsonKey(name: 'users') @Default([]) List<DiscourseUserBasicInfo> users,
  }) = _DiscourseUserSummaryResponse;

  factory DiscourseUserSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$DiscourseUserSummaryResponseFromJson(json);
}

/// Discourse 用户摘要模型
@freezed
class DiscourseUserSummary with _$DiscourseUserSummary {
  const factory DiscourseUserSummary({
    @JsonKey(name: 'likes_given') @Default(0) int likesGiven,
    @JsonKey(name: 'likes_received') @Default(0) int likesReceived,
    @JsonKey(name: 'topics_entered') @Default(0) int topicsEntered,
    @JsonKey(name: 'topic_count') @Default(0) int topicCount,
    @JsonKey(name: 'post_count') @Default(0) int postCount,
    @JsonKey(name: 'posts_read_count') @Default(0) int postsReadCount,
    @JsonKey(name: 'days_visited') @Default(0) int daysVisited,
    @JsonKey(name: 'solved_count') @Default(0) int solvedCount,
    @JsonKey(name: 'topic_ids') @Default([]) List<int> topicIds,
    @JsonKey(name: 'replies') @Default([]) List<DiscourseUserSummaryItem> replies,
    @JsonKey(name: 'links') @Default([]) List<DiscourseUserSummaryItem> links,
    @JsonKey(name: 'most_replied_to_users') @Default([]) List<DiscourseUserSummaryUser> mostRepliedToUsers,
    @JsonKey(name: 'most_liked_by_users') @Default([]) List<DiscourseUserSummaryUser> mostLikedByUsers,
    @JsonKey(name: 'most_liked_users') @Default([]) List<DiscourseUserSummaryUser> mostLikedUsers,
    @JsonKey(name: 'badges') @Default([]) List<DiscourseUserBadge> badges,
    @JsonKey(name: 'top_categories') @Default([]) List<DiscourseUserCategory> topCategories,
  }) = _DiscourseUserSummary;

  factory DiscourseUserSummary.fromJson(Map<String, dynamic> json) =>
      _$DiscourseUserSummaryFromJson(json);
}

/// Discourse 用户摘要条目模型
@freezed
class DiscourseUserSummaryItem with _$DiscourseUserSummaryItem {
  const factory DiscourseUserSummaryItem({
    @JsonKey(name: 'post_id') int? postId,
    @JsonKey(name: 'topic_id') int? topicId,
    @JsonKey(name: 'topic_title') String? topicTitle,
    @JsonKey(name: 'topic_slug') String? topicSlug,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'title') String? title,
  }) = _DiscourseUserSummaryItem;

  factory DiscourseUserSummaryItem.fromJson(Map<String, dynamic> json) =>
      _$DiscourseUserSummaryItemFromJson(json);
}

/// Discourse 用户摘要用户模型
@freezed
class DiscourseUserSummaryUser with _$DiscourseUserSummaryUser {
  const factory DiscourseUserSummaryUser({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') required String avatarTemplate,
    @JsonKey(name: 'count') @Default(0) int count,
    @JsonKey(name: 'post_number') int? postNumber,
  }) = _DiscourseUserSummaryUser;

  factory DiscourseUserSummaryUser.fromJson(Map<String, dynamic> json) =>
      _$DiscourseUserSummaryUserFromJson(json);
}

/// Discourse 用户徽章模型
@freezed
class DiscourseUserBadge with _$DiscourseUserBadge {
  const factory DiscourseUserBadge({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'granted_at') required String grantedAt,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'count') @Default(0) int count,
    @JsonKey(name: 'badge_id') required int badgeId,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'granted_by_id') int? grantedById,
  }) = _DiscourseUserBadge;

  factory DiscourseUserBadge.fromJson(Map<String, dynamic> json) =>
      _$DiscourseUserBadgeFromJson(json);
}

/// Discourse 用户分类统计模型
@freezed
class DiscourseUserCategory with _$DiscourseUserCategory {
  const factory DiscourseUserCategory({
    @JsonKey(name: 'topic_id') int? topicId,
    @JsonKey(name: 'topic_count') @Default(0) int topicCount,
    @JsonKey(name: 'post_count') @Default(0) int postCount,
    @JsonKey(name: 'category_id') required int categoryId,
    @JsonKey(name: 'category_name') required String categoryName,
    @JsonKey(name: 'category_slug') required String categorySlug,
    @JsonKey(name: 'category_color') required String categoryColor,
    @JsonKey(name: 'category_text_color') required String categoryTextColor,
  }) = _DiscourseUserCategory;

  factory DiscourseUserCategory.fromJson(Map<String, dynamic> json) =>
      _$DiscourseUserCategoryFromJson(json);
}
