import 'package:freezed_annotation/freezed_annotation.dart';

part 'reply_result.freezed.dart';
part 'reply_result.g.dart';

/// 回复操作结果模型
///
/// 用于表示回复操作的结果状态，包含成功/失败信息、帖子ID和错误消息
@freezed
class ReplyResult with _$ReplyResult {
  /// 构造函数
  ///
  /// [success] 操作是否成功
  /// [postId] 创建的帖子ID（成功时返回）
  /// [errorMessage] 错误信息（失败时返回）
  const factory ReplyResult({
    @Default(false) bool success,
    int? postId,
    String? errorMessage,
  }) = _ReplyResult;

  /// 从JSON解析结果对象
  ///
  /// [json] JSON数据
  /// @return ReplyResult实例
  factory ReplyResult.fromJson(Map<String, dynamic> json) =>
      _$ReplyResultFromJson(json);

  /// 创建成功结果
  ///
  /// [postId] 创建的帖子ID
  /// @return 成功的ReplyResult实例
  factory ReplyResult.success({int? postId}) => ReplyResult(
        success: true,
        postId: postId,
      );

  /// 创建失败结果
  ///
  /// [message] 错误信息
  /// @return 失败的ReplyResult实例
  factory ReplyResult.failure(String message) => ReplyResult(
        success: false,
        errorMessage: message,
      );
}
