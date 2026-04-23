// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageResponseImpl _$$MessageResponseImplFromJson(
  Map<String, dynamic> json,
) => _$MessageResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => MessageData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  total: (json['total'] as num?)?.toInt() ?? 0,
  page: (json['page'] as num?)?.toInt() ?? 1,
  hasMore: json['has_more'] as bool? ?? false,
);

Map<String, dynamic> _$$MessageResponseImplToJson(
  _$MessageResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
  'total': instance.total,
  'page': instance.page,
  'has_more': instance.hasMore,
};

_$MessageDataImpl _$$MessageDataImplFromJson(Map<String, dynamic> json) =>
    _$MessageDataImpl(
      id: json['id'] as String,
      fromUid: json['from_uid'] as String,
      toUid: json['to_uid'] as String,
      username: json['username'] as String? ?? '',
      avatar: json['avatar'] as String?,
      message: json['message'] as String? ?? '',
      picArr:
          (json['picArr'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      dateline: json['dateline'] as String? ?? '',
      isRead: json['is_read'] as bool? ?? false,
      messageType: json['message_type'] as String? ?? 'text',
    );

Map<String, dynamic> _$$MessageDataImplToJson(_$MessageDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'from_uid': instance.fromUid,
      'to_uid': instance.toUid,
      'username': instance.username,
      'avatar': instance.avatar,
      'message': instance.message,
      'picArr': instance.picArr,
      'dateline': instance.dateline,
      'is_read': instance.isRead,
      'message_type': instance.messageType,
    };

_$ConversationResponseImpl _$$ConversationResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ConversationResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => ConversationData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  total: (json['total'] as num?)?.toInt() ?? 0,
  unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$ConversationResponseImplToJson(
  _$ConversationResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
  'total': instance.total,
  'unread_count': instance.unreadCount,
};

_$ConversationDataImpl _$$ConversationDataImplFromJson(
  Map<String, dynamic> json,
) => _$ConversationDataImpl(
  id: json['id'] as String,
  uid: json['uid'] as String,
  username: json['username'] as String? ?? '',
  avatar: json['avatar'] as String?,
  lastMessage: json['last_message'] as String? ?? '',
  lastDateline: json['last_dateline'] as String? ?? '',
  unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
  isTop: json['is_top'] as bool? ?? false,
  isMute: json['is_mute'] as bool? ?? false,
);

Map<String, dynamic> _$$ConversationDataImplToJson(
  _$ConversationDataImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'uid': instance.uid,
  'username': instance.username,
  'avatar': instance.avatar,
  'last_message': instance.lastMessage,
  'last_dateline': instance.lastDateline,
  'unread_count': instance.unreadCount,
  'is_top': instance.isTop,
  'is_mute': instance.isMute,
};

_$SendMessageRequestImpl _$$SendMessageRequestImplFromJson(
  Map<String, dynamic> json,
) => _$SendMessageRequestImpl(
  toUid: json['to_uid'] as String,
  message: json['message'] as String? ?? '',
  picArr:
      (json['picArr'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  messageType: json['message_type'] as String? ?? 'text',
);

Map<String, dynamic> _$$SendMessageRequestImplToJson(
  _$SendMessageRequestImpl instance,
) => <String, dynamic>{
  'to_uid': instance.toUid,
  'message': instance.message,
  'picArr': instance.picArr,
  'message_type': instance.messageType,
};

_$SendMessageResponseImpl _$$SendMessageResponseImplFromJson(
  Map<String, dynamic> json,
) => _$SendMessageResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  data: json['data'] == null
      ? null
      : MessageData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$SendMessageResponseImplToJson(
  _$SendMessageResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_$MarkReadRequestImpl _$$MarkReadRequestImplFromJson(
  Map<String, dynamic> json,
) => _$MarkReadRequestImpl(
  uid: json['uid'] as String?,
  messageIds:
      (json['message_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$MarkReadRequestImplToJson(
  _$MarkReadRequestImpl instance,
) => <String, dynamic>{'uid': instance.uid, 'message_ids': instance.messageIds};

_$MarkReadResponseImpl _$$MarkReadResponseImplFromJson(
  Map<String, dynamic> json,
) => _$MarkReadResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  updatedCount: (json['updated_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$MarkReadResponseImplToJson(
  _$MarkReadResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'updated_count': instance.updatedCount,
};
