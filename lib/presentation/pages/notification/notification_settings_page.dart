import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../../core/utils/haptic_feedback_util.dart';
import '../../providers/auth_provider.dart';
import '../../providers/settings_provider.dart';

class NotificationSettingsPage extends ConsumerStatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  ConsumerState<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState
    extends ConsumerState<NotificationSettingsPage> {
  bool _notifyReplies = true;
  bool _notifyLikes = true;
  bool _notifyMentions = true;
  bool _notifyFollows = true;
  bool _notifySystem = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadSettings());
  }

  Future<void> _loadSettings() async {
    final settings = ref.read(currentSettingsProvider);
    if (!mounted) return;
    setState(() {
      _notifyReplies = settings.notifyReplies;
      _notifyLikes = settings.notifyLikes;
      _notifyMentions = settings.notifyMentions;
      _notifyFollows = settings.notifyFollows;
      _notifySystem = settings.notifySystem;
    });
  }

  Future<void> _saveSettings() async {
    await ref
        .read(settingsNotifierProvider.notifier)
        .setNotificationPreferences(
          notifyReplies: _notifyReplies,
          notifyLikes: _notifyLikes,
          notifyMentions: _notifyMentions,
          notifyFollows: _notifyFollows,
          notifySystem: _notifySystem,
        );
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('设置已保存')));
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    final appSettings = ref.watch(currentSettingsProvider);
    final isLoggedIn = currentUser != null && currentUser.uid.isNotEmpty;

    if (!isLoggedIn) {
      return Scaffold(
        appBar: AppBar(title: const Text('通知设置')),
        body: _StateView(
          icon: Icons.account_circle_outlined,
          title: '未登录',
          message: '登录后可设置通知偏好',
          actionLabel: '去登录',
          onAction: () => context.push(RoutePaths.login),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('通知设置'),
        actions: [
          TextButton(onPressed: _saveSettings, child: const Text('保存')),
        ],
      ),
      body: ListView(
        children: [
          _SectionHeader(title: '通知类型'),
          SwitchListTile(
            secondary: const Icon(Icons.reply_outlined),
            title: const Text('回复通知'),
            subtitle: const Text('有人回复我的话题或评论时'),
            value: _notifyReplies,
            onChanged: (value) {
              setState(() {
                _notifyReplies = value;
              });
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.thumb_up_outlined),
            title: const Text('赞通知'),
            subtitle: const Text('有人点赞我的话题或评论时'),
            value: _notifyLikes,
            onChanged: (value) {
              setState(() {
                _notifyLikes = value;
              });
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.alternate_email),
            title: const Text('@通知'),
            subtitle: const Text('有人@我时'),
            value: _notifyMentions,
            onChanged: (value) {
              setState(() {
                _notifyMentions = value;
              });
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.person_add_outlined),
            title: const Text('关注通知'),
            subtitle: const Text('有人关注我时'),
            value: _notifyFollows,
            onChanged: (value) {
              setState(() {
                _notifyFollows = value;
              });
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.notifications_outlined),
            title: const Text('系统通知'),
            subtitle: const Text('官方公告和系统消息'),
            value: _notifySystem,
            onChanged: (value) {
              setState(() {
                _notifySystem = value;
              });
            },
          ),
          const Divider(),
          _SectionHeader(title: '提醒方式'),
          SwitchListTile(
            secondary: const Icon(Icons.volume_up_outlined),
            title: const Text('声音'),
            subtitle: const Text('通知时播放声音'),
            value: appSettings.soundEnabled,
            onChanged: (value) {
              ref
                  .read(settingsNotifierProvider.notifier)
                  .setSoundEnabled(value);
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.vibration),
            title: const Text('振动'),
            subtitle: const Text('通知时振动提醒'),
            value: appSettings.vibrationEnabled,
            onChanged: (value) async {
              await ref
                  .read(settingsNotifierProvider.notifier)
                  .setVibrationEnabled(value);
              if (value) {
                await HapticFeedbackUtil.trigger(
                  ref,
                  HapticScene.tap,
                  ignoreSettings: true,
                );
              }
            },
          ),
          const Divider(),
          _SectionHeader(title: '提示'),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '你可以分别设置不同类型通知的接收状态。关闭某个通知类型后，将不会再收到该类型的推送通知。',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
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
