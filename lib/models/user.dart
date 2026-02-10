class User {
  final String name;
  final int xp;
  final int streak;
  final int lessonsCompleted;
  final int perfectLessons;
  final int totalStars;
  final DateTime? lastActiveDate;

  User({
    this.name = 'متعلم',
    this.xp = 0,
    this.streak = 0,
    this.lessonsCompleted = 0,
    this.perfectLessons = 0,
    this.totalStars = 0,
    this.lastActiveDate,
  });

  int get level => (xp / 100).floor() + 1;
  int get xpInCurrentLevel => xp % 100;
  int get xpForNextLevel => 100;
  double get levelProgress => xpInCurrentLevel / xpForNextLevel;

  User copyWith({
    String? name,
    int? xp,
    int? streak,
    int? lessonsCompleted,
    int? perfectLessons,
    int? totalStars,
    DateTime? lastActiveDate,
  }) {
    return User(
      name: name ?? this.name,
      xp: xp ?? this.xp,
      streak: streak ?? this.streak,
      lessonsCompleted: lessonsCompleted ?? this.lessonsCompleted,
      perfectLessons: perfectLessons ?? this.perfectLessons,
      totalStars: totalStars ?? this.totalStars,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'xp': xp,
      'streak': streak,
      'lessonsCompleted': lessonsCompleted,
      'perfectLessons': perfectLessons,
      'totalStars': totalStars,
      'lastActiveDate': lastActiveDate?.toIso8601String(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? 'متعلم',
      xp: json['xp'] ?? 0,
      streak: json['streak'] ?? 0,
      lessonsCompleted: json['lessonsCompleted'] ?? 0,
      perfectLessons: json['perfectLessons'] ?? 0,
      totalStars: json['totalStars'] ?? 0,
      lastActiveDate: json['lastActiveDate'] != null
          ? DateTime.parse(json['lastActiveDate'])
          : null,
    );
  }
}
