import 'package:freezed_annotation/freezed_annotation.dart';

part 'discourse_notification.freezed.dart';
part 'discourse_notification.g.dart';

/// Discourse 通知模型
/// 对应 TRAE 论坛通知 API 的数据结构

/// 通知列表响应模型
@freezed
class DiscourseNotificationResponse with _$DiscourseNotificationResponse {
  const factory DiscourseNotificationResponse({
    @JsonKey(name: 'notifications') @Default([]) List<DiscourseNotification> notifications,
    @JsonKey(name: 'seen_notification_id') @Default(0) int seenNotificationId,
    @JsonKey(name: 'total_rows_notifications') @Default(0) int totalRows,
  }) = _DiscourseNotificationResponse;

  factory DiscourseNotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$DiscourseNotificationResponseFromJson(json);
}

/// 单条通知数据模型
@freezed
class DiscourseNotification with _$DiscourseNotification {
  const factory DiscourseNotification({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'notification_type') required int notificationType,
    @JsonKey(name: 'read') @Default(false) bool read,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'post_number') int? postNumber,
    @JsonKey(name: 'topic_id') int? topicId,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'data') NotificationData? data,
    @JsonKey(name: 'fancy_title') String? fancyTitle,
    @JsonKey(name: 'topic_title') String? topicTitle,
    @JsonKey(name: 'display_username') String? displayUsername,
    @JsonKey(name: 'acting_user_id') int? actingUserId,
    @JsonKey(name: 'acting_user_avatar_template') String? actingUserAvatarTemplate,
    @JsonKey(name: 'acting_user_name') String? actingUserName,
  }) = _DiscourseNotification;

  factory DiscourseNotification.fromJson(Map<String, dynamic> json) =>
      _$DiscourseNotificationFromJson(json);
}

/// 通知附加数据模型
@freezed
class NotificationData with _$NotificationData {
  const factory NotificationData({
    @JsonKey(name: 'topic_title') String? topicTitle,
    @JsonKey(name: 'original_post_id') int? originalPostId,
    @JsonKey(name: 'original_post_type') int? originalPostType,
    @JsonKey(name: 'original_username') String? originalUsername,
    @JsonKey(name: 'revision_number') int? revisionNumber,
    @JsonKey(name: 'display_username') String? displayUsername,
    @JsonKey(name: 'count') int? count,
    @JsonKey(name: 'badge_id') int? badgeId,
    @JsonKey(name: 'badge_name') String? badgeName,
    @JsonKey(name: 'badge_slug') String? badgeSlug,
    @JsonKey(name: 'badge_title') String? badgeTitle,
    @JsonKey(name: 'message') String? message,
    @JsonKey(name: 'chat_channel_id') int? chatChannelId,
    @JsonKey(name: 'chat_message_id') int? chatMessageId,
    @JsonKey(name: 'chat_thread_id') int? chatThreadId,
    @JsonKey(name: 'chat_thread_title') String? chatThreadTitle,
    @JsonKey(name: 'mentioned_by_username') String? mentionedByUsername,
  }) = _NotificationData;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);
}

/// 通知类型枚举
/// 对应 Discourse 的通知类型 ID
class DiscourseNotificationType {
  /// 被提及 (@)
  static const int mentioned = 1;
  
  /// 被群组提及
  static const int groupMentioned = 2;
  
  /// 有新回复
  static const int posted = 3;
  
  /// 被引用
  static const int quoted = 4;
  
  /// 被回复
  static const int replied = 5;
  
  /// 被点赞
  static const int liked = 6;
  
  /// 被点赞（合并）
  static const int likedConsolidated = 7;
  
  /// 表情回应
  static const int reaction = 8;
  
  /// 帖子被编辑
  static const int edited = 9;
  
  /// 被邀请加入私信
  static const int invitedToPrivateMessage = 10;
  
  /// 邀请被接受
  static const int inviteeAccepted = 11;
  
  /// 帖子被移动
  static const int movedPost = 12;
  
