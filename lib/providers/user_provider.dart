import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/achievement.dart';
import '../services/storage_service.dart';

class UserProvider extends ChangeNotifier {
  User _user = User();
  List<Achievement> _achievements = Achievement.defaultAchievements;

  User get user => _user;
  List<Achievement> get achievements => _achievements;
  List<Achievement> get unlockedAchievements =>
      _achievements.where((a) => a.unlocked).toList();

  UserProvider() {
    _loadUser();
  }

  void _loadUser() {
    _user = User(
      name: StorageService.getUserName(),
      xp: StorageService.getUserXP(),
      streak: StorageService.getUserStreak(),
    );

    // Load unlocked achievements
    final unlockedIds = StorageService.getUnlockedAchievements();
    _achievements = Achievement.defaultAchievements.map((a) {
      if (unlockedIds.contains(a.id)) {
        return a.copyWith(unlocked: true);
      }
      return a;
    }).toList();

    notifyListeners();
  }

  Future<void> updateName(String name) async {
    _user = _user.copyWith(name: name);
    await StorageService.setUserName(name);
    notifyListeners();
  }

  Future<void> addXP(int amount) async {
    _user = _user.copyWith(xp: _user.xp + amount);
    await StorageService.setUserXP(_user.xp);
    await _checkXPAchievements();
    notifyListeners();
  }

  Future<void> incrementStreak() async {
    _user = _user.copyWith(streak: _user.streak + 1);
    await StorageService.setUserStreak(_user.streak);
    await _checkStreakAchievements();
    notifyListeners();
  }

  Future<void> resetStreak() async {
    _user = _user.copyWith(streak: 0);
    await StorageService.setUserStreak(0);
    notifyListeners();
  }

  Future<void> completeLesson({bool isPerfect = false}) async {
    _user = _user.copyWith(
      lessonsCompleted: _user.lessonsCompleted + 1,
      perfectLessons: isPerfect ? _user.perfectLessons + 1 : _user.perfectLessons,
    );

    if (_user.lessonsCompleted == 1) {
      await unlockAchievement('first_lesson');
    }

    if (isPerfect && _user.perfectLessons >= 5) {
      await unlockAchievement('perfect_5');
    }

    notifyListeners();
  }

  Future<void> unlockAchievement(String achievementId) async {
    final index = _achievements.indexWhere((a) => a.id == achievementId);
    if (index != -1 && !_achievements[index].unlocked) {
      _achievements[index] = _achievements[index].copyWith(
        unlocked: true,
        unlockedAt: DateTime.now(),
      );
      await StorageService.unlockAchievement(achievementId);
      await addXP(_achievements[index].xpReward);
      notifyListeners();
    }
  }

  Future<void> _checkStreakAchievements() async {
    if (_user.streak >= 3) {
      await unlockAchievement('streak_3');
    }
    if (_user.streak >= 7) {
      await unlockAchievement('streak_7');
    }
  }

  Future<void> _checkXPAchievements() async {
    if (_user.xp >= 500) {
      await unlockAchievement('xp_500');
    }
  }
}
