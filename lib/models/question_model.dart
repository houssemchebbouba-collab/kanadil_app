class QuestionModel {
  final int id;
  final String questionText;
  final String? imageUrl;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  QuestionModel({
    required this.id,
    required this.questionText,
    this.imageUrl,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });

  // Check if user's answer is correct
  bool isCorrect(int selectedIndex) {
    return selectedIndex == correctAnswerIndex;
  }

  // Get the correct answer text
  String get correctAnswer => options[correctAnswerIndex];

  // Get option label (A, B, C, D)
  static String getOptionLabel(int index) {
    const labels = ['A', 'B', 'C', 'D'];
    return labels[index];
  }

  // Create from JSON
  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      questionText: json['questionText'],
      imageUrl: json['imageUrl'],
      options: List<String>.from(json['options']),
      correctAnswerIndex: json['correctAnswerIndex'],
      explanation: json['explanation'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionText': questionText,
      'imageUrl': imageUrl,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
      'explanation': explanation,
    };
  }

  // Copy with modifications
  QuestionModel copyWith({
    int? id,
    String? questionText,
    String? imageUrl,
    List<String>? options,
    int? correctAnswerIndex,
    String? explanation,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      questionText: questionText ?? this.questionText,
      imageUrl: imageUrl ?? this.imageUrl,
      options: options ?? this.options,
      correctAnswerIndex: correctAnswerIndex ?? this.correctAnswerIndex,
      explanation: explanation ?? this.explanation,
    );
  }
}
