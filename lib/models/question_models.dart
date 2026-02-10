// ==========================================
// نماذج الأسئلة - Question Models
// ==========================================
// يدعم 6 أنواع من الأسئلة:
// 1. MCQ - اختيار متعدد
// 2. TrueFalse - صح أم خطأ
// 3. Ordering - الترتيب
// 4. Matching - المطابقة
// 5. Arrow - الأسهم
// 6. Custom - مخصص

enum QuestionType { mcq, trueFalse, ordering, matching, arrow, custom }

// ==========================================
// الفئة الأساسية المجردة للأسئلة
// ==========================================
abstract class BaseQuestion {
  final String id;
  final String stageId;
  final String question;
  final String? imageUrl;
  final QuestionType type;
  final int points;
  final String? explanation;

  BaseQuestion({
    required this.id,
    required this.stageId,
    required this.question,
    this.imageUrl,
    required this.type,
    this.points = 10,
    this.explanation,
  });

  /// التحقق من صحة الإجابة
  bool checkAnswer(dynamic userAnswer);

  /// تحويل إلى JSON
  Map<String, dynamic> toJson();

  /// التحقق من وجود صورة
  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;
}

// ==========================================
// سؤال الاختيار المتعدد - MCQ Question
// ==========================================
class MCQQuestion extends BaseQuestion {
  final List<String> options;
  final int correctAnswerIndex;

  MCQQuestion({
    required super.id,
    required super.stageId,
    required super.question,
    super.imageUrl,
    super.points,
    super.explanation,
    required this.options,
    required this.correctAnswerIndex,
  }) : super(type: QuestionType.mcq);

  @override
  bool checkAnswer(dynamic userAnswer) {
    if (userAnswer is int) {
      return userAnswer == correctAnswerIndex;
    }
    return false;
  }

  String get correctAnswer => options[correctAnswerIndex];

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stageId': stageId,
      'question': question,
      'imageUrl': imageUrl,
      'type': type.name,
      'points': points,
      'explanation': explanation,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
    };
  }

  factory MCQQuestion.fromJson(Map<String, dynamic> json) {
    return MCQQuestion(
      id: json['id'] as String,
      stageId: json['stageId'] as String,
      question: json['question'] as String,
      imageUrl: json['imageUrl'] as String?,
      points: json['points'] as int? ?? 10,
      explanation: json['explanation'] as String?,
      options: List<String>.from(json['options']),
      correctAnswerIndex: json['correctAnswerIndex'] as int,
    );
  }
}

// ==========================================
// سؤال صح أم خطأ - True/False Question
// ==========================================
class TrueFalseQuestion extends BaseQuestion {
  final bool correctAnswer;

  TrueFalseQuestion({
    required super.id,
    required super.stageId,
    required super.question,
    super.imageUrl,
    super.points,
    super.explanation,
    required this.correctAnswer,
  }) : super(type: QuestionType.trueFalse);

  @override
  bool checkAnswer(dynamic userAnswer) {
    if (userAnswer is bool) {
      return userAnswer == correctAnswer;
    }
    return false;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stageId': stageId,
      'question': question,
      'imageUrl': imageUrl,
      'type': type.name,
      'points': points,
      'explanation': explanation,
      'correctAnswer': correctAnswer,
    };
  }

  factory TrueFalseQuestion.fromJson(Map<String, dynamic> json) {
    return TrueFalseQuestion(
      id: json['id'] as String,
      stageId: json['stageId'] as String,
      question: json['question'] as String,
      imageUrl: json['imageUrl'] as String?,
      points: json['points'] as int? ?? 10,
      explanation: json['explanation'] as String?,
      correctAnswer: json['correctAnswer'] as bool,
    );
  }
}

// ==========================================
// سؤال الترتيب - Ordering Question
// ==========================================
class OrderingQuestion extends BaseQuestion {
  final List<String> items;
  final List<int> correctOrder;

  OrderingQuestion({
    required super.id,
    required super.stageId,
    required super.question,
    super.imageUrl,
    super.points,
    super.explanation,
    required this.items,
    required this.correctOrder,
  }) : super(type: QuestionType.ordering);

  @override
  bool checkAnswer(dynamic userAnswer) {
    if (userAnswer is List<int>) {
      if (userAnswer.length != correctOrder.length) return false;
      for (int i = 0; i < correctOrder.length; i++) {
        if (userAnswer[i] != correctOrder[i]) return false;
      }
      return true;
    }
    return false;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stageId': stageId,
      'question': question,
      'imageUrl': imageUrl,
      'type': type.name,
      'points': points,
      'explanation': explanation,
      'items': items,
      'correctOrder': correctOrder,
    };
  }

  factory OrderingQuestion.fromJson(Map<String, dynamic> json) {
    return OrderingQuestion(
      id: json['id'] as String,
      stageId: json['stageId'] as String,
      question: json['question'] as String,
      imageUrl: json['imageUrl'] as String?,
      points: json['points'] as int? ?? 10,
      explanation: json['explanation'] as String?,
      items: List<String>.from(json['items']),
      correctOrder: List<int>.from(json['correctOrder']),
    );
  }
}

// ==========================================
// سؤال المطابقة - Matching Question
// ==========================================
class MatchingQuestion extends BaseQuestion {
  final List<String> leftItems;
  final List<String> rightItems;
  final Map<int, int> correctMatches;

