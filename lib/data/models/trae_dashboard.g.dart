// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trae_dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TraeUserStatsImpl _$$TraeUserStatsImplFromJson(Map<String, dynamic> json) =>
    _$TraeUserStatsImpl(
      userId: json['UserID'] as String,
      registerDays: (json['RegisterDays'] as num).toInt(),
      dailyActivity: Map<String, int>.from(json['AiCnt365d'] as Map),
      codeAcceptCount7d: (json['CodeAiAcceptCnt7d'] as num).toInt(),
      languageStats: Map<String, int>.from(
        json['CodeAiAcceptDiffLanguageCnt7d'] as Map,
      ),
      conversationCount7d: (json['CodeCompCnt7d'] as num).toInt(),
      agentStats: Map<String, int>.from(json['CodeCompDiffAgentCnt7d'] as Map),
      modelStats: Map<String, int>.from(json['CodeCompDiffModelCnt7d'] as Map),
      hourlyActivity: Map<String, int>.from(
        json['IdeActiveDiffHourCnt7d'] as Map,
      ),
      dataDate: json['DataDate'] as String,
      isIde: json['IsIde'] as bool? ?? true,
    );

Map<String, dynamic> _$$TraeUserStatsImplToJson(_$TraeUserStatsImpl instance) =>
    <String, dynamic>{
      'UserID': instance.userId,
      'RegisterDays': instance.registerDays,
      'AiCnt365d': instance.dailyActivity,
      'CodeAiAcceptCnt7d': instance.codeAcceptCount7d,
      'CodeAiAcceptDiffLanguageCnt7d': instance.languageStats,
      'CodeCompCnt7d': instance.conversationCount7d,
      'CodeCompDiffAgentCnt7d': instance.agentStats,
      'CodeCompDiffModelCnt7d': instance.modelStats,
      'IdeActiveDiffHourCnt7d': instance.hourlyActivity,
      'DataDate': instance.dataDate,
      'IsIde': instance.isIde,
    };

_$TraeUserInfoImpl _$$TraeUserInfoImplFromJson(Map<String, dynamic> json) =>
    _$TraeUserInfoImpl(
      userId: json['UserID'] as String,
      screenName: json['ScreenName'] as String,
      avatarUrl: json['AvatarUrl'] as String?,
      registerTime: json['RegisterTime'] as String?,
      lastLoginTime: json['LastLoginTime'] as String?,
      region: json['Region'] as String? ?? 'CN',
    );

Map<String, dynamic> _$$TraeUserInfoImplToJson(_$TraeUserInfoImpl instance) =>
    <String, dynamic>{
      'UserID': instance.userId,
      'ScreenName': instance.screenName,
      'AvatarUrl': instance.avatarUrl,
      'RegisterTime': instance.registerTime,
      'LastLoginTime': instance.lastLoginTime,
      'Region': instance.region,
    };
