import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';

part 'topic.freezed.dart';
part 'topic.g.dart';

/// 话题模型文件
/// 包含话题列表、话题详情等数据结构

/// 话题列表响应模型
/// 用于话题列表接口返回的数据
@freezed
class TopicListResponse with _$TopicListResponse {
  /// 构造函数
  /// @param status 状态码
  /// @param message 响应消息
  /// @param data 话题数据列表
  /// @param total 总数
  /// @param page 当前页码
  const factory TopicListResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'data') @Default([]) List<TopicData> data,
    @JsonKey(name: 'total') @Default(0) int total,
    @JsonKey(name: 'page') @Default(1) int page,
  }) = _TopicListResponse;

  /// 从JSON解析话题列表响应对象
  /// @param json JSON数据
  /// @return TopicListResponse实例
  factory TopicListResponse.fromJson(Map<String, dynamic> json) =>
      _$TopicListResponseFromJson(json);
}

/// 话题数据模型
/// 单个话题的完整信息
@freezed
class TopicData with _$TopicData {
  /// 构造函数
  /// @param id 话题ID
  /// @param title 话题标题
  /// @param description 话题描述
  /// @param cover 话题封面图
  /// @param discussNum 讨论数量
  /// @param followNum 关注数量
  /// @param isFollow 是否已关注
  /// @param creator 创建者信息
  /// @param createTime 创建时间
  /// @param updateTime 更新时间
  const factory TopicData({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'description') @Default('') String description,
    @JsonKey(name: 'cover') String? cover,
    @JsonKey(name: 'discuss_num') @Default(0) int discussNum,
    @JsonKey(name: 'follow_num') @Default(0) int followNum,
    @JsonKey(name: 'is_follow') @Default(false) bool isFollow,
    @JsonKey(name: 'creator') UserInfo? creator,
    @JsonKey(name: 'create_time') String? createTime,
    @JsonKey(name: 'update_time') String? updateTime,
  }) = _TopicData;

  /// 从JSON解析话题数据对象
  /// @param json JSON数据
  /// @return TopicData实例
  factory TopicData.fromJson(Map<String, dynamic> json) =>
      _$TopicDataFromJson(json);
}

/// 话题详情响应模型
/// 用于话题详情页接口返回的数据
@freezed
class TopicDetailResponse with _$TopicDetailResponse {
  /// 构造函数
  /// @param status 状态码
  /// @param message 响应消息
  /// @param data 话题详情数据
  const factory TopicDetailResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'data') TopicDetailData? data,
  }) = _TopicDetailResponse;

  /// 从JSON解析话题详情响应对象
  /// @param json JSON数据
  /// @return TopicDetailResponse实例
  factory TopicDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$TopicDetailResponseFromJson(json);
}

/// 话题详情数据模型
/// 包含话题完整信息和相关动态
@freezed
class TopicDetailData with _$TopicDetailData {
  /// 构造函数
  /// @param topic 话题基础信息
  /// @param feeds 话题下的动态列表
  /// @param hotFeeds 热门动态列表
  /// @param contributors 贡献者列表
  const factory TopicDetailData({
    @JsonKey(name: 'topic') required TopicData topic,
    @JsonKey(name: 'feeds') @Default([]) List<dynamic> feeds,
    @JsonKey(name: 'hot_feeds') @Default([]) List<dynamic> hotFeeds,
    @JsonKey(name: 'contributors') @Default([]) List<UserInfo> contributors,
  }) = _TopicDetailData;

  /// 从JSON解析话题详情数据对象
  /// @param json JSON数据
  /// @return TopicDetailData实例
  factory TopicDetailData.fromJson(Map<String, dynamic> json) =>
      _$TopicDetailDataFromJson(json);
}

/// 推荐话题响应模型
/// 用于推荐话题接口返回的数据
@freezed
class RecommendTopicResponse with _$RecommendTopicResponse {
  /// 构造函数
  /// @param status 状态码
  /// @param message 响应消息
  /// @param data 推荐话题列表
  const factory RecommendTopicResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'data') @Default([]) List<TopicData> data,
  }) = _RecommendTopicResponse;

  /// 从JSON解析推荐话题响应对象
  /// @param json JSON数据
  /// @return RecommendTopicResponse实例
  factory RecommendTopicResponse.fromJson(Map<String, dynamic> json) =>
      _$RecommendTopicResponseFromJson(json);
}

/// 话题搜索响应模型
/// 用于话题搜索接口返回的数据
@freezed
class TopicSearchResponse with _$TopicSearchResponse {
  /// 构造函数
  /// @param status 状态码
  /// @param message 响应消息
  /// @param data 搜索结果列表
  /// @param total 总数
  const factory TopicSearchResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'data') @Default([]) List<TopicData> data,
    @JsonKey(name: 'total') @Default(0) int total,
  }) = _TopicSearchResponse;

  /// 从JSON解析话题搜索响应对象
  /// @param json JSON数据
  /// @return TopicSearchResponse实例
  factory TopicSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$TopicSearchResponseFromJson(json);
}

/// 话题关注操作响应模型
/// 用于关注/取消关注话题接口返回的数据
@freezed
class TopicFollowResponse with _$TopicFollowResponse {
  /// 构造函数
  /// @param status 状态码
  /// @param message 响应消息
  /// @param isFollow 当前关注状态
  /// @param followNum 当前关注数量
  const factory TopicFollowResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'is_follow') @Default(false) bool isFollow,
    @JsonKey(name: 'follow_num') @Default(0) int followNum,
  }) = _TopicFollowResponse;

  /// 从JSON解析话题关注响应对象
  /// @param json JSON数据
  /// @return TopicFollowResponse实例
  factory TopicFollowResponse.fromJson(Map<String, dynamic> json) =>
      _$TopicFollowResponseFromJson(json);
}
