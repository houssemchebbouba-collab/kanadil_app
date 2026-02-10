/// Model to hold all quiz configuration including questions and visual settings
class QuizData {
  final String subjectId;
  final String subjectName;
  final String lessonId;
  final String lessonName;
  final int stageNumber;
  final List<QuizQuestion> questions;
  final String? backgroundImage; // Asset path or URL
  final String? defaultBackgroundColor; // Fallback color hex

  QuizData({
    required this.subjectId,
    required this.subjectName,
    required this.lessonId,
    required this.lessonName,
    required this.stageNumber,
    required this.questions,
    this.backgroundImage,
    this.defaultBackgroundColor,
  });

  /// Factory to create sample quiz data for a subject
  factory QuizData.forSubject({
    required String subjectId,
    required String subjectName,
    required String lessonId,
    required String lessonName,
    required int stageNumber,
    String? backgroundImage,
  }) {
    return QuizData(
      subjectId: subjectId,
      subjectName: subjectName,
      lessonId: lessonId,
      lessonName: lessonName,
      stageNumber: stageNumber,
      questions: _getSampleQuestions(subjectId, lessonId),
      backgroundImage: backgroundImage,
      defaultBackgroundColor: _getDefaultBackgroundColor(subjectId),
    );
  }

  static String _getDefaultBackgroundColor(String subjectId) {
    // Default metallic dark colors for subjects without custom backgrounds
    switch (subjectId) {
      case 'science':
        return '#1A3A4A'; // Dark teal for science
      case 'math':
        return '#2A1A4A'; // Dark purple for math
      case 'arabic':
        return '#4A3A1A'; // Dark gold for Arabic
      case 'french':
        return '#1A2A4A'; // Dark blue for French
      case 'history':
        return '#4A2A1A'; // Dark brown for history
      case 'geography':
        return '#1A4A2A'; // Dark green for geography
      case 'islamic':
        return '#2A4A3A'; // Dark emerald for Islamic
      case 'civics':
        return '#3A3A4A'; // Dark gray for civics
      default:
        return '#2A2A3A'; // Default dark metallic
    }
  }

  static List<QuizQuestion> _getSampleQuestions(String subjectId, String lessonId) {
    // Sample questions - in production, these would come from a database
    if (subjectId == 'science') {
      return [
        QuizQuestion(
          id: '${lessonId}_q1',
          questionText: 'ما هو المصدر الرئيسي للطاقة السريعة التي يعتمد عليها جسم الإنسان؟',
          options: [
            'الدسم (الليبيدات)',
            'البروتينات',
            'الفيتامينات',
            'السكريات (الغلوسيدات)',
          ],
          correctIndex: 3,
          explanation: 'السكريات (الكربوهيدرات) هي المصدر الأساسي والأسرع للطاقة التي يستخدمها الجسم، خاصة أثناء النشاط البدني، حيث تتحول بسرعة إلى جلوكوز.',
          imagePath: 'assets/images/quiz/food_sources.png',
        ),
        QuizQuestion(
          id: '${lessonId}_q2',
          questionText: 'أين يبدأ الهضم الكيميائي للنشويات؟',
          options: [
            'المعدة',
            'الفم',
            'الأمعاء الدقيقة',
            'الأمعاء الغليظة',
          ],
          correctIndex: 1,
          explanation: 'يبدأ الهضم الكيميائي للنشويات في الفم بفضل إنزيم الأميلاز اللعابي الذي يحول النشا إلى سكر المالتوز.',
        ),
        QuizQuestion(
          id: '${lessonId}_q3',
          questionText: 'ما هو العضو المسؤول عن إنتاج الصفراء؟',
          options: [
            'المعدة',
            'البنكرياس',
            'الكبد',
            'الطحال',
          ],
          correctIndex: 2,
          explanation: 'الكبد هو العضو المسؤول عن إنتاج الصفراء التي تساعد في هضم الدهون وتخزن في المرارة.',
        ),
      ];
    }

    // Default questions for other subjects
    return [
      QuizQuestion(
        id: '${lessonId}_q1',
        questionText: 'السؤال الأول - اختر الإجابة الصحيحة',
        options: ['الخيار أ', 'الخيار ب', 'الخيار ج', 'الخيار د'],
        correctIndex: 0,
        explanation: 'هذا هو التفسير للإجابة الصحيحة.',
      ),
      QuizQuestion(
        id: '${lessonId}_q2',
        questionText: 'السؤال الثاني - اختر الإجابة الصحيحة',
        options: ['الخيار أ', 'الخيار ب', 'الخيار ج', 'الخيار د'],
        correctIndex: 1,
        explanation: 'هذا هو التفسير للإجابة الصحيحة.',
      ),
      QuizQuestion(
        id: '${lessonId}_q3',
        questionText: 'السؤال الثالث - اختر الإجابة الصحيحة',
        options: ['الخيار أ', 'الخيار ب', 'الخيار ج', 'الخيار د'],
        correctIndex: 2,
        explanation: 'هذا هو التفسير للإجابة الصحيحة.',
      ),
    ];
  }
}

/// Simple question model for the quiz
class QuizQuestion {
  final String id;
  final String questionText;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final String? imagePath;
  final String? imageUrl;

  const QuizQuestion({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    this.imagePath,
    this.imageUrl,
  });

  String get correctAnswer => options[correctIndex];

  bool isCorrect(int selectedIndex) => selectedIndex == correctIndex;
}
