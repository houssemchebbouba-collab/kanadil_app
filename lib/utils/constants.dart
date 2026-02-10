class AppConstants {
  // App info
  static const String appName = 'Kanadil';
  static const String appNameArabic = 'كناديل';

  // Storage keys
  static const String keyDarkMode = 'dark_mode';
  static const String keyUserName = 'user_name';
  static const String keyUserXP = 'user_xp';
  static const String keyUserStreak = 'user_streak';
  static const String keyCompletedLessons = 'completed_lessons';
  static const String keyUnlockedAchievements = 'unlocked_achievements';

  // XP values
  static const int xpPerLesson = 10;
  static const int xpPerPerfectLesson = 15;
  static const int xpPerStreak = 5;

  // Animation durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);

  // Layout
  static const double cardBorderRadius = 16.0;
  static const double buttonBorderRadius = 12.0;
  static const double islandSize = 70.0;
  static const double islandSpacing = 100.0;

  // Subject names in Arabic
  static const Map<String, String> subjectNames = {
    'math': 'الرياضيات',
    'arabic': 'اللغة العربية',
    'french': 'اللغة الفرنسية',
    'science': 'العلوم الطبيعية',
    'history': 'التاريخ',
    'geography': 'الجغرافيا',
    'islamic': 'التربية الإسلامية',
    'civics': 'التربية المدنية',
  };

  // Grade levels
  static const List<String> gradeLevels = [
    'السنة الأولى ابتدائي',
    'السنة الثانية ابتدائي',
    'السنة الثالثة ابتدائي',
    'السنة الرابعة ابتدائي',
    'السنة الخامسة ابتدائي',
  ];
}
