import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/network/api_service.dart' as api;

part 'message_repository.g.dart';

/// 消息仓库
/// 负责处理消息相关的数据操作，包括获取消息列表、标记已读、检查未读数量等
@riverpod
MessageRepository messageRepository(MessageRepositoryRef ref) {
  final apiService = ref.read(api.apiServiceProvider);
  return MessageRepository(apiService);
}

/// 消息仓库类
class MessageRepository {
  final api.ApiService _apiService;

  MessageRepository(this._apiService);

  /// 获取消息列表
  ///
  /// [url] 消息列表 URL
  Future<api.MessageResponse> getMessageList({
    required String url,
    required int page,
    String? lastItem,
  }) async {
    return await _apiService.getMessage(url: url, page: page, lastItem: lastItem);
  }

  /// 检查未读消息数量
  Future<api.CheckCountResponse> checkUnreadCount() async {
    return await _apiService.checkCount();
  }

  /// 标记消息已读
  ///
  /// [messageId] 消息 ID
  Future<void> markAsRead({
    required String messageId,
  }) async {
  }
}