  /// 被链接
  static const int linked = 13;
  
  /// 获得徽章
  static const int grantedBadge = 14;
  
  /// 被邀请参与话题
  static const int invitedToTopic = 15;
  
  /// 自定义通知
  static const int custom = 16;
  
  /// 关注的首帖
  static const int watchingFirstPost = 17;
  
  /// 话题提醒
  static const int topicReminder = 18;
  
  /// 帖子被批准
  static const int postApproved = 19;
  
  /// 代码审查提交被批准
  static const int codeReviewCommitApproved = 20;
  
  /// 成员请求被接受
  static const int membershipRequestAccepted = 21;
  
  /// 成员请求合并
  static const int membershipRequestConsolidated = 22;
  
  /// 投票释放
  static const int votesReleased = 23;
  
  /// 事件提醒
  static const int eventReminder = 24;
  
  /// 事件邀请
  static const int eventInvitation = 25;
  
  /// 聊天邀请
  static const int chatInvitation = 26;
  
  /// 聊天中被提及
  static const int chatMention = 27;
  
  /// 聊天消息
  static const int chatMessage = 28;
  
  /// 聊天中被引用
  static const int chatQuoted = 29;
  
  /// 关注的聊天线程
  static const int chatWatchedThread = 30;
  
  /// 聊天群组提及
  static const int chatGroupMention = 31;
  
  /// 被分配
  static const int assigned = 32;
  
  /// 问答用户评论
  static const int questionAnswerUserCommented = 33;
  
  /// 关注分类或标签
  static const int watchingCategoryOrTag = 34;
  
  /// 新功能
  static const int newFeatures = 35;
  
  /// 管理员问题
  static const int adminProblems = 36;
  
  /// 被链接（合并）
  static const int linkedConsolidated = 37;
  
  /// 即将可用的变更
  static const int upcomingChangeAvailable = 38;
  
  /// 自动升级的变更
  static const int upcomingChangeAutomaticallyPromoted = 39;
  
  /// 被关注
  static const int following = 40;
  
  /// 关注者创建话题
  static const int followingCreatedTopic = 41;
  
  /// 关注者回复
  static const int followingReplied = 42;
  
  /// 圈子活动
  static const int circlesActivity = 43;

  /// 获取通知类型名称
  static String getTypeName(int type) {
    switch (type) {
      case mentioned:
        return '提及';
      case groupMentioned:
        return '群组提及';
      case posted:
        return '新回复';
      case quoted:
        return '引用';
      case replied:
        return '回复';
      case liked:
      case likedConsolidated:
        return '点赞';
      case reaction:
        return '回应';
      case edited:
        return '编辑';
      case invitedToPrivateMessage:
        return '私信邀请';
      case inviteeAccepted:
        return '邀请接受';
      case movedPost:
        return '移动帖子';
      case linked:
      case linkedConsolidated:
        return '链接';
      case grantedBadge:
        return '徽章';
      case invitedToTopic:
        return '话题邀请';
      case custom:
        return '自定义';
      case watchingFirstPost:
        return '首帖';
      case topicReminder:
        return '提醒';
      case postApproved:
        return '已批准';
      case membershipRequestAccepted:
        return '成员请求';
      case votesReleased:
        return '投票';
      case eventReminder:
        return '事件提醒';
      case eventInvitation:
        return '事件邀请';
      case chatInvitation:
        return '聊天邀请';
      case chatMention:
        return '聊天提及';
      case chatMessage:
        return '聊天消息';
      case chatQuoted:
        return '聊天引用';
      case chatWatchedThread:
        return '聊天线程';
      case chatGroupMention:
        return '聊天群组提及';
      case assigned:
        return '分配';
      case following:
        return '关注';
      case followingCreatedTopic:
        return '关注者话题';
      case followingReplied:
        return '关注者回复';
      default:
        return '通知';
    }
  }

