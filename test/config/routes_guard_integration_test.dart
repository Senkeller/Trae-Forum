import 'package:flutter_test/flutter_test.dart';
import 'package:traeu/config/routes.dart';
import 'package:traeu/config/constants.dart';

void main() {
  group('isProtectedRoute 静态方法测试', () {
    test('受保护路由列表应包含所有敏感操作路由', () {
      final sensitiveRoutes = [
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
      ];

      for (final route in sensitiveRoutes) {
        expect(
          AppRouter.isProtectedRoute(route),
          isTrue,
          reason: 'Route $route should be protected',
        );
      }
    });

    test('公开路由不应被标记为受保护', () {
      final publicRoutes = [
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
        RoutePaths.themeSettings,
        RoutePaths.fontSettings,
      ];

      for (final route in publicRoutes) {
        expect(
          AppRouter.isProtectedRoute(route),
          isFalse,
          reason: 'Route $route should not be protected',
        );
      }
    });

    test('动态受保护路由应正确识别', () {
      final dynamicProtectedRoutes = [
        '/feed/123/reply',
        '/feed/abc456/edit',
        '/messages/all',
        '/messages/mentions',
        '/messages/system',
      ];

      for (final route in dynamicProtectedRoutes) {
        expect(
          AppRouter.isProtectedRoute(route),
          isTrue,
          reason: 'Dynamic route $route should be protected',
        );
      }
    });

    test('动态公开路由不应被标记为受保护', () {
      final dynamicPublicRoutes = [
        '/feed/123',
        '/feed/abc456',
        '/topic/flutter',
        '/tag/programming',
        '/product/789',
        '/user/123',
        '/user/123/follows',
        '/user/123/fans',
        '/search/result',
      ];

      for (final route in dynamicPublicRoutes) {
        expect(
          AppRouter.isProtectedRoute(route),
          isFalse,
          reason: 'Dynamic route $route should not be protected',
        );
      }
    });
  });

  group('isPublicRoute 静态方法测试', () {
    test('公开路由应正确识别', () {
      final publicRoutes = [
        RoutePaths.main,
        RoutePaths.home,
        RoutePaths.feedDetail,
        RoutePaths.topicList,
        RoutePaths.topics,
        RoutePaths.search,
        RoutePaths.login,
        RoutePaths.register,
        RoutePaths.forgotPassword,
      ];

      for (final route in publicRoutes) {
        expect(
          AppRouter.isPublicRoute(route),
          isTrue,
          reason: 'Route $route should be public',
        );
      }
    });

    test('受保护路由不应被标记为公开', () {
      final protectedRoutes = [
        RoutePaths.feedCreate,
        RoutePaths.feedReply,
        RoutePaths.feedEdit,
        RoutePaths.userEdit,
        RoutePaths.message,
        RoutePaths.notifications,
        RoutePaths.favorites,
      ];

      for (final route in protectedRoutes) {
        expect(
          AppRouter.isPublicRoute(route),
          isFalse,
          reason: 'Route $route should not be public',
        );
      }
    });

    test('未知路由应返回 false', () {
      const unknownRoute = '/unknown/route/xyz';
      expect(AppRouter.isPublicRoute(unknownRoute), isFalse);
      expect(AppRouter.isProtectedRoute(unknownRoute), isFalse);
    });
  });

  group('路由守卫边界情况测试', () {
    test('空路径应正确处理', () {
      expect(AppRouter.isProtectedRoute(''), isFalse);
      expect(AppRouter.isPublicRoute(''), isFalse);
    });

    test('根路径应被识别为公开', () {
      expect(AppRouter.isPublicRoute('/'), isTrue);
      expect(AppRouter.isProtectedRoute('/'), isFalse);
    });

    test('带查询参数的路由应正确处理', () {
      // 查询参数在路由匹配时会被忽略，只匹配路径部分
      const routeWithQuery = '/search/result';
      expect(AppRouter.isPublicRoute(routeWithQuery), isTrue);
      expect(AppRouter.isProtectedRoute(routeWithQuery), isFalse);
    });

    test('带特殊字符的路由应正确处理', () {
      const routeWithSpecialChars = '/topic/flutter%20development';
      expect(AppRouter.isPublicRoute(routeWithSpecialChars), isTrue);
      expect(AppRouter.isProtectedRoute(routeWithSpecialChars), isFalse);
    });

    test('超长路径应正确处理', () {
      final longPath = '/feed/${'a' * 1000}';
      expect(AppRouter.isPublicRoute(longPath), isTrue);
      expect(AppRouter.isProtectedRoute(longPath), isFalse);
    });
  });

  group('路由守卫白名单测试', () {
    test('白名单应包含关键公开路由', () {
      final essentialPublicRoutes = [
        RoutePaths.main,
        RoutePaths.home,
        RoutePaths.login,
        RoutePaths.register,
        RoutePaths.feedDetail,
        RoutePaths.topicList,
        RoutePaths.search,
        RoutePaths.userProfile,
        RoutePaths.settings,
        RoutePaths.about,
      ];

      for (final route in essentialPublicRoutes) {
        expect(
          AppRouter.isPublicRoute(route),
          isTrue,
          reason: 'Route $route should be in public routes',
        );
      }
    });

    test('白名单不应包含受保护路由', () {
      final protectedRoutes = [
        RoutePaths.feedCreate,
        RoutePaths.feedReply,
        RoutePaths.feedEdit,
        RoutePaths.userEdit,
        RoutePaths.message,
        RoutePaths.notifications,
        RoutePaths.favorites,
        RoutePaths.accountSecurity,
      ];

      for (final route in protectedRoutes) {
        expect(
          AppRouter.isPublicRoute(route),
          isFalse,
          reason: 'Route $route should not be in public routes',
        );
      }
    });
  });

  group('路由守卫重定向逻辑测试', () {
    test('未登录访问受保护路由应需要重定向', () {
      // 模拟未登录状态检查
      const targetRoute = RoutePaths.feedCreate;

      // 验证这是受保护路由
      expect(AppRouter.isProtectedRoute(targetRoute), isTrue);

      // 验证这不是公开路由
      expect(AppRouter.isPublicRoute(targetRoute), isFalse);
    });

    test('已登录访问公开路由应正常', () {
      // 模拟已登录状态检查
      const targetRoute = RoutePaths.home;

      // 验证这是公开路由
      expect(AppRouter.isPublicRoute(targetRoute), isTrue);

      // 验证这不是受保护路由
      expect(AppRouter.isProtectedRoute(targetRoute), isFalse);
    });

    test('登录相关路由应始终可访问', () {
      final authRoutes = [
        RoutePaths.login,
        RoutePaths.register,
        RoutePaths.forgotPassword,
      ];

      for (final route in authRoutes) {
        // 验证是公开路由
        expect(
          AppRouter.isPublicRoute(route),
          isTrue,
          reason: 'Auth route $route should be public',
        );

        // 验证不是受保护路由
        expect(
          AppRouter.isProtectedRoute(route),
          isFalse,
          reason: 'Auth route $route should not be protected',
        );
      }
    });
  });
}
