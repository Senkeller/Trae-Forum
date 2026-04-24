import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/theme_provider.dart';

class ThemeSettingsPage extends ConsumerWidget {
  const ThemeSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themeModeNotifierProvider);
    final themeModeType = themeModeAsync.valueOrNull ?? ThemeModeType.system;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('主题设置'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _ThemeOptionCard(
            title: '浅色模式',
            subtitle: '始终使用浅色主题',
            icon: Icons.light_mode,
            isSelected: themeModeType == ThemeModeType.light,
            onTap: () {
              ref.read(themeModeNotifierProvider.notifier).setThemeMode(ThemeModeType.light);
            },
          ),
          _ThemeOptionCard(
            title: '深色模式',
            subtitle: '始终使用深色主题',
            icon: Icons.dark_mode,
            isSelected: themeModeType == ThemeModeType.dark,
            onTap: () {
              ref.read(themeModeNotifierProvider.notifier).setThemeMode(ThemeModeType.dark);
            },
          ),
          _ThemeOptionCard(
            title: '跟随系统',
            subtitle: '自动跟随系统主题设置',
            icon: Icons.settings_brightness,
            isSelected: themeModeType == ThemeModeType.system,
            onTap: () {
              ref.read(themeModeNotifierProvider.notifier).setThemeMode(ThemeModeType.system);
            },
          ),
          const Divider(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              '预览',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: _ThemePreviewCard(currentMode: themeModeType),
          ),
        ],
      ),
    );
  }
}

class _ThemeOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOptionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: isSelected ? colorScheme.primaryContainer : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: isSelected
                      ? colorScheme.onPrimary
                      : colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: colorScheme.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemePreviewCard extends StatelessWidget {
  final ThemeModeType currentMode;

  const _ThemePreviewCard({required this.currentMode});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '当前主题: ${_getThemeName(currentMode)}',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _ColorDot(color: Colors.blue, label: '主色'),
              const SizedBox(width: 16),
              _ColorDot(color: Colors.green, label: '强调色'),
              const SizedBox(width: 16),
              _ColorDot(color: Colors.grey, label: '背景色'),
            ],
          ),
        ],
      ),
    );
  }

  String _getThemeName(ThemeModeType mode) {
    switch (mode) {
      case ThemeModeType.light:
        return '浅色模式';
      case ThemeModeType.dark:
        return '深色模式';
      case ThemeModeType.system:
        return '跟随系统';
    }
  }
}

class _ColorDot extends StatelessWidget {
  final Color color;
  final String label;

  const _ColorDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
