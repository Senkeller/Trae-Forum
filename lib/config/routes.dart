import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'constants.dart';
import '../presentation/pages/main/main_page.dart';
import '../presentation/pages/home/home_page.dart';
import '../presentation/pages/feed/feed_detail_page.dart';
import '../presentation/pages/feed/feed_create_page.dart';
import '../presentation/pages/feed/feed_reply_page.dart';
import '../presentation/pages/feed/feed_edit_page.dart';
import '../presentation/pages/user/user_profile_page.dart';
import '../presentation/pages/user/user_edit_page.dart';
import '../presentation/pages/user/follow_list_page.dart';
import '../presentation/pages/user/fan_list_page.dart';
import '../presentation/pages/user/login_page.dart';
import '../presentation/pages/search/search_page.dart';
import '../presentation/pages/search/search_result_page.dart';
import '../presentation/pages/message/message_page.dart';
import '../presentation/pages/message/message_detail_page.dart';

import '../presentation/pages/notification/notification_settings_page.dart';
import '../presentation/pages/settings/settings_page.dart';
import '../presentation/pages/settings/account_security_page.dart';
import '../presentation/pages/settings/theme_settings_page.dart';
import '../presentation/pages/settings/font_settings_page.dart';
import '../presentation/pages/settings/blacklist_page.dart';
import '../presentation/pages/settings/about_page.dart';
import '../presentation/pages/settings/app_info_page.dart';
import '../presentation/pages/auth/register_page.dart';
import '../presentation/pages/auth/forgot_password_page.dart';
import '../presentation/pages/topic/topic_list_page.dart';
import '../presentation/pages/topic/topic_detail_page.dart';
import '../presentation/pages/topics/topics_page.dart';
import '../presentation/pages/product/product_detail_page.dart';
import '../presentation/pages/history/history_page.dart';
import '../presentation/pages/favorites/favorites_page.dart';
import '../presentation/pages/user/local_favorites_page.dart';
import '../presentation/pages/user/browse_history_page.dart';
import '../presentation/pages/user/frequently_visited_page.dart';
import '../presentation/pages/error/error_page.dart';
import '../presentation/pages/common/webview_page.dart' as webview;
import '../presentation/pages/common/image_preview_page.dart';
import '../presentation/pages/dashboard/trae_dashboard_page.dart';
import '../presentation/pages/user/user_topics_page.dart';
import '../presentation/pages/user/user_replies_page.dart';
import '../presentation/pages/user/user_read_page.dart';
import '../presentation/pages/user/user_drafts_page.dart';
import '../presentation/pages/user/user_likes_page.dart';
import '../presentation/pages/user/user_bookmarks_page.dart';
import '../presentation/pages/user/user_solved_page.dart';
import '../presentation/pages/user/user_votes_page.dart';
import '../presentation/providers/auth_provider.dart';

