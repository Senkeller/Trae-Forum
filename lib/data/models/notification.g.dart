// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationResponseImpl _$$NotificationResponseImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => NotificationData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  total: (json['total'] as num?)?.toInt() ?? 0,
  page: (json['page'] as num?)?.toInt() ?? 1,
  unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$NotificationResponseImplToJson(
  _$NotificationResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
  'total': instance.total,
  'page': instance.page,
  'unread_count': instance.unreadCount,
};

_$NotificationDataImpl _$$NotificationDataImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationDataImpl(
  id: json['id'] as String,
  uid: json['uid'] as String?,
  username: json['username'] as String? ?? '',
  avatar: json['avatar'] as String?,
  type: json['type'] as String,
  title: json['title'] as String? ?? '',
  message: json['message'] as String? ?? '',
  targetId: json['target_id'] as String?,
  targetType: json['target_type'] as String?,
  targetContent: json['target_content'] as String?,
  dateline: json['dateline'] as String? ?? '',
  isRead: json['is_read'] as bool? ?? false,
  extra: json['extra'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$$NotificationDataImplToJson(
  _$NotificationDataImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'uid': instance.uid,
  'username': instance.username,
  'avatar': instance.avatar,
  'type': instance.type,
  'title': instance.title,
  'message': instance.message,
  'target_id': instance.targetId,
  'target_type': instance.targetType,
  'target_content': instance.targetContent,
  'dateline': instance.dateline,
  'is_read': instance.isRead,
  'extra': instance.extra,
};

_$NotificationStatsResponseImpl _$$NotificationStatsResponseImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationStatsResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  totalUnread: (json['total_unread'] as num?)?.toInt() ?? 0,
  likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
  commentCount: (json['comment_count'] as num?)?.toInt() ?? 0,
  followCount: (json['follow_count'] as num?)?.toInt() ?? 0,
  systemCount: (json['system_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$NotificationStatsResponseImplToJson(
  _$NotificationStatsResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'total_unread': instance.totalUnread,
  'like_count': instance.likeCount,
  'comment_count': instance.commentCount,
  'follow_count': instance.followCount,
  'system_count': instance.systemCount,
};

_$MarkNotificationReadRequestImpl _$$MarkNotificationReadRequestImplFromJson(
  Map<String, dynamic> json,
) => _$MarkNotificationReadRequestImpl(
  notificationIds:
      (json['notification_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  type: json['type'] as String?,
);

Map<String, dynamic> _$$MarkNotificationReadRequestImplToJson(
  _$MarkNotificationReadRequestImpl instance,
) => <String, dynamic>{
  'notification_ids': instance.notificationIds,
  'type': instance.type,
};

_$MarkNotificationReadResponseImpl _$$MarkNotificationReadResponseImplFromJson(
  Map<String, dynamic> json,
) => _$MarkNotificationReadResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  updatedCount: (json['updated_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$MarkNotificationReadResponseImplToJson(
  _$MarkNotificationReadResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'updated_count': instance.updatedCount,
};

_$DeleteNotificationRequestImpl _$$DeleteNotificationRequestImplFromJson(
  Map<String, dynamic> json,
) => _$DeleteNotificationRequestImpl(
  notificationIds: (json['notification_ids'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$$DeleteNotificationRequestImplToJson(
  _$DeleteNotificationRequestImpl instance,
) => <String, dynamic>{'notification_ids': instance.notificationIds};

_$DeleteNotificationResponseImpl _$$DeleteNotificationResponseImplFromJson(
  Map<String, dynamic> json,
) => _$DeleteNotificationResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  deletedCount: (json['deleted_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$DeleteNotificationResponseImplToJson(
  _$DeleteNotificationResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'deleted_count': instance.deletedCount,
};

_$AnnouncementResponseImpl _$$AnnouncementResponseImplFromJson(
  Map<String, dynamic> json,
) => _$AnnouncementResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => AnnouncementData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$AnnouncementResponseImplToJson(
  _$AnnouncementResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_$AnnouncementDataImpl _$$AnnouncementDataImplFromJson(
  Map<String, dynamic> json,
) => _$AnnouncementDataImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  content: json['content'] as String? ?? '',
  cover: json['cover'] as String?,
  url: json['url'] as String?,
  dateline: json['dateline'] as String? ?? '',
  isRead: json['is_read'] as bool? ?? false,
);

Map<String, dynamic> _$$AnnouncementDataImplToJson(
  _$AnnouncementDataImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'content': instance.content,
  'cover': instance.cover,
  'url': instance.url,
  'dateline': instance.dateline,
  'is_read': instance.isRead,
};
