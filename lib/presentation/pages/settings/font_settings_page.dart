import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/settings_provider.dart';

class FontSettingsPage extends ConsumerWidget {
  const FontSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFontSize = ref.watch(fontSizeProvider);
    final settingsNotifier = ref.read(settingsNotifierProvider.notifier);
    final fontScale = selectedFontSize.scaleFactor;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('字体设置')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '字体大小',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            '调整应用内的字体大小',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          _FontScalePreview(fontScale: fontScale),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('A', style: Theme.of(context).textTheme.bodySmall),
              Expanded(
                child: Slider(
                  value: fontScale,
                  min: FontSize.small.scaleFactor,
                  max: FontSize.extraLarge.scaleFactor,
                  divisions: 3,
                  onChanged: (value) {
                    settingsNotifier.setFontSize(_fontSizeFromScale(value));
                  },
                ),
              ),
              Text('A', style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _FontSizePresetChip(
                label: '小',
                value: FontSize.small.scaleFactor,
                currentValue: fontScale,
                onTap: () {
                  settingsNotifier.setFontSize(FontSize.small);
                },
              ),
              _FontSizePresetChip(
                label: '标准',
                value: FontSize.medium.scaleFactor,
                currentValue: fontScale,
                onTap: () {
                  settingsNotifier.setFontSize(FontSize.medium);
                },
              ),
              _FontSizePresetChip(
                label: '大',
                value: FontSize.large.scaleFactor,
                currentValue: fontScale,
                onTap: () {
                  settingsNotifier.setFontSize(FontSize.large);
                },
              ),
              _FontSizePresetChip(
                label: '特大',
                value: FontSize.extraLarge.scaleFactor,
                currentValue: fontScale,
                onTap: () {
                  settingsNotifier.setFontSize(FontSize.extraLarge);
                },
              ),
            ],
          ),
          const Divider(height: 48),
          Text(
            '预览',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          _FontPreviewSection(fontScale: fontScale),
        ],
      ),
    );
  }
}

FontSize _fontSizeFromScale(double scale) {
  final all = FontSize.values;
  FontSize nearest = all.first;
  double minDiff = (scale - nearest.scaleFactor).abs();

  for (final item in all.skip(1)) {
    final diff = (scale - item.scaleFactor).abs();
    if (diff < minDiff) {
      minDiff = diff;
      nearest = item;
    }
  }

  return nearest;
}

class _FontScalePreview extends StatelessWidget {
  final double fontScale;

  const _FontScalePreview({required this.fontScale});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Text('当前字体缩放', style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 8),
          Text(
            '${(fontScale * 100).round()}%',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _FontSizePresetChip extends StatelessWidget {
  final String label;
  final double value;
  final double currentValue;
  final VoidCallback onTap;

  const _FontSizePresetChip({
    required this.label,
    required this.value,
    required this.currentValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = (value - currentValue).abs() < 0.01;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
    );
  }
}

class _FontPreviewSection extends StatelessWidget {
  final double fontScale;

  const _FontPreviewSection({required this.fontScale});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '标题预览',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 20 * fontScale,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '这是一段正文内容的预览文字，用于展示不同字体大小下的阅读效果。你可以在这里看到调整字体大小后的实际显示效果。',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 14 * fontScale,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16 * fontScale,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                '提示文字',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 12 * fontScale,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
