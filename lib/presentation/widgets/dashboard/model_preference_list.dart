import 'package:flutter/material.dart';
import '../../../data/models/trae_dashboard.dart';

/// AI 模型偏好列表组件
///
/// 展示各 AI 模型的调用次数排行
class ModelPreferenceList extends StatelessWidget {
  final List<ModelStat> data;

  const ModelPreferenceList({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return _buildEmptyView();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF252525),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: data.asMap().entries.map((entry) {
          final index = entry.key;
          final stat = entry.value;
          return _buildModelItem(stat, index);
        }).toList(),
      ),
    );
  }

  /// 构建模型项
  Widget _buildModelItem(ModelStat stat, int index) {
    final isTop = index == 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          // 模型图标
          _buildModelIcon(stat.modelName, isTop),
          const SizedBox(width: 12),
          // 模型名称
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatModelName(stat.modelName),
                  style: TextStyle(
                    color: isTop ? const Color(0xFF32F08C) : Colors.white,
                    fontSize: 14,
                    fontWeight: isTop ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 4),
                // 进度条
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: stat.percentage,
                    backgroundColor: const Color(0xFF3D3D3D),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isTop
                          ? const Color(0xFF32F08C)
                          : Colors.white.withOpacity(0.5),
                    ),
                    minHeight: 4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // 调用次数
          Text(
            '${stat.count}',
            style: TextStyle(
              color: isTop ? const Color(0xFF32F08C) : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建模型图标
  Widget _buildModelIcon(String modelName, bool isTop) {
    final iconData = _getModelIcon(modelName);
    final color = isTop ? const Color(0xFF32F08C) : Colors.white.withOpacity(0.5);

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Icon(
        iconData,
        color: color,
        size: 20,
      ),
    );
  }

  /// 获取模型图标
  IconData _getModelIcon(String modelName) {
    final lowerName = modelName.toLowerCase();
    if (lowerName.contains('kimi')) {
      return Icons.auto_awesome;
    } else if (lowerName.contains('deepseek')) {
      return Icons.search;
    } else if (lowerName.contains('gpt') || lowerName.contains('openai')) {
      return Icons.chat_bubble_outline;
    } else if (lowerName.contains('glm')) {
      return Icons.psychology;
    } else if (lowerName.contains('minimax')) {
      return Icons.trending_up;
    } else if (lowerName.contains('qwen')) {
      return Icons.cloud;
    } else if (lowerName.contains('auto')) {
      return Icons.auto_mode;
    } else {
      return Icons.smart_toy;
    }
  }

  /// 格式化模型名称
  String _formatModelName(String modelName) {
    // 移除前缀
    var name = modelName
        .replaceAll('openai//', '')
        .replaceAll('openrouter//', '')
        .replaceAll('zai//', '');

    // 特殊格式化
    if (name.contains('kimi')) {
      name = name.replaceAll('kimi-', 'Kimi ');
    } else if (name.contains('deepseek')) {
      name = name.replaceAll('deepseek-', 'DeepSeek ');
    } else if (name.contains('glm')) {
      name = name.replaceAll('glm-', 'GLM-');
    } else if (name.contains('minimax')) {
      name = name.replaceAll('minimax-', 'MiniMax ');
    } else if (name.contains('qwen')) {
      name = name.replaceAll('qwen-', 'Qwen-');
    }

    // 首字母大写
    return name.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
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
          '暂无模型数据',
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
