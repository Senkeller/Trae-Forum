import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../../core/utils/haptic_feedback_util.dart';
import '../../providers/auth_provider.dart';

/// 账号与安全页面
///
/// 提供登录状态展示、登录跳转、退出登录等账号管理能力。
class AccountSecurityPage extends ConsumerWidget {
  const AccountSecurityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final authAsync = ref.watch(authNotifierProvider);
    final isAuthAsync = ref.watch(isAuthenticatedAsyncProvider);

    final isLoggedIn = currentUser != null;

    return Scaffold(
      appBar: AppBar(title: const Text('账号与安全')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _StatusCard(
            username: currentUser?.username,
            uid: currentUser?.uid,
            isLoggedIn: isLoggedIn,
            discourseSessionText: isAuthAsync.when(
              data: (value) => value ? '有效' : '无效',
              loading: () => '检测中',
              error: (error, stackTrace) => '检测失败',
            ),
          ),
          const SizedBox(height: 16),
          if (isLoggedIn) ...[
            _ActionTile(
              icon: Icons.edit_outlined,
              title: '编辑资料',
              subtitle: '修改昵称、头像等个人信息',
              onTap: () => context.push(RoutePaths.userEdit),
            ),
            _ActionTile(
              icon: Icons.switch_account_outlined,
              title: '重新登录/切换账号',
              subtitle: '跳转登录页并更新当前会话',
              onTap: () => context.push(RoutePaths.login),
            ),
            const SizedBox(height: 16),
            _LogoutActionButton(
              onTap: () => _confirmLogout(context, ref),
            ),
          ] else ...[
            _ActionTile(
              icon: Icons.login_outlined,
              title: '去登录',
              subtitle: '使用 TRAE 账号登录',
              onTap: () => context.push(RoutePaths.login),
            ),
          ],
          const SizedBox(height: 8),
          _ActionTile(
            icon: Icons.refresh_outlined,
            title: '刷新账号状态',
            subtitle: '重新检测本地会话与登录态',
            onTap: () async {
              ref.invalidate(isAuthenticatedAsyncProvider);
              ref.invalidate(authNotifierProvider);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('账号状态已刷新')));
            },
          ),
          const SizedBox(height: 16),
          if (authAsync.isLoading)
            const ListTile(
              leading: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              title: Text('处理中...'),
            ),
        ],
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final colorScheme = Theme.of(context).colorScheme;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              Icons.logout_outlined,
              color: colorScheme.error,
              size: 24,
            ),
            const SizedBox(width: 8),
            const Text('退出登录'),
          ],
        ),
        content: const Text(
          '确定要退出当前账号吗？退出后需要重新登录才能使用完整功能。',
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.onSurfaceVariant,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onError,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('退出登录'),
          ),
        ],
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      ),
    );

    if (confirmed != true) return;

    // 触发触觉反馈
    await HapticFeedbackUtil.trigger(
      ref,
      HapticScene.deleteSuccess,
    );

    await ref.read(authNotifierProvider.notifier).logout();
    ref.invalidate(isAuthenticatedAsyncProvider);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(width: 8),
              Text('已安全退出登录'),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}

/// 退出登录操作按钮
///
/// 账号与安全页面专用的退出登录按钮，带有渐变背景和动画效果
class _LogoutActionButton extends StatefulWidget {
  /// 点击回调
  final VoidCallback onTap;

  /// 构造函数
  const _LogoutActionButton({
    required this.onTap,
  });

  @override
  State<_LogoutActionButton> createState() => _LogoutActionButtonState();
}

class _LogoutActionButtonState extends State<_LogoutActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.error.withValues(alpha: 0.9),
                colorScheme.error,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: colorScheme.error.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: colorScheme.onError.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.logout_outlined,
                  color: colorScheme.onError,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '退出登录',
                    style: TextStyle(
                      color: colorScheme.onError,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '清除本地账号与会话信息',
                    style: TextStyle(
                      color: colorScheme.onError.withValues(alpha: 0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(
                Icons.chevron_right,
                color: colorScheme.onError.withValues(alpha: 0.7),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final String? username;
  final String? uid;
  final bool isLoggedIn;
  final String discourseSessionText;

  const _StatusCard({
    required this.username,
    required this.uid,
    required this.isLoggedIn,
    required this.discourseSessionText,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isLoggedIn
                    ? Icons.verified_user_outlined
                    : Icons.person_off_outlined,
                color: isLoggedIn ? Colors.green : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                isLoggedIn ? '当前已登录' : '当前未登录',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text('用户名：${username ?? '-'}'),
          Text('UID：${uid ?? '-'}'),
          Text('论坛会话：$discourseSessionText'),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
