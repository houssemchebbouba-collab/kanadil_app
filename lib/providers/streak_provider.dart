import 'package:flutter/foundation.dart';
import '../core/constants/app_constants.dart';
import '../core/utils/date_helper.dart';
import '../services/storage_service.dart';

// ==========================================
// مزود السلسلة - Streak Provider
// ==========================================

class StreakProvider extends ChangeNotifier {
  int _currentStreak = 0;
  int _longestStreak = 0;
  DateTime? _lastActiveDate;
  bool _hasPlayedToday = false;

  // السلسلة الحالية
  int get currentStreak => _currentStreak;

  // أطول سلسلة
  int get longestStreak => _longestStreak;

  // آخر تاريخ نشاط
  DateTime? get lastActiveDate => _lastActiveDate;

  // هل لعب اليوم
  bool get hasPlayedToday => _hasPlayedToday;

  // مستوى السلسلة
  String get streakLevel {
    if (_currentStreak >= AppConstants.streakGold) return 'ذهبي';
    if (_currentStreak >= AppConstants.streakSilver) return 'فضي';
    if (_currentStreak >= AppConstants.streakBronze) return 'برونزي';
    return 'مبتدئ';
  }

  // أيقونة السلسلة
  String get streakIcon {
    if (_currentStreak >= AppConstants.streakGold) return '🏆';
    if (_currentStreak >= AppConstants.streakSilver) return '🥈';
    if (_currentStreak >= AppConstants.streakBronze) return '🥉';
    return '🔥';
  }

  // نقاط المكافأة
  int get bonusXP {
    if (_currentStreak >= AppConstants.streakGold) {
      return AppConstants.xpForDailyStreak * 3;
    }
    if (_currentStreak >= AppConstants.streakSilver) {
      return AppConstants.xpForDailyStreak * 2;
    }
    if (_currentStreak >= AppConstants.streakBronze) {
      return AppConstants.xpForDailyStreak;
    }
    return 0;
  }

  // تحميل بيانات السلسلة
  Future<void> loadStreak() async {
    final storage = StorageService();

    _currentStreak = await storage.getInt('current_streak') ?? 0;
    _longestStreak = await storage.getInt('longest_streak') ?? 0;

    final lastDateStr = await storage.getString('last_active_date');
    if (lastDateStr != null) {
      _lastActiveDate = DateTime.tryParse(lastDateStr);
    }

    _checkStreakStatus();
    notifyListeners();
  }

  // التحقق من حالة السلسلة
  void _checkStreakStatus() {
    if (_lastActiveDate == null) {
      _hasPlayedToday = false;
      return;
    }

    if (DateHelper.isToday(_lastActiveDate!)) {
      // لعب اليوم
      _hasPlayedToday = true;
    } else if (DateHelper.isYesterday(_lastActiveDate!)) {
      // لعب أمس - السلسلة مستمرة لكن لم يلعب اليوم
      _hasPlayedToday = false;
    } else {
      // فاته أكثر من يوم - السلسلة انتهت
      _currentStreak = 0;
      _hasPlayedToday = false;
    }
  }

  // تسجيل نشاط اليوم
  Future<void> recordActivity() async {
    if (_hasPlayedToday) return;

    final now = DateTime.now();

    if (_lastActiveDate == null || DateHelper.isYesterday(_lastActiveDate!)) {
      // استمرار السلسلة
      _currentStreak++;
    } else if (!DateHelper.isToday(_lastActiveDate!)) {
      // بداية سلسلة جديدة
      _currentStreak = 1;
    }

    // تحديث أطول سلسلة
    if (_currentStreak > _longestStreak) {
      _longestStreak = _currentStreak;
    }

    _lastActiveDate = now;
    _hasPlayedToday = true;

    // حفظ البيانات
    final storage = StorageService();
    await storage.setInt('current_streak', _currentStreak);
    await storage.setInt('longest_streak', _longestStreak);
    await storage.setString('last_active_date', now.toIso8601String());

    notifyListeners();
  }

  // إعادة تعيين السلسلة
  Future<void> resetStreak() async {
    _currentStreak = 0;
    _hasPlayedToday = false;

    final storage = StorageService();
    await storage.setInt('current_streak', 0);

    notifyListeners();
  }
}
