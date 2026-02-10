import 'package:flutter/material.dart';
import '../models/achievement.dart';
import '../theme/app_colors.dart';

class AchievementBadge extends StatelessWidget {
  final Achievement achievement;
  final bool showDetails;

  const AchievementBadge({
    super.key,
    required this.achievement,
    this.showDetails = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(16),
        border: achievement.unlocked
            ? Border.all(color: achievement.color, width: 2)
            : null,
      ),
      child: Row(
        children: [
          // Badge icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: achievement.unlocked
                  ? achievement.color.withOpacity( 0.2)
                  : (isDark ? AppColors.lessonLockedDark : AppColors.lessonLocked),
              shape: BoxShape.circle,
            ),
            child: Icon(
              achievement.unlocked ? achievement.icon : Icons.lock_rounded,
              color: achievement.unlocked
                  ? achievement.color
                  : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
              size: 24,
            ),
          ),
          if (showDetails) ...[
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    achievement.titleArabic,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: achievement.unlocked
                          ? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)
                          : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    achievement.descriptionArabic,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ),
            if (achievement.unlocked)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.xpGold.withOpacity( 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.bolt_rounded,
                      color: AppColors.xpGold,
                      size: 14,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '+${achievement.xpReward}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.xpGold,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}
