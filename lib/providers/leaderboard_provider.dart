import 'package:flutter/foundation.dart';
import '../models/leaderboard_model.dart';

// ==========================================
// مزود لوحة المتصدرين - Leaderboard Provider
// ==========================================

class LeaderboardProvider extends ChangeNotifier {
  Leaderboard? _nationalLeaderboard;
  Leaderboard? _wilayaLeaderboard;
  Leaderboard? _streakLeaderboard;
  LeaderboardType _currentType = LeaderboardType.national;
  String? _selectedWilaya;
  bool _isLoading = false;

  // لوحة المتصدرين الوطنية
  Leaderboard? get nationalLeaderboard => _nationalLeaderboard;

  // لوحة المتصدرين حسب الولاية
  Leaderboard? get wilayaLeaderboard => _wilayaLeaderboard;

  // لوحة متصدرين السلسلة
  Leaderboard? get streakLeaderboard => _streakLeaderboard;

  // النوع الحالي
  LeaderboardType get currentType => _currentType;

  // الولاية المحددة
  String? get selectedWilaya => _selectedWilaya;

  // حالة التحميل
  bool get isLoading => _isLoading;

  // لوحة المتصدرين الحالية
  Leaderboard? get currentLeaderboard {
    switch (_currentType) {
      case LeaderboardType.national:
        return _nationalLeaderboard;
      case LeaderboardType.wilaya:
        return _wilayaLeaderboard;
      case LeaderboardType.streak:
        return _streakLeaderboard;
    }
  }

  // تغيير نوع لوحة المتصدرين
  void setLeaderboardType(LeaderboardType type) {
    _currentType = type;
    notifyListeners();
  }

  // تحديد الولاية
  void setWilaya(String wilaya) {
    _selectedWilaya = wilaya;
    // TODO: تحميل لوحة المتصدرين للولاية
    notifyListeners();
  }

  // تحميل لوحة المتصدرين الوطنية
  Future<void> loadNationalLeaderboard() async {
    _isLoading = true;
    notifyListeners();

    // TODO: تحميل من Firebase
    await Future.delayed(const Duration(milliseconds: 500));

    _nationalLeaderboard = Leaderboard(
      type: LeaderboardType.national,
      entries: [], // سيتم ملؤها من Firebase
      lastUpdated: DateTime.now(),
    );

    _isLoading = false;
    notifyListeners();
  }

  // تحميل لوحة المتصدرين حسب الولاية
  Future<void> loadWilayaLeaderboard(String wilaya) async {
    _isLoading = true;
    _selectedWilaya = wilaya;
    notifyListeners();

    // TODO: تحميل من Firebase
    await Future.delayed(const Duration(milliseconds: 500));

    _wilayaLeaderboard = Leaderboard(
      type: LeaderboardType.wilaya,
      wilayaFilter: wilaya,
      entries: [], // سيتم ملؤها من Firebase
      lastUpdated: DateTime.now(),
    );

    _isLoading = false;
    notifyListeners();
  }

  // تحميل لوحة متصدرين السلسلة
  Future<void> loadStreakLeaderboard() async {
    _isLoading = true;
    notifyListeners();

    // TODO: تحميل من Firebase
    await Future.delayed(const Duration(milliseconds: 500));

    _streakLeaderboard = Leaderboard(
      type: LeaderboardType.streak,
      entries: [], // سيتم ملؤها من Firebase
      lastUpdated: DateTime.now(),
    );

    _isLoading = false;
    notifyListeners();
  }

  // الحصول على ترتيب المستخدم
  int? getUserRank(String userId) {
    return currentLeaderboard?.findUser(userId)?.rank;
  }
}
