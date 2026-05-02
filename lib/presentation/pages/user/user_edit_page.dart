import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/constants.dart' show AppConstants, RoutePaths;
import '../../../core/network/discourse_api_service.dart';
import '../../../data/adapters/discourse_adapter.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';

/// 用户资料编辑页面
/// 支持原生编辑昵称和简介，无需跳转到官网
class UserEditPage extends ConsumerStatefulWidget {
  const UserEditPage({super.key});

  @override
  ConsumerState<UserEditPage> createState() => _UserEditPageState();
}

class _UserEditPageState extends ConsumerState<UserEditPage> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  String? _errorMessage;
  String? _successMessage;
  String _avatarUrl = '';
  String _username = '';
  bool _isLoading = false;
  bool _hasChanges = false;

  @override
  void dispose() {
    _nicknameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _initializeFromUserData(Map<String, dynamic>? userData) {
    if (userData == null) return;

    if (_username.isEmpty) {
      _username = userData['username'] ?? '';
      _nicknameController.text = userData['name'] ?? userData['username'] ?? '';
      _bioController.text = userData['bio_raw'] ?? userData['bio'] ?? '';

      final avatarTemplate = userData['avatar_template'] as String?;
      _avatarUrl = DiscourseAdapter.formatAvatarUrl(
        avatarTemplate ?? '',
        _username,
      );
    }
  }

  String _buildProfileEditUrl(String username) {
    final encoded = Uri.encodeComponent(username);
    return '${AppConstants.forumUrl}/u/$encoded/preferences/profile';
  }

  void _openInWebView() {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null || currentUser.username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('请先登录'),
          action: SnackBarAction(
            label: '登录',
            onPressed: () => context.push(RoutePaths.login),
          ),
        ),
      );
      return;
    }
    final url = _buildProfileEditUrl(currentUser.username);
    context.push(
      '${RoutePaths.webview}?url=${Uri.encodeComponent(url)}&title=${Uri.encodeComponent('编辑资料')}',
    );
  }

  Future<void> _openExternal() async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null || currentUser.username.isEmpty) return;
    final launched = await launchUrl(
      Uri.parse(_buildProfileEditUrl(currentUser.username)),
      mode: LaunchMode.externalApplication,
    );
    if (!mounted) return;
    if (!launched) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('无法打开浏览器，请稍后重试')));
    }
  }

  /// 保存用户资料
  /// 调用 Discourse API 更新用户昵称和简介
  Future<void> _saveProfile() async {
    if (_username.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      final apiService = ref.read(discourseApiServiceProvider);
      final response = await apiService.updateUserProfile(
        username: _username,
        name: _nicknameController.text.trim(),
        bioRaw: _bioController.text.trim(),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        // 更新成功，刷新用户资料
        ref.invalidate(discourseUserProfileProvider(_username));
        ref.invalidate(currentUserProvider);

        setState(() {
          _successMessage = '资料已保存';
          _hasChanges = false;
        });

        // 2秒后自动返回
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted && Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        });
      } else {
        setState(() {
          _errorMessage = '保存失败，请稍后重试';
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = '保存失败: ${e.toString()}';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onFieldChanged() {
    if (!_hasChanges) {
      setState(() {
        _hasChanges = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    final isLoggedIn = currentUser != null && currentUser.username.isNotEmpty;
    final colorScheme = Theme.of(context).colorScheme;

    if (!isLoggedIn) {
      return Scaffold(
        appBar: AppBar(title: const Text('编辑资料')),
        body: _StateView(
          icon: Icons.account_circle_outlined,
          title: '未登录',
          message: '登录后可编辑资料',
          actionLabel: '去登录',
          onAction: () => context.push(RoutePaths.login),
        ),
      );
    }

    final userProfileAsync = ref.watch(
      discourseUserProfileProvider(currentUser.username),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('编辑资料'),
        actions: [
          if (_hasChanges && !_isLoading)
            TextButton(
              onPressed: _saveProfile,
              child: const Text('保存'),
            ),
        ],
      ),
      body: userProfileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _StateView(
          icon: Icons.error_outline,
          title: '加载失败',
          message: error.toString(),
          actionLabel: '重试',
          onAction: () => ref.invalidate(
            discourseUserProfileProvider(currentUser.username),
          ),
        ),
        data: (userData) {
          _initializeFromUserData(userData);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _avatarUrl.isNotEmpty
                            ? NetworkImage(_avatarUrl)
                            : null,
                        child: _avatarUrl.isEmpty
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: colorScheme.primary,
                          child: IconButton(
                            icon: const Icon(
                              Icons.camera_alt,
                              size: 18,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('请前往官网编辑头像')),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    '@$_username',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 显示名称输入
                TextField(
                  controller: _nicknameController,
                  onChanged: (_) => _onFieldChanged(),
                  decoration: const InputDecoration(
                    labelText: '显示名称',
                    hintText: '输入你的昵称',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  maxLength: 30,
                ),
                const SizedBox(height: 16),

                // 简介输入
                TextField(
                  controller: _bioController,
                  onChanged: (_) => _onFieldChanged(),
                  decoration: const InputDecoration(
                    labelText: '个人简介',
                    hintText: '介绍一下自己',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.edit_note),
                  ),
                  maxLines: 4,
                  maxLength: 500,
                ),
                const SizedBox(height: 24),

                // 成功提示
                if (_successMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: colorScheme.onPrimaryContainer,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _successMessage!,
                            style: TextStyle(
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // 错误提示
                if (_errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: colorScheme.onErrorContainer,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _errorMessage!,
                            style: TextStyle(
                              color: colorScheme.onErrorContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // 保存按钮
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _isLoading ? null : _saveProfile,
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('保存修改'),
                  ),
                ),
                const SizedBox(height: 24),

                // 更多选项
                Text(
                  '更多选项',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  margin: EdgeInsets.zero,
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.open_in_browser),
                        title: const Text('在官网编辑更多资料'),
                        subtitle: const Text('修改头像、密码等高级设置'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: _openInWebView,
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.language),
                        title: const Text('在浏览器中打开'),
                        trailing: const Icon(Icons.open_in_new),
                        onTap: _openExternal,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
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
