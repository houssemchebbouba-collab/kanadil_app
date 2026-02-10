import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CurvedPathPainter extends CustomPainter {
  final List<Offset> points;
  final Color pathColor;
  final bool isDark;

  CurvedPathPainter({
    required this.points,
    required this.pathColor,
    this.isDark = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final paint = Paint()
      ..color = isDark ? AppColors.progressBackgroundDark : AppColors.progressBackground
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw dashed path
    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 1; i < points.length; i++) {
      final p0 = points[i - 1];
      final p1 = points[i];

      // Calculate control points for a smooth curve
      final midX = (p0.dx + p1.dx) / 2;

      path.cubicTo(
        midX, p0.dy,
        midX, p1.dy,
        p1.dx, p1.dy,
      );
    }

    // Draw path with dash effect
    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    const dashWidth = 10.0;
    const dashSpace = 8.0;

    final pathMetrics = path.computeMetrics();

    for (final metric in pathMetrics) {
      double distance = 0;
      while (distance < metric.length) {
        final extractPath = metric.extractPath(
          distance,
          distance + dashWidth,
        );
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CurvedPathPainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.pathColor != pathColor ||
        oldDelegate.isDark != isDark;
  }
}

class LessonPathWidget extends StatelessWidget {
  final int lessonCount;
  final double islandSize;
  final double verticalSpacing;

  const LessonPathWidget({
    super.key,
    required this.lessonCount,
    this.islandSize = 70,
    this.verticalSpacing = 100,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CustomPaint(
      size: Size(
        MediaQuery.of(context).size.width,
        lessonCount * verticalSpacing,
      ),
      painter: CurvedPathPainter(
        points: _generatePoints(MediaQuery.of(context).size.width),
        pathColor: isDark ? AppColors.progressBackgroundDark : AppColors.progressBackground,
        isDark: isDark,
      ),
    );
  }

  List<Offset> _generatePoints(double screenWidth) {
    final points = <Offset>[];
    final centerX = screenWidth / 2;
    final amplitude = screenWidth * 0.25;

    for (int i = 0; i < lessonCount; i++) {
      double x;
      if (i % 4 == 0) {
        x = centerX;
      } else if (i % 4 == 1) {
        x = centerX - amplitude;
      } else if (i % 4 == 2) {
        x = centerX;
      } else {
        x = centerX + amplitude;
      }

      final y = (i * verticalSpacing) + (islandSize / 2);
      points.add(Offset(x, y));
    }

    return points;
  }
}
