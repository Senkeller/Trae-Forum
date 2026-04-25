import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'constants.dart';
import '../presentation/pages/main/main_page.dart';
import '../presentation/pages/home/home_page.dart';
import '../presentation/pages/feed/feed_detail_page.dart';
import '../presentation/pages/feed/feed_create_page.dart';
import '../presentation/pages/feed/feed_reply_page.dart';
import '../presentation/pages/user/user_profile_page.dart';
import '../presentation/pages/user/user_edit_page.dart';
import '../presentation/pages/user/follow_list_page.dart';
import '../presentation/pages/user/fan_list_page.dart';
import '../presentation/pages/user/login_page.dart';
import '../presentation/pages/search/search_page.dart';
import '../presentation/pages/search/search_result_page.dart';
import '../presentation/pages/message/message_page.dart';
import '../presentation/pages/message/message_detail_page.dart';
import '../presentation/pages/notification/notifications_page.dart';
import '../presentation/pages/notification/notification_settings_page.dart';
import '../presentation/pages/settings/settings_page.dart';
import '../presentation/pages/settings/theme_settings_page.dart';
import '../presentation/pages/settings/font_settings_page.dart';
import '../presentation/pages/settings/blacklist_page.dart';
import '../presentation/pages/settings/about_page.dart';
import '../presentation/pages/auth/register_page.dart';
import '../presentation/pages/auth/forgot_password_page.dart';
import '../presentation/pages/topic/topic_list_page.dart';
import '../presentation/pages/topic/topic_detail_page.dart';
import '../presentation/pages/product/product_detail_page.dart';
import '../presentation/pages/history/history_page.dart';
import '../presentation/pages/favorites/favorites_page.dart';
import '../presentation/pages/error/error_page.dart';
import '../presentation/pages/common/webview_page.dart' as webview;
import '../presentation/pages/common/image_preview_page.dart';
import '../presentation/pages/dashboard/trae_dashboard_page.dart';

