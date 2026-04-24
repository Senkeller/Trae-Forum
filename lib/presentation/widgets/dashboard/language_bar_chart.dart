import 'package:flutter/material.dart';
import '../../../data/models/trae_dashboard.dart';

/// 编程语言条形图组件
///
/// 展示各编程语言的代码采纳次数分布
class LanguageBarChart extends StatelessWidget {
  final List<LanguageStat> data;

  const LanguageBarChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return _buildEmptyView();
    }

    // 获取最大值用于计算比例
    final maxCount = data.map((e) => e.count).reduce((a, b) => a > b ? a : b);

    return Column(
      children: data.map((stat) {
        return _buildLanguageBar(stat, maxCount);
      }).toList(),
    );
  }

  /// 构建语言条形
  Widget _buildLanguageBar(LanguageStat stat, int maxCount) {
    final percentage = maxCount > 0 ? stat.count / maxCount : 0.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          // 语言图标
          _buildLanguageIcon(stat.language),
          const SizedBox(width: 8),
          // 语言名称
          SizedBox(
            width: 80,
            child: Text(
              stat.language,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // 进度条
          Expanded(
            child: Stack(
              children: [
                // 背景条
                Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3D3D3D),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                // 进度条
                FractionallySizedBox(
                  widthFactor: percentage,
                  child: Container(
                    height: 24,
                    decoration: BoxDecoration(
                      color: _getLanguageColor(stat.language),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      '${stat.count}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建语言图标
  Widget _buildLanguageIcon(String language) {
    final iconData = _getLanguageIcon(language);
    final color = _getLanguageColor(language);

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(
        iconData,
        color: color,
        size: 16,
      ),
    );
  }

  /// 获取语言图标
  IconData _getLanguageIcon(String language) {
    switch (language.toLowerCase()) {
      case 'dart':
        return Icons.flutter_dash;
      case 'javascript':
      case 'typescript':
        return Icons.javascript;
      case 'python':
        return Icons.code;
      case 'java':
        return Icons.coffee;
      case 'kotlin':
        return Icons.android;
      case 'swift':
        return Icons.apple;
      case 'markdown':
        return Icons.description;
      case 'yaml':
      case 'yml':
        return Icons.settings;
      case 'json':
        return Icons.data_object;
      case 'html':
        return Icons.html;
      case 'css':
        return Icons.css;
      case 'shellscript':
      case 'bash':
        return Icons.terminal;
      case 'xml':
        return Icons.code;
      default:
        return Icons.code;
    }
  }

  /// 获取语言颜色
  Color _getLanguageColor(String language) {
    switch (language.toLowerCase()) {
      case 'dart':
        return const Color(0xFF00B4AB);
      case 'javascript':
        return const Color(0xFFF7DF1E);
      case 'typescript':
        return const Color(0xFF3178C6);
      case 'python':
        return const Color(0xFF3776AB);
      case 'java':
        return const Color(0xFF007396);
      case 'kotlin':
        return const Color(0xFF7F52FF);
      case 'swift':
        return const Color(0xFFF05138);
      case 'markdown':
        return const Color(0xFF083FA1);
      case 'yaml':
      case 'yml':
        return const Color(0xFFCB171E);
      case 'json':
        return const Color(0xFF292929);
      case 'html':
        return const Color(0xFFE34F26);
      case 'css':
        return const Color(0xFF1572B6);
      case 'shellscript':
      case 'bash':
        return const Color(0xFF89E051);
      case 'xml':
        return const Color(0xFF0060AC);
      default:
        return const Color(0xFF32F08C);
    }
  }

  /// 构建空视图
  Widget _buildEmptyView() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF252525),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          '暂无语言数据',
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
