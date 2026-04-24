import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../../data/models/user.dart' as user_model;
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/user/quick_actions_grid.dart';
import '../../widgets/user/notification_list.dart';

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

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // 顶部导航栏
            SliverToBoxAdapter(
              child: _buildAppBar(context, isAuthenticated),
            ),
            // 用户状态卡片
            SliverToBoxAdapter(
              child: _buildUserCard(context, currentUser, isAuthenticated),
            ),
            // 快捷功能入口
            SliverToBoxAdapter(
              child: _buildQuickActionsSection(context, isAuthenticated),
            ),
            // 消息通知
            SliverToBoxAdapter(
              child: _buildNotificationSection(context, isAuthenticated),
            ),
            // 底部间距
            const SliverToBoxAdapter(
              child: SizedBox(height: 32),
            ),
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
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
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
      child: isAuthenticated
          ? _buildAuthenticatedCard(context, user!)
          : _buildUnauthenticatedCard(context),
    );
  }

  /// 已登录用户卡片
  Widget _buildAuthenticatedCard(
    BuildContext context,
    user_model.UserInfo user,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // 获取用户统计数据
    final userState = ref.watch(userSpaceNotifierProvider(user.username));
    final profile = userState.profile;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // 头像和统计
          Row(
            children: [
              // 头像
              GestureDetector(
                onTap: () => _showAvatarOptions(context),
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colorScheme.outline.withValues(alpha: 0.2),
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: user.avatar != null && user.avatar!.isNotEmpty
                        ? Image.network(
                            user.avatar!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildDefaultAvatar(colorScheme),
                          )
                        : _buildDefaultAvatar(colorScheme),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              // 统计数据
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem(
                      '动态',
                      profile?.feedCount ?? 0,
                      () => _navigateToUserFeeds(context),
                      colorScheme,
                      textTheme,
                    ),
                    _buildStatItem(
                      '关注',
                      profile?.followCount ?? 0,
                      () => _navigateToFollowing(context),
                      colorScheme,
                      textTheme,
                    ),
                    _buildStatItem(
                      '粉丝',
                      profile?.fansCount ?? 0,
                      () => _navigateToFollowers(context),
                      colorScheme,
                      textTheme,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 用户名和简介
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '@${user.username}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                if (user.bio.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    user.bio,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          // 编辑资料按钮
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => context.push(RoutePaths.userEdit),
              icon: const Icon(Icons.edit, size: 18),
              label: const Text('编辑资料'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建统计项
  Widget _buildStatItem(
    String label,
    int count,
    VoidCallback onTap,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          children: [
            Text(
              _formatCount(count),
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
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
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          // 快捷功能网格
          QuickActionsGrid(
            items: [
              QuickActionPresets.localFavorite(
                onTap: () => _showFeatureComingSoon(context, '本地收藏'),
              ),
              QuickActionPresets.history(
                onTap: () => _showFeatureComingSoon(context, '浏览历史'),
              ),
              QuickActionPresets.frequentlyVisited(
                onTap: () => _showFeatureComingSoon(context, '我的常去'),
              ),
              QuickActionPresets.myFavorites(
                onTap: () => _showFeatureComingSoon(context, '我的收藏'),
              ),
              QuickActionPresets.myLikes(
                onTap: () => _showFeatureComingSoon(context, '我的赞'),
              ),
              QuickActionPresets.myReplies(
                onTap: () => _showFeatureComingSoon(context, '我的回复'),
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
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
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

  /// 构建默认头像
  Widget _buildDefaultAvatar(ColorScheme colorScheme) {
    return Container(
      color: colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.person,
        size: 36,
        color: colorScheme.onSurfaceVariant,
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
    // TODO: 实现消息中心页面
    _showFeatureComingSoon(context, '消息中心');
  }

  /// 显示头像选项
  void _showAvatarOptions(BuildContext context) {
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
            ListTile(
              leading: const Icon(Icons.visibility),
              title: const Text('查看大图'),
              onTap: () {
                Navigator.of(context).pop();
                _showFeatureComingSoon(context, '查看大图');
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 导航到用户动态
  void _navigateToUserFeeds(BuildContext context) {
    // TODO: 实现用户动态页面
    _showFeatureComingSoon(context, '我的动态');
  }

  /// 导航到关注列表
  void _navigateToFollowing(BuildContext context) {
    // TODO: 实现关注列表页面
    _showFeatureComingSoon(context, '关注列表');
  }

  /// 导航到粉丝列表
  void _navigateToFollowers(BuildContext context) {
    // TODO: 实现粉丝列表页面
    _showFeatureComingSoon(context, '粉丝列表');
  }
}
