import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/constants.dart';
import '../../../core/utils/haptic_feedback_util.dart';
import '../../providers/auth_provider.dart';
import '../../providers/settings_provider.dart';

/// 设置页面
///
/// 应用的设置中心，包含：
/// - 账号与安全
/// - 主题设置
/// - 字体设置
/// - 通知设置
/// - 隐私设置
/// - 黑名单
/// - 关于
/// - 退出登录
class SettingsPage extends ConsumerWidget {
  /// 构造函数
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final appSettings = ref.watch(currentSettingsProvider);
    final isLoggedIn = currentUser != null;

    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      body: ListView(
        children: [
          // 账号与安全
          _SectionHeader(title: '账号'),
          _SettingItem(
            icon: Icons.person_outline,
            title: '账号与安全',
            subtitle: isLoggedIn
                ? '当前账号：${currentUser.username}'
                : '未登录，前往登录与管理账号',
            onTap: () {
              context.push(RoutePaths.accountSecurity);
            },
          ),
          _SettingItem(
            icon: Icons.edit_outlined,
            title: '编辑资料',
            onTap: () {
              context.push(RoutePaths.userEdit);
            },
          ),

          // 外观
          _SectionHeader(title: '外观'),
          _SettingItem(
            icon: Icons.palette_outlined,
            title: '主题设置',
            subtitle: '跟随系统',
            onTap: () {
              context.push(RoutePaths.themeSettings);
            },
          ),
          _SettingItem(
            icon: Icons.text_fields_outlined,
            title: '字体设置',
            subtitle: '标准',
            onTap: () {
              context.push(RoutePaths.fontSettings);
            },
          ),

          // 通知
          _SectionHeader(title: '通知'),
          _SwitchSettingItem(
            icon: Icons.notifications_outlined,
            title: '接收通知',
            subtitle: '开启后接收推送通知',
            value: appSettings.pushNotification,
            onChanged: (value) {
              ref
                  .read(settingsNotifierProvider.notifier)
                  .setPushNotification(value);
            },
          ),
          _SwitchSettingItem(
            icon: Icons.volume_up_outlined,
            title: '声音',
            subtitle: '开启通知声音',
            value: appSettings.soundEnabled,
            onChanged: (value) {
              ref
                  .read(settingsNotifierProvider.notifier)
                  .setSoundEnabled(value);
            },
          ),
          _SwitchSettingItem(
            icon: Icons.vibration_outlined,
            title: '振动',
            subtitle: '开启通知振动',
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

          // 隐私
          _SectionHeader(title: '隐私'),
          _SettingItem(
            icon: Icons.block_outlined,
            title: '黑名单',
            subtitle: '已屏蔽 0 个用户',
            onTap: () {
              context.push(RoutePaths.blacklist);
            },
          ),
          _SwitchSettingItem(
            icon: Icons.visibility_off_outlined,
            title: '私密账号',
            subtitle: '开启后需要批准才能关注你',
            value: false,
            onChanged: (value) {
              // TODO: 切换私密账号设置
            },
          ),

          // 通用
          _SectionHeader(title: '通用'),
          _SettingItem(
            icon: Icons.image_outlined,
            title: '图片质量',
            subtitle: '自动',
            onTap: () {
              _showImageQualityDialog(context);
            },
          ),
          _SwitchSettingItem(
            icon: Icons.play_circle_outline,
            title: '自动播放视频',
            subtitle: 'Wi-Fi 下自动播放',
            value: true,
            onChanged: (value) {
              // TODO: 切换自动播放设置
            },
          ),
          _SettingItem(
            icon: Icons.language_outlined,
            title: '语言',
            subtitle: '简体中文',
            onTap: () {
              // TODO: 语言设置
            },
          ),
          _SettingItem(
            icon: Icons.storage_outlined,
            title: '清除缓存',
            subtitle: '12.5 MB',
            onTap: () {
              _showClearCacheDialog(context);
            },
          ),

          // 关于
          _SectionHeader(title: '关于'),
          _SettingItem(
            icon: Icons.info_outline,
            title: '关于我们',
            onTap: () {
              context.push(RoutePaths.about);
            },
          ),
          _SettingItem(
            icon: Icons.apps_outlined,
            title: '应用信息',
            subtitle: '项目特性、技术栈、开源信息',
            onTap: () {
              context.push(RoutePaths.appInfo);
            },
          ),
          _SettingItem(
            icon: Icons.description_outlined,
            title: '用户协议',
            onTap: () {
              // TODO: 打开用户协议
            },
          ),
          _SettingItem(
            icon: Icons.privacy_tip_outlined,
            title: '隐私政策',
            onTap: () {
              // TODO: 打开隐私政策
            },
          ),
          _SettingItem(
            icon: Icons.update_outlined,
            title: '检查更新',
            subtitle: '当前版本 1.0.0',
            onTap: () {
              // TODO: 检查更新
            },
          ),

          // 退出登录
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _LogoutButton(
              isLoggedIn: isLoggedIn,
              onTap: () => isLoggedIn
                  ? _showLogoutDialog(context, ref)
                  : context.push(RoutePaths.login),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  /// 显示图片质量选择对话框
  ///
  /// [context] 构建上下文
  void _showImageQualityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('图片质量'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: const Text('自动'),
              subtitle: const Text('根据网络自动选择'),
              value: 'auto',
              groupValue: 'auto',
              onChanged: (value) {
                Navigator.of(context).pop();
              },
            ),
            RadioListTile(
              title: const Text('高清'),
              subtitle: const Text('始终加载高清图片'),
              value: 'high',
              groupValue: 'auto',
              onChanged: (value) {
                Navigator.of(context).pop();
              },
            ),
            RadioListTile(
              title: const Text('标准'),
              subtitle: const Text('节省流量'),
              value: 'normal',
              groupValue: 'auto',
              onChanged: (value) {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
        ],
      ),
    );
  }

  /// 显示清除缓存确认对话框
  ///
  /// [context] 构建上下文
  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('清除缓存'),
        content: const Text('确定要清除所有缓存数据吗？这将删除图片、网页等缓存文件。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: 执行清除缓存操作
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  /// 显示退出登录确认对话框
  ///
  /// [context] 构建上下文
  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.logout_outlined, color: colorScheme.error, size: 24),
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
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.onSurfaceVariant,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(context).pop();

              // 触发触觉反馈
              await HapticFeedbackUtil.trigger(ref, HapticScene.deleteSuccess);

              await ref.read(authNotifierProvider.notifier).logout();

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
                context.go(RoutePaths.main);
              }
            },
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
  }
}

