import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/network/api_service.dart';
import '../../core/network/dio_client.dart';
import 'auth_provider.dart';

part 'message_provider.g.dart';

/// 消息类型枚举
enum MessageType {
  /// 通知消息
  notification,
  /// @我的
  atMe,
  /// 评论
  comment,
  /// 私信
  private,
  /// 点赞
  like,
}

/// 消息数据模型
class MessageItem {
  /// 消息ID
  final String id;
  /// 消息类型
  final MessageType type;
  /// 发送者UID
  final String fromUid;
  /// 发送者用户名
  final String fromUsername;
  /// 发送者头像
  final String fromAvatar;
  /// 消息标题
  final String title;
  /// 消息内容
  final String content;
  /// 关联的动态ID
  final String? feedId;
  /// 关联的评论ID
  final String? replyId;
  /// 发送时间
  final String createTime;
  /// 是否已读
  final bool isRead;

  const MessageItem({
    required this.id,
    required this.type,
    required this.fromUid,
    required this.fromUsername,
    required this.fromAvatar,
    required this.title,
    required this.content,
    this.feedId,
    this.replyId,
    required this.createTime,
    this.isRead = false,
  });

  /// 从 JSON 创建
  factory MessageItem.fromJson(Map<String, dynamic> json) {
    MessageType type = MessageType.notification;
    final typeStr = json['type']?.toString() ?? '';
    switch (typeStr) {
      case 'at':
        type = MessageType.atMe;
        break;
      case 'comment':
        type = MessageType.comment;
        break;
      case 'message':
        type = MessageType.private;
        break;
      case 'like':
        type = MessageType.like;
        break;
      default:
        type = MessageType.notification;
    }

    return MessageItem(
      id: json['id']?.toString() ?? '',
      type: type,
      fromUid: json['fromuid']?.toString() ?? '',
      fromUsername: json['fromusername'] ?? '',
      fromAvatar: json['fromuseravatar'] ?? '',
      title: json['title'] ?? '',
      content: json['message'] ?? json['content'] ?? '',
      feedId: json['fid']?.toString(),
      replyId: json['rid']?.toString(),
      createTime: json['dateline']?.toString() ?? '',
      isRead: json['isread'] == 1 || json['isread'] == true,
    );
  }

  /// 复制并修改
  MessageItem copyWith({
    String? id,
    MessageType? type,
    String? fromUid,
    String? fromUsername,
    String? fromAvatar,
    String? title,
    String? content,
    String? feedId,
    String? replyId,
    String? createTime,
    bool? isRead,
  }) {
    return MessageItem(
      id: id ?? this.id,
      type: type ?? this.type,
      fromUid: fromUid ?? this.fromUid,
      fromUsername: fromUsername ?? this.fromUsername,
      fromAvatar: fromAvatar ?? this.fromAvatar,
      title: title ?? this.title,
      content: content ?? this.content,
      feedId: feedId ?? this.feedId,
      replyId: replyId ?? this.replyId,
      createTime: createTime ?? this.createTime,
      isRead: isRead ?? this.isRead,
    );
  }
}

/// 未读消息计数
class UnreadCount {
  /// 通知消息未读数
  final int notification;
  /// @我的未读数
  final int atMe;
  /// 评论未读数
  final int comment;
  /// 私信未读数
  final int private;
  /// 点赞未读数
  final int like;
  /// 总未读数
  final int total;

  const UnreadCount({
    this.notification = 0,
    this.atMe = 0,
    this.comment = 0,
    this.private = 0,
    this.like = 0,
    this.total = 0,
  });

  /// 从 JSON 创建
  factory UnreadCount.fromJson(Map<String, dynamic> json) {
    return UnreadCount(
      notification: json['notification'] ?? 0,
      atMe: json['atme'] ?? 0,
      comment: json['comment'] ?? 0,
      private: json['message'] ?? 0,
      like: json['like'] ?? 0,
      total: json['total'] ?? 0,
    );
  }
}

/// 消息状态类
class MessageState {
  /// 消息列表
  final List<MessageItem> messages;
  /// 未读消息计数
  final UnreadCount unreadCount;
  /// 当前消息类型
  final MessageType currentType;
  /// 是否正在加载
  final bool isLoading;
  /// 是否正在刷新
  final bool isRefreshing;
  /// 是否正在加载更多
  final bool isLoadingMore;
  /// 当前页码
  final int currentPage;
  /// 是否还有更多
  final bool hasMore;
  /// 错误信息
  final String? errorMessage;

