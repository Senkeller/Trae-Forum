import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/discourse/discourse_post.dart';
import '../../data/models/discourse/discourse_private_message.dart';
import '../../data/repositories/private_message_repository.dart';
import 'auth_provider.dart';

part 'private_message_provider.g.dart';

/// 私信会话状态
class PrivateMessageConversationState {
  /// 会话列表
  final List<PrivateMessageConversation> conversations;
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
  /// 总未读数
  final int totalUnreadCount;

  const PrivateMessageConversationState({
    this.conversations = const [],
    this.isLoading = false,
    this.isRefreshing = false,
    this.isLoadingMore = false,
    this.currentPage = 0,
    this.hasMore = true,
    this.errorMessage,
    this.totalUnreadCount = 0,
  });

  PrivateMessageConversationState copyWith({
    List<PrivateMessageConversation>? conversations,
    bool? isLoading,
    bool? isRefreshing,
    bool? isLoadingMore,
    int? currentPage,
    bool? hasMore,
    String? errorMessage,
    int? totalUnreadCount,
  }) {
    return PrivateMessageConversationState(
      conversations: conversations ?? this.conversations,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage,
      totalUnreadCount: totalUnreadCount ?? this.totalUnreadCount,
    );
  }
}

/// 私信聊天状态
class PrivateMessageChatState {
  /// 当前会话ID
  final int? topicId;
  /// 会话标题
  final String? title;
  /// 消息列表
  final List<DiscoursePost> messages;
  /// 参与者列表
  final List<DiscourseUserBasic> participants;
  /// 是否正在加载
  final bool isLoading;
  /// 是否正在发送
  final bool isSending;
  /// 是否还有更多历史消息
  final bool hasMore;
  /// 当前页码
  final int currentPage;
  /// 错误信息
  final String? errorMessage;
  /// 未读数
  final int unreadCount;
  /// 是否已关闭
  final bool isClosed;
  /// 是否已归档
  final bool isArchived;

  const PrivateMessageChatState({
    this.topicId,
    this.title,
    this.messages = const [],
    this.participants = const [],
    this.isLoading = false,
    this.isSending = false,
    this.hasMore = true,
    this.currentPage = 0,
    this.errorMessage,
    this.unreadCount = 0,
    this.isClosed = false,
    this.isArchived = false,
  });

  PrivateMessageChatState copyWith({
    int? topicId,
    String? title,
    List<DiscoursePost>? messages,
    List<DiscourseUserBasic>? participants,
    bool? isLoading,
    bool? isSending,
    bool? hasMore,
    int? currentPage,
    String? errorMessage,
    int? unreadCount,
    bool? isClosed,
    bool? isArchived,
  }) {
    return PrivateMessageChatState(
      topicId: topicId ?? this.topicId,
      title: title ?? this.title,
      messages: messages ?? this.messages,
      participants: participants ?? this.participants,
      isLoading: isLoading ?? this.isLoading,
      isSending: isSending ?? this.isSending,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage,
      unreadCount: unreadCount ?? this.unreadCount,
      isClosed: isClosed ?? this.isClosed,
      isArchived: isArchived ?? this.isArchived,
    );
  }

  /// 获取对方用户（非当前用户）
  DiscourseUserBasic? getOtherParticipant(String currentUsername) {
    try {
      return participants.firstWhere(
        (p) => p.username != currentUsername,
      );
    } catch (e) {
      return participants.isNotEmpty ? participants.first : null;
    }
  }
}

/// 私信会话列表 Notifier
@riverpod
class PrivateMessageConversationNotifier extends _$PrivateMessageConversationNotifier {
  late PrivateMessageRepository _repository;

  @override
  PrivateMessageConversationState build() {
    _repository = ref.read(privateMessageRepositoryProvider);
    return const PrivateMessageConversationState();
  }