  MatchingQuestion({
    required super.id,
    required super.stageId,
    required super.question,
    super.imageUrl,
    super.points,
    super.explanation,
    required this.leftItems,
    required this.rightItems,
    required this.correctMatches,
  }) : super(type: QuestionType.matching);

  @override
  bool checkAnswer(dynamic userAnswer) {
    if (userAnswer is Map<int, int>) {
      if (userAnswer.length != correctMatches.length) return false;
      for (final entry in correctMatches.entries) {
        if (userAnswer[entry.key] != entry.value) return false;
      }
      return true;
    }
    return false;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stageId': stageId,
      'question': question,
      'imageUrl': imageUrl,
      'type': type.name,
      'points': points,
      'explanation': explanation,
      'leftItems': leftItems,
      'rightItems': rightItems,
      'correctMatches': correctMatches.map((k, v) => MapEntry(k.toString(), v)),
    };
  }

  factory MatchingQuestion.fromJson(Map<String, dynamic> json) {
    final matchesJson = json['correctMatches'] as Map<String, dynamic>;
    final matches = matchesJson.map((k, v) => MapEntry(int.parse(k), v as int));

    return MatchingQuestion(
      id: json['id'] as String,
      stageId: json['stageId'] as String,
      question: json['question'] as String,
      imageUrl: json['imageUrl'] as String?,
      points: json['points'] as int? ?? 10,
      explanation: json['explanation'] as String?,
      leftItems: List<String>.from(json['leftItems']),
      rightItems: List<String>.from(json['rightItems']),
      correctMatches: matches,
    );
  }
}

// ==========================================
// سؤال الأسهم - Arrow Question
// ==========================================
class ArrowQuestion extends BaseQuestion {
  final List<String> leftItems;
  final List<String> rightItems;
  final Map<int, int> correctConnections;

  ArrowQuestion({
    required super.id,
    required super.stageId,
    required super.question,
    super.imageUrl,
    super.points,
    super.explanation,
    required this.leftItems,
    required this.rightItems,
    required this.correctConnections,
  }) : super(type: QuestionType.arrow);

  @override
  bool checkAnswer(dynamic userAnswer) {
    if (userAnswer is Map<int, int>) {
      if (userAnswer.length != correctConnections.length) return false;
      for (final entry in correctConnections.entries) {
        if (userAnswer[entry.key] != entry.value) return false;
      }
      return true;
    }
    return false;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stageId': stageId,
      'question': question,
      'imageUrl': imageUrl,
      'type': type.name,
      'points': points,
      'explanation': explanation,
      'leftItems': leftItems,
      'rightItems': rightItems,
      'correctConnections':
          correctConnections.map((k, v) => MapEntry(k.toString(), v)),
    };
  }

  factory ArrowQuestion.fromJson(Map<String, dynamic> json) {
    final connectionsJson = json['correctConnections'] as Map<String, dynamic>;
    final connections =
        connectionsJson.map((k, v) => MapEntry(int.parse(k), v as int));

    return ArrowQuestion(
      id: json['id'] as String,
      stageId: json['stageId'] as String,
      question: json['question'] as String,
      imageUrl: json['imageUrl'] as String?,
      points: json['points'] as int? ?? 10,
      explanation: json['explanation'] as String?,
      leftItems: List<String>.from(json['leftItems']),
      rightItems: List<String>.from(json['rightItems']),
      correctConnections: connections,
    );
  }
}

// ==========================================
// سؤال مخصص - Custom Question
// ==========================================
class CustomQuestion extends BaseQuestion {
  final Map<String, dynamic> customData;
  final String correctAnswerKey;

  CustomQuestion({
    required super.id,
    required super.stageId,
    required super.question,
    super.imageUrl,
    super.points,
    super.explanation,
    required this.customData,
    required this.correctAnswerKey,
  }) : super(type: QuestionType.custom);

  @override
  bool checkAnswer(dynamic userAnswer) {
    return userAnswer == customData[correctAnswerKey];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stageId': stageId,
      'question': question,
      'imageUrl': imageUrl,
      'type': type.name,
      'points': points,
      'explanation': explanation,
      'customData': customData,
      'correctAnswerKey': correctAnswerKey,
    };
  }

  factory CustomQuestion.fromJson(Map<String, dynamic> json) {
    return CustomQuestion(
      id: json['id'] as String,
      stageId: json['stageId'] as String,
      question: json['question'] as String,
      imageUrl: json['imageUrl'] as String?,
      points: json['points'] as int? ?? 10,
      explanation: json['explanation'] as String?,
      customData: json['customData'] as Map<String, dynamic>,
      correctAnswerKey: json['correctAnswerKey'] as String,
    );
  }
}

// ==========================================
// مصنع الأسئلة - Question Factory
// ==========================================
class QuestionFactory {
  static BaseQuestion fromJson(Map<String, dynamic> json) {
    final type = QuestionType.values.firstWhere(
      (e) => e.name == json['type'],
      orElse: () => QuestionType.mcq,
    );

    switch (type) {
      case QuestionType.mcq:
        return MCQQuestion.fromJson(json);
      case QuestionType.trueFalse:
        return TrueFalseQuestion.fromJson(json);
      case QuestionType.ordering:
        return OrderingQuestion.fromJson(json);
      case QuestionType.matching:
        return MatchingQuestion.fromJson(json);
      case QuestionType.arrow:
        return ArrowQuestion.fromJson(json);
      case QuestionType.custom:
        return CustomQuestion.fromJson(json);
    }
  }
}