  const MessageState({
    this.messages = const [],
    this.unreadCount = const UnreadCount(),
    this.currentType = MessageType.notification,
    this.isLoading = false,
    this.isRefreshing = false,
    this.isLoadingMore = false,
    this.currentPage = 1,
    this.hasMore = true,
    this.errorMessage,
  });

  /// 复制并修改
  MessageState copyWith({
    List<MessageItem>? messages,
    UnreadCount? unreadCount,
    MessageType? currentType,
    bool? isLoading,
    bool? isRefreshing,
    bool? isLoadingMore,
    int? currentPage,
    bool? hasMore,
    String? errorMessage,
  }) {
    return MessageState(
      messages: messages ?? this.messages,
      unreadCount: unreadCount ?? this.unreadCount,
      currentType: currentType ?? this.currentType,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage,
    );
  }
}

/// 消息状态 Notifier
@riverpod
class MessageNotifier extends _$MessageNotifier {
  late ApiService _apiService;

  /// 构建消息状态
  @override
  MessageState build() {
    _apiService = ref.read(apiServiceProvider);
    return const MessageState();
  }

  /// 获取消息列表的 API URL
  String _getMessageUrl(MessageType type) {
    switch (type) {
      case MessageType.notification:
        return '/v6/notification/list';
      case MessageType.atMe:
        return '/v6/notification/atMeList';
      case MessageType.comment:
        return '/v6/notification/commentList';
      case MessageType.private:
        return '/v6/message/list';
      case MessageType.like:
        return '/v6/notification/likeList';
    }
  }

  /// 切换消息类型
  ///
  /// [type] 要切换到的消息类型
  void switchType(MessageType type) {
    state = state.copyWith(currentType: type);
    loadMessages();
  }

  /// 加载消息列表
  ///
  /// 根据当前消息类型加载对应的消息列表
  Future<void> loadMessages() async {
    final isAuthenticated = ref.read(isAuthenticatedProvider);
    if (!isAuthenticated) {
      state = state.copyWith(errorMessage: '请先登录');
      return;
    }

    if (state.isLoading) return;

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      currentPage: 1,
    );

    try {
      final url = _getMessageUrl(state.currentType);
      final response = await _apiService.getMessage(
        url: url,
        page: 1,
      );

      if (response.status == 1 && response.data != null) {
        final messages = (response.data as List<dynamic>)
            .map((item) => MessageItem.fromJson(item as Map<String, dynamic>))
            .toList();

        state = state.copyWith(
          messages: messages,
          isLoading: false,
          hasMore: messages.length >= 20,
          currentPage: 1,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: '加载消息失败',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '网络错误: $e',
      );
    }
  }

