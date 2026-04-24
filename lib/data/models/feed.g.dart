// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TopCommentImpl _$$TopCommentImplFromJson(Map<String, dynamic> json) =>
    _$TopCommentImpl(
      id: json['id'] as String,
      username: json['username'] as String,
      content: json['content'] as String? ?? '',
      likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$$TopCommentImplToJson(_$TopCommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'content': instance.content,
      'like_count': instance.likeCount,
      'avatar_url': instance.avatarUrl,
    };

_$HomeFeedResponseImpl _$$HomeFeedResponseImplFromJson(
  Map<String, dynamic> json,
) => _$HomeFeedResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => HomeFeedData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  total: (json['total'] as num?)?.toInt() ?? 0,
  page: (json['page'] as num?)?.toInt() ?? 1,
  lastUpdate: json['lastupdate'] as String?,
);

Map<String, dynamic> _$$HomeFeedResponseImplToJson(
  _$HomeFeedResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
  'total': instance.total,
  'page': instance.page,
  'lastupdate': instance.lastUpdate,
};

_$HomeFeedDataImpl _$$HomeFeedDataImplFromJson(Map<String, dynamic> json) =>
    _$HomeFeedDataImpl(
      id: json['id'] as String,
      entityType: json['entityType'] as String,
      title: json['title'] as String?,
      message: json['message'] as String? ?? '',
      picArr:
          (json['picArr'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      userInfo: json['userInfo'] == null
          ? null
          : UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
      action: json['user_action'] == null
          ? const UserAction()
          : UserAction.fromJson(json['user_action'] as Map<String, dynamic>),
      dateline: json['dateline'] as String? ?? '',
      replyNum: (json['replynum'] as num?)?.toInt() ?? 0,
      forwardNum: (json['forwardnum'] as num?)?.toInt() ?? 0,
      forwardId: json['forwardid'] as String?,
      forwardSource: json['forwardSource'] as String?,
      deviceTitle: json['device_title'] as String?,
      replyRows: json['replyRows'] as List<dynamic>? ?? const [],
      replyRowsMore: json['replyRowsMore'] as bool? ?? false,
      topComment: json['topComment'] == null
          ? null
          : TopComment.fromJson(json['topComment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$HomeFeedDataImplToJson(_$HomeFeedDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'entityType': instance.entityType,
      'title': instance.title,
      'message': instance.message,
      'picArr': instance.picArr,
      'userInfo': instance.userInfo,
      'user_action': instance.action,
      'dateline': instance.dateline,
      'replynum': instance.replyNum,
      'forwardnum': instance.forwardNum,
      'forwardid': instance.forwardId,
      'forwardSource': instance.forwardSource,
      'device_title': instance.deviceTitle,
      'replyRows': instance.replyRows,
      'replyRowsMore': instance.replyRowsMore,
      'topComment': instance.topComment,
    };

_$FeedContentResponseImpl _$$FeedContentResponseImplFromJson(
  Map<String, dynamic> json,
) => _$FeedContentResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  data: json['data'] == null
      ? null
      : FeedContentData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$FeedContentResponseImplToJson(
  _$FeedContentResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_$FeedContentDataImpl _$$FeedContentDataImplFromJson(
  Map<String, dynamic> json,
) => _$FeedContentDataImpl(
  id: json['id'] as String,
  entityType: json['entityType'] as String,
  title: json['title'] as String?,
  message: json['message'] as String? ?? '',
  picArr:
      (json['picArr'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  userInfo: json['userInfo'] == null
      ? null
      : UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
  action: json['user_action'] == null
      ? const UserAction()
      : UserAction.fromJson(json['user_action'] as Map<String, dynamic>),
  dateline: json['dateline'] as String? ?? '',
  replyNum: (json['replynum'] as num?)?.toInt() ?? 0,
  forwardNum: (json['forwardnum'] as num?)?.toInt() ?? 0,
  deviceTitle: json['device_title'] as String?,
  replyRows: json['replyRows'] as List<dynamic>? ?? const [],
  isTop: json['is_top'] as bool? ?? false,
);

Map<String, dynamic> _$$FeedContentDataImplToJson(
  _$FeedContentDataImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'entityType': instance.entityType,
  'title': instance.title,
  'message': instance.message,
  'picArr': instance.picArr,
  'userInfo': instance.userInfo,
  'user_action': instance.action,
  'dateline': instance.dateline,
  'replynum': instance.replyNum,
  'forwardnum': instance.forwardNum,
  'device_title': instance.deviceTitle,
  'replyRows': instance.replyRows,
  'is_top': instance.isTop,
};

_$CreateFeedRequestImpl _$$CreateFeedRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateFeedRequestImpl(
  message: json['message'] as String,
  picArr:
      (json['picArr'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  type: json['type'] as String? ?? 'feed',
  deviceTitle: json['device_title'] as String?,
);

Map<String, dynamic> _$$CreateFeedRequestImplToJson(
  _$CreateFeedRequestImpl instance,
) => <String, dynamic>{
  'message': instance.message,
  'picArr': instance.picArr,
  'type': instance.type,
  'device_title': instance.deviceTitle,
};

_$CreateFeedResponseImpl _$$CreateFeedResponseImplFromJson(
  Map<String, dynamic> json,
) => _$CreateFeedResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  data: json['data'] == null
      ? null
      : HomeFeedData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$CreateFeedResponseImplToJson(
  _$CreateFeedResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
