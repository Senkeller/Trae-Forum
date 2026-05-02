import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../providers/auth_provider.dart';
import '../../providers/settings_provider.dart';

class BlacklistPage extends ConsumerStatefulWidget {
  const BlacklistPage({super.key});

  @override
  ConsumerState<BlacklistPage> createState() => _BlacklistPageState();
}

class _BlacklistPageState extends ConsumerState<BlacklistPage> {
  Future<void> _unblockUser(String username) async {
    await ref
        .read(settingsNotifierProvider.notifier)
        .removeBlockedUser(username);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('已解除对 @$username 的屏蔽')));
  }

  Future<void> _unblockKeyword(String keyword) async {
    await ref
        .read(settingsNotifierProvider.notifier)
        .removeBlockedKeyword(keyword);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('已解除对关键词 "$keyword" 的屏蔽')));
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    final isLoggedIn = currentUser != null && currentUser.uid.isNotEmpty;
    final settings = ref.watch(currentSettingsProvider);
    final blockedUsers = settings.blockedUsers;
    final blockedKeywords = settings.blockedKeywords;

    if (!isLoggedIn) {
      return Scaffold(
        appBar: AppBar(title: const Text('黑名单')),
        body: _StateView(
          icon: Icons.account_circle_outlined,
          title: '未登录',
          message: '登录后可管理黑名单',
          actionLabel: '去登录',
          onAction: () => context.push(RoutePaths.login),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('黑名单'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddDialog(context),
            tooltip: '添加屏蔽',
          ),
        ],
      ),
      body: _buildBody(blockedUsers, blockedKeywords),
    );
  }

  Widget _buildBody(List<String> blockedUsers, List<String> blockedKeywords) {
    if (blockedUsers.isEmpty && blockedKeywords.isEmpty) {
      return _StateView(
        icon: Icons.block,
        title: '黑名单为空',
        message: '你没有屏蔽任何用户或关键词',
        actionLabel: '添加屏蔽',
        onAction: () => _showAddDialog(context),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        if (blockedUsers.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.person_outline, size: 20),
                const SizedBox(width: 8),
                Text(
                  '屏蔽的用户 (${blockedUsers.length})',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          ...List.generate(blockedUsers.length, (index) {
            final username = blockedUsers[index];
            return _BlockedUserTile(
              username: username,
              reason: null,
              onUnblock: () => _unblockUser(username),
              onViewProfile: () {
                context.push(
                  RoutePaths.userProfile.replaceFirst(':username', username),
                );
              },
            );
          }),
        ],
        if (blockedKeywords.isNotEmpty) ...[
          const Divider(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.text_fields, size: 20),
                const SizedBox(width: 8),
                Text(
                  '屏蔽的关键词 (${blockedKeywords.length})',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          ...List.generate(blockedKeywords.length, (index) {
            final keyword = blockedKeywords[index];
            return _BlockedKeywordTile(
              keyword: keyword,
              onUnblock: () => _unblockKeyword(keyword),
            );
          }),
        ],
      ],
    );
  }

  void _showAddDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('屏蔽用户'),
              subtitle: const Text('屏蔽指定用户的发言'),
              onTap: () {
                Navigator.of(context).pop();
                _showBlockUserDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.text_fields),
              title: const Text('屏蔽关键词'),
              subtitle: const Text('屏蔽包含关键词的内容'),
              onTap: () {
                Navigator.of(context).pop();
                _showBlockKeywordDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showBlockUserDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('屏蔽用户'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: '用户名',
            hintText: '输入要屏蔽的用户名',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () async {
              final username = controller.text.trim();
              if (username.isNotEmpty && username.length <= 40) {
                await ref
                    .read(settingsNotifierProvider.notifier)
                    .addBlockedUser(username);
                if (!mounted) return;
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('已屏蔽 @$username')));
              } else if (username.isNotEmpty && mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('用户名长度不能超过 40')));
              }
              Navigator.of(context).pop();
            },
            child: const Text('屏蔽'),
          ),
        ],
      ),
    );
  }

  void _showBlockKeywordDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('屏蔽关键词'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: '关键词',
            hintText: '输入要屏蔽的关键词',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () async {
              final keyword = controller.text.trim();
              if (keyword.isNotEmpty && keyword.length <= 40) {
                await ref
                    .read(settingsNotifierProvider.notifier)
                    .addBlockedKeyword(keyword);
                if (!mounted) return;
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('已屏蔽关键词 "$keyword"')));
              } else if (keyword.isNotEmpty && mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('关键词长度不能超过 40')));
              }
              Navigator.of(context).pop();
            },
            child: const Text('屏蔽'),
          ),
        ],
      ),
    );
  }
}

class _BlockedUserTile extends StatelessWidget {
  final String username;
  final String? reason;
  final VoidCallback onUnblock;
  final VoidCallback onViewProfile;

  const _BlockedUserTile({
    required this.username,
    this.reason,
    required this.onUnblock,
    required this.onViewProfile,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: CircleAvatar(
        child: Text(username.isNotEmpty ? username[0].toUpperCase() : '?'),
      ),
      title: Text(username),
      subtitle: reason != null && reason!.isNotEmpty ? Text(reason!) : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.visibility_outlined),
            onPressed: onViewProfile,
            tooltip: '查看主页',
          ),
          IconButton(
            icon: Icon(Icons.block, color: colorScheme.error),
            onPressed: onUnblock,
            tooltip: '解除屏蔽',
          ),
        ],
      ),
    );
  }
}

class _BlockedKeywordTile extends StatelessWidget {
  final String keyword;
  final VoidCallback onUnblock;

  const _BlockedKeywordTile({required this.keyword, required this.onUnblock});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: const Icon(Icons.text_fields),
      title: Text(keyword),
      trailing: IconButton(
        icon: Icon(Icons.block, color: colorScheme.error),
        onPressed: onUnblock,
        tooltip: '解除屏蔽',
      ),
    );
  }
}

class _StateView extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _StateView({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 16),
              FilledButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}
