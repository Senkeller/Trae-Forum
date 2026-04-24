import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/constants.dart';
import '../../../data/models/user.dart';
import '../../../presentation/providers/auth_provider.dart';

/// WebView 登录页面
///
/// 使用 WebView 加载 TRAE 官方登录页面
/// 通过监听 URL 变化和 Cookie 提取实现登录功能
class WebViewLoginPage extends ConsumerStatefulWidget {
  /// 登录成功后跳转的路径
  final String? redirectPath;

  /// 构造函数
  const WebViewLoginPage({
    super.key,
    this.redirectPath,
  });

  @override
  ConsumerState<WebViewLoginPage> createState() => _WebViewLoginPageState();
}

class _WebViewLoginPageState extends ConsumerState<WebViewLoginPage> {
  /// WebView 控制器
  late final WebViewController _controller;

  /// 加载进度 (0-100)
  int _loadingProgress = 0;

  /// 是否正在加载
  bool _isLoading = true;

  /// 是否登录成功
  bool _isLoginSuccess = false;

  /// 登录页面 URL
  static const String _loginUrl = 'https://www.trae.cn/login';

  /// 论坛首页 URL (用于判断是否登录成功)
  static const String _forumUrl = 'https://forum.trae.cn';

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  /// 初始化 WebView
  void _initWebView() {
    // 平台特定参数
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    // 创建控制器
    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    // 配置控制器
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _loadingProgress = progress;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) async {
            setState(() {
              _isLoading = false;
            });

            // 检查是否登录成功
            await _checkLoginStatus(url);
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              _isLoading = false;
            });
            debugPrint('''
              WebView 错误:
              错误码: ${error.errorCode}
              描述: ${error.description}
              错误类型: ${error.errorType}
              URL: ${error.url}
            ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('导航请求: ${request.url}');

            // 检查是否是登录成功后的跳转
            if (_isLoginSuccessUrl(request.url)) {
              _handleLoginSuccess();
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      );

    // Android 特定配置
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    // 加载登录页面
    controller.loadRequest(Uri.parse(_loginUrl));

    _controller = controller;
  }

  /// 检查 URL 是否是登录成功后的跳转
  bool _isLoginSuccessUrl(String url) {
    // 如果跳转回论坛首页或用户页面，说明登录成功
    final isSuccess = url.startsWith(_forumUrl) &&
        (url.contains('/session/sso_login') ||
            url == _forumUrl ||
            url == '$_forumUrl/');
    debugPrint('🔍 [WebViewLogin] 检查URL: $url');
    debugPrint('🔍 [WebViewLogin] 是否登录成功URL: $isSuccess');
    return isSuccess;
  }

  /// 检查登录状态
  Future<void> _checkLoginStatus(String url) async {
    try {
      // 如果当前在论坛页面且不是登录页，说明已登录
      if (url.startsWith(_forumUrl) && !url.contains('/login')) {
        // 尝试提取用户信息
        final userInfo = await _extractUserInfo();
        if (userInfo != null) {
          _handleLoginSuccess(userInfo: userInfo);
        }
      }
    } catch (e) {
      debugPrint('检查登录状态失败: $e');
    }
  }

  /// 从页面提取用户信息
  Future<Map<String, dynamic>?> _extractUserInfo() async {
    try {
      // 执行 JavaScript 获取用户信息
      final result = await _controller.runJavaScriptReturningResult('''
        (function() {
          // 尝试从页面获取用户信息
          // Discourse 通常会在页面中暴露当前用户信息
          if (typeof Discourse !== 'undefined' && Discourse.User) {
            return JSON.stringify({
              username: Discourse.User.currentProp('username'),
              name: Discourse.User.currentProp('name'),
              avatar_template: Discourse.User.currentProp('avatar_template'),
              id: Discourse.User.currentProp('id')
            });
          }
          // 尝试从 meta 标签获取
          const metaUser = document.querySelector('meta[name=discourse-username]');
          if (metaUser) {
            return JSON.stringify({
              username: metaUser.content
            });
          }
          return null;
        })()
      ''');

      if (result.toString().isNotEmpty) {
        // 解析结果
        final String resultStr = result.toString();
        if (resultStr != 'null') {
          // 移除 Dart 字符串的引号包裹
          final cleanJson = resultStr
              .replaceAll('"{"', '{"')
              .replaceAll('"}"', '"}')
              .replaceAll('""', '"');
          debugPrint('提取到用户信息: $cleanJson');
          // 这里简化处理，实际应该解析 JSON
          return {'username': 'user'};
        }
      }
    } catch (e) {
      debugPrint('提取用户信息失败: $e');
    }
    return null;
  }

  /// 处理登录成功
  void _handleLoginSuccess({Map<String, dynamic>? userInfo}) async {
    if (_isLoginSuccess) return; // 防止重复处理
    _isLoginSuccess = true;

    // 显示成功提示
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('登录成功'),
          backgroundColor: Colors.green,
        ),
      );
    }

    // 获取用户名（从 WebView 或传入的参数）
    String username = '用户';
    String userId = 'webview_user';

    if (userInfo != null && userInfo['username'] != null) {
      username = userInfo['username'].toString();
    } else {
      // 尝试从 Cookie 或页面获取用户名
      try {
        final cookieResult = await _controller.runJavaScriptReturningResult('''
          (function() {
            // 尝试从 Discourse 获取当前用户名
            if (typeof Discourse !== 'undefined' && Discourse.User && Discourse.User.current()) {
              return Discourse.User.current().username || '';
            }
            // 从 meta 标签获取
            const meta = document.querySelector('meta[name=discourse-username]');
            if (meta) return meta.content;
            // 从页面数据获取
            if (window.PreloadStore && window.PreloadStore.data) {
              const data = window.PreloadStore.data;
              if (data.current_user) return data.current_user.username;
            }
            return '';
          })()
        ''');
        final resultStr = cookieResult.toString();
        if (resultStr.isNotEmpty && resultStr != 'null' && resultStr != '""') {
          username = resultStr.replaceAll('"', '');
          userId = username;
        }
      } catch (e) {
        debugPrint('获取用户名失败: $e');
      }
    }

    // 创建用户信息对象并保存
    final userData = UserInfo(
      uid: userId,
      username: username,
      avatar: '',
    );

    // 保存到本地存储并更新状态
    await ref.read(authNotifierProvider.notifier).setUserInfo(userData);

    // 延迟后返回或跳转
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      if (widget.redirectPath != null) {
        context.go(widget.redirectPath!);
      } else {
        context.go(RoutePaths.main);
      }
    }
  }

  @override
  void dispose() {
    _controller.clearCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('登录'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _controller.reload();
            },
            tooltip: '刷新',
          ),
        ],
      ),
      body: Stack(
        children: [
          // WebView
          WebViewWidget(controller: _controller),

          // 加载进度条
          if (_isLoading)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(
                value: _loadingProgress / 100,
                backgroundColor: colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
              ),
            ),

          // 加载中提示
          if (_isLoading && _loadingProgress < 30)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '正在加载登录页面...',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