  /// 刷新消息列表
  Future<void> refreshMessages() async {
    final isAuthenticated = ref.read(isAuthenticatedProvider);
    if (!isAuthenticated) return;

    if (state.isRefreshing) return;

    state = state.copyWith(
      isRefreshing: true,
      errorMessage: null,
    );

    try {
      final url = _getMessageUrl(state.currentType);
      final response = await _apiService.getMessage(
        url: url,
        page: 1,
      );

      if (response.status == 1 && response.data != null) {
        final messages = (response.data as List<dynamic>)
            .map((item) => MessageItem.fromJson(item as Map<String, dynamic>))
            .toList();

        state = state.copyWith(
          messages: messages,
          isRefreshing: false,
          hasMore: messages.length >= 20,
          currentPage: 1,
        );
      } else {
        state = state.copyWith(
          isRefreshing: false,
          errorMessage: '刷新消息失败',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isRefreshing: false,
        errorMessage: '网络错误: $e',
      );
    }
  }

  /// 加载更多消息
  Future<void> loadMoreMessages() async {
    final isAuthenticated = ref.read(isAuthenticatedProvider);
    if (!isAuthenticated) return;

    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(
      isLoadingMore: true,
      errorMessage: null,
    );

    try {
      final nextPage = state.currentPage + 1;
      final url = _getMessageUrl(state.currentType);

      final response = await _apiService.getMessage(
        url: url,
        page: nextPage,
      );

      if (response.status == 1 && response.data != null) {
        final newMessages = (response.data as List<dynamic>)
            .map((item) => MessageItem.fromJson(item as Map<String, dynamic>))
            .toList();

        if (newMessages.isEmpty) {
          state = state.copyWith(
            isLoadingMore: false,
            hasMore: false,
          );
        } else {
          state = state.copyWith(
            messages: [...state.messages, ...newMessages],
            isLoadingMore: false,
            currentPage: nextPage,
            hasMore: newMessages.length >= 20,
          );
        }
      } else {
        state = state.copyWith(
          isLoadingMore: false,
          errorMessage: '加载更多失败',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: '网络错误: $e',
      );
    }
  }

  /// 检查未读消息数量
  ///
  /// 从服务器获取最新的未读消息计数
  Future<void> checkUnreadCount() async {
    final isAuthenticated = ref.read(isAuthenticatedProvider);
    if (!isAuthenticated) return;

    try {
      final response = await _apiService.checkCount();

      if (response.status == 1 && response.data != null) {
        final unreadCount = UnreadCount.fromJson(
          response.data as Map<String, dynamic>,
        );
        state = state.copyWith(unreadCount: unreadCount);
      }
    } catch (e) {
      // 获取未读数失败，不更新状态
    }
  }

  /// 标记消息为已读
  ///
  /// [messageId] 要标记的消息ID，为空则标记当前类型所有消息
  Future<void> markAsRead([String? messageId]) async {
    final isAuthenticated = ref.read(isAuthenticatedProvider);
    if (!isAuthenticated) return;

    try {
      // 更新本地状态
      if (messageId != null) {
        final updatedMessages = state.messages.map((msg) {
          if (msg.id == messageId) {
            return msg.copyWith(isRead: true);
          }
          return msg;
        }).toList();
        state = state.copyWith(messages: updatedMessages);
      } else {
        // 标记所有当前类型的消息为已读
        final updatedMessages = state.messages.map((msg) {
          return msg.copyWith(isRead: true);
        }).toList();
        state = state.copyWith(messages: updatedMessages);
      }

      // 刷新未读数
      await checkUnreadCount();
    } catch (e) {
      // 标记失败
    }
  }

  /// 删除消息
  ///
  /// [messageId] 要删除的消息ID
  Future<bool> deleteMessage(String messageId) async {
    final isAuthenticated = ref.read(isAuthenticatedProvider);
    if (!isAuthenticated) return false;

    try {
      // 从列表中移除
      final updatedMessages = state.messages
          .where((msg) => msg.id != messageId)
          .toList();
      state = state.copyWith(messages: updatedMessages);
      return true;
    } catch (e) {
      state = state.copyWith(errorMessage: '删除失败: $e');
      return false;
    }
  }

  /// 清空错误信息
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// 消息列表 Provider
@riverpod
List<MessageItem> messageList(MessageListRef ref) {
  return ref.watch(messageNotifierProvider).messages;
}

/// 未读消息计数 Provider
@riverpod
UnreadCount unreadMessageCount(UnreadMessageCountRef ref) {
  return ref.watch(messageNotifierProvider).unreadCount;
}

/// 总未读消息数 Provider
@riverpod
int totalUnreadCount(TotalUnreadCountRef ref) {
  return ref.watch(messageNotifierProvider).unreadCount.total;
}

/// 当前消息类型 Provider
@riverpod
MessageType currentMessageType(CurrentMessageTypeRef ref) {
  return ref.watch(messageNotifierProvider).currentType;
}

/// 是否正在加载消息 Provider
@riverpod
bool isMessageLoading(IsMessageLoadingRef ref) {
  return ref.watch(messageNotifierProvider).isLoading;
}

/// 消息类型扩展
extension MessageTypeExtension on MessageType {
  /// 获取消息类型的显示名称
  String get displayName {
    switch (this) {
      case MessageType.notification:
        return '通知';
      case MessageType.atMe:
        return '@我的';
      case MessageType.comment:
        return '评论';
      case MessageType.private:
        return '私信';
      case MessageType.like:
        return '点赞';
    }
  }

  /// 获取消息类型的图标名称
  String get iconName {
    switch (this) {
      case MessageType.notification:
        return 'notifications';
      case MessageType.atMe:
        return 'alternate_email';
      case MessageType.comment:
        return 'comment';
      case MessageType.private:
        return 'message';
      case MessageType.like:
        return 'favorite';
    }
  }
}
