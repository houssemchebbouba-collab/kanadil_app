import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/app_colors.dart';

class HexagonLesson extends StatelessWidget {
  final bool isCompleted;
  final bool isLocked;
  final bool isCurrent;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const HexagonLesson({
    super.key,
    this.isCompleted = false,
    this.isLocked = false,
    this.isCurrent = false,
    this.icon = Icons.menu_book_rounded,
    this.color = AppColors.primary,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lockedColor = isDark ? Colors.grey.shade700 : Colors.grey.shade300;

    return GestureDetector(
      onTap: isLocked ? null : onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Hexagon shape
          CustomPaint(
            size: const Size(70, 80),
            painter: HexagonPainter(
              color: isLocked ? lockedColor : color,
              isCompleted: isCompleted,
            ),
          ),
          // Icon
          Icon(
            isLocked ? Icons.lock_rounded : icon,
            color: Colors.white,
            size: 28,
          ),
          // Completion badge
          if (isCompleted)
            Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade800 : Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: color,
                  size: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class HexagonPainter extends CustomPainter {
  final Color color;
  final bool isCompleted;

  HexagonPainter({
    required this.color,
    this.isCompleted = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final path = _createHexagonPath(size, 0);
    final shadowPath = _createHexagonPath(size, 4);

    // Draw shadow
    canvas.drawPath(shadowPath, shadowPaint);
    // Draw hexagon
    canvas.drawPath(path, paint);
  }

  Path _createHexagonPath(Size size, double offset) {
    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2 + offset;
    final radius = size.width / 2 - 2;

    for (int i = 0; i < 6; i++) {
      final angle = (math.pi / 3) * i - math.pi / 2;
      final x = centerX + radius * math.cos(angle);
      final y = centerY + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
