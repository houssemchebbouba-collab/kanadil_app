// ==========================================
// نموذج المستخدم - User Model
// ==========================================

class UserModel {
  final String id;
  final String name;
  final String wilaya;
  final int totalXP;
  final int streakDays;
  final DateTime lastActiveDate;
  final List<String> achievements;
  final String? avatarUrl;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.wilaya,
    this.totalXP = 0,
    this.streakDays = 0,
    required this.lastActiveDate,
    this.achievements = const [],
    this.avatarUrl,
    required this.createdAt,
  });

  /// حساب المستوى من نقاط الخبرة
  int get level => (totalXP / 500).floor() + 1;

  /// حساب التقدم نحو المستوى التالي
  double get levelProgress => (totalXP % 500) / 500;

  /// نقاط الخبرة المطلوبة للمستوى التالي
  int get xpForNextLevel => 500 - (totalXP % 500);

  /// عدد الإنجازات
  int get achievementsCount => achievements.length;

  /// التحقق من نشاط المستخدم اليوم
  bool get isActiveToday {
    final now = DateTime.now();
    return lastActiveDate.year == now.year &&
        lastActiveDate.month == now.month &&
        lastActiveDate.day == now.day;
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? wilaya,
    int? totalXP,
    int? streakDays,
    DateTime? lastActiveDate,
    List<String>? achievements,
    String? avatarUrl,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      wilaya: wilaya ?? this.wilaya,
      totalXP: totalXP ?? this.totalXP,
      streakDays: streakDays ?? this.streakDays,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
      achievements: achievements ?? this.achievements,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'wilaya': wilaya,
      'totalXP': totalXP,
      'streakDays': streakDays,
      'lastActiveDate': lastActiveDate.toIso8601String(),
      'achievements': achievements,
      'avatarUrl': avatarUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      wilaya: json['wilaya'] as String,
      totalXP: json['totalXP'] as int? ?? 0,
      streakDays: json['streakDays'] as int? ?? 0,
      lastActiveDate: DateTime.parse(json['lastActiveDate'] as String),
      achievements: List<String>.from(json['achievements'] ?? []),
      avatarUrl: json['avatarUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  /// إنشاء مستخدم جديد
  factory UserModel.newUser({
    required String name,
    required String wilaya,
  }) {
    final now = DateTime.now();
    return UserModel(
      id: 'user_${now.millisecondsSinceEpoch}',
      name: name,
      wilaya: wilaya,
      totalXP: 0,
      streakDays: 0,
      lastActiveDate: now,
      achievements: [],
      avatarUrl: null,
      createdAt: now,
    );
  }
}