  /// 加载会话列表
  Future<void> loadConversations() async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null || currentUser.username.isEmpty) {
      state = state.copyWith(errorMessage: '请先登录');
      return;
    }

    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, errorMessage: null, currentPage: 0);

    try {
      final response = await _repository.getConversations(
        username: currentUser.username,
        page: 0,
      );

      final conversations = _repository.convertToConversations(
        response,
        currentUser.username,
      );

      // 计算总未读数
      final totalUnread = conversations.fold<int>(
        0,
        (sum, conv) => sum + conv.unreadCount,
      );

      state = state.copyWith(
        conversations: conversations,
        isLoading: false,
        hasMore: (response.topicList?.topics.length ?? 0) >= 30,
        currentPage: 0,
        totalUnreadCount: totalUnread,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '加载会话失败: $e',
      );
    }
  }

  /// 刷新会话列表
  Future<void> refreshConversations() async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null || currentUser.username.isEmpty) return;

    if (state.isRefreshing) return;

    state = state.copyWith(isRefreshing: true, errorMessage: null);

    try {
      final response = await _repository.getConversations(
        username: currentUser.username,
        page: 0,
      );

      final conversations = _repository.convertToConversations(
        response,
        currentUser.username,
      );

      // 计算总未读数
      final totalUnread = conversations.fold<int>(
        0,
        (sum, conv) => sum + conv.unreadCount,
      );

      state = state.copyWith(
        conversations: conversations,
        isRefreshing: false,
        hasMore: (response.topicList?.topics.length ?? 0) >= 30,
        currentPage: 0,
        totalUnreadCount: totalUnread,
      );
    } catch (e) {
      state = state.copyWith(
        isRefreshing: false,
        errorMessage: '刷新会话失败: $e',
      );
    }
  }

  /// 加载更多会话
  Future<void> loadMoreConversations() async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null || currentUser.username.isEmpty) return;

    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true, errorMessage: null);

    try {
      final nextPage = state.currentPage + 1;
      final response = await _repository.getConversations(
        username: currentUser.username,
        page: nextPage,
      );

      final newConversations = _repository.convertToConversations(
        response,
        currentUser.username,
      );

      if (newConversations.isEmpty) {
        state = state.copyWith(
          isLoadingMore: false,
          hasMore: false,
        );
      } else {
        // 计算总未读数
        final allConversations = [...state.conversations, ...newConversations];
        final totalUnread = allConversations.fold<int>(
          0,
          (sum, conv) => sum + conv.unreadCount,
        );

        state = state.copyWith(
          conversations: allConversations,
          isLoadingMore: false,
          currentPage: nextPage,
          hasMore: newConversations.length >= 30,
          totalUnreadCount: totalUnread,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: '加载更多失败: $e',
      );
    }
  }

  /// 更新会话未读数
  Future<void> updateUnreadCount() async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null || currentUser.username.isEmpty) return;

    try {
      final unreadCounts = await _repository.getUnreadCounts(
        username: currentUser.username,
      );

      // 更新会话列表中的未读数
      final updatedConversations = state.conversations.map((conv) {
        final unread = unreadCounts.firstWhere(
          (u) => u.topicId == conv.id,
          orElse: () => PrivateMessageUnreadCount(
            topicId: conv.id,
            unreadCount: 0,
          ),
        );
        return conv.copyWith(unreadCount: unread.unreadCount);
      }).toList();

      final totalUnread = updatedConversations.fold<int>(
        0,
        (sum, conv) => sum + conv.unreadCount,
      );

      state = state.copyWith(
        conversations: updatedConversations,
        totalUnreadCount: totalUnread,
      );
    } catch (e) {
      // 静默处理错误
    }
  }

  /// 删除会话（离开会话）
  Future<bool> leaveConversation(int topicId) async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null || currentUser.username.isEmpty) return false;

    try {
      final success = await _repository.leaveConversation(
        topicId: topicId,
        username: currentUser.username,
      );

      if (success) {
        // 从列表中移除
        final updatedConversations = state.conversations
            .where((conv) => conv.id != topicId)
            .toList();

        final totalUnread = updatedConversations.fold<int>(
          0,
          (sum, conv) => sum + conv.unreadCount,
        );

        state = state.copyWith(
          conversations: updatedConversations,
          totalUnreadCount: totalUnread,
        );
      }

      return success;
    } catch (e) {
      return false;
    }
  }

  /// 清空错误信息
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// 私信聊天 Notifier
@riverpod
class PrivateMessageChatNotifier extends _$PrivateMessageChatNotifier {
  late PrivateMessageRepository _repository;

  @override
  PrivateMessageChatState build() {
    _repository = ref.read(privateMessageRepositoryProvider);
    return const PrivateMessageChatState();
  }

  /// 加载聊天消息
  Future<void> loadMessages(int topicId) async {
    if (state.isLoading) return;

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      topicId: topicId,
      currentPage: 0,
      messages: [],
    );

