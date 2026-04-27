import 'package:flutter_test/flutter_test.dart';
import 'package:traeu/presentation/providers/settings_provider.dart';

void main() {
  group('AppSettings.fromJson', () {
    test('应在枚举索引越界时回退到默认值', () {
      final settings = AppSettings.fromJson({
        'imageQuality': 999,
        'fontSize': -1,
        'language': 'invalid',
      });

      expect(settings.imageQuality, ImageQuality.high);
      expect(settings.fontSize, FontSize.medium);
      expect(settings.language, AppLanguage.system);
    });

    test('应正确解析合法索引', () {
      final settings = AppSettings.fromJson({
        'imageQuality': ImageQuality.low.index,
        'fontSize': FontSize.large.index,
        'language': AppLanguage.english.index,
      });

      expect(settings.imageQuality, ImageQuality.low);
      expect(settings.fontSize, FontSize.large);
      expect(settings.language, AppLanguage.english);
    });
  });

  group('ImageQualityExtension.imagePickerQuality', () {
    test('应返回与质量等级匹配的压缩参数', () {
      expect(ImageQuality.original.imagePickerQuality, isNull);
      expect(ImageQuality.high.imagePickerQuality, 95);
      expect(ImageQuality.medium.imagePickerQuality, 80);
      expect(ImageQuality.low.imagePickerQuality, 65);
    });
  });
}
