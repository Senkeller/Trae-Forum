import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

/// 通知模型文件
/// 包含系统通知、互动通知等数据结构

/// 通知列表响应模型
/// 用于通知列表接口返回的数据
@freezed
class NotificationResponse with _$NotificationResponse {
  /// 构造函数
  /// @param status 状态码
  /// @param message 响应消息
  /// @param data 通知数据列表
  /// @param total 总数
  /// @param page 当前页码
  /// @param unreadCount 未读通知总数
  const factory NotificationResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'data') @Default([]) List<NotificationData> data,
    @JsonKey(name: 'total') @Default(0) int total,
    @JsonKey(name: 'page') @Default(1) int page,
    @JsonKey(name: 'unread_count') @Default(0) int unreadCount,
  }) = _NotificationResponse;

  /// 从JSON解析通知列表响应对象
  /// @param json JSON数据
  /// @return NotificationResponse实例
  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);
}

/// 通知数据模型
/// 单条通知的完整信息
@freezed
class NotificationData with _$NotificationData {
  /// 构造函数
  /// @param id 通知ID
  /// @param uid 触发通知的用户ID
  /// @param username 触发通知的用户名
  /// @param avatar 触发通知的用户头像
  /// @param type 通知类型（like、follow、comment、system 等）
  /// @param title 通知标题
  /// @param message 通知内容
  /// @param targetId 目标ID（如被点赞的动态ID）
  /// @param targetType 目标类型
  /// @param targetContent 目标内容摘要
  /// @param dateline 通知时间
  /// @param isRead 是否已读
  /// @param extra 额外数据
  const factory NotificationData({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'uid') String? uid,
    @JsonKey(name: 'username') @Default('') String username,
    @JsonKey(name: 'avatar') String? avatar,
    @JsonKey(name: 'type') required String type,
    @JsonKey(name: 'title') @Default('') String title,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'target_id') String? targetId,
    @JsonKey(name: 'target_type') String? targetType,
    @JsonKey(name: 'target_content') String? targetContent,
    @JsonKey(name: 'dateline') @Default('') String dateline,
    @JsonKey(name: 'is_read') @Default(false) bool isRead,
    @JsonKey(name: 'extra') @Default({}) Map<String, dynamic> extra,
  }) = _NotificationData;

  /// 从JSON解析通知数据对象
  /// @param json JSON数据
  /// @return NotificationData实例
  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);
}

/// 通知类型枚举
/// 定义不同类型的通知
class NotificationType {
  /// 点赞通知
  static const String like = 'like';

  /// 评论通知
  static const String comment = 'comment';

  /// 关注通知
  static const String follow = 'follow';

  /// 转发通知
  static const String forward = 'forward';

  /// 系统通知
  static const String system = 'system';

  /// 回复通知
  static const String reply = 'reply';

  /// 收藏通知
  static const String favorite = 'favorite';

  /// @提及通知
  static const String mention = 'mention';
}

/// 通知统计响应模型
/// 用于获取通知统计信息接口返回的数据
@freezed
class NotificationStatsResponse with _$NotificationStatsResponse {
  /// 构造函数
  /// @param status 状态码
  /// @param message 响应消息
  /// @param totalUnread 总未读数
  /// @param likeCount 点赞未读数
  /// @param commentCount 评论未读数
  /// @param followCount 关注未读数
  /// @param systemCount 系统通知未读数
  const factory NotificationStatsResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'total_unread') @Default(0) int totalUnread,
    @JsonKey(name: 'like_count') @Default(0) int likeCount,
    @JsonKey(name: 'comment_count') @Default(0) int commentCount,
    @JsonKey(name: 'follow_count') @Default(0) int followCount,
    @JsonKey(name: 'system_count') @Default(0) int systemCount,
  }) = _NotificationStatsResponse;

  /// 从JSON解析通知统计响应对象
  /// @param json JSON数据
  /// @return NotificationStatsResponse实例
  factory NotificationStatsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationStatsResponseFromJson(json);
}

