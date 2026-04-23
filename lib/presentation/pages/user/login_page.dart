import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/constants.dart';
import '../../../config/theme.dart';

/// 登录页面
///
/// 用户登录入口，支持账号密码登录
/// 提供跳转到注册和找回密码页面的入口
class LoginPage extends ConsumerStatefulWidget {
  /// 构造函数
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

/// 登录页面状态
class _LoginPageState extends ConsumerState<LoginPage> {
  /// 表单键
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// 账号控制器
  final TextEditingController _accountController = TextEditingController();

  /// 密码控制器
  final TextEditingController _passwordController = TextEditingController();

  /// 是否显示密码
  bool _obscurePassword = true;

  /// 是否正在登录
  bool _isLoading = false;

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// 处理登录
  ///
  /// 验证表单并执行登录操作
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: 实现登录逻辑
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        // 登录成功，跳转到首页
        context.go(RoutePaths.main);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('登录失败: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo 和标题
                const SizedBox(height: 40),
                Icon(
                  Icons.forum,
                  size: 80,
                  color: colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  '欢迎回来',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  '登录以继续探索精彩内容',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

                // 账号输入
                TextFormField(
                  controller: _accountController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: '邮箱/手机号',
                    prefixIcon: Icon(Icons.person_outline),
                    hintText: '请输入邮箱或手机号',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入账号';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 密码输入
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _handleLogin(),
                  decoration: InputDecoration(
                    labelText: '密码',
                    prefixIcon: const Icon(Icons.lock_outline),
                    hintText: '请输入密码',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入密码';
                    }
                    if (value.length < 6) {
                      return '密码长度不能少于6位';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // 忘记密码
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      context.push(RoutePaths.forgotPassword);
                    },
                    child: const Text('忘记密码?'),
                  ),
                ),
                const SizedBox(height: 24),

                // 登录按钮
                FilledButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('登录'),
                ),
                const SizedBox(height: 24),

                // 分隔线
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: colorScheme.outline.withOpacity(0.5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '或使用以下方式登录',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: colorScheme.outline.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 第三方登录
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialLoginButton(
                      icon: Icons.chat_bubble_outline,
                      label: '微信',
                      onTap: () {},
                    ),
                    const SizedBox(width: 24),
                    _SocialLoginButton(
                      icon: Icons.alternate_email,
                      label: 'QQ',
                      onTap: () {},
                    ),
                    const SizedBox(width: 24),
                    _SocialLoginButton(
                      icon: Icons.code,
                      label: 'GitHub',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 48),

                // 注册入口
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '还没有账号?',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.push(RoutePaths.register);
                      },
                      child: const Text('立即注册'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 社交登录按钮
///
/// 用于第三方登录的按钮组件
class _SocialLoginButton extends StatelessWidget {
  /// 图标
  final IconData icon;

  /// 标签
  final String label;

  /// 点击回调
  final VoidCallback onTap;

  /// 构造函数
  const _SocialLoginButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
