enum QuestionType {
  multipleChoice,
  trueFalse,
  fillInBlank,
  matching,
  ordering,
}

class Question {
  final String id;
  final String lessonId;
  final QuestionType type;
  final String questionText;
  final String questionTextArabic;
  final List<String> options;
  final List<String> optionsArabic;
  final dynamic correctAnswer; // Can be int, bool, String, or List depending on type
  final String? explanation;
  final String? explanationArabic;
  final String? imageUrl;

  Question({
    required this.id,
    required this.lessonId,
    required this.type,
    required this.questionText,
    required this.questionTextArabic,
    this.options = const [],
    this.optionsArabic = const [],
    required this.correctAnswer,
    this.explanation,
    this.explanationArabic,
    this.imageUrl,
  });

  bool checkAnswer(dynamic userAnswer) {
    if (correctAnswer is List && userAnswer is List) {
      if (correctAnswer.length != userAnswer.length) return false;
      for (int i = 0; i < correctAnswer.length; i++) {
        if (correctAnswer[i] != userAnswer[i]) return false;
      }
      return true;
    }
    return correctAnswer == userAnswer;
  }

  Question copyWith({
    String? id,
    String? lessonId,
    QuestionType? type,
    String? questionText,
    String? questionTextArabic,
    List<String>? options,
    List<String>? optionsArabic,
    dynamic correctAnswer,
    String? explanation,
    String? explanationArabic,
    String? imageUrl,
  }) {
    return Question(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      type: type ?? this.type,
      questionText: questionText ?? this.questionText,
      questionTextArabic: questionTextArabic ?? this.questionTextArabic,
      options: options ?? this.options,
      optionsArabic: optionsArabic ?? this.optionsArabic,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      explanation: explanation ?? this.explanation,
      explanationArabic: explanationArabic ?? this.explanationArabic,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lessonId': lessonId,
      'type': type.index,
      'questionText': questionText,
      'questionTextArabic': questionTextArabic,
      'options': options,
      'optionsArabic': optionsArabic,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
      'explanationArabic': explanationArabic,
      'imageUrl': imageUrl,
    };
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      lessonId: json['lessonId'],
      type: QuestionType.values[json['type'] ?? 0],
      questionText: json['questionText'],
      questionTextArabic: json['questionTextArabic'],
      options: List<String>.from(json['options'] ?? []),
      optionsArabic: List<String>.from(json['optionsArabic'] ?? []),
      correctAnswer: json['correctAnswer'],
      explanation: json['explanation'],
      explanationArabic: json['explanationArabic'],
      imageUrl: json['imageUrl'],
    );
  }
}
