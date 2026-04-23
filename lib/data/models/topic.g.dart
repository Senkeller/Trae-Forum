// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TopicListResponseImpl _$$TopicListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$TopicListResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => TopicData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  total: (json['total'] as num?)?.toInt() ?? 0,
  page: (json['page'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$$TopicListResponseImplToJson(
  _$TopicListResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
  'total': instance.total,
  'page': instance.page,
};

_$TopicDataImpl _$$TopicDataImplFromJson(Map<String, dynamic> json) =>
    _$TopicDataImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      cover: json['cover'] as String?,
      discussNum: (json['discuss_num'] as num?)?.toInt() ?? 0,
      followNum: (json['follow_num'] as num?)?.toInt() ?? 0,
      isFollow: json['is_follow'] as bool? ?? false,
      creator: json['creator'] == null
          ? null
          : UserInfo.fromJson(json['creator'] as Map<String, dynamic>),
      createTime: json['create_time'] as String?,
      updateTime: json['update_time'] as String?,
    );

Map<String, dynamic> _$$TopicDataImplToJson(_$TopicDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'cover': instance.cover,
      'discuss_num': instance.discussNum,
      'follow_num': instance.followNum,
      'is_follow': instance.isFollow,
      'creator': instance.creator,
      'create_time': instance.createTime,
      'update_time': instance.updateTime,
    };

_$TopicDetailResponseImpl _$$TopicDetailResponseImplFromJson(
  Map<String, dynamic> json,
) => _$TopicDetailResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  data: json['data'] == null
      ? null
      : TopicDetailData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$TopicDetailResponseImplToJson(
  _$TopicDetailResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_$TopicDetailDataImpl _$$TopicDetailDataImplFromJson(
  Map<String, dynamic> json,
) => _$TopicDetailDataImpl(
  topic: TopicData.fromJson(json['topic'] as Map<String, dynamic>),
  feeds: json['feeds'] as List<dynamic>? ?? const [],
  hotFeeds: json['hot_feeds'] as List<dynamic>? ?? const [],
  contributors:
      (json['contributors'] as List<dynamic>?)
          ?.map((e) => UserInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$TopicDetailDataImplToJson(
  _$TopicDetailDataImpl instance,
) => <String, dynamic>{
  'topic': instance.topic,
  'feeds': instance.feeds,
  'hot_feeds': instance.hotFeeds,
  'contributors': instance.contributors,
};

_$RecommendTopicResponseImpl _$$RecommendTopicResponseImplFromJson(
  Map<String, dynamic> json,
) => _$RecommendTopicResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => TopicData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$RecommendTopicResponseImplToJson(
  _$RecommendTopicResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_$TopicSearchResponseImpl _$$TopicSearchResponseImplFromJson(
  Map<String, dynamic> json,
) => _$TopicSearchResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => TopicData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  total: (json['total'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$TopicSearchResponseImplToJson(
  _$TopicSearchResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
  'total': instance.total,
};

_$TopicFollowResponseImpl _$$TopicFollowResponseImplFromJson(
  Map<String, dynamic> json,
) => _$TopicFollowResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  isFollow: json['is_follow'] as bool? ?? false,
  followNum: (json['follow_num'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$TopicFollowResponseImplToJson(
  _$TopicFollowResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'is_follow': instance.isFollow,
  'follow_num': instance.followNum,
};
