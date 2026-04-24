import 'package:flutter/material.dart';
import '../../../data/models/trae_dashboard.dart';

/// 编程时段曲线组件
///
/// 展示24小时编程活跃度分布，使用波浪曲线
class HourlyActivityCurve extends StatelessWidget {
  final List<HourlyActivity> data;

  const HourlyActivityCurve({
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
        children: [
          // 曲线图
          SizedBox(
            height: 120,
            child: CustomPaint(
              size: const Size(double.infinity, 120),
              painter: _WavePainter(data: data),
            ),
          ),
          const SizedBox(height: 16),
          // 时间标签
          _buildTimeLabels(),
        ],
      ),
    );
  }

  /// 构建时间标签
  Widget _buildTimeLabels() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTimeLabel('06:00', true),
        _buildTimeLabel('12:00', false),
        _buildTimeLabel('18:00', true),
        _buildTimeLabel('24:00', false),
        _buildTimeLabel('06:00', true),
      ],
    );
  }

  /// 构建单个时间标签
  Widget _buildTimeLabel(String time, bool hasIcon) {
    return Column(
      children: [
        if (hasIcon)
          Icon(
            time == '06:00'
                ? Icons.wb_twilight
                : time == '18:00'
                    ? Icons.nights_stay
                    : Icons.wb_sunny,
            color: const Color(0xFFFFA726),
            size: 16,
          ),
        if (hasIcon) const SizedBox(height: 4),
        Text(
          time,
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 11,
          ),
        ),
      ],
    );
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
          '暂无时段数据',
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

/// 波浪曲线绘制器
class _WavePainter extends CustomPainter {
  final List<HourlyActivity> data;

  _WavePainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final maxCount = data.map((e) => e.count).reduce((a, b) => a > b ? a : b);
    if (maxCount == 0) return;

    final width = size.width;
    final height = size.height;
    final padding = 20.0;

    // 绘制背景网格线
    _drawGrid(canvas, size, padding);

    // 绘制波浪曲线
    final path = Path();
    final points = <Offset>[];

    for (var i = 0; i < data.length; i++) {
      final x = padding + (width - 2 * padding) * (i / (data.length - 1));
      final normalizedValue = data[i].count / maxCount;
      final y = height - padding - (height - 2 * padding) * normalizedValue * 0.8;
      points.add(Offset(x, y));
    }

    if (points.isNotEmpty) {
      path.moveTo(points.first.dx, points.first.dy);

      // 使用贝塞尔曲线连接点
      for (var i = 0; i < points.length - 1; i++) {
        final current = points[i];
        final next = points[i + 1];
        final controlX = (current.dx + next.dx) / 2;

        path.cubicTo(
          controlX, current.dy,
          controlX, next.dy,
          next.dx, next.dy,
        );
      }
    }

    // 绘制填充区域
    final fillPath = Path.from(path);
    fillPath.lineTo(points.last.dx, height - padding);
    fillPath.lineTo(points.first.dx, height - padding);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF32F08C).withOpacity(0.3),
          const Color(0xFF32F08C).withOpacity(0.05),
        ],
      ).createShader(Rect.fromLTWH(0, 0, width, height));

    canvas.drawPath(fillPath, fillPaint);

    // 绘制曲线
    final linePaint = Paint()
      ..color = const Color(0xFF32F08C)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, linePaint);

    // 绘制数据点
    for (var i = 0; i < points.length; i++) {
      final point = points[i];
      final isPeak = data[i].isPeak;

      // 绘制点
      final pointPaint = Paint()
        ..color = isPeak ? const Color(0xFFFFA726) : Colors.white
        ..style = PaintingStyle.fill;

      canvas.drawCircle(point, isPeak ? 5 : 3, pointPaint);

      // 绘制峰值标记
      if (isPeak) {
        final peakPaint = Paint()
          ..color = const Color(0xFFFFA726).withOpacity(0.3)
          ..style = PaintingStyle.fill;
        canvas.drawCircle(point, 10, peakPaint);
      }
    }

    // 绘制峰值标签
    final peakHours = data.where((e) => e.isPeak).toList();
    if (peakHours.isNotEmpty) {
      final peakHour = peakHours.first;
      final peakIndex = data.indexOf(peakHour);
      if (peakIndex >= 0 && peakIndex < points.length) {
        final peakPoint = points[peakIndex];
        _drawPeakLabel(canvas, peakPoint, peakHour.hour);
      }
    }
  }

  /// 绘制背景网格
  void _drawGrid(Canvas canvas, Size size, double padding) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;

    // 水平线
    for (var i = 0; i <= 4; i++) {
      final y = padding + (size.height - 2 * padding) * (i / 4);
      canvas.drawLine(
        Offset(padding, y),
        Offset(size.width - padding, y),
        paint,
      );
    }
  }

  /// 绘制峰值标签
  void _drawPeakLabel(Canvas canvas, Offset point, int hour) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${hour.toString().padLeft(2, '0')}:00',
        style: const TextStyle(
          color: Color(0xFFFFA726),
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        point.dx - textPainter.width / 2,
        point.dy - 25,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
