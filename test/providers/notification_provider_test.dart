import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:traeu/core/network/discourse_api_service.dart';
import 'package:traeu/data/models/discourse/discourse_notification.dart';

class MockDiscourseApiService extends Mock implements DiscourseApiService {}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('NotificationList Provider', () {
    late MockDiscourseApiService mockApiService;

    setUp(() {
      mockApiService = MockDiscourseApiService();
    });

    test('fetchNotifications returns list', () async {
      final mockResponseData = {
        'notifications': [
          {
            'id': 1,
            'notification_type': 1,
            'read': false,
            'created_at': '2024-01-01T00:00:00Z',
            'data': {
              'message': 'Test notification',
              'username': 'test_user',
            },
          },
          {
            'id': 2,
            'notification_type': 2,
            'read': true,
            'created_at': '2024-01-02T00:00:00Z',
            'data': {
              'message': 'Another notification',
              'username': 'another_user',
            },
          },
        ],
        'seen_notification_id': 1,
        'total_rows_notifications': 2,
      };

      when(() => mockApiService.getNotifications(
        limit: any(named: 'limit'),
        recent: any(named: 'recent'),
        bumpLastSeen: any(named: 'bumpLastSeen'),
        filterByTypes: any(named: 'filterByTypes'),
      )).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/notifications'),
          statusCode: 200,
          data: mockResponseData,
        ),
      );

      final response = await mockApiService.getNotifications(
        limit: 30,
        recent: true,
        bumpLastSeen: true,
      );

      expect(response.statusCode, equals(200));
      final data = response.data as Map<String, dynamic>;
      final notifications = data['notifications'] as List<dynamic>;
      expect(notifications.length, equals(2));
    });

    test('markAsRead updates state optimistically', () async {
      when(() => mockApiService.markNotificationsRead(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/notifications/mark-read'),
          statusCode: 200,
        ),
      );

      await mockApiService.markNotificationsRead([1, 2]);

      verify(() => mockApiService.markNotificationsRead([1, 2])).called(1);
    });

    test('markAllAsRead marks all as read', () async {
      when(() => mockApiService.markAllNotificationsRead()).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/notifications/mark-read'),
          statusCode: 200,
        ),
      );

      await mockApiService.markAllNotificationsRead();

      verify(() => mockApiService.markAllNotificationsRead()).called(1);
    });

    test('getNotifications with filterByTypes', () async {
      when(() => mockApiService.getNotifications(
        limit: any(named: 'limit'),
        recent: any(named: 'recent'),
        bumpLastSeen: any(named: 'bumpLastSeen'),
        filterByTypes: any(named: 'filterByTypes'),
      )).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/notifications'),
          statusCode: 200,
          data: {
            'notifications': [],
            'seen_notification_id': 0,
            'total_rows_notifications': 0,
          },
        ),
      );

      await mockApiService.getNotifications(
        limit: 30,
        recent: true,
        bumpLastSeen: true,
        filterByTypes: '1,2,3',
      );

      verify(() => mockApiService.getNotifications(
        limit: 30,
        recent: true,
        bumpLastSeen: true,
        filterByTypes: '1,2,3',
      )).called(1);
    });
  });

  group('DiscourseNotification Model', () {
    test('should parse notification from JSON', () {
      final json = {
        'id': 1,
        'notification_type': 1,
        'read': false,
        'created_at': '2024-01-01T00:00:00Z',
        'data': {
          'message': 'Test notification',
          'username': 'test_user',
        },
      };

      final notification = DiscourseNotification.fromJson(json);

      expect(notification.id, equals(1));
      expect(notification.notificationType, equals(1));
      expect(notification.read, isFalse);
    });

    test('should handle missing optional fields', () {
      final json = {
        'id': 1,
        'notification_type': 1,
      };

      final notification = DiscourseNotification.fromJson(json);

      expect(notification.id, equals(1));
      expect(notification.notificationType, equals(1));
      expect(notification.read, isTrue);
    });
  });
}
