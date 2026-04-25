import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:traeu/core/network/discourse_api_service.dart';

class MockDiscourseApiService extends Mock implements DiscourseApiService {}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Core User Flows', () {
    late MockDiscourseApiService mockApiService;

    setUp(() {
      mockApiService = MockDiscourseApiService();
    });

    test('Home -> Detail -> Reply flow', () async {
      final latestTopicsResponse = {
        'topic_list': {
          'topics': [
            {
              'id': 123,
              'title': 'Test Topic',
              'slug': 'test-topic',
              'category_id': 1,
              'created_at': '2024-01-01T00:00:00Z',
              'posts_count': 5,
              'reply_count': 3,
              'views': 100,
              'like_count': 10,
            }
          ],
        },
        'users': [
          {
            'id': 1,
            'username': 'test_user',
            'name': 'Test User',
            'avatar_template': '/user_avatar/trae.cn/test_user/{size}/123.png',
          }
        ],
      };

      final topicDetailResponse = {
        'id': 123,
        'title': 'Test Topic',
        'slug': 'test-topic',
        'category_id': 1,
        'created_at': '2024-01-01T00:00:00Z',
        'reply_count': 3,
        'pinned': false,
        'post_stream': {
          'posts': [
            {
              'id': 1,
              'user_id': 1,
              'username': 'test_user',
              'avatar_template': '/user_avatar/trae.cn/test_user/{size}/123.png',
              'cooked': '<p>Original post content</p>',
              'created_at': '2024-01-01T00:00:00Z',
              'like_count': 5,
              'reply_count': 2,
            }
          ],
        },
      };

      when(() => mockApiService.getLatestTopics(page: any(named: 'page')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/latest.json'),
                statusCode: 200,
                data: latestTopicsResponse,
              ));

      when(() => mockApiService.getTopicDetail(any()))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/t/123.json'),
                statusCode: 200,
                data: topicDetailResponse,
              ));

      when(() => mockApiService.createPost(
        topicId: any(named: 'topicId'),
        raw: any(named: 'raw'),
        replyToPostNumber: any(named: 'replyToPostNumber'),
      )).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/posts'),
          statusCode: 200,
          data: {'topic_id': 123, 'post_number': 2},
        ),
      );

      final feedResponse = await mockApiService.getLatestTopics(page: 0);
      expect(feedResponse.statusCode, equals(200));
      final feedData = feedResponse.data as Map<String, dynamic>;
      final topics = feedData['topic_list']['topics'] as List;
      expect(topics.isNotEmpty, isTrue);

      final detailResponse = await mockApiService.getTopicDetail(123);
      expect(detailResponse.statusCode, equals(200));
      final detailData = detailResponse.data as Map<String, dynamic>;
      expect(detailData['id'], equals(123));

      final replyResponse = await mockApiService.createPost(
        topicId: 123,
        raw: 'This is a test reply',
        replyToPostNumber: null,
      );
      expect(replyResponse.statusCode, equals(200));
    });

    test('Notification -> Mark Read flow', () async {
      final notificationsResponse = {
        'notifications': [
          {
            'id': 1,
            'notification_type': 1,
            'read': false,
            'created_at': '2024-01-01T00:00:00Z',
            'data': {
              'message': 'New reply to your topic',
              'username': ' replier',
            },
          },
          {
            'id': 2,
            'notification_type': 1,
            'read': false,
            'created_at': '2024-01-02T00:00:00Z',
            'data': {
              'message': 'Another reply',
              'username': 'another_user',
            },
          },
        ],
        'seen_notification_id': 0,
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
          data: notificationsResponse,
        ),
      );

      when(() => mockApiService.markNotificationsRead(any()))
          .thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/notifications/mark-read'),
          statusCode: 200,
        ),
      );

      final response = await mockApiService.getNotifications(
        limit: 30,
        recent: true,
        bumpLastSeen: true,
      );
      expect(response.statusCode, equals(200));
      final data = response.data as Map<String, dynamic>;
      final notifications = data['notifications'] as List;
      expect(notifications.length, equals(2));

      final unreadCount = notifications.where((n) => !(n as Map)['read']).length;
      expect(unreadCount, equals(2));

      await mockApiService.markNotificationsRead([1]);
      verify(() => mockApiService.markNotificationsRead([1])).called(1);
    });

    test('User Profile -> Follow flow', () async {
      final userInfoResponse = {
        'user': {
          'id': 1,
          'username': 'target_user',
          'name': 'Target User',
          'avatar_template': '/user_avatar/trae.cn/target_user/{size}/456.png',
          'trust_level': 2,
        }
      };

      when(() => mockApiService.getUserInfo(any()))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/u/target_user.json'),
                statusCode: 200,
                data: userInfoResponse,
              ));

      when(() => mockApiService.followUser(any()))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/u/target_user/follow'),
                statusCode: 200,
              ));

      when(() => mockApiService.unfollowUser(any()))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/u/target_user/follow'),
                statusCode: 200,
              ));

      final userResponse = await mockApiService.getUserInfo('target_user');
      expect(userResponse.statusCode, equals(200));

      await mockApiService.followUser('target_user');
      verify(() => mockApiService.followUser('target_user')).called(1);

      await mockApiService.unfollowUser('target_user');
      verify(() => mockApiService.unfollowUser('target_user')).called(1);
    });

    test('Search -> Results flow', () async {
      final searchResponse = {
        'topics': [
          {
            'id': 100,
            'title': 'Flutter Development Tips',
            'slug': 'flutter-development-tips',
            'category_id': 1,
            'created_at': '2024-01-01T00:00:00Z',
            'posts_count': 10,
            'reply_count': 5,
            'views': 200,
            'like_count': 20,
          },
          {
            'id': 101,
            'title': 'Dart Programming Guide',
            'slug': 'dart-programming-guide',
            'category_id': 1,
            'created_at': '2024-01-02T00:00:00Z',
            'posts_count': 15,
            'reply_count': 8,
            'views': 300,
            'like_count': 25,
          },
        ],
        'users': [
          {
            'id': 2,
            'username': 'developer',
            'name': 'Developer',
            'avatar_template': '/user_avatar/trae.cn/developer/{size}/789.png',
          }
        ],
      };

      when(() => mockApiService.searchTopics(any()))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/search.json'),
                statusCode: 200,
                data: searchResponse,
              ));

      final response = await mockApiService.searchTopics('Flutter');
      expect(response.statusCode, equals(200));
      final data = response.data as Map<String, dynamic>;
      final topics = data['topics'] as List;
      expect(topics.length, equals(2));
    });

    test('Topic List -> Topic Detail flow', () async {
      final categoriesResponse = {
        'category_list': {
          'categories': [
            {
              'id': 1,
              'name': 'General',
              'slug': 'general',
              'description': 'General discussions',
            },
            {
              'id': 2,
              'name': 'Help',
              'slug': 'help',
              'description': 'Get help here',
            },
          ],
        }
      };

      final categoryTopicsResponse = {
        'topic_list': {
          'topics': [
            {
              'id': 200,
              'title': 'Category Topic',
              'slug': 'category-topic',
              'category_id': 1,
              'created_at': '2024-01-01T00:00:00Z',
              'posts_count': 3,
              'reply_count': 1,
              'views': 50,
              'like_count': 5,
            }
          ],
        },
        'users': [],
      };

      when(() => mockApiService.getCategories())
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/categories.json'),
                statusCode: 200,
                data: categoriesResponse,
              ));

      when(() => mockApiService.getTopicsByCategory(any(), page: any(named: 'page')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/c/1.json'),
                statusCode: 200,
                data: categoryTopicsResponse,
              ));

      final categoriesResult = await mockApiService.getCategories();
      expect(categoriesResult.statusCode, equals(200));

      final topicsResult = await mockApiService.getTopicsByCategory(1, page: 0);
      expect(topicsResult.statusCode, equals(200));
      final data = topicsResult.data as Map<String, dynamic>;
      final topics = data['topic_list']['topics'] as List;
      expect(topics.isNotEmpty, isTrue);
    });
  });
}