/// 应用路由配置
class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter get router => _router;

  /// 白名单路由列表（无需登录即可访问）
  @visibleForTesting
  static const List<String> publicRoutes = [
    RoutePaths.main,
    RoutePaths.home,
    RoutePaths.feedDetail,
    RoutePaths.topicList,
    RoutePaths.topics,
    RoutePaths.topicDetail,
    RoutePaths.tagDetail,
    RoutePaths.productDetail,
    RoutePaths.search,
    RoutePaths.searchResult,
    RoutePaths.userProfile,
    RoutePaths.followList,
    RoutePaths.fanList,
    RoutePaths.login,
    RoutePaths.register,
    RoutePaths.forgotPassword,
    RoutePaths.webview,
    RoutePaths.imagePreview,
    RoutePaths.traeDashboard,
    RoutePaths.settings,
    RoutePaths.about,
    RoutePaths.appInfo,
    RoutePaths.themeSettings,
    RoutePaths.fontSettings,
  ];

  /// 受保护路由列表（需要登录）
  @visibleForTesting
  static const List<String> protectedRoutes = [
    RoutePaths.feedCreate,
    RoutePaths.feedReply,
    RoutePaths.feedEdit,
    RoutePaths.userEdit,
    RoutePaths.message,
    RoutePaths.messageDetail,
    RoutePaths.notifications,
    RoutePaths.notificationSettings,
    RoutePaths.accountSecurity,
    RoutePaths.blacklist,
    RoutePaths.history,
    RoutePaths.favorites,
    RoutePaths.localFavorites,
    RoutePaths.browseHistory,
    RoutePaths.frequentlyVisited,
    RoutePaths.userTopics,
    RoutePaths.userReplies,
    RoutePaths.userRead,
    RoutePaths.userDrafts,
    RoutePaths.userLikes,
    RoutePaths.userBookmarks,
    RoutePaths.userSolved,
    RoutePaths.userVotes,
  ];

  /// 检查路由是否为受保护路由
  static bool isProtectedRoute(String path) {
    for (final route in protectedRoutes) {
      if (path == route) {
        return true;
      }
      // 处理动态路由参数匹配
      if (route.contains(':')) {
        final routePattern = route.replaceAll(RegExp(r':\w+'), r'[^/]+');
        if (RegExp('^$routePattern\$').hasMatch(path)) {
          return true;
        }
      }
    }
    return false;
  }

  /// 检查路由是否为公开路由
  static bool isPublicRoute(String path) {
    // 首先检查是否为受保护路由
    if (isProtectedRoute(path)) {
      return false;
    }

    // 处理带参数的路由（如 /feed/:id）
    for (final route in publicRoutes) {
      if (path == route) {
        return true;
      }
      // 处理动态路由参数匹配
      if (route.contains(':')) {
        final routePattern = route.replaceAll(RegExp(r':\w+'), r'[^/]+');
        if (RegExp('^$routePattern\$').hasMatch(path)) {
          return true;
        }
      }
    }
    return false;
  }

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

      // 创建 Feed
      GoRoute(
        path: RoutePaths.feedCreate,
        builder: (context, state) => const FeedCreatePage(),
      ),

      // Feed 详情 - 使用自定义转场动画使跳转更流畅
      GoRoute(
        path: RoutePaths.feedDetail,
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          final postNumber = int.tryParse(
            state.uri.queryParameters['postNumber'] ?? '',
          );
          final postId = int.tryParse(
            state.uri.queryParameters['postId'] ?? '',
          );
          return CustomTransitionPage(
            key: state.pageKey,
            child: FeedDetailPage(
              feedId: id,
              initialPostNumber: postNumber,
              initialPostId: postId,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  // 使用从右向左的滑动动画
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOutCubic;

                  var tween = Tween(
                    begin: begin,
                    end: end,
                  ).chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
            transitionDuration: const Duration(milliseconds: 300),
            reverseTransitionDuration: const Duration(milliseconds: 300),
          );
        },
      ),

      // Feed 回复
      GoRoute(
        path: RoutePaths.feedReply,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return FeedReplyPage(feedId: id);
        },
      ),

      // Feed 编辑
      GoRoute(
        path: RoutePaths.feedEdit,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return FeedEditPage(feedId: id);
        },
      ),

      // 用户主页
      GoRoute(
        path: RoutePaths.userProfile,
        builder: (context, state) {
          final uid = state.pathParameters['uid'];
          final tab = state.uri.queryParameters['tab'];
          final category = state.uri.queryParameters['category'];
          return UserProfilePage(
            uid: uid,
            initialTab: tab,
            initialActivityCategory: category,
          );
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

      // 话题分类页面（新版）
      GoRoute(
        path: RoutePaths.topics,
        builder: (context, state) => const TopicsPage(),
      ),

      // 话题详情
      GoRoute(
        path: RoutePaths.topicDetail,
        builder: (context, state) {
          final rawTag = state.pathParameters['tag']!;
          try {
            final tag = Uri.decodeComponent(rawTag);
            return TopicDetailPage(tag: tag);
          } catch (e) {
            // 如果解码失败，直接使用原始标签
            return TopicDetailPage(tag: rawTag);
          }
        },
      ),

      // 标签详情
      GoRoute(
        path: RoutePaths.tagDetail,
        builder: (context, state) {
          final rawTag = state.pathParameters['tag']!;
          try {
            final tag = Uri.decodeComponent(rawTag);
            return TopicDetailPage(tag: tag);
          } catch (e) {
            // 如果解码失败，直接使用原始标签
            return TopicDetailPage(tag: rawTag);
          }
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
        builder: (context, state) {
          final filter = state.uri.queryParameters['filter'];
          return MessagePage(initialFilter: filter);
        },
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
        builder: (context, state) {
          final filter = state.uri.queryParameters['filter'];
          return MessagePage(initialFilter: filter);
        },
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
        path: RoutePaths.accountSecurity,
        builder: (context, state) => const AccountSecurityPage(),
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

      // 应用信息
      GoRoute(
        path: RoutePaths.appInfo,
        builder: (context, state) => const AppInfoPage(),
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
          final index =
              int.tryParse(state.uri.queryParameters['index'] ?? '0') ?? 0;
          return ImagePreviewPage(imageUrls: images, initialIndex: index);
        },
      ),

      // Trae Dashboard
      GoRoute(
        path: RoutePaths.traeDashboard,
        builder: (context, state) => const TraeDashboardPage(),
      ),

      // 本地收藏
      GoRoute(
        path: RoutePaths.localFavorites,
        builder: (context, state) => const LocalFavoritesPage(),
      ),

      // 浏览历史
      GoRoute(
        path: RoutePaths.browseHistory,
        builder: (context, state) => const BrowseHistoryPage(),
      ),

      // 我常去
      GoRoute(
        path: RoutePaths.frequentlyVisited,
        builder: (context, state) => const FrequentlyVisitedPage(),
      ),

      // 用户话题
      GoRoute(
        path: RoutePaths.userTopics,
        builder: (context, state) {
          final username = state.pathParameters['username']!;
          return UserTopicsPage(username: username);
        },
      ),

      // 用户回复
      GoRoute(
        path: RoutePaths.userReplies,
        builder: (context, state) {
          final username = state.pathParameters['username']!;
          return UserRepliesPage(username: username);
        },
      ),

      // 用户已读
      GoRoute(
        path: RoutePaths.userRead,
        builder: (context, state) {
          final username = state.pathParameters['username']!;
          return UserReadPage(username: username);
        },
      ),

      // 用户草稿
      GoRoute(
        path: RoutePaths.userDrafts,
        builder: (context, state) {
          final username = state.pathParameters['username']!;
          return UserDraftsPage(username: username);
        },
      ),

      // 用户赞
      GoRoute(
        path: RoutePaths.userLikes,
        builder: (context, state) {
          final username = state.pathParameters['username']!;
          return UserLikesPage(username: username);
        },
      ),

      // 用户书签
      GoRoute(
        path: RoutePaths.userBookmarks,
        builder: (context, state) {
          final username = state.pathParameters['username']!;
          return UserBookmarksPage(username: username);
        },
      ),

      // 用户已解决
      GoRoute(
        path: RoutePaths.userSolved,
        builder: (context, state) {
          final username = state.pathParameters['username']!;
          return UserSolvedPage(username: username);
        },
      ),

      // 用户投票
      GoRoute(
        path: RoutePaths.userVotes,
        builder: (context, state) {
          final username = state.pathParameters['username']!;
          return UserVotesPage(username: username);
        },
      ),
    ],

    // 错误页面
    errorBuilder: (context, state) => ErrorPage(error: state.error),

    // 路由守卫
    redirect: (context, state) async {
      final location = state.matchedLocation;

      // 登录相关路由
      final isLoginRoute =
          location == RoutePaths.login ||
          location == RoutePaths.register ||
          location == RoutePaths.forgotPassword;

      // 获取登录状态（使用异步版本，支持 Discourse 登录恢复）
      final container = ProviderScope.containerOf(context);
      final isAuthenticated = await container.read(
        isAuthenticatedAsyncProvider.future,
      );

      debugPrint(
        '[RouteGuard] location=$location, isAuthenticated=$isAuthenticated, isLoginRoute=$isLoginRoute',
      );

      // 未登录访问受保护路由，重定向到登录页
      if (!isAuthenticated && isProtectedRoute(location) && !isLoginRoute) {
        debugPrint('[RouteGuard] 未登录访问受保护路由，重定向到登录页');
        return RoutePaths.login;
      }

      // 已登录访问登录页，重定向到首页
      if (isAuthenticated && isLoginRoute) {
        debugPrint('[RouteGuard] 已登录访问登录页，重定向到首页');
        return RoutePaths.main;
      }

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
    while (router.canPop() &&
        router.routerDelegate.currentConfiguration.uri.path != path) {
      router.pop();
    }
  }

  /// 获取当前路径
  static String get currentPath =>
      router.routerDelegate.currentConfiguration.uri.path;

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
  void navigateTo(String path, {Object? extra}) =>
      appRouter.go(path, extra: extra);

  /// 推送到指定路径
  void pushTo(String path, {Object? extra}) =>
      appRouter.push(path, extra: extra);

  /// 替换当前页面
  void replaceWith(String path, {Object? extra}) =>
      appRouter.replace(path, extra: extra);

  /// 返回上一页
  void goBack<T extends Object?>([T? result]) => appRouter.pop(result);
}
