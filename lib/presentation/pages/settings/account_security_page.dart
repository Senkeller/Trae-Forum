import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
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
            _ActionTile(
              icon: Icons.logout_outlined,
              title: '退出登录',
              subtitle: '清除本地账号与会话信息',
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
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('退出登录'),
        content: const Text('确定要退出当前账号吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('退出'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await ref.read(authNotifierProvider.notifier).logout();
    ref.invalidate(isAuthenticatedAsyncProvider);

    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('已退出登录')));
    }
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