/// 应用路由配置
class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  static GoRouter get router => _router;
  
  static final GoRouter _router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: RoutePaths.main,
    debugLogDiagnostics: true,
    routes: [
      // 主页面
      GoRoute(
        path: RoutePaths.main,
        builder: (context, state) => const MainPage(),
      ),
      
      // 首页
      GoRoute(
        path: RoutePaths.home,
        builder: (context, state) => const HomePage(),
      ),
      
      // Feed 详情
      GoRoute(
        path: RoutePaths.feedDetail,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return FeedDetailPage(feedId: id);
        },
      ),
      
      // 创建 Feed
      GoRoute(
        path: RoutePaths.feedCreate,
        builder: (context, state) => const FeedCreatePage(),
      ),
      
      // Feed 回复
      GoRoute(
        path: RoutePaths.feedReply,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return FeedReplyPage(feedId: id);
        },
      ),
      
      // 用户主页
      GoRoute(
        path: RoutePaths.userProfile,
        builder: (context, state) {
          final uid = state.pathParameters['uid'];
          return UserProfilePage(uid: uid);
        },
      ),
      
      // 用户编辑
      GoRoute(
        path: RoutePaths.userEdit,
        builder: (context, state) => const UserEditPage(),
      ),
      
      // 关注列表
      GoRoute(
        path: RoutePaths.followList,
        builder: (context, state) {
          final uid = state.pathParameters['uid']!;
          return FollowListPage(uid: uid);
        },
      ),
      
      // 粉丝列表
      GoRoute(
        path: RoutePaths.fanList,
        builder: (context, state) {
          final uid = state.pathParameters['uid']!;
          return FanListPage(uid: uid);
        },
      ),
      
      // 话题列表
      GoRoute(
        path: RoutePaths.topicList,
        builder: (context, state) => const TopicListPage(),
      ),

      // 话题详情
      GoRoute(
        path: RoutePaths.topicDetail,
        builder: (context, state) {
          final tag = state.pathParameters['tag']!;
          return TopicDetailPage(tag: tag);
        },
      ),

      // 标签详情
      GoRoute(
        path: RoutePaths.tagDetail,
        builder: (context, state) {
          final tag = state.pathParameters['tag']!;
          return TopicDetailPage(tag: tag);
        },
      ),

      // 数码详情
      GoRoute(
        path: RoutePaths.productDetail,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ProductDetailPage(id: id);
        },
      ),
      
      // 搜索
      GoRoute(
        path: RoutePaths.search,
        builder: (context, state) => const SearchPage(),
      ),
      
      // 搜索结果
      GoRoute(
        path: RoutePaths.searchResult,
        builder: (context, state) {
          final query = state.uri.queryParameters['q'] ?? '';
          return SearchResultPage(query: query);
        },
      ),
      
      // 消息
      GoRoute(
        path: RoutePaths.message,
        builder: (context, state) => const MessagePage(),
      ),
      
      // 消息详情
      GoRoute(
        path: RoutePaths.messageDetail,
        builder: (context, state) {
          final type = state.pathParameters['type']!;
          return MessageDetailPage(type: type);
        },
      ),
      
      // 通知
      GoRoute(
        path: RoutePaths.notifications,
        builder: (context, state) => const NotificationsPage(),
      ),
      
      // 通知设置
      GoRoute(
        path: RoutePaths.notificationSettings,
        builder: (context, state) => const NotificationSettingsPage(),
      ),
      
      // 设置
      GoRoute(
        path: RoutePaths.settings,
        builder: (context, state) => const SettingsPage(),
      ),
      
      // 主题设置
      GoRoute(
        path: RoutePaths.themeSettings,
        builder: (context, state) => const ThemeSettingsPage(),
      ),
      
      // 字体设置
      GoRoute(
        path: RoutePaths.fontSettings,
        builder: (context, state) => const FontSettingsPage(),
      ),
      
      // 黑名单
      GoRoute(
        path: RoutePaths.blacklist,
        builder: (context, state) => const BlacklistPage(),
      ),
      
      // 关于
      GoRoute(
        path: RoutePaths.about,
        builder: (context, state) => const AboutPage(),
      ),
      
      // 登录
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const LoginPage(),
      ),
      
      // 注册
      GoRoute(
        path: RoutePaths.register,
        builder: (context, state) => const RegisterPage(),
      ),
      
      // 忘记密码
      GoRoute(
        path: RoutePaths.forgotPassword,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      
      // WebView
      GoRoute(
        path: RoutePaths.webview,
        builder: (context, state) {
          final url = state.uri.queryParameters['url'] ?? '';
          final title = state.uri.queryParameters['title'];
          return webview.WebViewPage(url: url, title: title);
        },
      ),
      
      // 历史记录
      GoRoute(
        path: RoutePaths.history,
        builder: (context, state) => const HistoryPage(),
      ),
      
      // 收藏
      GoRoute(
        path: RoutePaths.favorites,
        builder: (context, state) => const FavoritesPage(),
      ),
      
      // 图片预览
      GoRoute(
        path: RoutePaths.imagePreview,
        builder: (context, state) {
          final images = state.extra as List<String>? ?? [];
          final index = int.tryParse(state.uri.queryParameters['index'] ?? '0') ?? 0;
          return ImagePreviewPage(imageUrls: images, initialIndex: index);
        },
      ),

      // Trae Dashboard
      GoRoute(
        path: RoutePaths.traeDashboard,
        builder: (context, state) => const TraeDashboardPage(),
      ),
    ],
    
    // 错误页面
    errorBuilder: (context, state) => ErrorPage(error: state.error),
    
    // 路由守卫
    redirect: (context, state) {
      // TODO: 实现登录检查
      // final isLoggedIn = context.read(authProvider).isLoggedIn;
      // final isLoginRoute = state.matchedLocation.startsWith('/login');
      // 
      // if (!isLoggedIn && !isLoginRoute) {
      //   return RoutePaths.login;
      // }
      // 
      // if (isLoggedIn && isLoginRoute) {
      //   return RoutePaths.main;
      // }
      
      return null;
    },
  );
  
  /// 导航到指定路径
  static void go(String path, {Object? extra}) {
    router.go(path, extra: extra);
  }
  
  /// 推送到指定路径
  static void push(String path, {Object? extra}) {
    router.push(path, extra: extra);
  }
  
  /// 替换当前页面
  static void replace(String path, {Object? extra}) {
    router.replace(path, extra: extra);
  }
  
  /// 返回上一页
  static void pop<T extends Object?>([T? result]) {
    router.pop(result);
  }
  
  /// 返回指定页面
  static void popUntil(String path) {
    while (router.canPop() && router.routerDelegate.currentConfiguration.uri.path != path) {
      router.pop();
    }
  }
  
  /// 获取当前路径
  static String get currentPath => router.routerDelegate.currentConfiguration.uri.path;
  
  /// 是否能返回
  static bool get canPop => router.canPop();
}

/// 路由扩展
/// 
/// 注意：go_router 包已提供类似的扩展方法，这里使用不同的方法名避免冲突
extension AppRouterExtension on BuildContext {
  /// 获取 GoRouter
  GoRouter get appRouter => GoRouter.of(this);
  
  /// 导航到指定路径
  void navigateTo(String path, {Object? extra}) => appRouter.go(path, extra: extra);
  
  /// 推送到指定路径
  void pushTo(String path, {Object? extra}) => appRouter.push(path, extra: extra);
  
  /// 替换当前页面
  void replaceWith(String path, {Object? extra}) => appRouter.replace(path, extra: extra);
  
  /// 返回上一页
  void goBack<T extends Object?>([T? result]) => appRouter.pop(result);
}
