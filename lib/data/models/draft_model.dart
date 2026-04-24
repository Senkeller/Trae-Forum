import 'package:freezed_annotation/freezed_annotation.dart';

part 'draft_model.freezed.dart';
part 'draft_model.g.dart';

/// 草稿模型
///
/// 用于保存用户未发送的回复草稿
@freezed
class DraftModel with _$DraftModel {
  /// 构造函数
  ///
  /// [topicId] 话题ID
  /// [content] 草稿内容
  /// [savedAt] 保存时间（ISO 8601格式）
  /// [replyToPostNumber] 回复目标楼层号（可选）
  /// [replyToUsername] 回复目标用户名（可选）
  const factory DraftModel({
    required int topicId,
    required String content,
    required String savedAt,
    int? replyToPostNumber,
    String? replyToUsername,
  }) = _DraftModel;

  /// 从JSON解析草稿对象
  ///
  /// [json] JSON数据
  /// @return DraftModel实例
  factory DraftModel.fromJson(Map<String, dynamic> json) =>
      _$DraftModelFromJson(json);

  /// 创建新的草稿
  ///
  /// [topicId] 话题ID
  /// [content] 草稿内容
  /// [replyToPostNumber] 回复目标楼层号（可选）
  /// [replyToUsername] 回复目标用户名（可选）
  /// @return DraftModel实例
  factory DraftModel.create({
    required int topicId,
    required String content,
    int? replyToPostNumber,
    String? replyToUsername,
  }) =>
      DraftModel(
        topicId: topicId,
        content: content,
        savedAt: DateTime.now().toIso8601String(),
        replyToPostNumber: replyToPostNumber,
        replyToUsername: replyToUsername,
      );
}

/// 草稿Key生成工具类
///
/// 用于生成Discourse草稿系统的draft_key
class DraftKey {
  /// 话题回复草稿key
  ///
  /// [topicId] 话题ID
  /// @return 草稿key字符串
  static String topicReply(int topicId) => 'topic_$topicId';

  /// 楼中楼回复草稿key
  ///
  /// [topicId] 话题ID
  /// [postNumber] 回复目标帖子编号
  /// @return 草稿key字符串
  static String nestedReply(int topicId, int postNumber) =>
      'topic_$topicId\_$postNumber';

  /// 新话题草稿key
  ///
  /// @return 草稿key字符串
  static String newTopic() => 'new_topic';

  /// 私信草稿key
  ///
  /// [recipient] 收件人用户名
  /// @return 草稿key字符串
  static String privateMessage(String recipient) => 'new_private_message_$recipient';
}

/// 草稿序列管理
///
/// 用于管理草稿的序列号，确保草稿版本一致性
class DraftSequence {
  static int _sequence = 1;

  /// 获取下一个序列号
  ///
  /// @return 递增的序列号
  static int next() => _sequence++;

  /// 重置序列号
  static void reset() => _sequence = 1;
}
