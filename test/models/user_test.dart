import 'package:flutter_test/flutter_test.dart';
import 'package:traeu/data/models/user.dart';

/// 用户模型单元测试
///
/// 测试目标：验证 UserInfo、UserAction、UserProfile、LoginResponse 模型的
/// JSON 序列化和反序列化功能，以及默认值处理
void main() {
  group('UserInfo 模型测试', () {
    /// 测试目的：验证 UserInfo 从 JSON 正确解析
    /// 测试场景：完整的用户数据
    test('应从完整 JSON 正确解析 UserInfo', () {
      // 准备测试数据
      final json = {
        'uid': '12345',
        'username': 'test_user',
        'avatar': 'https://example.com/avatar.jpg',
        'level': 5,
        'bio': '这是一个测试用户',
        'fans': 100,
        'follow': 50,
        'verify_title': '认证开发者',
        'is_developer': true,
      };

      // 执行解析
      final userInfo = UserInfo.fromJson(json);

      // 验证结果
      expect(userInfo.uid, equals('12345'));
      expect(userInfo.username, equals('test_user'));
      expect(userInfo.avatar, equals('https://example.com/avatar.jpg'));
      expect(userInfo.level, equals(5));
      expect(userInfo.bio, equals('这是一个测试用户'));
      expect(userInfo.fans, equals(100));
      expect(userInfo.follow, equals(50));
      expect(userInfo.verifyTitle, equals('认证开发者'));
      expect(userInfo.isDeveloper, isTrue);
    });

    /// 测试目的：验证 UserInfo 默认值处理
    /// 测试场景：最小化 JSON 数据
    test('应使用默认值处理最小化 JSON', () {
      final json = {
        'uid': '12345',
        'username': 'test_user',
      };

      final userInfo = UserInfo.fromJson(json);

      expect(userInfo.uid, equals('12345'));
      expect(userInfo.username, equals('test_user'));
      expect(userInfo.avatar, isNull);
      expect(userInfo.level, equals(0));
      expect(userInfo.bio, equals(''));
      expect(userInfo.fans, equals(0));
      expect(userInfo.follow, equals(0));
      expect(userInfo.verifyTitle, isNull);
      expect(userInfo.isDeveloper, isFalse);
    });

    /// 测试目的：验证 UserInfo 序列化为 JSON
    /// 测试场景：完整对象转 JSON
    test('应正确序列化为 JSON', () {
      const userInfo = UserInfo(
        uid: '12345',
        username: 'test_user',
        level: 3,
      );

      final json = userInfo.toJson();

      expect(json['uid'], equals('12345'));
      expect(json['username'], equals('test_user'));
      expect(json['level'], equals(3));
    });
  });

  group('UserAction 模型测试', () {
    /// 测试目的：验证 UserAction 从 JSON 正确解析
    test('应从 JSON 正确解析 UserAction', () {
      final json = {
        'is_like': true,
        'is_favorite': false,
        'is_follow': true,
        'like_num': 42,
        'favorite_num': 10,
      };

      final action = UserAction.fromJson(json);

      expect(action.isLike, isTrue);
      expect(action.isFavorite, isFalse);
      expect(action.isFollow, isTrue);
      expect(action.likeNum, equals(42));
      expect(action.favoriteNum, equals(10));
    });

    /// 测试目的：验证 UserAction 默认值
    test('应使用正确的默认值', () {
      const action = UserAction();

      expect(action.isLike, isFalse);
      expect(action.isFavorite, isFalse);
      expect(action.isFollow, isFalse);
      expect(action.likeNum, equals(0));
      expect(action.favoriteNum, equals(0));
    });
  });

  group('UserProfile 模型测试', () {
    /// 测试目的：验证 UserProfile 从 JSON 正确解析
    test('应从 JSON 正确解析 UserProfile', () {
      final json = {
        'user_info': {
          'uid': '12345',
          'username': 'test_user',
        },
        'action': {
          'is_like': true,
          'like_num': 100,
        },
        'feed_count': 50,
        'reply_count': 200,
      };

      final profile = UserProfile.fromJson(json);

      expect(profile.userInfo.uid, equals('12345'));
      expect(profile.userInfo.username, equals('test_user'));
      expect(profile.action.isLike, isTrue);
      expect(profile.action.likeNum, equals(100));
      expect(profile.feedCount, equals(50));
      expect(profile.replyCount, equals(200));
    });

    /// 测试目的：验证嵌套模型的默认值
    test('嵌套模型应使用默认值', () {
      final json = {
        'user_info': {
          'uid': '12345',
          'username': 'test_user',
        },
      };

      final profile = UserProfile.fromJson(json);

      expect(profile.userInfo.uid, equals('12345'));
      expect(profile.action.isLike, isFalse);
      expect(profile.feedCount, equals(0));
      expect(profile.replyCount, equals(0));
    });
  });

  group('LoginResponse 模型测试', () {
    /// 测试目的：验证登录成功响应解析
    test('应正确解析登录成功响应', () {
      final json = {
        'status': 200,
        'message': '登录成功',
        'data': {
          'uid': '12345',
          'username': 'test_user',
        },
        'token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9',
      };

      final response = LoginResponse.fromJson(json);

      expect(response.status, equals(200));
      expect(response.message, equals('登录成功'));
      expect(response.data, isNotNull);
      expect(response.data!.uid, equals('12345'));
      expect(response.token, equals('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'));
    });

    /// 测试目的：验证登录失败响应解析
    test('应正确解析登录失败响应', () {
      final json = {
        'status': 401,
        'message': '用户名或密码错误',
        'data': null,
        'token': null,
      };

      final response = LoginResponse.fromJson(json);

      expect(response.status, equals(401));
      expect(response.message, equals('用户名或密码错误'));
      expect(response.data, isNull);
      expect(response.token, isNull);
    });

    /// 测试目的：验证 message 默认值
    test('message 应使用空字符串默认值', () {
      final json = {
        'status': 200,
      };

      final response = LoginResponse.fromJson(json);

      expect(response.message, equals(''));
    });
  });
}
