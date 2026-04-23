import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// 用户模型文件
/// 包含用户基本信息和用户行为数据

/// 用户基础信息模型
/// 用于存储用户的基本资料信息
@freezed
class UserInfo with _$UserInfo {
  /// 构造函数
  /// @param uid 用户唯一标识
  /// @param username 用户名
  /// @param avatar 头像URL
  /// @param level 用户等级
  /// @param bio 个人简介
  /// @param fans 粉丝数量
  /// @param follow 关注数量
  /// @param verifyTitle 认证头衔
  /// @param isDeveloper 是否为开发者
  const factory UserInfo({
    @JsonKey(name: 'uid') required String uid,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'avatar') String? avatar,
    @JsonKey(name: 'level') @Default(0) int level,
    @JsonKey(name: 'bio') @Default('') String bio,
    @JsonKey(name: 'fans') @Default(0) int fans,
    @JsonKey(name: 'follow') @Default(0) int follow,
    @JsonKey(name: 'verify_title') String? verifyTitle,
    @JsonKey(name: 'is_developer') @Default(false) bool isDeveloper,
  }) = _UserInfo;

  /// 从JSON解析用户对象
  /// @param json JSON数据
  /// @return UserInfo实例
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}

/// 用户行为模型
/// 用于存储用户对内容的操作行为（点赞、收藏、关注等）
@freezed
class UserAction with _$UserAction {
  /// 构造函数
  /// @param isLike 是否点赞
  /// @param isFavorite 是否收藏
  /// @param isFollow 是否关注
  /// @param likeNum 点赞数量
  /// @param favoriteNum 收藏数量
  const factory UserAction({
    @JsonKey(name: 'is_like') @Default(false) bool isLike,
    @JsonKey(name: 'is_favorite') @Default(false) bool isFavorite,
    @JsonKey(name: 'is_follow') @Default(false) bool isFollow,
    @JsonKey(name: 'like_num') @Default(0) int likeNum,
    @JsonKey(name: 'favorite_num') @Default(0) int favoriteNum,
  }) = _UserAction;

  /// 从JSON解析用户行为对象
  /// @param json JSON数据
  /// @return UserAction实例
  factory UserAction.fromJson(Map<String, dynamic> json) =>
      _$UserActionFromJson(json);
}

/// 用户资料详情模型
/// 包含完整的用户信息展示
@freezed
class UserProfile with _$UserProfile {
  /// 构造函数
  /// @param userInfo 基础用户信息
  /// @param action 用户行为状态
  /// @param feedCount 发布动态数量
  /// @param replyCount 回复数量
  const factory UserProfile({
    @JsonKey(name: 'user_info') required UserInfo userInfo,
    @JsonKey(name: 'action') @Default(UserAction()) UserAction action,
    @JsonKey(name: 'feed_count') @Default(0) int feedCount,
    @JsonKey(name: 'reply_count') @Default(0) int replyCount,
  }) = _UserProfile;

  /// 从JSON解析用户资料对象
  /// @param json JSON数据
  /// @return UserProfile实例
  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

/// 用户登录响应模型
/// 用于处理登录接口返回的数据
@freezed
class LoginResponse with _$LoginResponse {
  /// 构造函数
  /// @param status 状态码
  /// @param message 响应消息
  /// @param data 用户数据
  /// @param token 认证令牌
  const factory LoginResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'data') UserInfo? data,
    @JsonKey(name: 'token') String? token,
  }) = _LoginResponse;

  /// 从JSON解析登录响应对象
  /// @param json JSON数据
  /// @return LoginResponse实例
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
