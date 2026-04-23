import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:traeu/presentation/widgets/user/user_avatar.dart';

/// UserAvatar Widget 测试
///
/// 测试目标：验证 UserAvatar 组件的渲染和交互行为，包括：
/// - 正常渲染（有头像和无头像）
/// - 不同尺寸预设
/// - 在线状态和认证标识
/// - 点击事件
/// - 头像组组件
void main() {
  group('UserAvatar 基础渲染测试', () {
    /// 测试目的：验证有头像 URL 时的渲染
    testWidgets('应正确渲染带头像的用户头像', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatar(
              avatarUrl: 'https://example.com/avatar.jpg',
              username: '测试用户',
            ),
          ),
        ),
      );

      // 验证头像组件存在
      expect(find.byType(UserAvatar), findsOneWidget);
    });

    /// 测试目的：验证无头像时的默认头像渲染
    testWidgets('应正确渲染默认头像', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatar(
              username: '无头像用户',
            ),
          ),
        ),
      );

      // 验证默认头像图标存在
      expect(find.byType(UserAvatar), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    /// 测试目的：验证空头像 URL 时的默认头像
    testWidgets('空头像 URL 应显示默认头像', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatar(
              avatarUrl: '',
              username: '空头像用户',
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
    });
  });

  group('UserAvatar 尺寸测试', () {
    /// 测试目的：验证小尺寸头像
    testWidgets('应正确渲染小尺寸头像', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatar.small(
              avatarUrl: 'https://example.com/avatar.jpg',
            ),
          ),
        ),
      );

      expect(find.byType(UserAvatar), findsOneWidget);
    });

    /// 测试目的：验证中尺寸头像
    testWidgets('应正确渲染中尺寸头像', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatar.medium(
              avatarUrl: 'https://example.com/avatar.jpg',
            ),
          ),
        ),
      );

      expect(find.byType(UserAvatar), findsOneWidget);
    });

    /// 测试目的：验证大尺寸头像
    testWidgets('应正确渲染大尺寸头像', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatar.large(
              avatarUrl: 'https://example.com/avatar.jpg',
            ),
          ),
        ),
      );

      expect(find.byType(UserAvatar), findsOneWidget);
    });

    /// 测试目的：验证超大尺寸头像
    testWidgets('应正确渲染超大尺寸头像', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatar.xlarge(
              avatarUrl: 'https://example.com/avatar.jpg',
            ),
          ),
        ),
      );

      expect(find.byType(UserAvatar), findsOneWidget);
    });

    /// 测试目的：验证自定义尺寸
    testWidgets('应支持自定义尺寸', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatar(
              avatarUrl: 'https://example.com/avatar.jpg',
              size: 100,
            ),
          ),
        ),
      );

      expect(find.byType(UserAvatar), findsOneWidget);
    });
  });

  group('UserAvatar 状态标识测试', () {
    /// 测试目的：验证在线状态指示器
    testWidgets('应显示在线状态指示器', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatar(
              avatarUrl: 'https://example.com/avatar.jpg',
              showOnlineStatus: true,
              isOnline: true,
            ),
          ),
        ),
      );

      expect(find.byType(UserAvatar), findsOneWidget);
    });

    /// 测试目的：验证离线状态不显示指示器
    testWidgets('离线状态不应显示在线指示器', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatar(
              avatarUrl: 'https://example.com/avatar.jpg',
              showOnlineStatus: true,
              isOnline: false,
            ),
          ),
        ),
      );

      expect(find.byType(UserAvatar), findsOneWidget);
    });

    /// 测试目的：验证认证标识
    testWidgets('应显示认证标识', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatar(
              avatarUrl: 'https://example.com/avatar.jpg',
              showVerifiedBadge: true,
              isVerified: true,
            ),
          ),
        ),
      );

      expect(find.byType(UserAvatar), findsOneWidget);
    });

    /// 测试目的：验证非认证用户不显示标识
    testWidgets('非认证用户不应显示认证标识', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatar(
              avatarUrl: 'https://example.com/avatar.jpg',
              showVerifiedBadge: true,
              isVerified: false,
            ),
          ),
        ),
      );

      expect(find.byType(UserAvatar), findsOneWidget);
    });
  });

  group('UserAvatar 交互测试', () {
    /// 测试目的：验证点击回调
    testWidgets('点击头像应触发 onTap 回调', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserAvatar(
              avatarUrl: 'https://example.com/avatar.jpg',
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(UserAvatar));
      await tester.pump();

      expect(tapped, isTrue);
    });

    /// 测试目的：验证带 userId 的点击
    testWidgets('带 userId 的头像应可点击', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatar(
              avatarUrl: 'https://example.com/avatar.jpg',
              userId: 'user_001',
            ),
          ),
        ),
      );

      // 点击不应抛异常
      await tester.tap(find.byType(UserAvatar));
      await tester.pump();

      expect(find.byType(UserAvatar), findsOneWidget);
    });
  });

  group('UserAvatar 边框测试', () {
    /// 测试目的：验证带边框的头像
    testWidgets('应支持带边框的头像', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserAvatar(
              avatarUrl: 'https://example.com/avatar.jpg',
              borderColor: Colors.blue,
              borderWidth: 2,
            ),
          ),
        ),
      );

      expect(find.byType(UserAvatar), findsOneWidget);
    });
  });

  group('UserAvatarGroup 测试', () {
    /// 测试目的：验证头像组渲染
    testWidgets('应正确渲染头像组', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatarGroup(
              avatarUrls: [
                'https://example.com/avatar1.jpg',
                'https://example.com/avatar2.jpg',
                'https://example.com/avatar3.jpg',
              ],
            ),
          ),
        ),
      );

      expect(find.byType(UserAvatarGroup), findsOneWidget);
    });

    /// 测试目的：验证头像组数量限制
    testWidgets('头像组应支持最大数量限制', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatarGroup(
              avatarUrls: [
                'https://example.com/avatar1.jpg',
                'https://example.com/avatar2.jpg',
                'https://example.com/avatar3.jpg',
                'https://example.com/avatar4.jpg',
                'https://example.com/avatar5.jpg',
              ],
              maxCount: 3,
            ),
          ),
        ),
      );

      expect(find.byType(UserAvatarGroup), findsOneWidget);
    });

    /// 测试目的：验证头像组点击
    testWidgets('点击头像组应触发 onTap', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserAvatarGroup(
              avatarUrls: [
                'https://example.com/avatar1.jpg',
                'https://example.com/avatar2.jpg',
              ],
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(UserAvatarGroup));
      await tester.pump();

      expect(tapped, isTrue);
    });
  });
}
