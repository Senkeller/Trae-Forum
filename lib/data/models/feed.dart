import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';

part 'feed.freezed.dart';
part 'feed.g.dart';

/// 动态/帖子模型文件
/// 包含首页动态、帖子详情等数据结构

/// 首页动态响应模型
/// 用于首页动态列表接口返回的数据
@freezed
class HomeFeedResponse with _$HomeFeedResponse {
  /// 构造函数
  /// @param status 状态码
  /// @param message 响应消息
  /// @param data 动态数据列表
  /// @param total 总数
  /// @param page 当前页码
  /// @param lastUpdate 最后更新时间
  const factory HomeFeedResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'data') @Default([]) List<HomeFeedData> data,
    @JsonKey(name: 'total') @Default(0) int total,
    @JsonKey(name: 'page') @Default(1) int page,
    @JsonKey(name: 'lastupdate') String? lastUpdate,
  }) = _HomeFeedResponse;

  /// 从JSON解析首页动态响应对象
  /// @param json JSON数据
  /// @return HomeFeedResponse实例
  factory HomeFeedResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeFeedResponseFromJson(json);
}

/// 首页动态数据模型
/// 单个动态/帖子的完整信息
@freezed
class HomeFeedData with _$HomeFeedData {
  /// 构造函数
  /// @param id 动态ID
  /// @param entityType 实体类型（如 feed、article 等）
  /// @param title 标题
  /// @param message 内容
  /// @param picArr 图片数组
  /// @param userInfo 发布者信息
  /// @param action 用户行为状态
  /// @param dateline 发布时间戳
  /// @param replyNum 回复数量
  /// @param forwardNum 转发数量
  /// @param forwardId 转发来源ID
  /// @param forwardSource 转发来源内容
  /// @param deviceTitle 发布设备
  /// @param replyRows 部分回复列表
  /// @param replyRowsMore 是否有更多回复
  const factory HomeFeedData({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'entityType') required String entityType,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'picArr') @Default([]) List<String> picArr,
    @JsonKey(name: 'userInfo') UserInfo? userInfo,
    @JsonKey(name: 'user_action') @Default(UserAction()) UserAction action,
    @JsonKey(name: 'dateline') @Default('') String dateline,
    @JsonKey(name: 'replynum') @Default(0) int replyNum,
    @JsonKey(name: 'forwardnum') @Default(0) int forwardNum,
    @JsonKey(name: 'forwardid') String? forwardId,
    @JsonKey(name: 'forwardSource') String? forwardSource,
    @JsonKey(name: 'device_title') String? deviceTitle,
    @JsonKey(name: 'replyRows') @Default([]) List<dynamic> replyRows,
    @JsonKey(name: 'replyRowsMore') @Default(false) bool replyRowsMore,
  }) = _HomeFeedData;

  /// 从JSON解析动态数据对象
  /// @param json JSON数据
  /// @return HomeFeedData实例
  factory HomeFeedData.fromJson(Map<String, dynamic> json) =>
      _$HomeFeedDataFromJson(json);
}

/// 动态详情响应模型
/// 用于动态详情页接口返回的数据
@freezed
class FeedContentResponse with _$FeedContentResponse {
  /// 构造函数
  /// @param status 状态码
  /// @param message 响应消息
  /// @param data 动态详情数据
  const factory FeedContentResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'data') FeedContentData? data,
  }) = _FeedContentResponse;

  /// 从JSON解析动态详情响应对象
  /// @param json JSON数据
  /// @return FeedContentResponse实例
  factory FeedContentResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedContentResponseFromJson(json);
}

/// 动态详情数据模型
/// 包含动态完整内容和相关信息
@freezed
class FeedContentData with _$FeedContentData {
  /// 构造函数
  /// @param id 动态ID
  /// @param entityType 实体类型
  /// @param title 标题
  /// @param message 内容
  /// @param picArr 图片数组
  /// @param userInfo 发布者信息
  /// @param action 用户行为状态
  /// @param dateline 发布时间
  /// @param replyNum 回复数量
  /// @param forwardNum 转发数量
  /// @param deviceTitle 发布设备
  /// @param replyRows 回复列表
  /// @param isTop 是否置顶
  const factory FeedContentData({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'entityType') required String entityType,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'picArr') @Default([]) List<String> picArr,
    @JsonKey(name: 'userInfo') UserInfo? userInfo,
    @JsonKey(name: 'user_action') @Default(UserAction()) UserAction action,
    @JsonKey(name: 'dateline') @Default('') String dateline,
    @JsonKey(name: 'replynum') @Default(0) int replyNum,
    @JsonKey(name: 'forwardnum') @Default(0) int forwardNum,
    @JsonKey(name: 'device_title') String? deviceTitle,
    @JsonKey(name: 'replyRows') @Default([]) List<dynamic> replyRows,
    @JsonKey(name: 'is_top') @Default(false) bool isTop,
  }) = _FeedContentData;

  /// 从JSON解析动态详情数据对象
  /// @param json JSON数据
  /// @return FeedContentData实例
  factory FeedContentData.fromJson(Map<String, dynamic> json) =>
      _$FeedContentDataFromJson(json);
}

/// 发布动态请求模型
/// 用于发布新动态时的参数
@freezed
class CreateFeedRequest with _$CreateFeedRequest {
  /// 构造函数
  /// @param message 动态内容
  /// @param picArr 图片数组
  /// @param type 动态类型
  /// @param deviceTitle 发布设备
  const factory CreateFeedRequest({
    @JsonKey(name: 'message') required String message,
    @JsonKey(name: 'picArr') @Default([]) List<String> picArr,
    @JsonKey(name: 'type') @Default('feed') String type,
    @JsonKey(name: 'device_title') String? deviceTitle,
  }) = _CreateFeedRequest;

  /// 从JSON解析发布动态请求对象
  /// @param json JSON数据
  /// @return CreateFeedRequest实例
  factory CreateFeedRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateFeedRequestFromJson(json);
}

/// 发布动态响应模型
/// 用于发布动态接口返回的数据
@freezed
class CreateFeedResponse with _$CreateFeedResponse {
  /// 构造函数
  /// @param status 状态码
  /// @param message 响应消息
  /// @param data 发布的动态数据
  const factory CreateFeedResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'data') HomeFeedData? data,
  }) = _CreateFeedResponse;

  /// 从JSON解析发布动态响应对象
  /// @param json JSON数据
  /// @return CreateFeedResponse实例
  factory CreateFeedResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateFeedResponseFromJson(json);
}