/// 标记通知已读请求模型
/// 用于标记通知已读时的参数
@freezed
class MarkNotificationReadRequest with _$MarkNotificationReadRequest {
  /// 构造函数
  /// @param notificationIds 要标记的通知ID列表
  /// @param type 要标记的通知类型（标记某类型全部）
  const factory MarkNotificationReadRequest({
    @JsonKey(name: 'notification_ids') @Default([]) List<String> notificationIds,
    @JsonKey(name: 'type') String? type,
  }) = _MarkNotificationReadRequest;

  /// 从JSON解析标记通知已读请求对象
  /// @param json JSON数据
  /// @return MarkNotificationReadRequest实例
  factory MarkNotificationReadRequest.fromJson(Map<String, dynamic> json) =>
      _$MarkNotificationReadRequestFromJson(json);
}

/// 标记通知已读响应模型
/// 用于标记通知已读接口返回的数据
@freezed
class MarkNotificationReadResponse with _$MarkNotificationReadResponse {
  /// 构造函数
  /// @param status 状态码
  /// @param message 响应消息
  /// @param updatedCount 更新的通知数
  const factory MarkNotificationReadResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'updated_count') @Default(0) int updatedCount,
  }) = _MarkNotificationReadResponse;

  /// 从JSON解析标记通知已读响应对象
  /// @param json JSON数据
  /// @return MarkNotificationReadResponse实例
  factory MarkNotificationReadResponse.fromJson(Map<String, dynamic> json) =>
      _$MarkNotificationReadResponseFromJson(json);
}

/// 删除通知请求模型
/// 用于删除通知时的参数
@freezed
class DeleteNotificationRequest with _$DeleteNotificationRequest {
  /// 构造函数
  /// @param notificationIds 要删除的通知ID列表
  const factory DeleteNotificationRequest({
    @JsonKey(name: 'notification_ids') required List<String> notificationIds,
  }) = _DeleteNotificationRequest;

  /// 从JSON解析删除通知请求对象
  /// @param json JSON数据
  /// @return DeleteNotificationRequest实例
  factory DeleteNotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteNotificationRequestFromJson(json);
}

/// 删除通知响应模型
/// 用于删除通知接口返回的数据
@freezed
class DeleteNotificationResponse with _$DeleteNotificationResponse {
  /// 构造函数
  /// @param status 状态码
  /// @param message 响应消息
  /// @param deletedCount 删除的通知数
  const factory DeleteNotificationResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'deleted_count') @Default(0) int deletedCount,
  }) = _DeleteNotificationResponse;

  /// 从JSON解析删除通知响应对象
  /// @param json JSON数据
  /// @return DeleteNotificationResponse实例
  factory DeleteNotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteNotificationResponseFromJson(json);
}

/// 系统公告响应模型
/// 用于获取系统公告接口返回的数据
@freezed
class AnnouncementResponse with _$AnnouncementResponse {
  /// 构造函数
  /// @param status 状态码
  /// @param message 响应消息
  /// @param data 公告数据列表
  const factory AnnouncementResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'data') @Default([]) List<AnnouncementData> data,
  }) = _AnnouncementResponse;

  /// 从JSON解析系统公告响应对象
  /// @param json JSON数据
  /// @return AnnouncementResponse实例
  factory AnnouncementResponse.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementResponseFromJson(json);
}

/// 系统公告数据模型
/// 单条系统公告的完整信息
@freezed
class AnnouncementData with _$AnnouncementData {
  /// 构造函数
  /// @param id 公告ID
  /// @param title 公告标题
  /// @param content 公告内容
  /// @param cover 公告封面图
  /// @param url 跳转链接
  /// @param dateline 发布时间
  /// @param isRead 是否已读
  const factory AnnouncementData({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'content') @Default('') String content,
    @JsonKey(name: 'cover') String? cover,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'dateline') @Default('') String dateline,
    @JsonKey(name: 'is_read') @Default(false) bool isRead,
  }) = _AnnouncementData;

  /// 从JSON解析系统公告数据对象
  /// @param json JSON数据
  /// @return AnnouncementData实例
  factory AnnouncementData.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementDataFromJson(json);
}
