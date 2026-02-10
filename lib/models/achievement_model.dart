// ==========================================
// نموذج الإنجاز - Achievement Model
// ==========================================

enum AchievementCategory {
  streak,     // سلسلة التعلم
  xp,         // نقاط الخبرة
  subjects,   // المواد
  quizzes,    // الاختبارات
  special,    // خاص
}

class AchievementModel {
  final String id;
  final String title;
  final String arabicTitle;
  final String description;
  final String arabicDescription;
  final String iconPath;
  final AchievementCategory category;
  final int targetValue;
  final int currentValue;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final int xpReward;

  const AchievementModel({
    required this.id,
    required this.title,
    required this.arabicTitle,
    required this.description,
    required this.arabicDescription,
    required this.iconPath,
    required this.category,
    this.targetValue = 1,
    this.currentValue = 0,
    this.isUnlocked = false,
    this.unlockedAt,
    this.xpReward = 50,
  });

  /// نسبة التقدم نحو الإنجاز
  double get progress {
    if (targetValue == 0) return 0;
    return (currentValue / targetValue).clamp(0.0, 1.0);
  }

  /// التحقق مما إذا كان الإنجاز قابل للفتح
  bool get canUnlock => currentValue >= targetValue && !isUnlocked;

  AchievementModel copyWith({
    String? id,
    String? title,
    String? arabicTitle,
    String? description,
    String? arabicDescription,
    String? iconPath,
    AchievementCategory? category,
    int? targetValue,
    int? currentValue,
    bool? isUnlocked,
    DateTime? unlockedAt,
    int? xpReward,
  }) {
    return AchievementModel(
      id: id ?? this.id,
      title: title ?? this.title,
      arabicTitle: arabicTitle ?? this.arabicTitle,
      description: description ?? this.description,
      arabicDescription: arabicDescription ?? this.arabicDescription,
      iconPath: iconPath ?? this.iconPath,
      category: category ?? this.category,
      targetValue: targetValue ?? this.targetValue,
      currentValue: currentValue ?? this.currentValue,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      xpReward: xpReward ?? this.xpReward,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'arabicTitle': arabicTitle,
      'description': description,
      'arabicDescription': arabicDescription,
      'iconPath': iconPath,
      'category': category.name,
      'targetValue': targetValue,
      'currentValue': currentValue,
      'isUnlocked': isUnlocked,
      'unlockedAt': unlockedAt?.toIso8601String(),
      'xpReward': xpReward,
    };
  }

  factory AchievementModel.fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      id: json['id'] as String,
      title: json['title'] as String,
      arabicTitle: json['arabicTitle'] as String,
      description: json['description'] as String,
      arabicDescription: json['arabicDescription'] as String,
      iconPath: json['iconPath'] as String,
      category: AchievementCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => AchievementCategory.special,
      ),
      targetValue: json['targetValue'] as int? ?? 1,
      currentValue: json['currentValue'] as int? ?? 0,
      isUnlocked: json['isUnlocked'] as bool? ?? false,
      unlockedAt: json['unlockedAt'] != null
          ? DateTime.parse(json['unlockedAt'] as String)
          : null,
      xpReward: json['xpReward'] as int? ?? 50,
    );
  }
}
