import 'package:flutter_test/flutter_test.dart';
import 'package:traeu/data/models/feed.dart';
import 'package:traeu/data/models/user.dart';

/// Feed 模型单元测试
///
/// 测试目标：验证 Feed 相关模型的 JSON 序列化和反序列化功能，
/// 包括 HomeFeedResponse、HomeFeedData、FeedContentResponse、
/// FeedContentData、CreateFeedRequest、CreateFeedResponse
void main() {
  group('HomeFeedResponse 模型测试', () {
    /// 测试目的：验证首页 Feed 响应解析
    test('应正确解析首页 Feed 响应', () {
      final json = {
        'status': 200,
        'message': 'success',
        'data': [
          {
            'id': 'feed_001',
            'entityType': 'feed',
            'message': '测试动态内容',
            'userInfo': {
              'uid': 'user_001',
              'username': 'test_user',
            },
          },
        ],
        'total': 100,
        'page': 1,
        'lastupdate': '1713945600',
      };

      final response = HomeFeedResponse.fromJson(json);

      expect(response.status, equals(200));
      expect(response.message, equals('success'));
      expect(response.data.length, equals(1));
      expect(response.data[0].id, equals('feed_001'));
      expect(response.total, equals(100));
      expect(response.page, equals(1));
      expect(response.lastUpdate, equals('1713945600'));
    });

    /// 测试目的：验证空列表处理
    test('应正确处理空数据列表', () {
      final json = {
        'status': 200,
        'data': [],
      };

      final response = HomeFeedResponse.fromJson(json);

      expect(response.data, isEmpty);
      expect(response.total, equals(0));
      expect(response.page, equals(1));
    });
  });

  group('HomeFeedData 模型测试', () {
    /// 测试目的：验证完整动态数据解析
    test('应正确解析完整动态数据', () {
      final json = {
        'id': 'feed_001',
        'entityType': 'feed',
        'title': '动态标题',
        'message': '动态内容',
        'picArr': ['https://example.com/img1.jpg', 'https://example.com/img2.jpg'],
        'userInfo': {
          'uid': 'user_001',
          'username': 'test_user',
          'avatar': 'https://example.com/avatar.jpg',
        },
        'user_action': {
          'is_like': true,
          'like_num': 50,
        },
        'dateline': '1713945600',
        'replynum': 20,
        'forwardnum': 5,
        'forwardid': 'feed_000',
        'forwardSource': '转发来源',
        'device_title': 'iPhone 15 Pro',
        'replyRows': [],
        'replyRowsMore': false,
      };

      final feed = HomeFeedData.fromJson(json);

      expect(feed.id, equals('feed_001'));
      expect(feed.entityType, equals('feed'));
      expect(feed.title, equals('动态标题'));
      expect(feed.message, equals('动态内容'));
      expect(feed.picArr.length, equals(2));
      expect(feed.picArr[0], equals('https://example.com/img1.jpg'));
      expect(feed.userInfo, isNotNull);
      expect(feed.userInfo!.username, equals('test_user'));
      expect(feed.action.isLike, isTrue);
      expect(feed.action.likeNum, equals(50));
      expect(feed.dateline, equals('1713945600'));
      expect(feed.replyNum, equals(20));
      expect(feed.forwardNum, equals(5));
      expect(feed.forwardId, equals('feed_000'));
      expect(feed.forwardSource, equals('转发来源'));
      expect(feed.deviceTitle, equals('iPhone 15 Pro'));
    });

    /// 测试目的：验证最小化动态数据解析
    test('应正确处理最小化动态数据', () {
      final json = {
        'id': 'feed_001',
        'entityType': 'feed',
      };

      final feed = HomeFeedData.fromJson(json);

      expect(feed.id, equals('feed_001'));
      expect(feed.entityType, equals('feed'));
      expect(feed.title, isNull);
      expect(feed.message, equals(''));
      expect(feed.picArr, isEmpty);
      expect(feed.userInfo, isNull);
      expect(feed.dateline, equals(''));
      expect(feed.replyNum, equals(0));
      expect(feed.forwardNum, equals(0));
    });

    /// 测试目的：验证转发数据解析
    test('应正确解析转发数据', () {
      final json = {
        'id': 'feed_002',
        'entityType': 'feed',
        'forwardid': 'feed_001',
        'forwardSource': '原始动态内容',
      };

      final feed = HomeFeedData.fromJson(json);

      expect(feed.forwardId, equals('feed_001'));
      expect(feed.forwardSource, equals('原始动态内容'));
    });
  });

  group('FeedContentResponse 模型测试', () {
    /// 测试目的：验证动态详情响应解析
    test('应正确解析动态详情响应', () {
      final json = {
        'status': 200,
        'message': 'success',
        'data': {
          'id': 'feed_001',
          'entityType': 'feed',
          'message': '动态详情内容',
          'is_top': true,
        },
      };

      final response = FeedContentResponse.fromJson(json);

      expect(response.status, equals(200));
      expect(response.data, isNotNull);
      expect(response.data!.id, equals('feed_001'));
      expect(response.data!.isTop, isTrue);
    });

    /// 测试目的：验证空数据响应
    test('应正确处理空数据响应', () {
      final json = {
        'status': 404,
        'message': '动态不存在',
        'data': null,
      };

      final response = FeedContentResponse.fromJson(json);

      expect(response.status, equals(404));
      expect(response.data, isNull);
    });
  });

  group('FeedContentData 模型测试', () {
    /// 测试目的：验证动态详情数据解析
    test('应正确解析动态详情数据', () {
      final json = {
        'id': 'feed_001',
        'entityType': 'feed',
        'title': '详情标题',
        'message': '详情内容',
        'picArr': ['img1.jpg'],
        'dateline': '1713945600',
        'replynum': 100,
        'forwardnum': 20,
        'device_title': 'Android',
        'is_top': true,
      };

      final data = FeedContentData.fromJson(json);

      expect(data.id, equals('feed_001'));
      expect(data.title, equals('详情标题'));
      expect(data.isTop, isTrue);
    });

    /// 测试目的：验证默认值
    test('应使用正确的默认值', () {
      final json = {
        'id': 'feed_001',
        'entityType': 'feed',
      };

      final data = FeedContentData.fromJson(json);

      expect(data.message, equals(''));
      expect(data.picArr, isEmpty);
      expect(data.replyNum, equals(0));
      expect(data.forwardNum, equals(0));
      expect(data.isTop, isFalse);
    });
  });

  group('CreateFeedRequest 模型测试', () {
    /// 测试目的：验证发布动态请求构建
    test('应正确构建发布动态请求', () {
      const request = CreateFeedRequest(
        message: '新动态内容',
        picArr: ['img1.jpg', 'img2.jpg'],
        type: 'feed',
        deviceTitle: 'iPhone',
      );

      final json = request.toJson();

      expect(json['message'], equals('新动态内容'));
      expect(json['picArr'], equals(['img1.jpg', 'img2.jpg']));
      expect(json['type'], equals('feed'));
      expect(json['device_title'], equals('iPhone'));
    });

    /// 测试目的：验证默认值
    test('应使用正确的默认值', () {
      const request = CreateFeedRequest(
        message: '纯文字动态',
      );

      final json = request.toJson();

      expect(json['message'], equals('纯文字动态'));
      expect(json['picArr'], isEmpty);
      expect(json['type'], equals('feed'));
      expect(json['device_title'], isNull);
    });
  });

  group('CreateFeedResponse 模型测试', () {
    /// 测试目的：验证发布成功响应
    test('应正确解析发布成功响应', () {
      final json = {
        'status': 200,
        'message': '发布成功',
        'data': {
          'id': 'feed_new',
          'entityType': 'feed',
          'message': '新发布的动态',
        },
      };

      final response = CreateFeedResponse.fromJson(json);

      expect(response.status, equals(200));
      expect(response.message, equals('发布成功'));
      expect(response.data, isNotNull);
      expect(response.data!.id, equals('feed_new'));
    });

    /// 测试目的：验证发布失败响应
    test('应正确解析发布失败响应', () {
      final json = {
        'status': 400,
        'message': '内容不能为空',
        'data': null,
      };

      final response = CreateFeedResponse.fromJson(json);

      expect(response.status, equals(400));
      expect(response.message, equals('内容不能为空'));
      expect(response.data, isNull);
    });
  });
}
