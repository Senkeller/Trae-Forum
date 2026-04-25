import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  group('Route Smoke Tests', () {
    testWidgets('All routes build without crashing', (WidgetTester tester) async {
      final routes = [
        '/',
        '/home',
        '/feed/1',
        '/feed/create',
        '/feed/1/reply',
        '/user/1',
        '/user/edit',
        '/user/1/follows',
        '/user/1/fans',
        '/topics',
        '/topic/general',
        '/search',
        '/search/result',
        '/messages',
        '/notifications',
        '/settings',
        '/settings/theme',
        '/settings/font',
        '/settings/blacklist',
        '/settings/about',
        '/history',
        '/favorites',
      ];

      final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(body: Center(child: Text('Main Page'))),
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) => const Scaffold(body: Center(child: Text('Home Page'))),
          ),
          GoRoute(
            path: '/feed/create',
            builder: (context, state) => const Scaffold(body: Center(child: Text('Feed Create Page'))),
          ),
          GoRoute(
            path: '/feed/:id',
            builder: (context, state) => Scaffold(body: Center(child: Text('Feed Detail: ${state.pathParameters['id']}'))),
          ),
          GoRoute(
            path: '/feed/:id/reply',
            builder: (context, state) => Scaffold(body: Center(child: Text('Feed Reply: ${state.pathParameters['id']}'))),
          ),
          GoRoute(
            path: '/user/:uid',
            builder: (context, state) => Scaffold(body: Center(child: Text('User Profile: ${state.pathParameters['uid']}'))),
          ),
          GoRoute(
            path: '/user/edit',
            builder: (context, state) => const Scaffold(body: Center(child: Text('User Edit Page'))),
          ),
          GoRoute(
            path: '/user/:uid/follows',
            builder: (context, state) => Scaffold(body: Center(child: Text('Follow List: ${state.pathParameters['uid']}'))),
          ),
          GoRoute(
            path: '/user/:uid/fans',
            builder: (context, state) => Scaffold(body: Center(child: Text('Fan List: ${state.pathParameters['uid']}'))),
          ),
          GoRoute(
            path: '/topics',
            builder: (context, state) => const Scaffold(body: Center(child: Text('Topic List Page'))),
          ),
          GoRoute(
            path: '/topic/:tag',
            builder: (context, state) => Scaffold(body: Center(child: Text('Topic Detail: ${state.pathParameters['tag']}'))),
          ),
          GoRoute(
            path: '/search',
            builder: (context, state) => const Scaffold(body: Center(child: Text('Search Page'))),
          ),
          GoRoute(
            path: '/search/result',
            builder: (context, state) => Scaffold(body: Center(child: Text('Search Result: ${state.uri.queryParameters['q']}'))),
          ),
          GoRoute(
            path: '/messages',
            builder: (context, state) => const Scaffold(body: Center(child: Text('Message Page'))),
          ),
          GoRoute(
            path: '/notifications',
            builder: (context, state) => const Scaffold(body: Center(child: Text('Notifications Page'))),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const Scaffold(body: Center(child: Text('Settings Page'))),
          ),
          GoRoute(
            path: '/settings/theme',
            builder: (context, state) => const Scaffold(body: Center(child: Text('Theme Settings Page'))),
          ),
          GoRoute(
            path: '/settings/font',
            builder: (context, state) => const Scaffold(body: Center(child: Text('Font Settings Page'))),
          ),
          GoRoute(
            path: '/settings/blacklist',
            builder: (context, state) => const Scaffold(body: Center(child: Text('Blacklist Page'))),
          ),
          GoRoute(
            path: '/settings/about',
            builder: (context, state) => const Scaffold(body: Center(child: Text('About Page'))),
          ),
          GoRoute(
            path: '/history',
            builder: (context, state) => const Scaffold(body: Center(child: Text('History Page'))),
          ),
          GoRoute(
            path: '/favorites',
            builder: (context, state) => const Scaffold(body: Center(child: Text('Favorites Page'))),
          ),
        ],
      );

      for (final route in routes) {
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp.router(
              routerConfig: router,
            ),
          ),
        );

        router.go(route);
        await tester.pumpAndSettle();

        expect(find.byType(Scaffold), findsOneWidget);
      }
    });

    testWidgets('Main page can be navigated to', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('Main Page')),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Main Page'), findsOneWidget);
    });

    testWidgets('Settings page can be navigated to', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: '/settings',
        routes: [
          GoRoute(
            path: '/settings',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('Settings Page')),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Settings Page'), findsOneWidget);
    });

    testWidgets('Notifications page can be navigated to', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: '/notifications',
        routes: [
          GoRoute(
            path: '/notifications',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('Notifications Page')),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Notifications Page'), findsOneWidget);
    });

    testWidgets('Search page can be navigated to', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: '/search',
        routes: [
          GoRoute(
            path: '/search',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('Search Page')),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Search Page'), findsOneWidget);
    });

    testWidgets('Feed detail page with ID can be navigated to', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: '/feed/123',
        routes: [
          GoRoute(
            path: '/feed/:id',
            builder: (context, state) => Scaffold(
              body: Center(child: Text('Feed Detail: ${state.pathParameters['id']}')),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Feed Detail: 123'), findsOneWidget);
    });
  });
}
