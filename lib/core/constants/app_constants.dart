// ==========================================
// ثوابت التطبيق - Kanadil App Constants
// ==========================================

class AppConstants {
  // ==========================================
  // نظام نقاط الخبرة (XP System)
  // ==========================================
  static const int xpPerCorrectAnswer = 10;
  static const int xpForCompletingUnit = 50;
  static const int xpForThreeStarsBonus = 30;
  static const int xpForDailyStreak = 20;
  static const int xpForDailyChallenge = 100;

  // ==========================================
  // عتبات النجوم (Stars Thresholds)
  // ==========================================
  static const int oneStarMin = 60;   // 60-79%
  static const int twoStarMin = 80;   // 80-94%
  static const int threeStarMin = 95; // 95-100%

  // ==========================================
  // مستويات السلسلة (Streak Levels)
  // ==========================================
  static const int streakBronze = 3;  // أيام
  static const int streakSilver = 7;  // أيام
  static const int streakGold = 30;   // أيام

  // ==========================================
  // إعدادات الإشعارات (Notification Settings)
  // ==========================================
  static const int notificationAfterInactiveDays = 3;
  static const String notificationTitle = "نفتقدك في قناديل! 🕯️";
  static const String notificationBody = "حان وقت التعلم! عد وواصل رحلتك التعليمية";

  // ==========================================
  // إعدادات الاختبار (Quiz Settings)
  // ==========================================
  static const bool allowRetry = true;
  static const int maxAttemptsPerStage = -1; // غير محدود
  static const int? timePerQuestion = null;  // بدون مؤقت

  // ==========================================
  // إعدادات الدروس (Lesson Settings)
  // ==========================================
  static const bool canUnlockAllLessons = true; // من الإعدادات

  // ==========================================
  // التحدي اليومي (Daily Challenge)
  // ==========================================
  static const int dailyChallengeQuestionsCount = 5;

  // ==========================================
  // معلومات التطبيق (App Info)
  // ==========================================
  static const String appName = 'قناديل';
  static const String appNameEn = 'Kanadil';
  static const String appVersion = '1.0.0';
  static const String targetGrade = 'السنة الرابعة متوسط';
}
