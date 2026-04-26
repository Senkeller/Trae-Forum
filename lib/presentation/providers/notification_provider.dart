import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/network/discourse_api_service.dart';
import '../../data/models/discourse/discourse_notification.dart';
import 'auth_provider.dart';

part 'notification_provider.g.dart';

/// 未读通知分类统计
class NotificationUnreadSummary {
  final int total;
  final int replies;
  final int likes;
  final int messages;
  final int bookmarks;
  final int chat;
  final int others;

  const NotificationUnreadSummary({
    this.total = 0,
    this.replies = 0,
    this.likes = 0,
    this.messages = 0,
    this.bookmarks = 0,
    this.chat = 0,
    this.others = 0,
  });
}

/// 通知状态类
class NotificationState {
  /// 通知列表
  final List<DiscourseNotification> notifications;

  /// 当前筛选类型
  final NotificationFilterType filterType;

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

  /// 未读通知数量
  final int unreadCount;

  /// 最后查看的通知ID
  final int seenNotificationId;

  const NotificationState({
    this.notifications = const [],
    this.filterType = NotificationFilterType.all,
    this.isLoading = false,
    this.isRefreshing = false,
    this.isLoadingMore = false,
    this.currentPage = 1,
    this.hasMore = true,
    this.errorMessage,
    this.unreadCount = 0,
    this.seenNotificationId = 0,
  });

  /// 复制并修改
  NotificationState copyWith({
    List<DiscourseNotification>? notifications,
    NotificationFilterType? filterType,
    bool? isLoading,
    bool? isRefreshing,
    bool? isLoadingMore,
    int? currentPage,
    bool? hasMore,
    String? errorMessage,
    int? unreadCount,
    int? seenNotificationId,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      filterType: filterType ?? this.filterType,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage,
      unreadCount: unreadCount ?? this.unreadCount,
      seenNotificationId: seenNotificationId ?? this.seenNotificationId,
    );
  }

  /// 获取未读通知数量
  int get unreadNotificationsCount {
    return notifications.where((n) => !n.read).length;
  }
}

/// 通知状态 Notifier
@riverpod
class NotificationNotifier extends _$NotificationNotifier {
  static const int _pageSize = 30;
  late DiscourseApiService _apiService;

  /// 构建通知状态
  @override
  NotificationState build() {
    _apiService = ref.read(discourseApiServiceProvider);
    return const NotificationState();
  }

  /// 切换筛选类型
  ///
  /// [type] 要切换到的筛选类型
  void switchFilterType(NotificationFilterType type) {
    if (state.filterType == type) return;

    state = state.copyWith(
      filterType: type,
      notifications: [],
      currentPage: 1,
      hasMore: true,
      errorMessage: null,
    );
    loadNotifications();
  }

  /// 加载通知列表
  ///
  /// 根据当前筛选类型加载对应的通知列表
  Future<void> loadNotifications() async {
    // 使用异步版本检查登录状态，支持 Discourse 登录
    final isAuthenticated = await ref.read(isAuthenticatedAsyncProvider.future);
    if (!isAuthenticated) {
      state = state.copyWith(errorMessage: '请先登录');
      return;
    }

    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, errorMessage: null, currentPage: 1);

    try {
      final filterParam = state.filterType.filterParam;

      final response = await _apiService.getNotifications(
        limit: _pageSize,
        recent: true,
        bumpLastSeen: true,
        filterByTypes: filterParam,
        offset: 0,
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final notificationResponse = DiscourseNotificationResponse.fromJson(
          data,
        );

        state = state.copyWith(
          notifications: notificationResponse.notifications,
          isLoading: false,
          hasMore: notificationResponse.notifications.length >= _pageSize,
          currentPage: 1,
          seenNotificationId: notificationResponse.seenNotificationId,
          unreadCount: notificationResponse.notifications
              .where((n) => !n.read)
              .length,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: '加载通知失败: ${response.statusCode}',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: '网络错误: $e');
    }
  }

