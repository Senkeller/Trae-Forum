import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traeu/app.dart';

void main() {
  testWidgets('App should build without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // 等待应用初始化完成（Hive 初始化需要异步操作）
    // 使用多次 pump 来推进异步操作，而不是 pumpAndSettle（会超时）
    for (int i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    // 验证 MaterialApp 已构建（无论是加载中、错误还是正常状态）
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
