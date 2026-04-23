// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TotalReplyResponseImpl _$$TotalReplyResponseImplFromJson(
  Map<String, dynamic> json,
) => _$TotalReplyResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => ReplyData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  total: (json['total'] as num?)?.toInt() ?? 0,
  page: (json['page'] as num?)?.toInt() ?? 1,
  lastUpdate: json['lastupdate'] as String?,
);

Map<String, dynamic> _$$TotalReplyResponseImplToJson(
  _$TotalReplyResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
  'total': instance.total,
  'page': instance.page,
  'lastupdate': instance.lastUpdate,
};

_$ReplyDataImpl _$$ReplyDataImplFromJson(Map<String, dynamic> json) =>
    _$ReplyDataImpl(
      id: json['id'] as String,
      uid: json['uid'] as String,
      username: json['username'] as String? ?? '',
      avatar: json['avatar'] as String?,
      message: json['message'] as String? ?? '',
      picArr:
          (json['picArr'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      dateline: json['dateline'] as String? ?? '',
      likeNum: (json['like_num'] as num?)?.toInt() ?? 0,
      isLike: json['is_like'] as bool? ?? false,
      replyNum: (json['replynum'] as num?)?.toInt() ?? 0,
      replyRows:
          (json['replyRows'] as List<dynamic>?)
              ?.map((e) => ReplyData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      replyRowsMore: json['replyRowsMore'] as bool? ?? false,
      replyTo: json['reply_to'] as String?,
      replyUid: json['reply_uid'] as String?,
    );

Map<String, dynamic> _$$ReplyDataImplToJson(_$ReplyDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'username': instance.username,
      'avatar': instance.avatar,
      'message': instance.message,
      'picArr': instance.picArr,
      'dateline': instance.dateline,
      'like_num': instance.likeNum,
      'is_like': instance.isLike,
      'replynum': instance.replyNum,
      'replyRows': instance.replyRows,
      'replyRowsMore': instance.replyRowsMore,
      'reply_to': instance.replyTo,
      'reply_uid': instance.replyUid,
    };

_$CreateReplyRequestImpl _$$CreateReplyRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateReplyRequestImpl(
  id: json['id'] as String,
  message: json['message'] as String,
  picArr:
      (json['picArr'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  replyId: json['reply_id'] as String?,
  replyUid: json['reply_uid'] as String?,
);

Map<String, dynamic> _$$CreateReplyRequestImplToJson(
  _$CreateReplyRequestImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'message': instance.message,
  'picArr': instance.picArr,
  'reply_id': instance.replyId,
  'reply_uid': instance.replyUid,
};

_$CreateReplyResponseImpl _$$CreateReplyResponseImplFromJson(
  Map<String, dynamic> json,
) => _$CreateReplyResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  data: json['data'] == null
      ? null
      : ReplyData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$CreateReplyResponseImplToJson(
  _$CreateReplyResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_$SubReplyResponseImpl _$$SubReplyResponseImplFromJson(
  Map<String, dynamic> json,
) => _$SubReplyResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => ReplyData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  total: (json['total'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$SubReplyResponseImplToJson(
  _$SubReplyResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
  'total': instance.total,
};
