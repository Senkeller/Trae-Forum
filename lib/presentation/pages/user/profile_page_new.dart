import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../../data/models/user.dart' as user_model;
import '../../providers/auth_provider.dart';
import '../../providers/notification_provider.dart';
import '../../providers/trae_dashboard_provider.dart';
import '../../providers/user_badges_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/user/quick_actions_grid.dart';
import '../../widgets/user/notification_list.dart';
import '../../widgets/dashboard/embedded_trae_dashboard.dart';
import '../settings/settings_page.dart';

/// 新版个人主页页面
///
/// 采用现代化的卡片式布局，包含：
/// - 用户信息卡片（已登录/未登录状态）
/// - 快捷功能入口网格
/// - 消息通知列表
class ProfilePageNew extends ConsumerStatefulWidget {
  const ProfilePageNew({super.key});

  @override
  ConsumerState<ProfilePageNew> createState() => _ProfilePageNewState();
}

class _ProfilePageNewState extends ConsumerState<ProfilePageNew> {
  bool _notificationInitialized = false;

  @override
  Widget build(BuildContext context) {
    ref.listen<user_model.UserInfo?>(currentUserProvider, (previous, next) {
      final previousUid = previous?.uid ?? '';
      final nextUid = next?.uid ?? '';
      if (nextUid.isNotEmpty && nextUid != previousUid) {
        ref.invalidate(dashboardStateNotifierProvider);
        ref.invalidate(userStatsSummaryProvider);
      }
    });

    final currentUser = ref.watch(currentUserProvider);
    final isAuthenticated = currentUser != null;
    final notificationState = ref.watch(notificationNotifierProvider);
    final unreadCount = notificationState.unreadCount;
    final unreadSummary = buildNotificationUnreadSummary(
      notificationState.notifications,
    );

    // 首次进入登录态页面时自动拉取通知
    if (!isAuthenticated) {
      _notificationInitialized = false;
    }
    if (isAuthenticated && !_notificationInitialized) {
      _notificationInitialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(notificationNotifierProvider.notifier).loadNotifications();
      });
    }

    // 调试日志
    debugPrint('🔍 [ProfilePage] currentUser: $currentUser');
    debugPrint('🔍 [ProfilePage] isAuthenticated: $isAuthenticated');
    if (currentUser != null) {
      debugPrint(
        '🔍 [ProfilePage] uid: ${currentUser.uid}, username: ${currentUser.username}',
      );
    }

    return Semantics(
      label: '个人中心页面',
      child: Scaffold(
        backgroundColor: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              // 顶部导航栏
              SliverToBoxAdapter(
                child: _buildAppBar(context, isAuthenticated, unreadCount),
              ),
              // 用户状态卡片
              SliverToBoxAdapter(
                child: _buildUserCard(context, currentUser, isAuthenticated),
              ),
              // TRAE 仪表盘（仅已登录用户显示）
              if (isAuthenticated)
                const SliverToBoxAdapter(child: EmbeddedTraeDashboard()),
              // 快捷功能入口
              SliverToBoxAdapter(child: _buildQuickActionsSection(context)),
              // 消息通知
              SliverToBoxAdapter(
                child: _buildNotificationSection(context, unreadSummary),
              ),
              // 底部间距
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建顶部导航栏
  Widget _buildAppBar(
    BuildContext context,
    bool isAuthenticated,
    int totalUnreadCount,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '我的',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              // 设置按钮
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const SettingsPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.settings_outlined),
                tooltip: '设置',
              ),
              // 消息中心按钮（带未读角标）
              Badge(
                isLabelVisible: isAuthenticated && totalUnreadCount > 0,
                label: Text(
                  totalUnreadCount > 99 ? '99+' : '$totalUnreadCount',
                ),
                child: IconButton(
                  onPressed: () => _showMessageCenter(context),
                  icon: const Icon(Icons.notifications_outlined),
                  tooltip: '消息',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 构建用户卡片（已登录/未登录）
  Widget _buildUserCard(
    BuildContext context,
    user_model.UserInfo? user,
    bool isAuthenticated,
  ) {
    if (isAuthenticated) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: _buildAuthenticatedCard(context, user!),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: _buildUnauthenticatedCard(context),
    );
  }

  /// 已登录用户卡片
  Widget _buildAuthenticatedCard(
    BuildContext context,
    user_model.UserInfo user,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final userState = ref.watch(userSpaceNotifierProvider(user.username));
    if (!userState.isLoadingSummary && userState.summary == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(userSpaceNotifierProvider(user.username).notifier)
            .loadUserSummary();
      });
    }
    final summary = userState.summary;
    final summaryAsync = ref.watch(userStatsSummaryProvider);
    final dashboardSummary = summaryAsync.when(
      data: (value) => value,
      loading: () => null,
      error: (error, stackTrace) => null,
    );
    final registerDays = dashboardSummary?.registerDays ?? 1;
    final displayName = _resolveDisplayName(
      user.username,
      dashboardSummary?.screenName,
    );

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1D1E22),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.14),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _showAvatarOptions(context),
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF43D1AA),
                  ),
                  child: ClipOval(
                    child: user.avatar != null && user.avatar!.isNotEmpty
                        ? Image.network(
                            user.avatar!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildDashboardStyleAvatar(),
                          )
                        : _buildDashboardStyleAvatar(),
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello! $displayName',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '这是你使用 TRAE IDE 的第 $registerDays 天',
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                    if (user.bio.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        user.bio,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.52),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  context: context,
                  label: '话题',
                  count: summary?.topicCount ?? 0,
                  onTap: () => _navigateToUserTopics(context),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _buildStatItem(
                  context: context,
                  label: '活动',
                  count: summary?.postCount ?? 0,
                  onTap: () => _navigateToUserActivities(context),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _buildStatItem(
                  context: context,
                  label: '赞',
                  count: summary?.likesReceived ?? 0,
                  onTap: () => _navigateToUserLikes(context),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _buildStatItem(
                  context: context,
                  label: '访问天数',
                  count: summary?.daysVisited ?? 0,
                  onTap: () => _navigateToUserSummary(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 徽章展示区域
          _buildUserBadgesSection(context, user.username),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildProfileTag('# 满勤码神'),
              _buildProfileTag('# 智能体饲养员'),
              _buildProfileTag('# 单模型挚友'),
              _buildProfileTag('# 编程夜行侠'),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton.tonalIcon(
              onPressed: () => _openForumProfilePreferences(context),
              icon: const Icon(Icons.edit, size: 16),
              label: const Text('编辑资料'),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF2B2E34),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _resolveDisplayName(String username, String? dashboardScreenName) {
    final name = username.trim();
    if (name.isNotEmpty &&
        name != '用户' &&
        name != 'discourse_session' &&
        name != '-') {
      return name;
    }

    final dashboardName = dashboardScreenName?.trim() ?? '';
    if (dashboardName.isNotEmpty) {
      return dashboardName;
    }

    return name.isNotEmpty ? name : '用户';
  }

  /// 未登录用户卡片
  Widget _buildUnauthenticatedCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1D1E22),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.14),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF43D1AA),
                ),
                child: ClipOval(child: _buildDashboardStyleAvatar()),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello! 游客',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '登录后可同步你的数据与消息',
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '登录后体验完整个人主页能力',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.52),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  context: context,
                  label: '动态',
                  count: 0,
                  displayText: '--',
                  onTap: () => context.push(RoutePaths.login),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatItem(
                  context: context,
                  label: '粉丝',
                  count: 0,
                  displayText: '--',
                  onTap: () => context.push(RoutePaths.login),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _ProfileGhostTag('# 登录后解锁'),
              _ProfileGhostTag('# 个性标签'),
              _ProfileGhostTag('# 成长轨迹'),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton.tonalIcon(
              onPressed: () => context.push(RoutePaths.login),
              icon: const Icon(Icons.login, size: 16),
              label: const Text('去登录'),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF2B2E34),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建统计项
  Widget _buildStatItem({
    required BuildContext context,
    required String label,
    required int count,
    required VoidCallback onTap,
    String? displayText,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF262A30),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          ),
          child: Column(
            children: [
              Text(
                displayText ?? _formatCount(count),
                style: textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: textTheme.labelMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.62),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建快捷功能区
  Widget _buildQuickActionsSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentUser = ref.watch(currentUserProvider);
    final username = currentUser?.username ?? '';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Text(
              '常用功能',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          // 快捷功能网格
          QuickActionsGrid(
            items: [
              QuickActionItem(
                title: '话题',
                icon: Icons.forum_outlined,
                route: RoutePaths.userProfile,
                requireLogin: true,
                iconColor: const Color(0xFF2196F3),
                backgroundColor: const Color(0xFFE3F2FD),
                onTap: () => context.push(
                  RoutePaths.userTopics.replaceFirst(':username', username),
                ),
              ),
              QuickActionItem(
                title: '回复',
                icon: Icons.reply_outlined,
                route: RoutePaths.userProfile,
                requireLogin: true,
                iconColor: const Color(0xFF00BCD4),
                backgroundColor: const Color(0xFFE0F7FA),
                onTap: () => context.push(
                  RoutePaths.userReplies.replaceFirst(':username', username),
                ),
              ),
              QuickActionItem(
                title: '已读',
                icon: Icons.mark_chat_read_outlined,
                route: RoutePaths.userProfile,
                requireLogin: true,
                iconColor: const Color(0xFF4CAF50),
                backgroundColor: const Color(0xFFE8F5E9),
                onTap: () => context.push(
                  RoutePaths.userRead.replaceFirst(':username', username),
                ),
              ),
              QuickActionItem(
                title: '草稿',
                icon: Icons.drafts_outlined,
                route: RoutePaths.userProfile,
                requireLogin: true,
                iconColor: const Color(0xFFFF9800),
                backgroundColor: const Color(0xFFFFF3E0),
                onTap: () => context.push(
                  RoutePaths.userDrafts.replaceFirst(':username', username),
                ),
              ),
              QuickActionItem(
                title: '赞',
                icon: Icons.thumb_up_outlined,
                route: RoutePaths.userProfile,
                requireLogin: true,
                iconColor: const Color(0xFFE91E63),
                backgroundColor: const Color(0xFFFCE4EC),
                onTap: () => context.push(
                  RoutePaths.userLikes.replaceFirst(':username', username),
                ),
              ),
              QuickActionItem(
                title: '书签',
                icon: Icons.bookmark_outline,
                route: RoutePaths.userProfile,
                requireLogin: true,
                iconColor: const Color(0xFF9C27B0),
                backgroundColor: const Color(0xFFF3E5F5),
                onTap: () => context.push(
                  RoutePaths.userBookmarks.replaceFirst(':username', username),
                ),
              ),
              QuickActionItem(
                title: '已解决',
                icon: Icons.check_circle_outline,
                route: RoutePaths.userProfile,
                requireLogin: true,
                iconColor: const Color(0xFF3F51B5),
                backgroundColor: const Color(0xFFE8EAF6),
                onTap: () => context.push(
                  RoutePaths.userSolved.replaceFirst(':username', username),
                ),
              ),
              QuickActionItem(
                title: '投票',
                icon: Icons.how_to_vote_outlined,
                route: RoutePaths.userProfile,
                requireLogin: true,
                iconColor: const Color(0xFF009688),
                backgroundColor: const Color(0xFFE0F2F1),
                onTap: () => context.push(
                  RoutePaths.userVotes.replaceFirst(':username', username),
                ),
              ),
            ],
            padding: const EdgeInsets.all(12),
            spacing: 8,
            runSpacing: 8,
          ),
        ],
      ),
    );
  }

  /// 构建消息通知区
  Widget _buildNotificationSection(
    BuildContext context,
    NotificationUnreadSummary unreadSummary,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              '消息通知',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          // 通知列表
          NotificationList(
            items: [
              NotificationPresets.mentionMe(
                onTap: () =>
                    context.push('${RoutePaths.message}?filter=replies'),
                unreadCount: unreadSummary.replies,
              ),
              NotificationPresets.mentionComment(
                onTap: () =>
                    context.push('${RoutePaths.message}?filter=replies'),
                unreadCount: unreadSummary.replies,
              ),
              NotificationPresets.receivedLikes(
                onTap: () => context.push('${RoutePaths.message}?filter=likes'),
                unreadCount: unreadSummary.likes,
              ),
              NotificationPresets.friendFollow(
                onTap: () =>
                    context.push('${RoutePaths.message}?filter=others'),
                unreadCount: unreadSummary.others,
              ),
            ],
            backgroundColor: colorScheme.surface,
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardStyleAvatar() {
    return Container(
      color: const Color(0xFF43D1AA),
      child: const Icon(Icons.person, size: 34, color: Color(0xFF05614A)),
    );
  }

  Widget _buildProfileTag(String text) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1F4D3F),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: textTheme.labelLarge?.copyWith(
          color: Color(0xFF3BE89A),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// 构建用户徽章展示区域
  Widget _buildUserBadgesSection(BuildContext context, String username) {
    final badgesAsync = ref.watch(userBadgesProvider(username));

    return badgesAsync.when(
      data: (badges) {
        if (badges.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 徽章标题和数量
            Row(
              children: [
                Icon(
                  Icons.workspace_premium_outlined,
                  size: 16,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
                const SizedBox(width: 6),
                Text(
                  '徽章',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF43D1AA).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${badges.length}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: const Color(0xFF43D1AA),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // 徽章列表
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: badges
                  .take(6)
                  .map((badge) => _buildBadgeItem(context, badge))
                  .toList(),
            ),
            // 查看更多按钮（如果徽章数量超过6个）
            if (badges.length > 6) ...[
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _navigateToUserBadges(context, username),
                child: Text(
                  '查看全部 ${badges.length} 个徽章 →',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF43D1AA),
                  ),
                ),
              ),
            ],
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }

  /// 构建单个徽章项
  Widget _buildBadgeItem(BuildContext context, UserBadgeInfo badge) {
    return Tooltip(
      message: badge.description ?? badge.name,
      child: GestureDetector(
        onTap: () => _navigateToBadgeDetail(context, badge),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF2B2E34),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 徽章图标
              if (badge.imageUrl != null && badge.imageUrl!.isNotEmpty)
                Image.network(
                  badge.imageUrl!,
                  width: 16,
                  height: 16,
                  errorBuilder: (_, _, _) => _buildDefaultBadgeIcon(),
                )
              else
                _buildDefaultBadgeIcon(),
              const SizedBox(width: 6),
              // 徽章名称
              Flexible(
                child: Text(
                  badge.name,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建默认徽章图标
  Widget _buildDefaultBadgeIcon() {
    return const Icon(
      Icons.emoji_events_outlined,
      size: 16,
      color: Color(0xFFFFB800),
    );
  }

  /// 导航到徽章详情页
  void _navigateToBadgeDetail(BuildContext context, UserBadgeInfo badge) {
    final baseUri = Uri.parse(AppConstants.forumUrl);
    final badgeUri = baseUri.replace(
      pathSegments: ['badges', badge.id.toString(), badge.slug],
    );

    context.push(
      '${RoutePaths.webview}?url=${Uri.encodeComponent(badgeUri.toString())}&title=${Uri.encodeComponent(badge.name)}',
    );
  }

  /// 导航到用户徽章列表页
  void _navigateToUserBadges(BuildContext context, String username) {
    final baseUri = Uri.parse(AppConstants.forumUrl);
    final badgesUri = baseUri.replace(pathSegments: ['u', username, 'badges']);

    context.push(
      '${RoutePaths.webview}?url=${Uri.encodeComponent(badgesUri.toString())}&title=${Uri.encodeComponent('我的徽章')}',
    );
  }

  /// 格式化数字
  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

  /// 显示消息中心
  void _showMessageCenter(BuildContext context) {
    context.push(RoutePaths.notifications);
  }

  /// 打开论坛个人资料设置页面（/my/preferences/profile）
  void _openForumProfilePreferences(BuildContext context) {
    final baseUri = Uri.parse(AppConstants.forumUrl);
    final profileUri = baseUri.replace(
      pathSegments: ['my', 'preferences', 'profile'],
    );

    context.push(
      '${RoutePaths.webview}?url=${Uri.encodeComponent(profileUri.toString())}&title=${Uri.encodeComponent('编辑资料')}',
    );
  }

  /// 打开论坛头像设置页面（/my/preferences/profile）
  void _openForumAvatarSettings(BuildContext context) {
    final baseUri = Uri.parse(AppConstants.forumUrl);
    final avatarUri = baseUri.replace(
      pathSegments: ['my', 'preferences', 'profile'],
    );

    context.push(
      '${RoutePaths.webview}?url=${Uri.encodeComponent(avatarUri.toString())}&title=${Uri.encodeComponent('更换头像')}',
    );
  }

  /// 显示头像选项
  void _showAvatarOptions(BuildContext context) {
    final currentUser = ref.read(currentUserProvider);
    final avatarUrl = currentUser?.avatar;

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('更换头像'),
              onTap: () {
                Navigator.of(context).pop();
                _openForumAvatarSettings(context);
              },
            ),
            if (avatarUrl != null && avatarUrl.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.visibility),
                title: const Text('查看大图'),
                onTap: () {
                  Navigator.of(context).pop();
                  context.push(RoutePaths.imagePreview, extra: [avatarUrl]);
                },
              ),
          ],
        ),
      ),
    );
  }

  /// 导航到用户话题
  void _navigateToUserTopics(BuildContext context) {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    context.push(
      RoutePaths.userTopics.replaceFirst(':username', currentUser.username),
    );
  }

  /// 导航到用户活动页
  void _navigateToUserActivities(BuildContext context) {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    context.push(
      '${RoutePaths.userProfile.replaceFirst(':username', currentUser.username)}?tab=activity',
    );
  }

  /// 导航到用户收到的赞
  void _navigateToUserLikes(BuildContext context) {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    context.push(
      RoutePaths.userLikes.replaceFirst(':username', currentUser.username),
    );
  }

  /// 导航到用户总结页（默认标签）
  void _navigateToUserSummary(BuildContext context) {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    context.push(
      RoutePaths.userProfile.replaceFirst(':username', currentUser.username),
    );
  }
}

class _ProfileGhostTag extends StatelessWidget {
  final String text;

  const _ProfileGhostTag(this.text);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2B2E34),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: textTheme.labelMedium?.copyWith(
          color: Color(0xFF9AA0AA),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
