import '../constants/app_constants.dart';

// ==========================================
// حاسبة النقاط - Score Calculator
// ==========================================

class ScoreCalculator {
  /// حساب النسبة المئوية
  static double calculatePercentage(int correct, int total) {
    if (total == 0) return 0;
    return (correct / total) * 100;
  }

  /// حساب عدد النجوم بناءً على النسبة المئوية
  static int calculateStars(double percentage) {
    if (percentage >= AppConstants.threeStarMin) return 3;
    if (percentage >= AppConstants.twoStarMin) return 2;
    if (percentage >= AppConstants.oneStarMin) return 1;
    return 0;
  }

  /// حساب نقاط الخبرة المكتسبة
  static int calculateXP({
    required int correctAnswers,
    required int totalQuestions,
    required int starsEarned,
    bool isUnitComplete = false,
  }) {
    int xp = 0;

    // نقاط الإجابات الصحيحة
    xp += correctAnswers * AppConstants.xpPerCorrectAnswer;

    // مكافأة النجوم الثلاث
    if (starsEarned == 3) {
      xp += AppConstants.xpForThreeStarsBonus;
    }

    // مكافأة إكمال الوحدة
    if (isUnitComplete) {
      xp += AppConstants.xpForCompletingUnit;
    }

    return xp;
  }

  /// حساب مكافأة السلسلة اليومية
  static int calculateStreakBonus(int streakDays) {
    if (streakDays >= AppConstants.streakGold) {
      return AppConstants.xpForDailyStreak * 3;
    } else if (streakDays >= AppConstants.streakSilver) {
      return AppConstants.xpForDailyStreak * 2;
    } else if (streakDays >= AppConstants.streakBronze) {
      return AppConstants.xpForDailyStreak;
    }
    return 0;
  }

  /// الحصول على مستوى السلسلة
  static String getStreakLevel(int streakDays) {
    if (streakDays >= AppConstants.streakGold) return 'ذهبي';
    if (streakDays >= AppConstants.streakSilver) return 'فضي';
    if (streakDays >= AppConstants.streakBronze) return 'برونزي';
    return 'مبتدئ';
  }

  /// حساب المستوى من نقاط الخبرة
  static int calculateLevel(int totalXP) {
    // كل 500 نقطة = مستوى جديد
    return (totalXP / 500).floor() + 1;
  }

  /// حساب التقدم نحو المستوى التالي
  static double calculateLevelProgress(int totalXP) {
    return (totalXP % 500) / 500;
  }

  /// الحصول على نقاط الخبرة المطلوبة للمستوى التالي
  static int xpForNextLevel(int totalXP) {
    return 500 - (totalXP % 500);
  }
}
