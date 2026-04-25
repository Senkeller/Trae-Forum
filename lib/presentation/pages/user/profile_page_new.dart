import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../../data/models/user.dart' as user_model;
import '../../providers/auth_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    final isAuthenticated = currentUser != null;

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
            SliverToBoxAdapter(child: _buildAppBar(context, isAuthenticated)),
            // 用户状态卡片
            SliverToBoxAdapter(
              child: _buildUserCard(context, currentUser, isAuthenticated),
            ),
            // TRAE 仪表盘（仅已登录用户显示）
            if (isAuthenticated)
              const SliverToBoxAdapter(child: EmbeddedTraeDashboard()),
            // 快捷功能入口
            SliverToBoxAdapter(
              child: _buildQuickActionsSection(context, isAuthenticated),
            ),
            // 消息通知
            SliverToBoxAdapter(
              child: _buildNotificationSection(context, isAuthenticated),
            ),
            // 底部间距
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }

  /// 构建顶部导航栏
  Widget _buildAppBar(BuildContext context, bool isAuthenticated) {
    final colorScheme = Theme.of(context).colorScheme;

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
              // 消息中心按钮
              Stack(
                children: [
                  IconButton(
                    onPressed: () => _showMessageCenter(context),
                    icon: const Icon(Icons.notifications_outlined),
                    tooltip: '消息',
                  ),
                  // 未读消息红点
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: colorScheme.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
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
      child: _buildUnauthenticatedCard(context),
    );
  }

  /// 已登录用户卡片
  Widget _buildAuthenticatedCard(
    BuildContext context,
    user_model.UserInfo user,
  ) {
    final userState = ref.watch(userSpaceNotifierProvider(user.username));
    final profile = userState.profile;
    final summary = ref.watch(userStatsSummaryProvider).valueOrNull;
    final registerDays = summary?.registerDays ?? 1;
    final displayName = _resolveDisplayName(user.username, summary?.screenName);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1D1E22),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _showAvatarOptions(context),
                child: Container(
                  width: 88,
                  height: 88,
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
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '这是你使用 TRAE IDE 的第 $registerDays 天',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 16,
                      ),
                    ),
                    if (user.bio.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        user.bio,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.52),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  label: '动态',
                  count: profile?.feedCount ?? 0,
                  onTap: () => _navigateToUserFeeds(context),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildStatItem(
                  label: '关注',
                  count: profile?.followCount ?? 0,
                  onTap: () => _navigateToFollowing(context),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildStatItem(
                  label: '粉丝',
                  count: profile?.fansCount ?? 0,
                  onTap: () => _navigateToFollowers(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildProfileTag('# 满勤码神'),
              _buildProfileTag('# 智能体饲养员'),
              _buildProfileTag('# 单模型挚友'),
              _buildProfileTag('# 编程夜行侠'),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.tonalIcon(
              onPressed: () => _openForumProfilePreferences(context),
              icon: const Icon(Icons.edit, size: 16),
              label: const Text('编辑资料'),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF2B2E34),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 默认头像占位
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.surfaceContainerHighest,
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.2),
                width: 2,
              ),
            ),
            child: Icon(
              Icons.person_outline,
              size: 40,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '登录后体验更多功能',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          // 登录按钮
          SizedBox(
            width: 160,
            height: 44,
            child: FilledButton(
              onPressed: () => context.push(RoutePaths.login),
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              child: const Text(
                '点击登录',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建统计项
  Widget _buildStatItem({
    required String label,
    required int count,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF262A30),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          ),
          child: Column(
            children: [
              Text(
                _formatCount(count),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.62),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建快捷功能区
  Widget _buildQuickActionsSection(BuildContext context, bool isAuthenticated) {
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
                route: RoutePaths.myLikes,
                requireLogin: true,
                iconColor: const Color(0xFF2196F3),
                backgroundColor: const Color(0xFFE3F2FD),
              ),
              QuickActionItem(
                title: '我的回复',
                icon: Icons.chat_bubble_outline,
                route: RoutePaths.myReplies,
                requireLogin: true,
                iconColor: const Color(0xFF00BCD4),
                backgroundColor: const Color(0xFFE0F7FA),
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
  Widget _buildNotificationSection(BuildContext context, bool isAuthenticated) {
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
                onTap: () => _showFeatureComingSoon(context, '@我的动态'),
                unreadCount: isAuthenticated ? 3 : 0,
              ),
              NotificationPresets.mentionComment(
                onTap: () => _showFeatureComingSoon(context, '@我的评论'),
                unreadCount: isAuthenticated ? 1 : 0,
              ),
              NotificationPresets.receivedLikes(
                onTap: () => _showFeatureComingSoon(context, '我收到的赞'),
                unreadCount: isAuthenticated ? 12 : 0,
              ),
              NotificationPresets.friendFollow(
                onTap: () => _showFeatureComingSoon(context, '好友关注'),
                unreadCount: isAuthenticated ? 2 : 0,
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
      child: const Icon(Icons.person, size: 42, color: Color(0xFF05614A)),
    );
  }

  Widget _buildProfileTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1F4D3F),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF3BE89A),
          fontSize: 17,
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

  /// 显示功能开发中提示
  void _showFeatureComingSoon(BuildContext context, String featureName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$featureName 功能开发中'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
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
                _showFeatureComingSoon(context, '更换头像');
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
}
