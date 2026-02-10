import 'question_models.dart';

// ==========================================
// نموذج المرحلة - Stage Model
// ==========================================

class StageModel {
  final String id;
  final String unitId;
  final String stageName;
  final String? description;
  final List<BaseQuestion> questions;
  final bool isLocked;
  final bool isCompleted;
  final int starsEarned; // 0-3
  final int bestScore;
  final int order;
  final int attemptsCount;

  const StageModel({
    required this.id,
    required this.unitId,
    required this.stageName,
    this.description,
    this.questions = const [],
    this.isLocked = true,
    this.isCompleted = false,
    this.starsEarned = 0,
    this.bestScore = 0,
    this.order = 0,
    this.attemptsCount = 0,
  });

  /// عدد الأسئلة في المرحلة
  int get totalQuestions => questions.length;

  /// التحقق من توفر المرحلة
  bool get isAvailable => !isLocked;

  /// حساب النجوم من النسبة المئوية
  static int calculateStars(double percentage) {
    if (percentage >= 95) return 3;
    if (percentage >= 80) return 2;
    if (percentage >= 60) return 1;
    return 0;
  }

  /// الحصول على نص التقدم
  String get progressText {
    if (isCompleted) {
      return 'مكتمل - $starsEarned/3 نجوم';
    } else if (isLocked) {
      return 'مقفل';
    } else {
      return 'متاح';
    }
  }

  StageModel copyWith({
    String? id,
    String? unitId,
    String? stageName,
    String? description,
    List<BaseQuestion>? questions,
    bool? isLocked,
    bool? isCompleted,
    int? starsEarned,
    int? bestScore,
    int? order,
    int? attemptsCount,
  }) {
    return StageModel(
      id: id ?? this.id,
      unitId: unitId ?? this.unitId,
      stageName: stageName ?? this.stageName,
      description: description ?? this.description,
      questions: questions ?? this.questions,
      isLocked: isLocked ?? this.isLocked,
      isCompleted: isCompleted ?? this.isCompleted,
      starsEarned: starsEarned ?? this.starsEarned,
      bestScore: bestScore ?? this.bestScore,
      order: order ?? this.order,
      attemptsCount: attemptsCount ?? this.attemptsCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'unitId': unitId,
      'stageName': stageName,
      'description': description,
      'questions': questions.map((q) => q.toJson()).toList(),
      'isLocked': isLocked,
      'isCompleted': isCompleted,
      'starsEarned': starsEarned,
      'bestScore': bestScore,
      'order': order,
      'attemptsCount': attemptsCount,
    };
  }

  factory StageModel.fromJson(Map<String, dynamic> json) {
    return StageModel(
      id: json['id'] as String,
      unitId: json['unitId'] as String,
      stageName: json['stageName'] as String,
      description: json['description'] as String?,
      questions: (json['questions'] as List<dynamic>?)
              ?.map((q) => QuestionFactory.fromJson(q as Map<String, dynamic>))
              .toList() ??
          [],
      isLocked: json['isLocked'] as bool? ?? true,
      isCompleted: json['isCompleted'] as bool? ?? false,
      starsEarned: json['starsEarned'] as int? ?? 0,
      bestScore: json['bestScore'] as int? ?? 0,
      order: json['order'] as int? ?? 0,
      attemptsCount: json['attemptsCount'] as int? ?? 0,
    );
  }
}
