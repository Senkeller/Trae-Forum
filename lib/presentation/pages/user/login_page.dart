import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'webview_login_page.dart';

/// 登录页面
///
/// 用户登录入口，支持 WebView 登录方式
/// 由于 TRAE 论坛使用 SSO 登录体系，需要通过 WebView 加载官方登录页面
class LoginPage extends ConsumerStatefulWidget {
  /// 构造函数
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

/// 登录页面状态
class _LoginPageState extends ConsumerState<LoginPage> {
  /// 是否正在加载
  bool _isLoading = false;

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

              // 主要登录按钮 - WebView 登录
              FilledButton.icon(
                onPressed: _isLoading ? null : _handleWebViewLogin,
                icon: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.login),
                label: const Text('使用 TRAE 账号登录'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              const SizedBox(height: 16),

              // 说明文字
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 16,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '登录说明',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'TRAE 论坛使用统一的账号体系，点击上方按钮将跳转到官方登录页面完成认证。登录成功后即可在应用内访问论坛的所有功能。',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),

              // 分隔线
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: colorScheme.outline.withValues(alpha: 0.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '其他方式',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: colorScheme.outline.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 浏览器打开选项
              OutlinedButton.icon(
                onPressed: _openInBrowser,
                icon: const Icon(Icons.open_in_browser),
                label: const Text('在浏览器中打开论坛'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              const SizedBox(height: 48),

              // 用户协议
              Text(
                '登录即表示您同意我们的服务条款和隐私政策',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 处理 WebView 登录
  ///
  /// 打开 WebView 登录页面，加载 TRAE 官方登录页面
  Future<void> _handleWebViewLogin() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 延迟一下以显示加载状态
      await Future.delayed(const Duration(milliseconds: 300));

      if (mounted) {
        // 导航到 WebView 登录页面
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const WebViewLoginPage(),
          ),
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

  /// 在浏览器中打开论坛
  ///
  /// 使用系统浏览器打开论坛登录页面
  Future<void> _openInBrowser() async {
    // 这里可以使用 url_launcher 打开浏览器
    // 暂时显示提示
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('将在浏览器中打开论坛登录页面'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
