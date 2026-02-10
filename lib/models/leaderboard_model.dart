// ==========================================
// نموذج لوحة المتصدرين - Leaderboard Model
// ==========================================

enum LeaderboardType { wilaya, national, streak }

class LeaderboardEntry {
  final String userId;
  final String userName;
  final String? wilaya;
  final int totalXP;
  final int streakDays;
  final int rank;
  final String? avatarUrl;

  const LeaderboardEntry({
    required this.userId,
    required this.userName,
    this.wilaya,
    required this.totalXP,
    this.streakDays = 0,
    required this.rank,
    this.avatarUrl,
  });

  /// الحصول على المستوى
  int get level => (totalXP / 500).floor() + 1;

  /// التحقق من المراكز الثلاثة الأولى
  bool get isTopThree => rank <= 3;

  /// الحصول على لون الترتيب
  String get rankBadge {
    switch (rank) {
      case 1:
        return '🥇';
      case 2:
        return '🥈';
      case 3:
        return '🥉';
      default:
        return '$rank';
    }
  }

  LeaderboardEntry copyWith({
    String? userId,
    String? userName,
    String? wilaya,
    int? totalXP,
    int? streakDays,
    int? rank,
    String? avatarUrl,
  }) {
    return LeaderboardEntry(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      wilaya: wilaya ?? this.wilaya,
      totalXP: totalXP ?? this.totalXP,
      streakDays: streakDays ?? this.streakDays,
      rank: rank ?? this.rank,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'wilaya': wilaya,
      'totalXP': totalXP,
      'streakDays': streakDays,
      'rank': rank,
      'avatarUrl': avatarUrl,
    };
  }

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      wilaya: json['wilaya'] as String?,
      totalXP: json['totalXP'] as int,
      streakDays: json['streakDays'] as int? ?? 0,
      rank: json['rank'] as int,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }
}

// ==========================================
// نموذج لوحة المتصدرين الكاملة
// ==========================================
class Leaderboard {
  final LeaderboardType type;
  final String? wilayaFilter;
  final List<LeaderboardEntry> entries;
  final DateTime lastUpdated;

  const Leaderboard({
    required this.type,
    this.wilayaFilter,
    required this.entries,
    required this.lastUpdated,
  });

  /// الحصول على أفضل 10
  List<LeaderboardEntry> get topTen => entries.take(10).toList();

  /// الحصول على أفضل 3
  List<LeaderboardEntry> get topThree => entries.take(3).toList();

  /// البحث عن مستخدم معين
  LeaderboardEntry? findUser(String userId) {
    try {
      return entries.firstWhere((e) => e.userId == userId);
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'wilayaFilter': wilayaFilter,
      'entries': entries.map((e) => e.toJson()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  factory Leaderboard.fromJson(Map<String, dynamic> json) {
    return Leaderboard(
      type: LeaderboardType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => LeaderboardType.national,
      ),
      wilayaFilter: json['wilayaFilter'] as String?,
      entries: (json['entries'] as List<dynamic>)
          .map((e) => LeaderboardEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }
}
