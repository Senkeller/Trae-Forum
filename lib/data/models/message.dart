import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

/// 消息模型文件
/// 包含私信消息、消息列表等数据结构

/// 消息列表响应模型
/// 用于消息列表接口返回的数据
@freezed
class MessageResponse with _$MessageResponse {
  /// 构造函数
  /// @param status 状态码
  /// @param message 响应消息
  /// @param data 消息数据列表
  /// @param total 总数
  /// @param page 当前页码
  /// @param hasMore 是否还有更多
  const factory MessageResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'data') @Default([]) List<MessageData> data,
    @JsonKey(name: 'total') @Default(0) int total,
    @JsonKey(name: 'page') @Default(1) int page,
    @JsonKey(name: 'has_more') @Default(false) bool hasMore,
  }) = _MessageResponse;

  /// 从JSON解析消息列表响应对象
  /// @param json JSON数据
  /// @return MessageResponse实例
  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseFromJson(json);
}

/// 消息数据模型
/// 单条私信的完整信息
@freezed
class MessageData with _$MessageData {
  /// 构造函数
  /// @param id 消息ID
  /// @param fromUid 发送者ID
  /// @param toUid 接收者ID
  /// @param username 发送者用户名
  /// @param avatar 发送者头像
  /// @param message 消息内容
  /// @param picArr 图片数组
  /// @param dateline 发送时间
  /// @param isRead 是否已读
  /// @param messageType 消息类型（text、image 等）
  const factory MessageData({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'from_uid') required String fromUid,
    @JsonKey(name: 'to_uid') required String toUid,
    @JsonKey(name: 'username') @Default('') String username,
    @JsonKey(name: 'avatar') String? avatar,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'picArr') @Default([]) List<String> picArr,
    @JsonKey(name: 'dateline') @Default('') String dateline,
    @JsonKey(name: 'is_read') @Default(false) bool isRead,
    @JsonKey(name: 'message_type') @Default('text') String messageType,
  }) = _MessageData;

  /// 从JSON解析消息数据对象
  /// @param json JSON数据
  /// @return MessageData实例
  factory MessageData.fromJson(Map<String, dynamic> json) =>
      _$MessageDataFromJson(json);
}

/// 会话列表响应模型
/// 用于会话列表接口返回的数据
@freezed
class ConversationResponse with _$ConversationResponse {
  /// 构造函数
  /// @param status 状态码
  /// @param message 响应消息
  /// @param data 会话数据列表
  /// @param total 总数
  /// @param unreadCount 未读消息总数
  const factory ConversationResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'data') @Default([]) List<ConversationData> data,
    @JsonKey(name: 'total') @Default(0) int total,
    @JsonKey(name: 'unread_count') @Default(0) int unreadCount,
  }) = _ConversationResponse;

  /// 从JSON解析会话列表响应对象
  /// @param json JSON数据
  /// @return ConversationResponse实例
  factory ConversationResponse.fromJson(Map<String, dynamic> json) =>
      _$ConversationResponseFromJson(json);
}

/// 会话数据模型
/// 单个会话的完整信息
@freezed
class ConversationData with _$ConversationData {
  /// 构造函数
  /// @param id 会话ID
  /// @param uid 对方用户ID
  /// @param username 对方用户名
  /// @param avatar 对方头像
  /// @param lastMessage 最后一条消息
  /// @param lastDateline 最后消息时间
  /// @param unreadCount 未读消息数
  /// @param isTop 是否置顶
  /// @param isMute 是否免打扰
  const factory ConversationData({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'uid') required String uid,
    @JsonKey(name: 'username') @Default('') String username,
    @JsonKey(name: 'avatar') String? avatar,
    @JsonKey(name: 'last_message') @Default('') String lastMessage,
    @JsonKey(name: 'last_dateline') @Default('') String lastDateline,
    @JsonKey(name: 'unread_count') @Default(0) int unreadCount,
    @JsonKey(name: 'is_top') @Default(false) bool isTop,
    @JsonKey(name: 'is_mute') @Default(false) bool isMute,
  }) = _ConversationData;

  /// 从JSON解析会话数据对象
  /// @param json JSON数据
  /// @return ConversationData实例
  factory ConversationData.fromJson(Map<String, dynamic> json) =>
      _$ConversationDataFromJson(json);
}

/// 发送消息请求模型
/// 用于发送私信时的参数
@freezed
class SendMessageRequest with _$SendMessageRequest {
  /// 构造函数
  /// @param toUid 接收者ID
  /// @param message 消息内容
  /// @param picArr 图片数组
  /// @param messageType 消息类型
  const factory SendMessageRequest({
    @JsonKey(name: 'to_uid') required String toUid,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'picArr') @Default([]) List<String> picArr,
    @JsonKey(name: 'message_type') @Default('text') String messageType,
  }) = _SendMessageRequest;

  /// 从JSON解析发送消息请求对象
  /// @param json JSON数据
  /// @return SendMessageRequest实例
  factory SendMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$SendMessageRequestFromJson(json);
}

/// 发送消息响应模型
/// 用于发送消息接口返回的数据
@freezed
class SendMessageResponse with _$SendMessageResponse {
  /// 构造函数
  /// @param status 状态码
  /// @param message 响应消息
  /// @param data 发送的消息数据
  const factory SendMessageResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'data') MessageData? data,
  }) = _SendMessageResponse;

  /// 从JSON解析发送消息响应对象
  /// @param json JSON数据
  /// @return SendMessageResponse实例
  factory SendMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$SendMessageResponseFromJson(json);
}

/// 标记已读请求模型
/// 用于标记消息已读时的参数
@freezed
class MarkReadRequest with _$MarkReadRequest {
  /// 构造函数
  /// @param uid 对方用户ID
  /// @param messageIds 要标记的消息ID列表
  const factory MarkReadRequest({
    @JsonKey(name: 'uid') String? uid,
    @JsonKey(name: 'message_ids') @Default([]) List<String> messageIds,
  }) = _MarkReadRequest;

  /// 从JSON解析标记已读请求对象
  /// @param json JSON数据
  /// @return MarkReadRequest实例
  factory MarkReadRequest.fromJson(Map<String, dynamic> json) =>
      _$MarkReadRequestFromJson(json);
}

/// 标记已读响应模型
/// 用于标记已读接口返回的数据
@freezed
class MarkReadResponse with _$MarkReadResponse {
  /// 构造函数
  /// @param status 状态码
  /// @param message 响应消息
  /// @param updatedCount 更新的消息数
  const factory MarkReadResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'updated_count') @Default(0) int updatedCount,
  }) = _MarkReadResponse;

  /// 从JSON解析标记已读响应对象
  /// @param json JSON数据
  /// @return MarkReadResponse实例
  factory MarkReadResponse.fromJson(Map<String, dynamic> json) =>
      _$MarkReadResponseFromJson(json);
}
