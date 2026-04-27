// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReplyResultImpl _$$ReplyResultImplFromJson(Map<String, dynamic> json) =>
    _$ReplyResultImpl(
      success: json['success'] as bool? ?? false,
      postId: (json['postId'] as num?)?.toInt(),
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$$ReplyResultImplToJson(_$ReplyResultImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'postId': instance.postId,
      'errorMessage': instance.errorMessage,
    };