    try {
      // 并行加载详情和消息
      final results = await Future.wait([
        _repository.getConversationDetail(topicId: topicId),
        _repository.getMessages(topicId: topicId, page: 0),
      ]);

      final detail = results[0] as DiscoursePrivateMessageDetailResponse;
      final messages = results[1] as List<DiscoursePost>;

      // 合并参与者信息
      final participants = <DiscourseUserBasic>[
        ...detail.allowedUsers,
        ...detail.participants.map((p) => DiscourseUserBasic(
              id: p.id,
              username: p.username,
              name: p.name,
              avatarTemplate: p.avatarTemplate,
            )),
      ];

      // 去重
      final uniqueParticipants = <String, DiscourseUserBasic>{};
      for (final p in participants) {
        uniqueParticipants[p.username] = p;
      }

      state = state.copyWith(
        isLoading: false,
        title: detail.fancyTitle ?? detail.title,
        messages: messages,
        participants: uniqueParticipants.values.toList(),
        hasMore: messages.length >= 20,
        currentPage: 0,
        unreadCount: detail.unreadPosts ?? 0,
        isClosed: detail.closed ?? false,
        isArchived: detail.archived ?? false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '加载消息失败: $e',
      );
    }
  }

  /// 加载更多历史消息
  Future<void> loadMoreMessages() async {
    final topicId = state.topicId;
    if (topicId == null || state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final nextPage = state.currentPage + 1;
      final messages = await _repository.getMessages(
        topicId: topicId,
        page: nextPage,
      );

      if (messages.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          hasMore: false,
        );
      } else {
        // 将新消息添加到开头（历史消息）
        final allMessages = [...messages, ...state.messages];
        state = state.copyWith(
          isLoading: false,
          messages: allMessages,
          currentPage: nextPage,
          hasMore: messages.length >= 20,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '加载更多失败: $e',
      );
    }
  }

  /// 发送消息
  Future<bool> sendMessage(String content) async {
    final topicId = state.topicId;
    if (topicId == null || content.trim().isEmpty) return false;

    if (state.isSending) return false;

    state = state.copyWith(isSending: true, errorMessage: null);

    try {
      final response = await _repository.replyToMessage(
        topicId: topicId,
        content: content.trim(),
      );

      if (response.errors != null && response.errors!.isNotEmpty) {
        state = state.copyWith(
          isSending: false,
          errorMessage: response.errors!.first,
        );
        return false;
      }

      // 发送成功，刷新消息列表
      await loadMessages(topicId);
      state = state.copyWith(isSending: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isSending: false,
        errorMessage: '发送失败: $e',
      );
      return false;
    }
  }

  /// 创建新私信
  Future<int?> createConversation({
    required String title,
    required String content,
    required List<String> targetUsernames,
  }) async {
    if (title.trim().isEmpty || content.trim().isEmpty || targetUsernames.isEmpty) {
      return null;
    }

    state = state.copyWith(isSending: true, errorMessage: null);

    try {
      final response = await _repository.sendPrivateMessage(
        title: title.trim(),
        content: content.trim(),
        targetUsernames: targetUsernames,
      );

      if (response.errors != null && response.errors!.isNotEmpty) {
        state = state.copyWith(
          isSending: false,
          errorMessage: response.errors!.first,
        );
        return null;
      }

      // 创建成功，返回话题ID
      final topicId = response.topicId;
      state = state.copyWith(isSending: false);
      return topicId;
    } catch (e) {
      state = state.copyWith(
        isSending: false,
        errorMessage: '创建失败: $e',
      );
      return null;
    }
  }

  /// 邀请用户加入
  Future<bool> inviteUsers(List<String> usernames) async {
    final topicId = state.topicId;
    if (topicId == null || usernames.isEmpty) return false;

    try {
      return await _repository.inviteUsers(
        topicId: topicId,
        usernames: usernames,
      );
    } catch (e) {
      return false;
    }
  }

  /// 离开会话
  Future<bool> leaveConversation() async {
    final currentUser = ref.read(currentUserProvider);
    final topicId = state.topicId;
    if (topicId == null || currentUser == null) return false;

    try {
      return await _repository.leaveConversation(
        topicId: topicId,
        username: currentUser.username,
      );
    } catch (e) {
      return false;
    }
  }

  /// 清空错误信息
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// 重置状态
  void reset() {
    state = const PrivateMessageChatState();
  }
}

/// 私信未读总数 Provider
@riverpod
Future<int> privateMessageUnreadCount(PrivateMessageUnreadCountRef ref) async {
  final repository = ref.read(privateMessageRepositoryProvider);
  final currentUser = ref.read(currentUserProvider);

  if (currentUser == null || currentUser.username.isEmpty) {
    return 0;
  }

  try {
    return await repository.getTotalUnreadCount(username: currentUser.username);
  } catch (e) {
    return 0;
  }
}

/// 会话列表 Provider（简化访问）
@riverpod
List<PrivateMessageConversation> conversationList(ConversationListRef ref) {
  return ref.watch(
    privateMessageConversationNotifierProvider,
  ).conversations;
}

/// 是否有未读私信 Provider
@riverpod
bool hasUnreadPrivateMessages(HasUnreadPrivateMessagesRef ref) {
  final state = ref.watch(privateMessageConversationNotifierProvider);
  return state.totalUnreadCount > 0;
}
