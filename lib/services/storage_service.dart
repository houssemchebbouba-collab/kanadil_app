import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// ==========================================
// خدمة التخزين المحلي - Storage Service
// ==========================================
// يستخدم SharedPreferences لتخزين البيانات محلياً

class StorageService {
  static SharedPreferences? _prefs;

  // تهيئة الخدمة
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // الحصول على مثيل SharedPreferences
  Future<SharedPreferences> get _preferences async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  static SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception('StorageService not initialized. Call init() first.');
    }
    return _prefs!;
  }

  // ==========================================
  // عمليات String
  // ==========================================
  Future<String?> getString(String key) async {
    final prefs = await _preferences;
    return prefs.getString(key);
  }

  Future<bool> setString(String key, String value) async {
    final prefs = await _preferences;
    return prefs.setString(key, value);
  }

  // ==========================================
  // عمليات Int
  // ==========================================
  Future<int?> getInt(String key) async {
    final prefs = await _preferences;
    return prefs.getInt(key);
  }

  Future<bool> setInt(String key, int value) async {
    final prefs = await _preferences;
    return prefs.setInt(key, value);
  }

  // ==========================================
  // عمليات Double
  // ==========================================
  Future<double?> getDouble(String key) async {
    final prefs = await _preferences;
    return prefs.getDouble(key);
  }

  Future<bool> setDouble(String key, double value) async {
    final prefs = await _preferences;
    return prefs.setDouble(key, value);
  }

  // ==========================================
  // عمليات Bool
  // ==========================================
  Future<bool?> getBool(String key) async {
    final prefs = await _preferences;
    return prefs.getBool(key);
  }

  Future<bool> setBool(String key, bool value) async {
    final prefs = await _preferences;
    return prefs.setBool(key, value);
  }

  // ==========================================
  // عمليات قديمة (للتوافقية)
  // ==========================================
  static bool getDarkMode() {
    return prefs.getBool('dark_mode') ?? false;
  }

  static Future<void> setDarkMode(bool value) async {
    await prefs.setBool('dark_mode', value);
  }

  static String getUserName() {
    return prefs.getString('user_name') ?? 'متعلم';
  }

  static Future<void> setUserName(String name) async {
    await prefs.setString('user_name', name);
  }

  static int getUserXP() {
    return prefs.getInt('user_xp') ?? 0;
  }

  static Future<void> setUserXP(int xp) async {
    await prefs.setInt('user_xp', xp);
  }

  static int getUserStreak() {
    return prefs.getInt('user_streak') ?? 0;
  }

  static Future<void> setUserStreak(int streak) async {
    await prefs.setInt('user_streak', streak);
  }

  static List<String> getCompletedLessons() {
    final String? data = prefs.getString('completed_lessons');
    if (data == null) return [];
    return List<String>.from(jsonDecode(data));
  }

  static Future<void> setCompletedLessons(List<String> lessons) async {
    await prefs.setString('completed_lessons', jsonEncode(lessons));
  }

  static Future<void> addCompletedLesson(String lessonId) async {
    final lessons = getCompletedLessons();
    if (!lessons.contains(lessonId)) {
      lessons.add(lessonId);
      await setCompletedLessons(lessons);
    }
  }

  static List<String> getUnlockedAchievements() {
    final String? data = prefs.getString('unlocked_achievements');
    if (data == null) return [];
    return List<String>.from(jsonDecode(data));
  }

  static Future<void> setUnlockedAchievements(List<String> achievements) async {
    await prefs.setString('unlocked_achievements', jsonEncode(achievements));
  }

  static Future<void> unlockAchievement(String achievementId) async {
    final achievements = getUnlockedAchievements();
    if (!achievements.contains(achievementId)) {
      achievements.add(achievementId);
      await setUnlockedAchievements(achievements);
    }
  }

  // ==========================================
  // عمليات عامة
  // ==========================================
  Future<bool> remove(String key) async {
    final prefs = await _preferences;
    return prefs.remove(key);
  }

  Future<bool> clear() async {
    final prefs = await _preferences;
    return prefs.clear();
  }

  static Future<void> clearAll() async {
    await prefs.clear();
  }

  // ==========================================
  // مفاتيح التخزين الثابتة
  // ==========================================
  static const String keyUser = 'user_data';
  static const String keySettings = 'settings';
  static const String keyProgress = 'user_progress';
  static const String keyAchievements = 'achievements';
  static const String keyStreak = 'streak_data';
  static const String keyOnboardingComplete = 'onboarding_complete';
  static const String keyLastSync = 'last_sync';
}
