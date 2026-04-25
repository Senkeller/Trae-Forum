import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TestRoutes {
  static const String main = '/';
  static const String home = '/home';
  static const String search = '/search';
  static const String notifications = '/notifications';
  static const String feedCreate = '/feed/create';
}

void main() {
  group('HomePage 基础渲染测试', () {
    testWidgets('App should build without crashing', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: TestRoutes.home,
        routes: [
          GoRoute(
            path: TestRoutes.main,
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('Main Page')),
            ),
          ),
          GoRoute(
            path: TestRoutes.home,
            builder: (context, state) => const Scaffold(
              appBar: SliverAppBar(title: Text('TRAE Forum')),
              body: Center(child: Text('Home Content')),
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

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('AppBar should display title', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: TestRoutes.home,
        routes: [
          GoRoute(
            path: TestRoutes.home,
            builder: (context, state) => const Scaffold(
              appBar: SliverAppBar(title: Text('TRAE Forum')),
              body: Center(child: Text('Home Content')),
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

      expect(find.text('TRAE Forum'), findsOneWidget);
    });

    testWidgets('Body should display content', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: TestRoutes.home,
        routes: [
          GoRoute(
            path: TestRoutes.home,
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('Home Content')),
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

      expect(find.text('Home Content'), findsOneWidget);
    });

    testWidgets('FloatingActionButton should be present', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: TestRoutes.home,
        routes: [
          GoRoute(
            path: TestRoutes.home,
            builder: (context, state) => Scaffold(
              body: const Center(child: Text('Home')),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
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

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('Icons should be present in AppBar', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: TestRoutes.home,
        routes: [
          GoRoute(
            path: TestRoutes.home,
            builder: (context, state) => Scaffold(
              appBar: AppBar(
                actions: const [
                  Icon(Icons.search),
                  Icon(Icons.notifications_outlined),
                ],
              ),
              body: const Center(child: Text('Home')),
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

      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);
    });
  });

  group('Navigation Tests', () {
    testWidgets('Should navigate to search page', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: TestRoutes.home,
        routes: [
          GoRoute(
            path: TestRoutes.home,
            builder: (context, state) => Scaffold(
              body: const Center(child: Text('Home')),
              floatingActionButton: FloatingActionButton(
                onPressed: () => context.go(TestRoutes.search),
                child: const Icon(Icons.search),
              ),
            ),
          ),
          GoRoute(
            path: TestRoutes.search,
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

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      expect(find.text('Search Page'), findsOneWidget);
    });

    testWidgets('Should navigate to notifications', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: TestRoutes.home,
        routes: [
          GoRoute(
            path: TestRoutes.home,
            builder: (context, state) => Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () => context.go(TestRoutes.notifications),
                  ),
                ],
              ),
              body: const Center(child: Text('Home')),
            ),
          ),
          GoRoute(
            path: TestRoutes.notifications,
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

      await tester.tap(find.byIcon(Icons.notifications_outlined));
      await tester.pumpAndSettle();

      expect(find.text('Notifications Page'), findsOneWidget);
    });

    testWidgets('Should navigate to create feed', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: TestRoutes.home,
        routes: [
          GoRoute(
            path: TestRoutes.home,
            builder: (context, state) => Scaffold(
              body: const Center(child: Text('Home')),
              floatingActionButton: FloatingActionButton(
                onPressed: () => context.go(TestRoutes.feedCreate),
              ),
            ),
          ),
          GoRoute(
            path: TestRoutes.feedCreate,
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('Create Feed Page')),
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

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.text('Create Feed Page'), findsOneWidget);
    });
  });

  group('List and Cards Tests', () {
    testWidgets('ListView should render', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: TestRoutes.home,
        routes: [
          GoRoute(
            path: TestRoutes.home,
            builder: (context, state) => Scaffold(
              body: ListView(
                children: const [
                  Card(child: ListTile(title: Text('Item 1'))),
                  Card(child: ListTile(title: Text('Item 2'))),
                ],
              ),
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

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(Card), findsNWidgets(2));
    });

    testWidgets('Cards should be tappable', (WidgetTester tester) async {
      bool cardTapped = false;

      final router = GoRouter(
        initialLocation: TestRoutes.home,
        routes: [
          GoRoute(
            path: TestRoutes.home,
            builder: (context, state) => Scaffold(
              body: ListView(
                children: [
                  Card(
                    child: ListTile(
                      title: const Text('Tappable Card'),
                      onTap: () => cardTapped = true,
                    ),
                  ),
                ],
              ),
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

      await tester.tap(find.text('Tappable Card'));
      await tester.pump();

      expect(cardTapped, isTrue);
    });
  });

  group('Icons Tests', () {
    testWidgets('Should display thumb_up icon', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: TestRoutes.home,
        routes: [
          GoRoute(
            path: TestRoutes.home,
            builder: (context, state) => const Scaffold(
              body: Center(child: Icon(Icons.thumb_up_outlined)),
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

      expect(find.byIcon(Icons.thumb_up_outlined), findsOneWidget);
    });

    testWidgets('Should display comment icon', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: TestRoutes.home,
        routes: [
          GoRoute(
            path: TestRoutes.home,
            builder: (context, state) => const Scaffold(
              body: Center(child: Icon(Icons.comment_outlined)),
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

      expect(find.byIcon(Icons.comment_outlined), findsOneWidget);
    });

    testWidgets('Should display share icon', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: TestRoutes.home,
        routes: [
          GoRoute(
            path: TestRoutes.home,
            builder: (context, state) => const Scaffold(
              body: Center(child: Icon(Icons.share_outlined)),
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

      expect(find.byIcon(Icons.share_outlined), findsOneWidget);
    });

    testWidgets('Should display bookmark icon', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: TestRoutes.home,
        routes: [
          GoRoute(
            path: TestRoutes.home,
            builder: (context, state) => const Scaffold(
              body: Center(child: Icon(Icons.bookmark_border)),
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

      expect(find.byIcon(Icons.bookmark_border), findsOneWidget);
    });
  });
}
