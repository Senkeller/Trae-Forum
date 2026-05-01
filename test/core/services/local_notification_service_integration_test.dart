import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traeu/core/services/local_notification_service.dart';

class _MockFlutterLocalNotificationsPlugin extends Mock
    implements FlutterLocalNotificationsPlugin {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    registerFallbackValue(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
  });

  group('LocalNotificationService integration', () {
    late _MockFlutterLocalNotificationsPlugin plugin;

    setUp(() {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      plugin = _MockFlutterLocalNotificationsPlugin();
      when(
        () => plugin.initialize(
          any(),
          onDidReceiveNotificationResponse: any(
            named: 'onDidReceiveNotificationResponse',
          ),
          onDidReceiveBackgroundNotificationResponse: any(
            named: 'onDidReceiveBackgroundNotificationResponse',
          ),
        ),
      ).thenAnswer((_) async => true);
    });

    test(
      'background cached path is consumed and routed on next initialize',
      () async {
        when(
          () => plugin.getNotificationAppLaunchDetails(),
        ).thenAnswer((_) async => const NotificationAppLaunchDetails(false));

        final service = LocalNotificationService.createForTest(plugin: plugin);
        String? navigatedPath;
        service.debugNavigationHandler = (path) {
          navigatedPath = path;
        };

        await service.handleBackgroundNotificationTap(
          const NotificationResponse(
            notificationResponseType:
                NotificationResponseType.selectedNotification,
            payload: '{"topicId":42,"postNumber":3}',
          ),
        );

        await service.initialize();
        expect(navigatedPath, '/feed/42?postNumber=3');

        // pending path should be consumed only once
        final secondService = LocalNotificationService.createForTest(
          plugin: plugin,
        );
        String? secondNavigation;
        secondService.debugNavigationHandler = (path) {
          secondNavigation = path;
        };
        await secondService.initialize();
        expect(secondNavigation, isNull);
      },
    );

    test('cold start launch response routes via resolver', () async {
      when(() => plugin.getNotificationAppLaunchDetails()).thenAnswer(
        (_) async => const NotificationAppLaunchDetails(
          true,
          notificationResponse: NotificationResponse(
            notificationResponseType:
                NotificationResponseType.selectedNotification,
            payload: '{"topic_id":"88"}',
          ),
        ),
      );

      final service = LocalNotificationService.createForTest(plugin: plugin);
      String? navigatedPath;
      service.debugNavigationHandler = (path) {
        navigatedPath = path;
      };

      await service.initialize();
      expect(navigatedPath, '/feed/88');
    });

    test('pending path has priority over cold start response', () async {
      when(() => plugin.getNotificationAppLaunchDetails()).thenAnswer(
        (_) async => const NotificationAppLaunchDetails(
          true,
          notificationResponse: NotificationResponse(
            notificationResponseType:
                NotificationResponseType.selectedNotification,
            payload: '{"topicId":999}',
          ),
        ),
      );

      final service = LocalNotificationService.createForTest(plugin: plugin);
      String? navigatedPath;
      service.debugNavigationHandler = (path) {
        navigatedPath = path;
      };

      await service.handleBackgroundNotificationTap(
        const NotificationResponse(
          notificationResponseType:
              NotificationResponseType.selectedNotification,
          payload: '{"topicId":123}',
        ),
      );
      await service.initialize();

      expect(navigatedPath, '/feed/123');
    });

    test('dedupes rapid repeated taps for the same payload', () async {
      when(
        () => plugin.getNotificationAppLaunchDetails(),
      ).thenAnswer((_) async => const NotificationAppLaunchDetails(false));

      final service = LocalNotificationService.createForTest(plugin: plugin);
      final navigatedPaths = <String>[];
      service.debugNavigationHandler = (path) {
        navigatedPaths.add(path);
      };

      var now = DateTime(2026, 1, 1, 0, 0, 0, 0, 0);
      service.debugNow = () => now;

      await service.initialize();
      const response = NotificationResponse(
        notificationResponseType: NotificationResponseType.selectedNotification,
        payload: '{"topicId":321,"postNumber":2}',
      );

      service.handleForegroundNotificationTap(response);
      service.handleForegroundNotificationTap(response);

      expect(navigatedPaths, ['/feed/321?postNumber=2']);

      now = now.add(const Duration(milliseconds: 1500));
      service.handleForegroundNotificationTap(response);
      expect(navigatedPaths, [
        '/feed/321?postNumber=2',
        '/feed/321?postNumber=2',
      ]);
    });
  });
}
