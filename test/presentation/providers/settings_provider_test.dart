import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traeu/presentation/providers/settings_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SettingsNotifier 字体设置', () {
    test('setFontSize 会持久化并在新容器中恢复', () async {
      SharedPreferences.setMockInitialValues({});

      final firstContainer = ProviderContainer();
      addTearDown(firstContainer.dispose);

      await firstContainer.read(settingsNotifierProvider.future);

      await firstContainer
          .read(settingsNotifierProvider.notifier)
          .setFontSize(FontSize.extraLarge);

      expect(
        firstContainer.read(currentSettingsProvider).fontSize,
        FontSize.extraLarge,
      );

      firstContainer.dispose();

      final secondContainer = ProviderContainer();
      addTearDown(secondContainer.dispose);
      await secondContainer.read(settingsNotifierProvider.future);

      expect(
        secondContainer.read(currentSettingsProvider).fontSize,
        FontSize.extraLarge,
      );
    });

    test('持久化数据损坏时回退默认字体设置', () async {
      SharedPreferences.setMockInitialValues({'app_settings': 'invalid-json'});

      final container = ProviderContainer();
      addTearDown(container.dispose);

      final settings = await container.read(settingsNotifierProvider.future);

      expect(settings.fontSize, FontSize.medium);
      expect(container.read(currentSettingsProvider).fontSize, FontSize.medium);
    });
  });
}
