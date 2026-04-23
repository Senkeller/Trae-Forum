import 'package:flutter_test/flutter_test.dart';
import 'package:traeu/data/models/comment.dart';

/// 评论模型单元测试
///
/// 测试目标：验证评论相关模型的 JSON 序列化和反序列化功能，
/// 包括 TotalReplyResponse、ReplyData、CreateReplyRequest、
/// CreateReplyResponse、SubReplyResponse
void main() {
  group('TotalReplyResponse 模型测试', () {
    /// 测试目的：验证评论列表响应解析
    test('应正确解析评论列表响应', () {
      final json = {
        'status': 200,
        'message': 'success',
        'data': [
          {
            'id': 'reply_001',
            'uid': 'user_001',
            'username': '评论用户1',
            'message': '第一条评论',
          },
          {
            'id': 'reply_002',
            'uid': 'user_002',
            'username': '评论用户2',
            'message': '第二条评论',
          },
        ],
        'total': 50,
        'page': 1,
        'lastupdate': '1713945600',
      };

      final response = TotalReplyResponse.fromJson(json);

      expect(response.status, equals(200));
      expect(response.message, equals('success'));
      expect(response.data.length, equals(2));
      expect(response.data[0].id, equals('reply_001'));
      expect(response.data[1].username, equals('评论用户2'));
      expect(response.total, equals(50));
      expect(response.page, equals(1));
      expect(response.lastUpdate, equals('1713945600'));
    });

    /// 测试目的：验证空评论列表
    test('应正确处理空评论列表', () {
      final json = {
        'status': 200,
        'data': [],
      };

      final response = TotalReplyResponse.fromJson(json);

      expect(response.data, isEmpty);
      expect(response.total, equals(0));
      expect(response.page, equals(1));
    });
  });

  group('ReplyData 模型测试', () {
    /// 测试目的：验证完整评论数据解析
    test('应正确解析完整评论数据', () {
      final json = {
        'id': 'reply_001',
        'uid': 'user_001',
        'username': '评论用户',
        'avatar': 'https://example.com/avatar.jpg',
        'message': '这是一条评论',
        'picArr': ['https://example.com/comment_img.jpg'],
        'dateline': '1713945600',
        'like_num': 25,
        'is_like': true,
        'replynum': 5,
        'replyRows': [],
        'replyRowsMore': false,
      };

      final reply = ReplyData.fromJson(json);

      expect(reply.id, equals('reply_001'));
      expect(reply.uid, equals('user_001'));
      expect(reply.username, equals('评论用户'));
      expect(reply.avatar, equals('https://example.com/avatar.jpg'));
      expect(reply.message, equals('这是一条评论'));
      expect(reply.picArr.length, equals(1));
      expect(reply.dateline, equals('1713945600'));
      expect(reply.likeNum, equals(25));
      expect(reply.isLike, isTrue);
      expect(reply.replyNum, equals(5));
    });

    /// 测试目的：验证最小化评论数据
    test('应正确处理最小化评论数据', () {
      final json = {
        'id': 'reply_001',
        'uid': 'user_001',
      };

      final reply = ReplyData.fromJson(json);

      expect(reply.id, equals('reply_001'));
      expect(reply.uid, equals('user_001'));
      expect(reply.username, equals(''));
      expect(reply.avatar, isNull);
      expect(reply.message, equals(''));
      expect(reply.picArr, isEmpty);
      expect(reply.dateline, equals(''));
      expect(reply.likeNum, equals(0));
      expect(reply.isLike, isFalse);
      expect(reply.replyNum, equals(0));
    });

    /// 测试目的：验证二级回复（楼中楼）数据
    test('应正确解析包含子回复的评论', () {
      final json = {
        'id': 'reply_001',
        'uid': 'user_001',
        'username': '父评论用户',
        'message': '父评论',
        'replyRows': [
          {
            'id': 'reply_002',
            'uid': 'user_002',
            'username': '子评论用户',
            'message': '子评论',
            'reply_to': '父评论用户',
            'reply_uid': 'user_001',
          },
        ],
        'replyRowsMore': true,
      };

      final reply = ReplyData.fromJson(json);

      expect(reply.replyRows.length, equals(1));
      expect(reply.replyRows[0].message, equals('子评论'));
      expect(reply.replyRows[0].replyTo, equals('父评论用户'));
      expect(reply.replyRows[0].replyUid, equals('user_001'));
      expect(reply.replyRowsMore, isTrue);
    });

    /// 测试目的：验证回复目标信息
    test('应正确解析回复目标信息', () {
      final json = {
        'id': 'reply_002',
        'uid': 'user_002',
        'username': '回复者',
        'message': '回复内容',
        'reply_to': '被回复者',
        'reply_uid': 'user_001',
      };

      final reply = ReplyData.fromJson(json);

      expect(reply.replyTo, equals('被回复者'));
      expect(reply.replyUid, equals('user_001'));
    });
  });

  group('CreateReplyRequest 模型测试', () {
    /// 测试目的：验证发布评论请求构建
    test('应正确构建发布评论请求', () {
      const request = CreateReplyRequest(
        id: 'feed_001',
        message: '评论内容',
        picArr: ['img1.jpg'],
      );

      final json = request.toJson();

      expect(json['id'], equals('feed_001'));
      expect(json['message'], equals('评论内容'));
      expect(json['picArr'], equals(['img1.jpg']));
      expect(json['reply_id'], isNull);
      expect(json['reply_uid'], isNull);
    });

    /// 测试目的：验证二级回复请求构建
    test('应正确构建二级回复请求', () {
      const request = CreateReplyRequest(
        id: 'feed_001',
        message: '回复评论',
        replyId: 'reply_001',
        replyUid: 'user_001',
      );

      final json = request.toJson();

      expect(json['id'], equals('feed_001'));
      expect(json['message'], equals('回复评论'));
      expect(json['reply_id'], equals('reply_001'));
      expect(json['reply_uid'], equals('user_001'));
      expect(json['picArr'], isEmpty);
    });
  });

  group('CreateReplyResponse 模型测试', () {
    /// 测试目的：验证发布评论成功响应
    test('应正确解析发布成功响应', () {
      final json = {
        'status': 200,
        'message': '评论成功',
        'data': {
          'id': 'reply_new',
          'uid': 'user_001',
          'username': '评论者',
          'message': '新评论',
        },
      };

      final response = CreateReplyResponse.fromJson(json);

      expect(response.status, equals(200));
      expect(response.message, equals('评论成功'));
      expect(response.data, isNotNull);
      expect(response.data!.id, equals('reply_new'));
      expect(response.data!.message, equals('新评论'));
    });

    /// 测试目的：验证发布失败响应
    test('应正确解析发布失败响应', () {
      final json = {
        'status': 400,
        'message': '评论内容不能为空',
        'data': null,
      };

      final response = CreateReplyResponse.fromJson(json);

      expect(response.status, equals(400));
      expect(response.message, equals('评论内容不能为空'));
      expect(response.data, isNull);
    });
  });

  group('SubReplyResponse 模型测试', () {
    /// 测试目的：验证子回复列表响应解析
    test('应正确解析子回复列表响应', () {
      final json = {
        'status': 200,
        'message': 'success',
        'data': [
          {
            'id': 'sub_reply_001',
            'uid': 'user_002',
            'username': '用户2',
            'message': '子回复1',
          },
          {
            'id': 'sub_reply_002',
            'uid': 'user_003',
            'username': '用户3',
            'message': '子回复2',
          },
        ],
        'total': 10,
      };

      final response = SubReplyResponse.fromJson(json);

      expect(response.status, equals(200));
      expect(response.data.length, equals(2));
      expect(response.total, equals(10));
    });

    /// 测试目的：验证默认值
    test('应使用正确的默认值', () {
      final json = {
        'status': 200,
      };

      final response = SubReplyResponse.fromJson(json);

      expect(response.data, isEmpty);
      expect(response.total, equals(0));
      expect(response.message, equals(''));
    });
  });
}
