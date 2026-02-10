import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/lesson.dart';
import '../theme/app_colors.dart';

class LessonIsland extends StatelessWidget {
  final Lesson lesson;
  final Color subjectColor;
  final VoidCallback? onTap;
  final bool isCurrent;

  const LessonIsland({
    super.key,
    required this.lesson,
    required this.subjectColor,
    this.onTap,
    this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color backgroundColor;
    Color borderColor;
    Color iconColor;
    IconData icon;

    if (lesson.isLocked) {
      backgroundColor = isDark ? AppColors.lessonLockedDark : AppColors.lessonLocked;
      borderColor = backgroundColor;
      iconColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
      icon = Icons.lock_rounded;
    } else if (lesson.isCompleted) {
      backgroundColor = AppColors.lessonCompleted;
      borderColor = AppColors.lessonCompleted;
      iconColor = Colors.white;
      icon = lesson.isPerfect ? Icons.star_rounded : Icons.check_rounded;
    } else {
      backgroundColor = subjectColor;
      borderColor = subjectColor;
      iconColor = Colors.white;
      icon = _getLessonTypeIcon(lesson.type);
    }

    Widget island = GestureDetector(
      onTap: lesson.isLocked ? null : onTap,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor,
            width: 4,
          ),
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28,
              color: iconColor,
            ),
            if (!lesson.isLocked && lesson.isCompleted && lesson.stars > 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  lesson.stars,
                  (index) => const Icon(
                    Icons.star_rounded,
                    size: 10,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    // Add animation for current lesson
    if (isCurrent && lesson.isAvailable) {
      island = island
          .animate(onPlay: (controller) => controller.repeat())
          .scale(
            begin: const Offset(1, 1),
            end: const Offset(1.1, 1.1),
            duration: 1000.ms,
          )
          .then()
          .scale(
            begin: const Offset(1.1, 1.1),
            end: const Offset(1, 1),
            duration: 1000.ms,
          );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        island,
        const SizedBox(height: 8),
        SizedBox(
          width: 80,
          child: Text(
            lesson.titleArabic,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: lesson.isLocked
                  ? (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)
                  : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  IconData _getLessonTypeIcon(LessonType type) {
    switch (type) {
      case LessonType.learn:
        return Icons.school_rounded;
      case LessonType.practice:
        return Icons.edit_rounded;
      case LessonType.quiz:
        return Icons.quiz_rounded;
      case LessonType.challenge:
        return Icons.emoji_events_rounded;
    }
  }
}
