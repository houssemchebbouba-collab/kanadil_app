import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class Helpers {
  static Color getSubjectColor(String subjectId) {
    switch (subjectId) {
      case 'math':
        return AppColors.mathColor;
      case 'arabic':
        return AppColors.arabicColor;
      case 'french':
        return AppColors.frenchColor;
      case 'science':
        return AppColors.scienceColor;
      case 'history':
        return AppColors.historyColor;
      case 'geography':
        return AppColors.geographyColor;
      case 'islamic':
        return AppColors.islamicColor;
      case 'civics':
        return AppColors.civicsColor;
      default:
        return AppColors.primary;
    }
  }

  static IconData getSubjectIcon(String subjectId) {
    switch (subjectId) {
      case 'math':
        return Icons.calculate_rounded;
      case 'arabic':
        return Icons.menu_book_rounded;
      case 'french':
        return Icons.language_rounded;
      case 'science':
        return Icons.science_rounded;
      case 'history':
        return Icons.history_edu_rounded;
      case 'geography':
        return Icons.public_rounded;
      case 'islamic':
        return Icons.auto_stories_rounded;
      case 'civics':
        return Icons.people_rounded;
      default:
        return Icons.school_rounded;
    }
  }

  static String formatXP(int xp) {
    if (xp >= 1000) {
      return '${(xp / 1000).toStringAsFixed(1)}K';
    }
    return xp.toString();
  }

  static String getStreakEmoji(int streak) {
    if (streak >= 30) return '';
    if (streak >= 14) return '';
    if (streak >= 7) return '';
    if (streak >= 3) return '';
    return '';
  }

  static String getLessonStatusText(String status) {
    switch (status) {
      case 'locked':
        return 'مقفل';
      case 'available':
        return 'متاح';
      case 'completed':
        return 'مكتمل';
      case 'perfect':
        return 'ممتاز';
      default:
        return '';
    }
  }
}
