// ==========================================
// نموذج تقدم الاختبار - Quiz Progress Model
// ==========================================

class QuizProgressModel {
  final String id;
  final String userId;
  final String subjectId;
  final String unitId;
  final String stageId;
  final int correctAnswers;
  final int totalQuestions;
  final int starsEarned;
  final int xpEarned;
  final int attemptNumber;
  final Duration? timeSpent;
  final DateTime completedAt;
  final List<String> answeredQuestionIds;
  final Map<String, bool> answerResults; // questionId -> isCorrect

  const QuizProgressModel({
    required this.id,
    required this.userId,
    required this.subjectId,
    required this.unitId,
    required this.stageId,
    this.correctAnswers = 0,
    this.totalQuestions = 0,
    this.starsEarned = 0,
    this.xpEarned = 0,
    this.attemptNumber = 1,
    this.timeSpent,
    required this.completedAt,
    this.answeredQuestionIds = const [],
    this.answerResults = const {},
  });

  /// حساب النسبة المئوية
  double get percentage {
    if (totalQuestions == 0) return 0;
    return (correctAnswers / totalQuestions) * 100;
  }

  /// التحقق من النجاح (60%+)
  bool get isPassed => percentage >= 60;

  /// التحقق من الإتقان (95%+)
  bool get isMastered => percentage >= 95;

  /// تنسيق الوقت المستغرق
  String get formattedTime {
    if (timeSpent == null) return '--:--';
    final minutes = timeSpent!.inMinutes;
    final seconds = timeSpent!.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  QuizProgressModel copyWith({
    String? id,
    String? userId,
    String? subjectId,
    String? unitId,
    String? stageId,
    int? correctAnswers,
    int? totalQuestions,
    int? starsEarned,
    int? xpEarned,
    int? attemptNumber,
    Duration? timeSpent,
    DateTime? completedAt,
    List<String>? answeredQuestionIds,
    Map<String, bool>? answerResults,
  }) {
    return QuizProgressModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      subjectId: subjectId ?? this.subjectId,
      unitId: unitId ?? this.unitId,
      stageId: stageId ?? this.stageId,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      starsEarned: starsEarned ?? this.starsEarned,
      xpEarned: xpEarned ?? this.xpEarned,
      attemptNumber: attemptNumber ?? this.attemptNumber,
      timeSpent: timeSpent ?? this.timeSpent,
      completedAt: completedAt ?? this.completedAt,
      answeredQuestionIds: answeredQuestionIds ?? this.answeredQuestionIds,
      answerResults: answerResults ?? this.answerResults,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'subjectId': subjectId,
      'unitId': unitId,
      'stageId': stageId,
      'correctAnswers': correctAnswers,
      'totalQuestions': totalQuestions,
      'starsEarned': starsEarned,
      'xpEarned': xpEarned,
      'attemptNumber': attemptNumber,
      'timeSpent': timeSpent?.inSeconds,
      'completedAt': completedAt.toIso8601String(),
      'answeredQuestionIds': answeredQuestionIds,
      'answerResults': answerResults,
    };
  }

  factory QuizProgressModel.fromJson(Map<String, dynamic> json) {
    return QuizProgressModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      subjectId: json['subjectId'] as String,
      unitId: json['unitId'] as String,
      stageId: json['stageId'] as String,
      correctAnswers: json['correctAnswers'] as int? ?? 0,
      totalQuestions: json['totalQuestions'] as int? ?? 0,
      starsEarned: json['starsEarned'] as int? ?? 0,
      xpEarned: json['xpEarned'] as int? ?? 0,
      attemptNumber: json['attemptNumber'] as int? ?? 1,
      timeSpent: json['timeSpent'] != null
          ? Duration(seconds: json['timeSpent'] as int)
          : null,
      completedAt: DateTime.parse(json['completedAt'] as String),
      answeredQuestionIds:
          List<String>.from(json['answeredQuestionIds'] ?? []),
      answerResults: Map<String, bool>.from(json['answerResults'] ?? {}),
    );
  }

  /// إنشاء تقدم جديد
  factory QuizProgressModel.start({
    required String userId,
    required String subjectId,
    required String unitId,
    required String stageId,
    required int totalQuestions,
  }) {
    return QuizProgressModel(
      id: 'progress_${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      subjectId: subjectId,
      unitId: unitId,
      stageId: stageId,
      totalQuestions: totalQuestions,
      completedAt: DateTime.now(),
    );
  }
}