  /// 刷新通知列表
  Future<void> refreshNotifications() async {
    // 使用异步版本检查登录状态，支持 Discourse 登录
    final isAuthenticated = await ref.read(isAuthenticatedAsyncProvider.future);
    if (!isAuthenticated) return;

    if (state.isRefreshing) return;

    state = state.copyWith(isRefreshing: true, errorMessage: null);

    try {
      final filterParam = state.filterType.filterParam;

      final response = await _apiService.getNotifications(
        limit: _pageSize,
        recent: true,
        bumpLastSeen: true,
        filterByTypes: filterParam,
        offset: 0,
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final notificationResponse = DiscourseNotificationResponse.fromJson(
          data,
        );

        state = state.copyWith(
          notifications: notificationResponse.notifications,
          isRefreshing: false,
          hasMore: notificationResponse.notifications.length >= _pageSize,
          currentPage: 1,
          seenNotificationId: notificationResponse.seenNotificationId,
          unreadCount: notificationResponse.notifications
              .where((n) => !n.read)
              .length,
        );
      } else {
        state = state.copyWith(isRefreshing: false, errorMessage: '刷新通知失败');
      }
    } catch (e) {
      state = state.copyWith(isRefreshing: false, errorMessage: '网络错误: $e');
    }
  }

  /// 加载更多通知
  Future<void> loadMoreNotifications() async {
    // 使用异步版本检查登录状态，支持 Discourse 登录
    final isAuthenticated = await ref.read(isAuthenticatedAsyncProvider.future);
    if (!isAuthenticated) return;

    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true, errorMessage: null);

    try {
      final nextPage = state.currentPage + 1;
      final filterParam = state.filterType.filterParam;

      final response = await _apiService.getNotifications(
        limit: _pageSize,
        recent: true,
        bumpLastSeen: false,
        filterByTypes: filterParam,
        offset: state.notifications.length,
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final notificationResponse = DiscourseNotificationResponse.fromJson(
          data,
        );

        final newNotifications = notificationResponse.notifications;

        // 基于服务端返回条数判定是否还有更多数据
        final hasMore = newNotifications.length >= _pageSize;

        if (newNotifications.isEmpty) {
          state = state.copyWith(isLoadingMore: false, hasMore: false);
        } else {
          // 合并通知列表，避免重复
          final existingIds = state.notifications.map((n) => n.id).toSet();
          final uniqueNewNotifications = newNotifications
              .where((n) => !existingIds.contains(n.id))
              .toList();

          // 计算合并后的未读数量
          final mergedNotifications = [...state.notifications, ...uniqueNewNotifications];

          state = state.copyWith(
            notifications: mergedNotifications,
            isLoadingMore: false,
            currentPage: nextPage,
            hasMore: hasMore,
            unreadCount: mergedNotifications.where((n) => !n.read).length,
          );
        }
      } else {
        state = state.copyWith(isLoadingMore: false, errorMessage: '加载更多失败');
      }
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, errorMessage: '网络错误: $e');
    }
  }

  /// 标记通知为已读
  ///
  /// [notificationId] 要标记的通知ID，为空则标记当前筛选类型所有通知
  Future<void> markAsRead([int? notificationId]) async {
    // 使用异步版本检查登录状态，支持 Discourse 登录
    final isAuthenticated = await ref.read(isAuthenticatedAsyncProvider.future);
    if (!isAuthenticated) return;

    try {
      if (notificationId != null) {
        // 标记单条通知已读
        await _apiService.markNotificationsRead([notificationId]);

        // 更新本地状态
        final updatedNotifications = state.notifications.map((n) {
          if (n.id == notificationId) {
            return n.copyWith(read: true);
          }
          return n;
        }).toList();

        state = state.copyWith(
          notifications: updatedNotifications,
          unreadCount: updatedNotifications.where((n) => !n.read).length,
        );
      } else {
        // 标记所有通知已读
        await _apiService.markAllNotificationsRead();

        // 更新本地状态
        final updatedNotifications = state.notifications.map((n) {
          return n.copyWith(read: true);
        }).toList();

        state = state.copyWith(
          notifications: updatedNotifications,
          unreadCount: 0,
        );
      }
    } catch (e) {
      // 标记失败，不更新状态
    }
  }

  /// 清空错误信息
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// 删除通知
  ///
  /// [notificationId] 要删除的通知ID
  Future<void> deleteNotification(int notificationId) async {
    // 使用异步版本检查登录状态，支持 Discourse 登录
    final isAuthenticated = await ref.read(isAuthenticatedAsyncProvider.future);
    if (!isAuthenticated) return;

    try {
      // 先更新本地状态，提供即时反馈
      final updatedNotifications = state.notifications
          .where((n) => n.id != notificationId)
          .toList();

      state = state.copyWith(
        notifications: updatedNotifications,
        unreadCount: updatedNotifications.where((n) => !n.read).length,
      );

      // 调用 API 删除通知
      await _apiService.deleteNotification(notificationId);
    } catch (e) {
      // 删除失败，恢复状态
      await loadNotifications();
    }
  }

  /// 批量删除通知
  ///
  /// [notificationIds] 要删除的通知ID列表
  Future<void> deleteNotifications(List<int> notificationIds) async {
    // 使用异步版本检查登录状态，支持 Discourse 登录
    final isAuthenticated = await ref.read(isAuthenticatedAsyncProvider.future);
    if (!isAuthenticated) return;

    try {
      // 先更新本地状态，提供即时反馈
      final updatedNotifications = state.notifications
          .where((n) => !notificationIds.contains(n.id))
          .toList();

      state = state.copyWith(
        notifications: updatedNotifications,
        unreadCount: updatedNotifications.where((n) => !n.read).length,
      );

      // 调用 API 批量删除通知
      for (final id in notificationIds) {
        await _apiService.deleteNotification(id);
      }
    } catch (e) {
      // 删除失败，恢复状态
      await loadNotifications();
    }
  }

  /// 标记通知为未读
  ///
  /// [notificationId] 要标记的通知ID
  Future<void> markAsUnread(int notificationId) async {
    // 使用异步版本检查登录状态，支持 Discourse 登录
    final isAuthenticated = await ref.read(isAuthenticatedAsyncProvider.future);
    if (!isAuthenticated) return;

    try {
      // 更新本地状态
      final updatedNotifications = state.notifications.map((n) {
        if (n.id == notificationId) {
          return n.copyWith(read: false);
        }
        return n;
      }).toList();

      state = state.copyWith(
        notifications: updatedNotifications,
        unreadCount: updatedNotifications.where((n) => !n.read).length,
      );
    } catch (e) {
      // 标记失败
    }
  }
}