/// 退出登录按钮
///
/// 带有动画效果和触觉反馈的退出登录按钮
class _LogoutButton extends StatefulWidget {
  /// 是否已登录
  final bool isLoggedIn;

  /// 点击回调
  final VoidCallback onTap;

  /// 构造函数
  const _LogoutButton({required this.isLoggedIn, required this.onTap});

  @override
  State<_LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<_LogoutButton>
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
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
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
          return Transform.scale(scale: _scaleAnimation.value, child: child);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: widget.isLoggedIn
                ? LinearGradient(
                    colors: [
                      colorScheme.error.withValues(alpha: 0.9),
                      colorScheme.error,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [
                      colorScheme.primary.withValues(alpha: 0.9),
                      colorScheme.primary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: widget.isLoggedIn
                    ? colorScheme.error.withValues(alpha: 0.3)
                    : colorScheme.primary.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.isLoggedIn
                    ? Icons.logout_outlined
                    : Icons.login_outlined,
                color: widget.isLoggedIn
                    ? colorScheme.onError
                    : colorScheme.onPrimary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                widget.isLoggedIn ? '退出登录' : '去登录',
                style: TextStyle(
                  color: widget.isLoggedIn
                      ? colorScheme.onError
                      : colorScheme.onPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 分组标题
///
/// 设置项分组标题
class _SectionHeader extends StatelessWidget {
  /// 标题文字
  final String title;

  /// 构造函数
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// 设置项
///
/// 可点击的设置项
class _SettingItem extends StatelessWidget {
  /// 图标
  final IconData icon;

  /// 标题
  final String title;

  /// 副标题
  final String? subtitle;

  /// 点击回调
  final VoidCallback onTap;

  /// 构造函数
  const _SettingItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      leading: Icon(icon, color: colorScheme.onSurfaceVariant),
      title: Text(title),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            )
          : null,
      trailing: Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
      onTap: onTap,
    );
  }
}

/// 开关设置项
///
/// 带开关的设置项
class _SwitchSettingItem extends StatelessWidget {
  /// 图标
  final IconData icon;

  /// 标题
  final String title;

  /// 副标题
  final String? subtitle;

  /// 当前值
  final bool value;

  /// 变更回调
  final ValueChanged<bool> onChanged;

  /// 构造函数
  const _SwitchSettingItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SwitchListTile(
      secondary: Icon(icon, color: colorScheme.onSurfaceVariant),
      title: Text(title),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            )
          : null,
      value: value,
      onChanged: onChanged,
    );
  }
}
