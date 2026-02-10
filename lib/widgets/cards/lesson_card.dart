import 'package:flutter/material.dart';
import '../../models/lesson_model.dart';

// ==========================================
// بطاقة الدرس - Lesson Card
// ==========================================

class LessonCard extends StatelessWidget {
  final LessonModel lesson;
  final int lessonNumber;
  final Color color;
  final VoidCallback? onTap;

  const LessonCard({
    super.key,
    required this.lesson,
    required this.lessonNumber,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: lesson.isLocked ? null : onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: lesson.isLocked
                ? Colors.grey[300]!
                : lesson.isCompleted
                    ? const Color(0xFF58CC02)
                    : color.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            // أيقونة نوع الدرس
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: lesson.isLocked
                    ? Colors.grey[200]
                    : lesson.isCompleted
                        ? const Color(0xFF58CC02).withOpacity(0.2)
                        : color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: lesson.isLocked
                    ? Icon(Icons.lock, color: Colors.grey[400], size: 18)
                    : lesson.isCompleted
                        ? const Icon(Icons.check,
                            color: Color(0xFF58CC02), size: 18)
                        : Icon(_getLessonTypeIcon(), color: color, size: 18),
              ),
            ),

            const SizedBox(width: 12),

            // معلومات الدرس
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.arabicTitle,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: lesson.isLocked ? Colors.grey : null,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _getLessonTypeText(),
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),

            // السهم
            if (!lesson.isLocked)
              Icon(
                Icons.chevron_left,
                color: Colors.grey[400],
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  IconData _getLessonTypeIcon() {
    switch (lesson.type) {
      case LessonType.text:
        return Icons.article;
      case LessonType.image:
        return Icons.image;
      case LessonType.video:
        return Icons.play_circle;
      case LessonType.mixed:
        return Icons.dashboard;
    }
  }

  String _getLessonTypeText() {
    switch (lesson.type) {
      case LessonType.text:
        return 'درس نصي';
      case LessonType.image:
        return 'درس مصور';
      case LessonType.video:
        return 'درس فيديو';
      case LessonType.mixed:
        return 'درس متنوع';
    }
  }
}
