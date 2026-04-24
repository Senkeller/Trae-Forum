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
    debugPrint('🔍 [WebViewLogin] 页面加载完成: $url');
    try {
      // 检测登录成功的几种情况：
      // 1. 跳转到论坛页面（已登录状态）
      // 2. 跳转到 TRAE 主站的 dashboard（登录成功后的页面）
      final isForumPage = url.startsWith(_forumUrl) && !url.contains('/login');
      final isTraeDashboard = url.startsWith('https://www.trae.cn') &&
          (url.contains('/dashboard') || url.contains('/console') || url == 'https://www.trae.cn/');

      if (isForumPage) {
        debugPrint('✅ [WebViewLogin] 检测到论坛页面，尝试提取用户信息');
        // 尝试提取用户信息
        final userInfo = await _extractUserInfo();
        debugPrint('✅ [WebViewLogin] 提取到的用户信息: $userInfo');
        // 即使无法提取用户信息，也认为是登录成功
        _handleLoginSuccess(userInfo: userInfo);
      } else if (isTraeDashboard) {
        debugPrint('✅ [WebViewLogin] 检测到 TRAE 登录成功页面，准备跳转到论坛验证');
        // 登录成功，但需要跳转到论坛来验证登录状态
        // 延迟一下确保 Cookie 已经保存
        await Future.delayed(const Duration(seconds: 1));
        debugPrint('🚀 [WebViewLogin] 导航到论坛页面');
        await _controller.loadRequest(Uri.parse(_forumUrl));
      } else {
        debugPrint('ℹ️ [WebViewLogin] 当前不是登录成功页面，跳过登录检测');
      }
    } catch (e) {
      debugPrint('❌ [WebViewLogin] 检查登录状态失败: $e');
    }
  }

  /// 从页面提取用户信息
  Future<Map<String, dynamic>?> _extractUserInfo() async {
    try {
      debugPrint('🔍 [WebViewLogin] 开始从页面提取用户信息...');
      // 执行 JavaScript 获取用户信息
      final result = await _controller.runJavaScriptReturningResult('''
        (function() {
          // 方法1: 尝试从 Discourse 全局对象获取当前用户信息
          if (typeof Discourse !== 'undefined' && Discourse.User && Discourse.User.current && Discourse.User.current()) {
            const user = Discourse.User.current();
            return JSON.stringify({
              username: user.username || '',
              name: user.name || '',
              id: user.id || ''
            });
          }
          // 方法2: 尝试从 meta 标签获取
          const metaUser = document.querySelector('meta[name=discourse-username]');
          if (metaUser && metaUser.content) {
            return JSON.stringify({
              username: metaUser.content
            });
          }
          // 方法3: 尝试从 PreloadStore 获取
          if (typeof PreloadStore !== 'undefined' && PreloadStore.data && PreloadStore.data.current_user) {
            const user = PreloadStore.data.current_user;
            return JSON.stringify({
              username: user.username || '',
              name: user.name || '',
              id: user.id || ''
            });
          }
          // 方法4: 尝试从页面中的当前用户菜单获取
          const userMenu = document.querySelector('.user-menu .username');
          if (userMenu && userMenu.textContent) {
            return JSON.stringify({
              username: userMenu.textContent.trim()
            });
          }
          return null;
        })()
      ''');

      debugPrint('🔍 [WebViewLogin] JavaScript 返回原始结果: $result');

      if (result != null && result.toString().isNotEmpty && result.toString() != 'null') {
        // 解析结果
        final String resultStr = result.toString();
        // 移除 Dart 字符串的外层引号
        String cleanJson = resultStr;
        if (cleanJson.startsWith('"') && cleanJson.endsWith('"')) {
          cleanJson = cleanJson.substring(1, cleanJson.length - 1);
        }
        // 处理转义的引号
        cleanJson = cleanJson.replaceAll('\\"', '"');

        debugPrint('✅ [WebViewLogin] 提取到用户信息 JSON: $cleanJson');

        // 简单解析 JSON
        if (cleanJson.contains('username')) {
          // 提取 username 值
          final usernameMatch = RegExp(r'"username":"([^"]*)"').firstMatch(cleanJson);
          if (usernameMatch != null) {
            final username = usernameMatch.group(1) ?? '';
            if (username.isNotEmpty) {
              debugPrint('✅ [WebViewLogin] 解析到用户名: $username');
              return {'username': username};
            }
          }
        }
      }
      debugPrint('⚠️ [WebViewLogin] 未能从页面提取到有效用户信息');
    } catch (e) {
      debugPrint('❌ [WebViewLogin] 提取用户信息失败: $e');
    }
    return null;
  }

  /// 处理登录成功
  void _handleLoginSuccess({Map<String, dynamic>? userInfo}) async {
    debugPrint('🎉 [WebViewLogin] _handleLoginSuccess 被调用');
    if (_isLoginSuccess) {
      debugPrint('⚠️ [WebViewLogin] 已经处理过登录成功，跳过');
      return; // 防止重复处理
    }
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
      debugPrint('✅ [WebViewLogin] 从 userInfo 获取用户名: $username');
    } else {
      // 尝试从 Cookie 或页面获取用户名
      try {
        debugPrint('🔍 [WebViewLogin] 尝试从页面获取用户名...');
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
        debugPrint('✅ [WebViewLogin] JavaScript 返回: $resultStr');
        if (resultStr.isNotEmpty && resultStr != 'null' && resultStr != '""') {
          username = resultStr.replaceAll('"', '');
          userId = username;
          debugPrint('✅ [WebViewLogin] 解析后的用户名: $username');
        } else {
          debugPrint('⚠️ [WebViewLogin] JavaScript 返回为空，使用默认用户名');
        }
      } catch (e) {
        debugPrint('❌ [WebViewLogin] 获取用户名失败: $e');
      }
    }

    // 创建用户信息对象并保存
    debugPrint('💾 [WebViewLogin] 创建 UserInfo: uid=$userId, username=$username');
    final userData = UserInfo(
      uid: userId,
      username: username,
      avatar: '',
    );

    // 保存到本地存储并更新状态
    debugPrint('💾 [WebViewLogin] 调用 setUserInfo...');
    await ref.read(authNotifierProvider.notifier).setUserInfo(userData);
    debugPrint('✅ [WebViewLogin] setUserInfo 完成');

    // 验证保存结果
    final prefs = await SharedPreferences.getInstance();
    final savedUid = prefs.getString('uid');
    final savedUsername = prefs.getString('username');
    debugPrint('🔍 [WebViewLogin] 验证保存结果: uid=$savedUid, username=$savedUsername');

    // 延迟后返回或跳转
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      debugPrint('🚀 [WebViewLogin] 导航到首页');
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
