import 'package:flutter_test/flutter_test.dart';
import 'package:traeu/config/routes.dart';
import 'package:traeu/config/constants.dart';

void main() {
  group('AppRouter Route Guard Tests', () {
    test('isPublicRoute should return true for public routes', () {
      // 完全匹配的路由
      expect(AppRouter.isPublicRoute(RoutePaths.main), isTrue);
      expect(AppRouter.isPublicRoute(RoutePaths.home), isTrue);
      expect(AppRouter.isPublicRoute(RoutePaths.topicList), isTrue);
      expect(AppRouter.isPublicRoute(RoutePaths.topics), isTrue);
      expect(AppRouter.isPublicRoute(RoutePaths.search), isTrue);
      expect(AppRouter.isPublicRoute(RoutePaths.login), isTrue);
      expect(AppRouter.isPublicRoute(RoutePaths.register), isTrue);
      expect(AppRouter.isPublicRoute(RoutePaths.forgotPassword), isTrue);
      expect(AppRouter.isPublicRoute(RoutePaths.settings), isTrue);
      expect(AppRouter.isPublicRoute(RoutePaths.about), isTrue);
    });

    test('isPublicRoute should return true for dynamic public routes', () {
      // 动态路由参数匹配
      expect(AppRouter.isPublicRoute('/feed/123'), isTrue);
      expect(AppRouter.isPublicRoute('/feed/abc123'), isTrue);
      expect(AppRouter.isPublicRoute('/topic/general'), isTrue);
      expect(AppRouter.isPublicRoute('/topic/flutter-dev'), isTrue);
      expect(AppRouter.isPublicRoute('/tag/programming'), isTrue);
      expect(AppRouter.isPublicRoute('/product/456'), isTrue);
      expect(AppRouter.isPublicRoute('/user/789'), isTrue);
      expect(AppRouter.isPublicRoute('/user/789/follows'), isTrue);
      expect(AppRouter.isPublicRoute('/user/789/fans'), isTrue);
      expect(AppRouter.isPublicRoute('/search/result'), isTrue);
    });

    test('isPublicRoute should return false for protected routes', () {
      expect(AppRouter.isPublicRoute(RoutePaths.feedCreate), isFalse);
      expect(AppRouter.isPublicRoute(RoutePaths.feedReply), isFalse);
      expect(AppRouter.isPublicRoute(RoutePaths.feedEdit), isFalse);
      expect(AppRouter.isPublicRoute(RoutePaths.userEdit), isFalse);
      expect(AppRouter.isPublicRoute(RoutePaths.message), isFalse);
      expect(AppRouter.isPublicRoute(RoutePaths.notifications), isFalse);
      expect(AppRouter.isPublicRoute(RoutePaths.favorites), isFalse);
      expect(AppRouter.isPublicRoute(RoutePaths.history), isFalse);
    });

    test('isProtectedRoute should return true for protected routes', () {
      // 完全匹配的路由
      expect(AppRouter.isProtectedRoute(RoutePaths.feedCreate), isTrue);
      expect(AppRouter.isProtectedRoute(RoutePaths.userEdit), isTrue);
      expect(AppRouter.isProtectedRoute(RoutePaths.message), isTrue);
      expect(AppRouter.isProtectedRoute(RoutePaths.notifications), isTrue);
      expect(AppRouter.isProtectedRoute(RoutePaths.notificationSettings), isTrue);
      expect(AppRouter.isProtectedRoute(RoutePaths.accountSecurity), isTrue);
      expect(AppRouter.isProtectedRoute(RoutePaths.blacklist), isTrue);
      expect(AppRouter.isProtectedRoute(RoutePaths.history), isTrue);
      expect(AppRouter.isProtectedRoute(RoutePaths.favorites), isTrue);
      expect(AppRouter.isProtectedRoute(RoutePaths.localFavorites), isTrue);
      expect(AppRouter.isProtectedRoute(RoutePaths.browseHistory), isTrue);
      expect(AppRouter.isProtectedRoute(RoutePaths.frequentlyVisited), isTrue);
    });

    test('isProtectedRoute should return true for dynamic protected routes', () {
      // 动态路由参数匹配
      expect(AppRouter.isProtectedRoute('/feed/123/reply'), isTrue);
      expect(AppRouter.isProtectedRoute('/feed/abc123/edit'), isTrue);
      expect(AppRouter.isProtectedRoute('/messages/all'), isTrue);
      expect(AppRouter.isProtectedRoute('/messages/mention'), isTrue);
    });

    test('isProtectedRoute should return false for public routes', () {
      expect(AppRouter.isProtectedRoute(RoutePaths.main), isFalse);
      expect(AppRouter.isProtectedRoute(RoutePaths.home), isFalse);
      expect(AppRouter.isProtectedRoute(RoutePaths.feedDetail), isFalse);
      expect(AppRouter.isProtectedRoute(RoutePaths.topicList), isFalse);
      expect(AppRouter.isProtectedRoute(RoutePaths.search), isFalse);
      expect(AppRouter.isProtectedRoute(RoutePaths.login), isFalse);
      expect(AppRouter.isProtectedRoute(RoutePaths.register), isFalse);
      expect(AppRouter.isProtectedRoute('/feed/123'), isFalse);
      expect(AppRouter.isProtectedRoute('/user/789'), isFalse);
    });

    test('public and protected routes should not overlap', () {
      // 确保没有路由同时属于公开和受保护
      final allRoutes = [
        ...AppRouter.publicRoutes,
        ...AppRouter.protectedRoutes,
      ];

      // 检查是否有重复
      final uniqueRoutes = allRoutes.toSet();
      expect(uniqueRoutes.length, equals(allRoutes.length),
          reason: 'Public and protected routes should not have duplicates');
    });

    test('white list should include essential routes', () {
      // 确保白名单包含关键公开路由
      final essentialPublicRoutes = [
        RoutePaths.main,
        RoutePaths.home,
        RoutePaths.login,
        RoutePaths.register,
        RoutePaths.feedDetail,
        RoutePaths.topicList,
        RoutePaths.search,
        RoutePaths.userProfile,
      ];

      for (final route in essentialPublicRoutes) {
        expect(
          AppRouter.isPublicRoute(route),
          isTrue,
          reason: 'Route $route should be in public routes',
        );
      }
    });

    test('protected routes should include sensitive operations', () {
      // 确保受保护路由包含敏感操作
      final sensitiveRoutes = [
        RoutePaths.feedCreate,
        RoutePaths.feedReply,
        RoutePaths.feedEdit,
        RoutePaths.userEdit,
        RoutePaths.message,
        RoutePaths.notifications,
        RoutePaths.favorites,
        RoutePaths.accountSecurity,
      ];

      for (final route in sensitiveRoutes) {
        expect(
          AppRouter.isProtectedRoute(route),
          isTrue,
          reason: 'Route $route should be protected',
        );
      }
    });
  });
}
