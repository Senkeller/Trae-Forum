import 'package:flutter/material.dart';
import '../../../data/models/trae_dashboard.dart';

/// 活跃热力图组件
///
/// 展示用户过去一年的每日活跃情况
/// 使用 GitHub 风格的绿色热力图
class ActivityHeatmap extends StatelessWidget {
  final List<DailyActivity> data;

  const ActivityHeatmap({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return _buildEmptyView();
    }

    // 计算要显示的周数（最多53周）
    final weeksToShow = data.length ~/ 7;
    final displayWeeks = weeksToShow > 53 ? 53 : weeksToShow;

    // 获取最近的数据
    final recentData = data.length > displayWeeks * 7
        ? data.sublist(data.length - displayWeeks * 7)
        : data;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF252525),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 月份标签
          _buildMonthLabels(recentData),
          const SizedBox(height: 8),
          // 热力图网格
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 星期标签
              _buildWeekdayLabels(),
              const SizedBox(width: 8),
              // 热力图
              Expanded(
                child: _buildHeatmapGrid(recentData),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 图例
          _buildLegend(),
        ],
      ),
    );
  }

  /// 构建月份标签
  Widget _buildMonthLabels(List<DailyActivity> data) {
    final months = <String>[];
    DateTime? lastMonth;

    for (var i = 0; i < data.length; i += 7) {
      final date = data[i].date;
      if (lastMonth == null || date.month != lastMonth.month) {
        months.add(_getMonthAbbreviation(date.month));
        lastMonth = date;
      } else {
        months.add('');
      }
    }

    return Row(
      children: months.map((month) {
        return Expanded(
          child: month.isEmpty
              ? const SizedBox()
              : Text(
                  month,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 10,
                  ),
                ),
        );
      }).toList(),
    );
  }

  /// 构建星期标签
  Widget _buildWeekdayLabels() {
    final weekdays = ['M', 'W', 'F'];
    return Column(
      children: List.generate(7, (index) {
        if (index == 0 || index == 2 || index == 4) {
          return Container(
            height: 12,
            width: 20,
            alignment: Alignment.center,
            child: Text(
              weekdays[index ~/ 2],
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 9,
              ),
            ),
          );
        }
        return const SizedBox(height: 12, width: 20);
      }),
    );
  }

  /// 构建热力图网格
  Widget _buildHeatmapGrid(List<DailyActivity> data) {
    // 按周组织数据
    final weeks = <List<DailyActivity>>[];
    for (var i = 0; i < data.length; i += 7) {
      final end = (i + 7 < data.length) ? i + 7 : data.length;
      weeks.add(data.sublist(i, end));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: weeks.map((week) {
        return Column(
          children: List.generate(7, (dayIndex) {
            if (dayIndex < week.length) {
              final activity = week[dayIndex];
              return Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: _getActivityColor(activity.level),
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }
            return const SizedBox(width: 10, height: 10);
          }),
        );
      }).toList(),
    );
  }

  /// 构建图例
  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Less',
          style: TextStyle(
            color: Colors.white.withOpacity(0.4),
            fontSize: 10,
          ),
        ),
        const SizedBox(width: 4),
        ...List.generate(5, (level) {
          return Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: _getActivityColor(level),
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
        const SizedBox(width: 4),
        Text(
          'More',
          style: TextStyle(
            color: Colors.white.withOpacity(0.4),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  /// 获取活跃等级对应的颜色
  Color _getActivityColor(int level) {
    switch (level) {
      case 0:
        return const Color(0xFF2D333B); // 无活跃
      case 1:
        return const Color(0xFF0E4429); // 低活跃
      case 2:
        return const Color(0xFF006D32); // 中低活跃
      case 3:
        return const Color(0xFF26A641); // 中高活跃
      case 4:
        return const Color(0xFF39D353); // 高活跃
      default:
        return const Color(0xFF2D333B);
    }
  }

  /// 获取月份缩写
  String _getMonthAbbreviation(int month) {
    const months = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month];
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
          '暂无活跃数据',
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
