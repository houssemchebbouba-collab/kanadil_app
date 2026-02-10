import 'package:flutter/material.dart';
import '../../models/unit_model.dart';

// ==========================================
// بطاقة الوحدة - Unit Card
// ==========================================

class UnitCard extends StatelessWidget {
  final UnitModel unit;
  final Color subjectColor;
  final VoidCallback? onTap;

  const UnitCard({
    super.key,
    required this.unit,
    required this.subjectColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: unit.isLocked ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: unit.isLocked
                ? Colors.grey[300]!
                : subjectColor.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // أيقونة الحالة
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: unit.isLocked
                    ? Colors.grey[200]
                    : unit.isCompleted
                        ? const Color(0xFF58CC02).withOpacity(0.2)
                        : subjectColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: unit.isLocked
                    ? Icon(Icons.lock, color: Colors.grey[400])
                    : unit.isCompleted
                        ? const Icon(Icons.check, color: Color(0xFF58CC02))
                        : Icon(Icons.play_arrow, color: subjectColor),
              ),
            ),

            const SizedBox(width: 16),

            // معلومات الوحدة
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    unit.unitName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: unit.isLocked ? Colors.grey : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${unit.stages.length} مراحل • ${unit.lessons.length} دروس',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (!unit.isLocked) ...[
                    const SizedBox(height: 8),
                    // شريط التقدم
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: unit.calculatedProgress,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation(
                          unit.isCompleted
                              ? const Color(0xFF58CC02)
                              : subjectColor,
                        ),
                        minHeight: 6,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(width: 12),

            // النجوم
            if (!unit.isLocked)
              Column(
                children: [
                  Row(
                    children: List.generate(3, (index) {
                      return Icon(
                        index < unit.totalStarsEarned
                            ? Icons.star
                            : Icons.star_border,
                        size: 16,
                        color: index < unit.totalStarsEarned
                            ? const Color(0xFFFFD700)
                            : Colors.grey[300],
                      );
                    }),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${unit.totalStarsEarned}/${unit.maxStars}',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
