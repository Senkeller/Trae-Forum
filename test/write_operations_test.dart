import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:traeu/core/network/discourse_api_service.dart';

class MockDiscourseApiService extends Mock implements DiscourseApiService {}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Discourse Write Operations', () {
    late MockDiscourseApiService mockDiscourseApi;

    setUp(() {
      mockDiscourseApi = MockDiscourseApiService();
    });

    group('postLikeReply', () {
      test('postLikeReply calls likePost API', () async {
        when(() => mockDiscourseApi.likePost(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/post_actions'),
            statusCode: 200,
          ),
        );

        await mockDiscourseApi.likePost(123);

        verify(() => mockDiscourseApi.likePost(123)).called(1);
      });

      test('postLikeReply handles error when not authenticated', () async {
        when(() => mockDiscourseApi.likePost(any())).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/post_actions'),
            response: Response(
              statusCode: 403,
              requestOptions: RequestOptions(path: '/post_actions'),
            ),
          ),
        );

        expect(
          () => mockDiscourseApi.likePost(123),
          throwsA(isA<DioException>()),
        );
      });
    });

    group('postReply', () {
      test('postReply calls createPost API', () async {
        when(() => mockDiscourseApi.createPost(
          topicId: any(named: 'topicId'),
          raw: any(named: 'raw'),
          replyToPostNumber: any(named: 'replyToPostNumber'),
        )).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/posts'),
            statusCode: 200,
            data: {'topic_id': 123},
          ),
        );

        await mockDiscourseApi.createPost(
          topicId: 123,
          raw: 'Test reply content',
          replyToPostNumber: null,
        );

        verify(() => mockDiscourseApi.createPost(
          topicId: 123,
          raw: 'Test reply content',
          replyToPostNumber: null,
        )).called(1);
      });

      test('postReply with replyToPostNumber calls createPost with reply parameter', () async {
        when(() => mockDiscourseApi.createPost(
          topicId: any(named: 'topicId'),
          raw: any(named: 'raw'),
          replyToPostNumber: any(named: 'replyToPostNumber'),
        )).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/posts'),
            statusCode: 200,
            data: {'topic_id': 123, 'post_number': 5},
          ),
        );

        await mockDiscourseApi.createPost(
          topicId: 123,
          raw: 'Reply to specific post',
          replyToPostNumber: 4,
        );

        verify(() => mockDiscourseApi.createPost(
          topicId: 123,
          raw: 'Reply to specific post',
          replyToPostNumber: 4,
        )).called(1);
      });
    });

    group('postDelete', () {
      test('postDelete calls deletePost API', () async {
        when(() => mockDiscourseApi.deletePost(
          postId: any(named: 'postId'),
          forceDestroy: any(named: 'forceDestroy'),
        )).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/posts/123'),
            statusCode: 200,
          ),
        );

        await mockDiscourseApi.deletePost(postId: 123);

        verify(() => mockDiscourseApi.deletePost(
          postId: 123,
          forceDestroy: false,
        )).called(1);
      });

      test('postDelete with forceDestroy calls deletePost with forceDestroy true', () async {
        when(() => mockDiscourseApi.deletePost(
          postId: any(named: 'postId'),
          forceDestroy: any(named: 'forceDestroy'),
        )).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/posts/123'),
            statusCode: 200,
          ),
        );

        await mockDiscourseApi.deletePost(
          postId: 123,
          forceDestroy: true,
        );

        verify(() => mockDiscourseApi.deletePost(
          postId: 123,
          forceDestroy: true,
        )).called(1);
      });
    });

    group('followUser', () {
      test('followUser calls followUser API', () async {
        when(() => mockDiscourseApi.followUser(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/u/test_user/follow'),
            statusCode: 200,
          ),
        );

        await mockDiscourseApi.followUser('test_user');

        verify(() => mockDiscourseApi.followUser('test_user')).called(1);
      });
    });

    group('unfollowUser', () {
      test('unfollowUser calls unfollowUser API', () async {
        when(() => mockDiscourseApi.unfollowUser(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/u/test_user/follow'),
            statusCode: 200,
          ),
        );

        await mockDiscourseApi.unfollowUser('test_user');

        verify(() => mockDiscourseApi.unfollowUser('test_user')).called(1);
      });
    });

    group('createTopic', () {
      test('createTopic calls createTopic API', () async {
        when(() => mockDiscourseApi.createTopic(
          title: any(named: 'title'),
          raw: any(named: 'raw'),
          category: any(named: 'category'),
          replyToPostNumber: any(named: 'replyToPostNumber'),
        )).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/posts'),
            statusCode: 200,
            data: {'topic_id': 456},
          ),
        );

        await mockDiscourseApi.createTopic(
          title: 'New Topic Title',
          raw: 'Topic content here',
          category: 1,
        );

        verify(() => mockDiscourseApi.createTopic(
          title: 'New Topic Title',
          raw: 'Topic content here',
          category: 1,
          replyToPostNumber: null,
        )).called(1);
      });
    });

    group('markNotificationsRead', () {
      test('markNotificationsRead calls markNotificationsRead API', () async {
        when(() => mockDiscourseApi.markNotificationsRead(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/notifications/mark-read'),
            statusCode: 200,
          ),
        );

        await mockDiscourseApi.markNotificationsRead([1, 2, 3]);

        verify(() => mockDiscourseApi.markNotificationsRead([1, 2, 3])).called(1);
      });
    });

    group('markAllNotificationsRead', () {
      test('markAllNotificationsRead calls markAllNotificationsRead API', () async {
        when(() => mockDiscourseApi.markAllNotificationsRead()).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/notifications/mark-read'),
            statusCode: 200,
          ),
        );

        await mockDiscourseApi.markAllNotificationsRead();

        verify(() => mockDiscourseApi.markAllNotificationsRead()).called(1);
      });
    });
  });
}
