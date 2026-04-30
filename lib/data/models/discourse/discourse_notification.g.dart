// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discourse_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiscourseNotificationResponseImpl
_$$DiscourseNotificationResponseImplFromJson(Map<String, dynamic> json) =>
    _$DiscourseNotificationResponseImpl(
      notifications:
          (json['notifications'] as List<dynamic>?)
              ?.map(
                (e) =>
                    DiscourseNotification.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      seenNotificationId: (json['seen_notification_id'] as num?)?.toInt() ?? 0,
      totalRows: (json['total_rows_notifications'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DiscourseNotificationResponseImplToJson(
  _$DiscourseNotificationResponseImpl instance,
) => <String, dynamic>{
  'notifications': instance.notifications,
  'seen_notification_id': instance.seenNotificationId,
  'total_rows_notifications': instance.totalRows,
};

_$DiscourseNotificationImpl _$$DiscourseNotificationImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseNotificationImpl(
  id: (json['id'] as num).toInt(),
  notificationType: (json['notification_type'] as num).toInt(),
  read: json['read'] == null ? false : _parseBool(json['read']),
  createdAt: json['created_at'] as String?,
  postNumber: (json['post_number'] as num?)?.toInt(),
  topicId: (json['topic_id'] as num?)?.toInt(),
  slug: json['slug'] as String?,
  data: json['data'] == null
      ? null
      : NotificationData.fromJson(json['data'] as Map<String, dynamic>),
  fancyTitle: json['fancy_title'] as String?,
  topicTitle: json['topic_title'] as String?,
  displayUsername: json['display_username'] as String?,
  actingUserId: (json['acting_user_id'] as num?)?.toInt(),
  actingUserAvatarTemplate: json['acting_user_avatar_template'] as String?,
  actingUserName: json['acting_user_name'] as String?,
);

Map<String, dynamic> _$$DiscourseNotificationImplToJson(
  _$DiscourseNotificationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'notification_type': instance.notificationType,
  'read': instance.read,
  'created_at': instance.createdAt,
  'post_number': instance.postNumber,
  'topic_id': instance.topicId,
  'slug': instance.slug,
  'data': instance.data,
  'fancy_title': instance.fancyTitle,
  'topic_title': instance.topicTitle,
  'display_username': instance.displayUsername,
  'acting_user_id': instance.actingUserId,
  'acting_user_avatar_template': instance.actingUserAvatarTemplate,
  'acting_user_name': instance.actingUserName,
};

_$NotificationDataImpl _$$NotificationDataImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationDataImpl(
  topicTitle: json['topic_title'] as String?,
  originalPostId: (json['original_post_id'] as num?)?.toInt(),
  originalPostType: (json['original_post_type'] as num?)?.toInt(),
  originalUsername: json['original_username'] as String?,
  revisionNumber: (json['revision_number'] as num?)?.toInt(),
  displayUsername: json['display_username'] as String?,
  count: (json['count'] as num?)?.toInt(),
  badgeId: (json['badge_id'] as num?)?.toInt(),
  badgeName: json['badge_name'] as String?,
  badgeSlug: json['badge_slug'] as String?,
  badgeTitle: _parseString(json['badge_title']),
  message: json['message'] as String?,
  chatChannelId: (json['chat_channel_id'] as num?)?.toInt(),
  chatMessageId: (json['chat_message_id'] as num?)?.toInt(),
  chatThreadId: (json['chat_thread_id'] as num?)?.toInt(),
  chatThreadTitle: json['chat_thread_title'] as String?,
  mentionedByUsername: json['mentioned_by_username'] as String?,
  movedToTopicId: (json['moved_to_topic_id'] as num?)?.toInt(),
  movedToPostNumber: (json['moved_to_post_number'] as num?)?.toInt(),
);

Map<String, dynamic> _$$NotificationDataImplToJson(
  _$NotificationDataImpl instance,
) => <String, dynamic>{
  'topic_title': instance.topicTitle,
  'original_post_id': instance.originalPostId,
  'original_post_type': instance.originalPostType,
  'original_username': instance.originalUsername,
  'revision_number': instance.revisionNumber,
  'display_username': instance.displayUsername,
  'count': instance.count,
  'badge_id': instance.badgeId,
  'badge_name': instance.badgeName,
  'badge_slug': instance.badgeSlug,
  'badge_title': instance.badgeTitle,
  'message': instance.message,
  'chat_channel_id': instance.chatChannelId,
  'chat_message_id': instance.chatMessageId,
  'chat_thread_id': instance.chatThreadId,
  'chat_thread_title': instance.chatThreadTitle,
  'mentioned_by_username': instance.mentionedByUsername,
  'moved_to_topic_id': instance.movedToTopicId,
  'moved_to_post_number': instance.movedToPostNumber,
};
