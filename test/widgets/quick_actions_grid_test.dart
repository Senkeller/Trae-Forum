import 'package:flutter_test/flutter_test.dart';
import 'package:traeu/presentation/widgets/user/quick_actions_grid.dart';

void main() {
  group('resolveQuickActionRoute', () {
    test('不含 :username 占位符时返回原始路由', () {
      const route = '/messages';
      final result = resolveQuickActionRoute(route, 'alice');
      expect(result, route);
    });

    test('含 :username 占位符时替换为编码后的用户名', () {
      const route = '/user/:username?tab=activity&category=likes';
      final result = resolveQuickActionRoute(route, 'alice bob');
      expect(result, '/user/alice%20bob?tab=activity&category=likes');
    });

    test('用户名为空时返回 null', () {
      const route = '/user/:username?tab=activity&category=replies';
      final result = resolveQuickActionRoute(route, '  ');
      expect(result, isNull);
    });
  });
}
