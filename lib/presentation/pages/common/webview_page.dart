import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

/// WebView 页面
///
/// 用于加载网页内容的页面，支持加载指定 URL
/// 包含加载进度指示器和错误处理
class WebViewPage extends StatefulWidget {
  /// 页面标题
  final String? title;

  /// 要加载的 URL
  final String url;

  /// 是否显示 AppBar
  final bool showAppBar;

  /// 构造函数
  const WebViewPage({
    super.key,
    this.title,
    required this.url,
    this.showAppBar = true,
  });

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  /// WebView 控制器
  late final WebViewController _controller;

  /// 加载进度 (0-100)
  int _loadingProgress = 0;

  /// 是否正在加载
  bool _isLoading = true;

  /// 页面标题
  String _pageTitle = '';

  /// 是否加载出错
  bool _hasError = false;

  /// 错误信息
  String _errorMessage = '';

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
              _hasError = false;
            });
          },
          onPageFinished: (String url) async {
            setState(() {
              _isLoading = false;
            });
            // 获取页面标题
            try {
              final title = await controller.getTitle();
              if (title != null && title.isNotEmpty) {
                setState(() {
                  _pageTitle = title;
                });
              }
            } catch (e) {
              debugPrint('获取页面标题失败: $e');
            }
          },
          onWebResourceError: (WebResourceError error) {
            // 忽略某些非关键错误（如 ORB 阻止的第三方资源）
            final isNonCriticalError = error.description?.contains('ERR_BLOCKED_BY_ORB') == true ||
                error.description?.contains('ERR_BLOCKED_BY_RESPONSE') == true ||
                error.description?.contains('ERR_ABORTED') == true;

            if (isNonCriticalError) {
              debugPrint('WebView 非关键错误(已忽略): ${error.description} - URL: ${error.url}');
              return;
            }

            setState(() {
              _isLoading = false;
              _hasError = true;
              _errorMessage = '加载失败: ${error.description}';
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
            // 可以在这里拦截某些 URL
            debugPrint('导航请求: ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      );

    // Android 特定配置
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    // 加载 URL
    controller.loadRequest(Uri.parse(widget.url));

    _controller = controller;
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
      appBar: widget.showAppBar
          ? AppBar(
              title: Text(
                widget.title ?? _pageTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    _controller.reload();
                  },
                  tooltip: '刷新',
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () async {
                    if (await _controller.canGoBack()) {
                      await _controller.goBack();
                    }
                  },
                  tooltip: '后退',
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () async {
                    if (await _controller.canGoForward()) {
                      await _controller.goForward();
                    }
                  },
                  tooltip: '前进',
                ),
              ],
            )
          : null,
      body: Stack(
        children: [
          // WebView
          if (!_hasError)
            WebViewWidget(controller: _controller)
          else
            _buildErrorWidget(colorScheme),

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
        ],
      ),
    );
  }

  /// 构建错误页面
  Widget _buildErrorWidget(ColorScheme colorScheme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              '页面加载失败',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage,
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _hasError = false;
                  _isLoading = true;
                });
                _controller.reload();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('重新加载'),
            ),
          ],
        ),
      ),
    );
  }
}