  /// 获取通知类型图标
  static String getTypeIcon(int type) {
    switch (type) {
      case mentioned:
      case groupMentioned:
      case chatMention:
      case chatGroupMention:
        return 'alternate_email';
      case posted:
      case replied:
      case questionAnswerUserCommented:
      case followingReplied:
        return 'comment';
      case quoted:
      case chatQuoted:
        return 'format_quote';
      case liked:
      case likedConsolidated:
        return 'favorite';
      case reaction:
        return 'emoji_emotions';
      case edited:
        return 'edit';
      case invitedToPrivateMessage:
      case inviteeAccepted:
      case invitedToTopic:
      case eventInvitation:
      case chatInvitation:
        return 'mail';
      case movedPost:
        return 'move';
      case linked:
      case linkedConsolidated:
        return 'link';
      case grantedBadge:
        return 'emoji_events';
      case custom:
        return 'notifications';
      case watchingFirstPost:
      case watchingCategoryOrTag:
        return 'visibility';
      case topicReminder:
      case eventReminder:
        return 'alarm';
      case postApproved:
      case codeReviewCommitApproved:
        return 'check_circle';
      case membershipRequestAccepted:
        return 'person_add';
      case votesReleased:
        return 'how_to_vote';
      case chatMessage:
      case chatWatchedThread:
        return 'chat';
      case assigned:
        return 'assignment_ind';
      case following:
      case followingCreatedTopic:
        return 'person';
      case newFeatures:
        return 'new_releases';
      case adminProblems:
        return 'warning';
      default:
        return 'notifications';
    }
  }

  /// 获取通知类型颜色
  static String getTypeColor(int type) {
    switch (type) {
      case liked:
      case likedConsolidated:
      case reaction:
        return '#E91E63'; // 粉色
      case mentioned:
      case groupMentioned:
      case chatMention:
        return '#2196F3'; // 蓝色
      case replied:
      case posted:
      case questionAnswerUserCommented:
        return '#4CAF50'; // 绿色
      case grantedBadge:
        return '#FF9800'; // 橙色
      case following:
      case followingCreatedTopic:
      case followingReplied:
        return '#9C27B0'; // 紫色
      default:
        return '#757575'; // 灰色
    }
  }
}

/// 通知筛选类型
enum NotificationFilterType {
  /// 所有通知
  all,
  
  /// 回复相关（提及、引用、回复）
  replies,
  
  /// 点赞相关
  likes,
  
  /// 私信相关
  messages,
  
  /// 书签相关
  bookmarks,
  
  /// 聊天相关
  chat,
  
  /// 其他通知
  others,
}

/// 通知筛选类型扩展
extension NotificationFilterTypeExtension on NotificationFilterType {
  /// 获取显示名称
  String get displayName {
    switch (this) {
      case NotificationFilterType.all:
        return '全部';
      case NotificationFilterType.replies:
        return '回复';
      case NotificationFilterType.likes:
        return '赞';
      case NotificationFilterType.messages:
        return '私信';
      case NotificationFilterType.bookmarks:
        return '书签';
      case NotificationFilterType.chat:
        return '聊天';
      case NotificationFilterType.others:
        return '其他';
    }
  }

  /// 获取对应的 API 筛选参数
  String? get filterParam {
    switch (this) {
      case NotificationFilterType.all:
        return null;
      case NotificationFilterType.replies:
        return 'mentioned,group_mentioned,posted,quoted,replied';
      case NotificationFilterType.likes:
        return 'liked,liked_consolidated,reaction';
      case NotificationFilterType.messages:
        return null; // 使用单独的 API
      case NotificationFilterType.bookmarks:
        return null; // 使用单独的 API
      case NotificationFilterType.chat:
        return 'chat_invitation,chat_mention,chat_message,chat_quoted,chat_watched_thread';
      case NotificationFilterType.others:
        return 'edited,invited_to_private_message,invitee_accepted,moved_post,linked,granted_badge,invited_to_topic,custom,watching_first_post,topic_reminder,post_approved';
    }
  }
}