/// 通知列表 Provider
@riverpod
List<DiscourseNotification> notificationList(NotificationListRef ref) {
  return ref.watch(notificationNotifierProvider).notifications;
}

/// 未读通知数量 Provider
@riverpod
int unreadNotificationCount(UnreadNotificationCountRef ref) {
  return ref.watch(notificationNotifierProvider).unreadCount;
}

NotificationUnreadSummary buildNotificationUnreadSummary(
  List<DiscourseNotification> notifications,
) {
  int replies = 0;
  int likes = 0;
  int messages = 0;
  int bookmarks = 0;
  int chat = 0;
  int others = 0;

  for (final notification in notifications) {
    if (notification.read) continue;
    if (NotificationFilterType.replies.matchesNotificationType(
      notification.notificationType,
    )) {
      replies++;
      continue;
    }
    if (NotificationFilterType.likes.matchesNotificationType(
      notification.notificationType,
    )) {
      likes++;
      continue;
    }
    if (NotificationFilterType.messages.matchesNotificationType(
      notification.notificationType,
    )) {
      messages++;
      continue;
    }
    if (NotificationFilterType.bookmarks.matchesNotificationType(
      notification.notificationType,
    )) {
      bookmarks++;
      continue;
    }
    if (NotificationFilterType.chat.matchesNotificationType(
      notification.notificationType,
    )) {
      chat++;
      continue;
    }
    others++;
  }

  final total = replies + likes + messages + bookmarks + chat + others;
  return NotificationUnreadSummary(
    total: total,
    replies: replies,
    likes: likes,
    messages: messages,
    bookmarks: bookmarks,
    chat: chat,
    others: others,
  );
}

/// 当前筛选类型 Provider
@riverpod
NotificationFilterType currentNotificationFilterType(
  CurrentNotificationFilterTypeRef ref,
) {
  return ref.watch(notificationNotifierProvider).filterType;
}

/// 是否正在加载通知 Provider
@riverpod
bool isNotificationLoading(IsNotificationLoadingRef ref) {
  return ref.watch(notificationNotifierProvider).isLoading;
}

/// 通知状态 Provider
@riverpod
NotificationState notificationState(NotificationStateRef ref) {
  return ref.watch(notificationNotifierProvider);
}
