// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draft_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DraftModelImpl _$$DraftModelImplFromJson(Map<String, dynamic> json) =>
    _$DraftModelImpl(
      topicId: (json['topicId'] as num).toInt(),
      content: json['content'] as String,
      savedAt: json['savedAt'] as String,
      replyToPostNumber: (json['replyToPostNumber'] as num?)?.toInt(),
      replyToUsername: json['replyToUsername'] as String?,
    );

Map<String, dynamic> _$$DraftModelImplToJson(_$DraftModelImpl instance) =>
    <String, dynamic>{
      'topicId': instance.topicId,
      'content': instance.content,
      'savedAt': instance.savedAt,
      'replyToPostNumber': instance.replyToPostNumber,
      'replyToUsername': instance.replyToUsername,
    };
