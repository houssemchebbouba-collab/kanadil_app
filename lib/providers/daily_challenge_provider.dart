import 'package:flutter/foundation.dart';
import '../models/daily_challenge_model.dart';
import '../models/question_models.dart';
import '../core/constants/app_constants.dart';

// ==========================================
// مزود التحدي اليومي - Daily Challenge Provider
// ==========================================

class DailyChallengeProvider extends ChangeNotifier {
  DailyChallengeModel? _todayChallenge;
  bool _isLoading = false;
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  List<bool> _answers = [];

  // تحدي اليوم
  DailyChallengeModel? get todayChallenge => _todayChallenge;

  // حالة التحميل
  bool get isLoading => _isLoading;

  // فهرس السؤال الحالي
  int get currentQuestionIndex => _currentQuestionIndex;

  // عدد الإجابات الصحيحة
  int get correctAnswers => _correctAnswers;

  // السؤال الحالي
  BaseQuestion? get currentQuestion {
    if (_todayChallenge == null) return null;
    if (_currentQuestionIndex >= _todayChallenge!.questions.length) return null;
    return _todayChallenge!.questions[_currentQuestionIndex];
  }

  // التحقق من اكتمال التحدي
  bool get isCompleted => _todayChallenge?.isCompleted ?? false;

  // التحقق من توفر التحدي
  bool get isChallengeAvailable {
    if (_todayChallenge == null) return false;
    return _todayChallenge!.isAvailableToday && !_todayChallenge!.isCompleted;
  }

  // نسبة التقدم
  double get progress {
    if (_todayChallenge == null) return 0;
    return _currentQuestionIndex / _todayChallenge!.questions.length;
  }

  // تحميل تحدي اليوم
  Future<void> loadTodayChallenge() async {
    _isLoading = true;
    notifyListeners();

    // TODO: تحميل من Firebase
    await Future.delayed(const Duration(milliseconds: 500));

    // إنشاء تحدي فارغ (سيتم ملؤه من Firebase)
    _todayChallenge = DailyChallengeModel(
      id: 'challenge_${DateTime.now().toIso8601String().substring(0, 10)}',
      date: DateTime.now(),
      questions: [], // سيتم ملؤها من Firebase
      isCompleted: false,
    );

    _currentQuestionIndex = 0;
    _correctAnswers = 0;
    _answers = [];

    _isLoading = false;
    notifyListeners();
  }

  // تقديم إجابة
  bool submitAnswer(dynamic answer) {
    if (_todayChallenge == null) return false;
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
    if (_todayChallenge == null) return;

    if (_currentQuestionIndex < _todayChallenge!.questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    } else {
      completeChallenge();
    }
  }

  // إكمال التحدي
  void completeChallenge() {
    if (_todayChallenge == null) return;

    final xpEarned = _correctAnswers == _todayChallenge!.questions.length
        ? AppConstants.xpForDailyChallenge
        : (_correctAnswers * 10);

    _todayChallenge = _todayChallenge!.copyWith(
      isCompleted: true,
      correctAnswers: _correctAnswers,
      xpEarned: xpEarned,
      score: ((_correctAnswers / _todayChallenge!.questions.length) * 100).round(),
    );

    notifyListeners();
  }

  // إعادة تعيين التحدي (للاختبار فقط)
  void resetChallenge() {
    _currentQuestionIndex = 0;
    _correctAnswers = 0;
    _answers = [];
    if (_todayChallenge != null) {
      _todayChallenge = _todayChallenge!.copyWith(
        isCompleted: false,
        correctAnswers: 0,
        xpEarned: 0,
        score: 0,
      );
    }
    notifyListeners();
  }
}
