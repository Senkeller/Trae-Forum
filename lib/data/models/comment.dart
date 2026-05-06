import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

/// 评论模型文件
/// 包含评论列表、回复等数据结构

/// 评论列表响应模型
/// 用于评论列表接口返回的数据
@freezed
class TotalReplyResponse with _$TotalReplyResponse {
  /// 构造函数
  /// @param status 状态码
  /// @param message 响应消息
  /// @param data 评论数据列表
  /// @param total 总数
  /// @param page 当前页码
  /// @param lastUpdate 最后更新时间
  const factory TotalReplyResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'data') @Default([]) List<ReplyData> data,
    @JsonKey(name: 'total') @Default(0) int total,
    @JsonKey(name: 'page') @Default(1) int page,
    @JsonKey(name: 'lastupdate') String? lastUpdate,
  }) = _TotalReplyResponse;

  /// 从JSON解析评论列表响应对象
  /// @param json JSON数据
  /// @return TotalReplyResponse实例
  factory TotalReplyResponse.fromJson(Map<String, dynamic> json) =>
      _$TotalReplyResponseFromJson(json);
}

/// 评论/回复数据模型
/// 单个评论或回复的完整信息
@freezed
class ReplyData with _$ReplyData {
  /// 构造函数
  /// @param id 评论ID
  /// @param uid 用户ID
  /// @param username 用户名
  /// @param avatar 用户头像
  /// @param message 评论内容
  /// @param picArr 图片数组
  /// @param dateline 发布时间
  /// @param likeNum 点赞数量
  /// @param isLike 是否已点赞
  /// @param replyNum 回复数量
  /// @param replyRows 子回复列表
  /// @param replyRowsMore 是否有更多子回复
  /// @param replyTo 回复对象用户名
  /// @param replyUid 回复对象用户ID
  /// @param postNumber 帖子楼层号（用于楼中楼回复）
  const factory ReplyData({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'uid') required String uid,
    @JsonKey(name: 'username') @Default('') String username,
    @JsonKey(name: 'avatar') String? avatar,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'picArr') @Default([]) List<String> picArr,
    @JsonKey(name: 'dateline') @Default('') String dateline,
    @JsonKey(name: 'like_num') @Default(0) int likeNum,
    @JsonKey(name: 'is_like') @Default(false) bool isLike,
    @JsonKey(name: 'replynum') @Default(0) int replyNum,
    @JsonKey(name: 'replyRows') @Default([]) List<ReplyData> replyRows,
    @JsonKey(name: 'replyRowsMore') @Default(false) bool replyRowsMore,
    @JsonKey(name: 'reply_to') String? replyTo,
    @JsonKey(name: 'reply_uid') String? replyUid,
    @JsonKey(name: 'post_number') int? postNumber,
  }) = _ReplyData;

  /// 从JSON解析评论数据对象
  /// @param json JSON数据
  /// @return ReplyData实例
  factory ReplyData.fromJson(Map<String, dynamic> json) =>
      _$ReplyDataFromJson(json);
}

/// 发布评论请求模型
/// 用于发布评论时的参数
@freezed
class CreateReplyRequest with _$CreateReplyRequest {
  /// 构造函数
  /// @param id 动态/帖子ID
  /// @param message 评论内容
  /// @param picArr 图片数组
  /// @param replyId 回复的评论ID（二级回复时使用）
  /// @param replyUid 回复的用户ID
  const factory CreateReplyRequest({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'message') required String message,
    @JsonKey(name: 'picArr') @Default([]) List<String> picArr,
    @JsonKey(name: 'reply_id') String? replyId,
    @JsonKey(name: 'reply_uid') String? replyUid,
  }) = _CreateReplyRequest;

  /// 从JSON解析发布评论请求对象
  /// @param json JSON数据
  /// @return CreateReplyRequest实例
  factory CreateReplyRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateReplyRequestFromJson(json);
}

/// 发布评论响应模型
/// 用于发布评论接口返回的数据
@freezed
class CreateReplyResponse with _$CreateReplyResponse {
  /// 构造函数
  /// @param status 状态码
  /// @param message 响应消息
  /// @param data 发布的评论数据
  const factory CreateReplyResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'data') ReplyData? data,
  }) = _CreateReplyResponse;

  /// 从JSON解析发布评论响应对象
  /// @param json JSON数据
  /// @return CreateReplyResponse实例
  factory CreateReplyResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateReplyResponseFromJson(json);
}

/// 子回复列表响应模型
/// 用于获取子回复列表接口返回的数据
@freezed
class SubReplyResponse with _$SubReplyResponse {
  /// 构造函数
  /// @param status 状态码
  /// @param message 响应消息
  /// @param data 子回复数据列表
  /// @param total 总数
  const factory SubReplyResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'data') @Default([]) List<ReplyData> data,
    @JsonKey(name: 'total') @Default(0) int total,
  }) = _SubReplyResponse;

  /// 从JSON解析子回复列表响应对象
  /// @param json JSON数据
  /// @return SubReplyResponse实例
  factory SubReplyResponse.fromJson(Map<String, dynamic> json) =>
      _$SubReplyResponseFromJson(json);
}

/// 创建评论结果模型
/// 用于 createComment 方法返回的结果
class CommentResult {
  /// 是否成功
  final bool success;

  /// 错误消息（失败时）
  final String? errorMessage;

  /// 创建的帖子ID（成功时）
  final int? postId;

  /// 构造函数
  /// @param success 是否成功
  /// @param errorMessage 错误消息
  /// @param postId 帖子ID
  const CommentResult({required this.success, this.errorMessage, this.postId});

  /// 创建成功结果
  /// @param postId 帖子ID（可选）
  /// @return CommentResult实例
  factory CommentResult.success({int? postId}) {
    return CommentResult(success: true, postId: postId);
  }

  /// 创建失败结果
  /// @param message 错误消息
  /// @return CommentResult实例
  factory CommentResult.failure(String message) {
    return CommentResult(success: false, errorMessage: message);
  }

  @override
  String toString() =>
      'CommentResult(success: $success, postId: $postId, errorMessage: $errorMessage)';
}

/// 评论图片上传结果模型
///
/// 用于 uploadCommentImage 方法返回的结果
class CommentImageUploadResult {
  /// 是否成功
  final bool success;

  /// Markdown 图片片段（成功时）
  final String? markdown;

  /// 错误消息（失败时）
  final String? errorMessage;

  const CommentImageUploadResult({
    required this.success,
    this.markdown,
    this.errorMessage,
  });

  factory CommentImageUploadResult.success(String markdown) {
    return CommentImageUploadResult(success: true, markdown: markdown);
  }

  factory CommentImageUploadResult.failure(String message) {
    return CommentImageUploadResult(success: false, errorMessage: message);
  }
}
