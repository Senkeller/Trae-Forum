import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../../data/models/user.dart' as user_model;
import '../../providers/auth_provider.dart';
import '../../providers/notification_provider.dart';
import '../../providers/trae_dashboard_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/user/quick_actions_grid.dart';
import '../../widgets/user/notification_list.dart';
import '../../widgets/dashboard/embedded_trae_dashboard.dart';

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

    return Scaffold(
      backgroundColor: Theme.of(
        context,
      ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // 顶部导航栏
            SliverToBoxAdapter(
              child: _buildAppBar(
                context,
                isAuthenticated,
                unreadCount,
              ),
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
                onPressed: () => context.push(RoutePaths.settings),
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
    final profile = userState.profile;
    final summary = ref.watch(userStatsSummaryProvider).valueOrNull;
    final registerDays = summary?.registerDays ?? 1;
    final displayName = _resolveDisplayName(user.username, summary?.screenName);

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
                  label: '动态',
                  count: profile?.feedCount ?? 0,
                  onTap: () => _navigateToUserFeeds(context),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatItem(
                  context: context,
                  label: '关注',
                  count: profile?.followCount ?? 0,
                  onTap: () => _navigateToFollowing(context),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatItem(
                  context: context,
                  label: '粉丝',
                  count: profile?.fansCount ?? 0,
                  onTap: () => _navigateToFollowers(context),
                ),
              ),
            ],
          ),
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
                  onTap: () => context.push(RoutePaths.login),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatItem(
                  context: context,
                  label: '关注',
                  count: 0,
                  onTap: () => context.push(RoutePaths.login),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatItem(
                  context: context,
                  label: '粉丝',
                  count: 0,
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
                _formatCount(count),
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
                title: '本地收藏',
                icon: Icons.favorite_outline,
                route: RoutePaths.localFavorites,
                iconColor: const Color(0xFFE91E63),
                backgroundColor: const Color(0xFFFCE4EC),
              ),
              QuickActionItem(
                title: '浏览历史',
                icon: Icons.history,
                route: RoutePaths.browseHistory,
                iconColor: const Color(0xFF9C27B0),
                backgroundColor: const Color(0xFFF3E5F5),
              ),
              QuickActionItem(
                title: '我常去',
                icon: Icons.location_on_outlined,
                route: RoutePaths.frequentlyVisited,
                iconColor: const Color(0xFF4CAF50),
                backgroundColor: const Color(0xFFE8F5E9),
              ),
              QuickActionItem(
                title: '我的收藏',
                icon: Icons.bookmark_outline,
                route: RoutePaths.favorites,
                requireLogin: true,
                iconColor: const Color(0xFFFF9800),
                backgroundColor: const Color(0xFFFFF3E0),
              ),
              QuickActionItem(
                title: '我的赞',
                icon: Icons.thumb_up_outlined,
                route: RoutePaths.userProfile,
                requireLogin: true,
                iconColor: const Color(0xFF2196F3),
                backgroundColor: const Color(0xFFE3F2FD),
                onTap: () => _navigateToMyLikes(context),
              ),
              QuickActionItem(
                title: '我的回复',
                icon: Icons.chat_bubble_outline,
                route: RoutePaths.userProfile,
                requireLogin: true,
                iconColor: const Color(0xFF00BCD4),
                backgroundColor: const Color(0xFFE0F7FA),
                onTap: () => _navigateToMyReplies(context),
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

  /// 导航到用户动态
  void _navigateToUserFeeds(BuildContext context) {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    // 跳转到用户主页，显示用户的帖子
    context.push(
      RoutePaths.userProfile.replaceFirst(':uid', currentUser.username),
    );
  }

  /// 导航到关注列表
  void _navigateToFollowing(BuildContext context) {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    context.push(
      RoutePaths.followList.replaceFirst(':uid', currentUser.username),
    );
  }

  /// 导航到粉丝列表
  void _navigateToFollowers(BuildContext context) {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    context.push(RoutePaths.fanList.replaceFirst(':uid', currentUser.username));
  }

  /// 导航到"我的赞"页面
  void _navigateToMyLikes(BuildContext context) {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    context.push(
      '${RoutePaths.userProfile.replaceFirst(':uid', currentUser.username)}?tab=activity&category=likes',
    );
  }

  /// 导航到"我的回复"页面
  void _navigateToMyReplies(BuildContext context) {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    context.push(
      '${RoutePaths.userProfile.replaceFirst(':uid', currentUser.username)}?tab=activity&category=replies',
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
