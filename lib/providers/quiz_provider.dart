import 'package:flutter/foundation.dart';
import '../models/question_models.dart';
import '../models/quiz_progress_model.dart';
import '../models/stage_model.dart';
import '../core/utils/score_calculator.dart';

// ==========================================
// مزود الاختبار - Quiz Provider
// ==========================================

enum QuizState { idle, inProgress, completed, paused }

class QuizProvider extends ChangeNotifier {
  QuizState _state = QuizState.idle;
  StageModel? _currentStage;
  int _currentQuestionIndex = 0;
  List<bool> _answers = [];
  DateTime? _startTime;
  int _correctAnswers = 0;

  // الحالة الحالية
  QuizState get state => _state;

  // المرحلة الحالية
  StageModel? get currentStage => _currentStage;

  // فهرس السؤال الحالي
  int get currentQuestionIndex => _currentQuestionIndex;

  // السؤال الحالي
  BaseQuestion? get currentQuestion {
    if (_currentStage == null) return null;
    if (_currentQuestionIndex >= _currentStage!.questions.length) return null;
    return _currentStage!.questions[_currentQuestionIndex];
  }

  // عدد الأسئلة الكلي
  int get totalQuestions => _currentStage?.questions.length ?? 0;

  // عدد الإجابات الصحيحة
  int get correctAnswers => _correctAnswers;

  // نسبة التقدم
  double get progress {
    if (totalQuestions == 0) return 0;
    return _currentQuestionIndex / totalQuestions;
  }

  // التحقق من آخر سؤال
  bool get isLastQuestion => _currentQuestionIndex >= totalQuestions - 1;

  // بدء اختبار جديد
  void startQuiz(StageModel stage) {
    _currentStage = stage;
    _currentQuestionIndex = 0;
    _answers = [];
    _correctAnswers = 0;
    _startTime = DateTime.now();
    _state = QuizState.inProgress;
    notifyListeners();
  }

  // تقديم إجابة
  bool submitAnswer(dynamic answer) {
    if (_state != QuizState.inProgress) return false;
    if (currentQuestion == null) return false;

    final isCorrect = currentQuestion!.checkAnswer(answer);
    _answers.add(isCorrect);

    if (isCorrect) {
      _correctAnswers++;
    }

    notifyListeners();
    return isCorrect;
  }

  // الانتقال للسؤال التالي
  void nextQuestion() {
    if (_currentQuestionIndex < totalQuestions - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    } else {
      completeQuiz();
    }
  }

  // إكمال الاختبار
  void completeQuiz() {
    _state = QuizState.completed;
    notifyListeners();
  }

  // الحصول على نتائج الاختبار
  QuizProgressModel? getResults({
    required String userId,
    required String subjectId,
    required String unitId,
  }) {
    if (_currentStage == null || _startTime == null) return null;

    final percentage = ScoreCalculator.calculatePercentage(
      _correctAnswers,
      totalQuestions,
    );
    final stars = ScoreCalculator.calculateStars(percentage);
    final xp = ScoreCalculator.calculateXP(
      correctAnswers: _correctAnswers,
      totalQuestions: totalQuestions,
      starsEarned: stars,
    );

    return QuizProgressModel(
      id: 'progress_${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      subjectId: subjectId,
      unitId: unitId,
      stageId: _currentStage!.id,
      correctAnswers: _correctAnswers,
      totalQuestions: totalQuestions,
      starsEarned: stars,
      xpEarned: xp,
      timeSpent: DateTime.now().difference(_startTime!),
      completedAt: DateTime.now(),
    );
  }

  // إيقاف الاختبار مؤقتاً
  void pauseQuiz() {
    if (_state == QuizState.inProgress) {
      _state = QuizState.paused;
      notifyListeners();
    }
  }

  // استئناف الاختبار
  void resumeQuiz() {
    if (_state == QuizState.paused) {
      _state = QuizState.inProgress;
      notifyListeners();
    }
  }

  // إعادة تعيين الاختبار
  void resetQuiz() {
    _state = QuizState.idle;
    _currentStage = null;
    _currentQuestionIndex = 0;
    _answers = [];
    _correctAnswers = 0;
    _startTime = null;
    notifyListeners();
  }
}
