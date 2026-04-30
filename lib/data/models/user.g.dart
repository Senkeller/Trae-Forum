// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserInfoImpl _$$UserInfoImplFromJson(Map<String, dynamic> json) =>
    _$UserInfoImpl(
      uid: json['uid'] as String,
      username: json['username'] as String,
      avatar: json['avatar'] as String?,
      level: (json['level'] as num?)?.toInt() ?? 0,
      bio: json['bio'] as String? ?? '',
      fans: (json['fans'] as num?)?.toInt() ?? 0,
      follow: (json['follow'] as num?)?.toInt() ?? 0,
      verifyTitle: json['verify_title'] as String?,
      isDeveloper: json['is_developer'] as bool? ?? false,
      title: json['title'] as String?,
      location: json['location'] as String?,
      website: json['website'] as String?,
      createdAt: json['created_at'] as String?,
      lastPostedAt: json['last_posted_at'] as String?,
      lastSeenAt: json['last_seen_at'] as String?,
      profileViewCount: (json['profile_view_count'] as num?)?.toInt() ?? 0,
      trustLevel: (json['trust_level'] as num?)?.toInt() ?? 0,
      groups:
          (json['groups'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      gamificationScore: (json['gamification_score'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$UserInfoImplToJson(_$UserInfoImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'avatar': instance.avatar,
      'level': instance.level,
      'bio': instance.bio,
      'fans': instance.fans,
      'follow': instance.follow,
      'verify_title': instance.verifyTitle,
      'is_developer': instance.isDeveloper,
      'title': instance.title,
      'location': instance.location,
      'website': instance.website,
      'created_at': instance.createdAt,
      'last_posted_at': instance.lastPostedAt,
      'last_seen_at': instance.lastSeenAt,
      'profile_view_count': instance.profileViewCount,
      'trust_level': instance.trustLevel,
      'groups': instance.groups,
      'gamification_score': instance.gamificationScore,
    };

_$UserActionImpl _$$UserActionImplFromJson(Map<String, dynamic> json) =>
    _$UserActionImpl(
      isLike: json['is_like'] as bool? ?? false,
      isFavorite: json['is_favorite'] as bool? ?? false,
      isFollow: json['is_follow'] as bool? ?? false,
      likeNum: (json['like_num'] as num?)?.toInt() ?? 0,
      favoriteNum: (json['favorite_num'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$UserActionImplToJson(_$UserActionImpl instance) =>
    <String, dynamic>{
      'is_like': instance.isLike,
      'is_favorite': instance.isFavorite,
      'is_follow': instance.isFollow,
      'like_num': instance.likeNum,
      'favorite_num': instance.favoriteNum,
    };

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      userInfo: UserInfo.fromJson(json['user_info'] as Map<String, dynamic>),
      action: json['action'] == null
          ? const UserAction()
          : UserAction.fromJson(json['action'] as Map<String, dynamic>),
      feedCount: (json['feed_count'] as num?)?.toInt() ?? 0,
      replyCount: (json['reply_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'user_info': instance.userInfo,
      'action': instance.action,
      'feed_count': instance.feedCount,
      'reply_count': instance.replyCount,
    };

_$LoginResponseImpl _$$LoginResponseImplFromJson(Map<String, dynamic> json) =>
    _$LoginResponseImpl(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String? ?? '',
      data: json['data'] == null
          ? null
          : UserInfo.fromJson(json['data'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$$LoginResponseImplToJson(_$LoginResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'token': instance.token,
    };
