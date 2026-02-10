import 'question_models.dart';

// ==========================================
// نموذج التحدي اليومي - Daily Challenge Model
// ==========================================

class DailyChallengeModel {
  final String id;
  final DateTime date;
  final List<BaseQuestion> questions;
  final bool isCompleted;
  final int score;
  final int xpEarned;
  final int correctAnswers;
  final Duration? timeSpent;

  const DailyChallengeModel({
    required this.id,
    required this.date,
    required this.questions,
    this.isCompleted = false,
    this.score = 0,
    this.xpEarned = 0,
    this.correctAnswers = 0,
    this.timeSpent,
  });

  /// عدد الأسئلة الكلي
  int get totalQuestions => questions.length;

  /// النسبة المئوية
  double get percentage {
    if (totalQuestions == 0) return 0;
    return (correctAnswers / totalQuestions) * 100;
  }

  /// التحقق مما إذا كان التحدي متاحاً اليوم
  bool get isAvailableToday {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// التحقق مما إذا كان التحدي منتهي الصلاحية
  bool get isExpired {
    final now = DateTime.now();
    final challengeDate = DateTime(date.year, date.month, date.day);
    final today = DateTime(now.year, now.month, now.day);
    return challengeDate.isBefore(today);
  }

  DailyChallengeModel copyWith({
    String? id,
    DateTime? date,
    List<BaseQuestion>? questions,
    bool? isCompleted,
    int? score,
    int? xpEarned,
    int? correctAnswers,
    Duration? timeSpent,
  }) {
    return DailyChallengeModel(
      id: id ?? this.id,
      date: date ?? this.date,
      questions: questions ?? this.questions,
      isCompleted: isCompleted ?? this.isCompleted,
      score: score ?? this.score,
      xpEarned: xpEarned ?? this.xpEarned,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      timeSpent: timeSpent ?? this.timeSpent,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'questions': questions.map((q) => q.toJson()).toList(),
      'isCompleted': isCompleted,
      'score': score,
      'xpEarned': xpEarned,
      'correctAnswers': correctAnswers,
      'timeSpent': timeSpent?.inSeconds,
    };
  }

  factory DailyChallengeModel.fromJson(Map<String, dynamic> json) {
    return DailyChallengeModel(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      questions: (json['questions'] as List<dynamic>)
          .map((q) => QuestionFactory.fromJson(q as Map<String, dynamic>))
          .toList(),
      isCompleted: json['isCompleted'] as bool? ?? false,
      score: json['score'] as int? ?? 0,
      xpEarned: json['xpEarned'] as int? ?? 0,
      correctAnswers: json['correctAnswers'] as int? ?? 0,
      timeSpent: json['timeSpent'] != null
          ? Duration(seconds: json['timeSpent'] as int)
          : null,
    );
  }
}
