// ==========================================
// نموذج إحصائيات الأسئلة - Question Stats Model
// ==========================================

class QuestionStatsModel {
  final String questionId;
  final int timesAnswered;
  final int timesCorrect;
  final DateTime? lastAnswered;
  final int streak; // عدد الإجابات الصحيحة المتتالية

  const QuestionStatsModel({
    required this.questionId,
    this.timesAnswered = 0,
    this.timesCorrect = 0,
    this.lastAnswered,
    this.streak = 0,
  });

  /// حساب نسبة الدقة
  double get accuracy {
    if (timesAnswered == 0) return 0;
    return (timesCorrect / timesAnswered) * 100;
  }

  /// عدد الإجابات الخاطئة
  int get timesWrong => timesAnswered - timesCorrect;

  /// التحقق مما إذا كان السؤال متقناً (دقة > 80%)
  bool get isMastered => accuracy >= 80 && timesAnswered >= 3;

  /// التحقق مما إذا كان السؤال يحتاج مراجعة
  bool get needsReview => accuracy < 60 && timesAnswered >= 2;

  QuestionStatsModel copyWith({
    String? questionId,
    int? timesAnswered,
    int? timesCorrect,
    DateTime? lastAnswered,
    int? streak,
  }) {
    return QuestionStatsModel(
      questionId: questionId ?? this.questionId,
      timesAnswered: timesAnswered ?? this.timesAnswered,
      timesCorrect: timesCorrect ?? this.timesCorrect,
      lastAnswered: lastAnswered ?? this.lastAnswered,
      streak: streak ?? this.streak,
    );
  }

  /// تسجيل إجابة جديدة
  QuestionStatsModel recordAnswer(bool isCorrect) {
    return QuestionStatsModel(
      questionId: questionId,
      timesAnswered: timesAnswered + 1,
      timesCorrect: isCorrect ? timesCorrect + 1 : timesCorrect,
      lastAnswered: DateTime.now(),
      streak: isCorrect ? streak + 1 : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'timesAnswered': timesAnswered,
      'timesCorrect': timesCorrect,
      'lastAnswered': lastAnswered?.toIso8601String(),
      'streak': streak,
    };
  }

  factory QuestionStatsModel.fromJson(Map<String, dynamic> json) {
    return QuestionStatsModel(
      questionId: json['questionId'] as String,
      timesAnswered: json['timesAnswered'] as int? ?? 0,
      timesCorrect: json['timesCorrect'] as int? ?? 0,
      lastAnswered: json['lastAnswered'] != null
          ? DateTime.parse(json['lastAnswered'] as String)
          : null,
      streak: json['streak'] as int? ?? 0,
    );
  }
}
