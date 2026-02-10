import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/user_provider.dart';
import '../providers/progress_provider.dart';
import '../theme/app_colors.dart';
import 'results_screen.dart';

class QuizScreen extends StatefulWidget {
  final String lessonId;
  final String subjectId;

  const QuizScreen({
    super.key,
    required this.lessonId,
    required this.subjectId,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  int? _selectedAnswer;
  bool _answered = false;

  // Sample questions - in a real app, these would come from a database
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'ما هو الجواب الصحيح؟',
      'options': ['الخيار الأول', 'الخيار الثاني', 'الخيار الثالث', 'الخيار الرابع'],
      'correct': 0,
    },
    {
      'question': 'اختر الإجابة الصحيحة:',
      'options': ['إجابة أ', 'إجابة ب', 'إجابة ج', 'إجابة د'],
      'correct': 1,
    },
    {
      'question': 'ما هي الإجابة؟',
      'options': ['خيار 1', 'خيار 2', 'خيار 3', 'خيار 4'],
      'correct': 2,
    },
  ];

  void _selectAnswer(int index) {
    if (_answered) return;

    setState(() {
      _selectedAnswer = index;
      _answered = true;
      if (index == _questions[_currentQuestionIndex]['correct']) {
        _correctAnswers++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null;
        _answered = false;
      });
    } else {
      _finishQuiz();
    }
  }

  void _finishQuiz() async {
    final progressProvider = context.read<ProgressProvider>();
    final userProvider = context.read<UserProvider>();

    final isPerfect = _correctAnswers == _questions.length;
    final xpEarned = isPerfect ? 15 : 10;

    await progressProvider.completeLesson(widget.lessonId);
    await userProvider.addXP(xpEarned);
    await userProvider.completeLesson(isPerfect: isPerfect);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          correctAnswers: _correctAnswers,
          totalQuestions: _questions.length,
          xpEarned: xpEarned,
          subjectId: widget.subjectId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progressProvider = context.watch<ProgressProvider>();
    final subject = progressProvider.getSubject(widget.subjectId);
    final progress = (_currentQuestionIndex + 1) / _questions.length;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => _showExitDialog(),
                    icon: Icon(
                      Icons.close_rounded,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: isDark
                            ? AppColors.progressBackgroundDark
                            : AppColors.progressBackground,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          subject?.color ?? AppColors.primary,
                        ),
                        minHeight: 10,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity( 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.favorite_rounded,
                          color: AppColors.error,
                          size: 18,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '5',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(),

            // Question
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Question text
                    Text(
                      _questions[_currentQuestionIndex]['question'],
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn().slideY(begin: -0.1, end: 0),

                    const SizedBox(height: 40),

                    // Options
                    ...List.generate(
                      (_questions[_currentQuestionIndex]['options'] as List).length,
                      (index) {
                        final option = _questions[_currentQuestionIndex]['options'][index];
                        final isCorrect = index == _questions[_currentQuestionIndex]['correct'];
                        final isSelected = _selectedAnswer == index;

                        Color backgroundColor;
                        Color borderColor;
                        Color textColor;

                        if (_answered) {
                          if (isCorrect) {
                            backgroundColor = AppColors.success.withOpacity( 0.2);
                            borderColor = AppColors.success;
                            textColor = AppColors.success;
                          } else if (isSelected) {
                            backgroundColor = AppColors.error.withOpacity( 0.2);
                            borderColor = AppColors.error;
                            textColor = AppColors.error;
                          } else {
                            backgroundColor = isDark
                                ? AppColors.cardDark
                                : AppColors.cardLight;
                            borderColor = isDark
                                ? AppColors.progressBackgroundDark
                                : AppColors.progressBackground;
                            textColor = isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight;
                          }
                        } else {
                          backgroundColor = isDark
                              ? AppColors.cardDark
                              : AppColors.cardLight;
                          borderColor = isSelected
                              ? (subject?.color ?? AppColors.primary)
                              : (isDark
                                  ? AppColors.progressBackgroundDark
                                  : AppColors.progressBackground);
                          textColor = isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight;
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: GestureDetector(
                            onTap: () => _selectAnswer(index),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: borderColor,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      option,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                  if (_answered)
                                    Icon(
                                      isCorrect
                                          ? Icons.check_circle_rounded
                                          : (isSelected
                                              ? Icons.cancel_rounded
                                              : null),
                                      color: isCorrect
                                          ? AppColors.success
                                          : AppColors.error,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ).animate(delay: Duration(milliseconds: 100 * index))
                            .fadeIn()
                            .slideX(begin: 0.1, end: 0);
                      },
                    ),

                    const Spacer(),

                    // Continue button
                    if (_answered)
                      ElevatedButton(
                        onPressed: _nextQuestion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: subject?.color ?? AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          _currentQuestionIndex < _questions.length - 1
                              ? 'السؤال التالي'
                              : 'إنهاء الدرس',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ).animate().fadeIn().slideY(begin: 0.2, end: 0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showExitDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppColors.cardDark : AppColors.cardLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'هل تريد الخروج؟',
          style: TextStyle(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          'سيتم فقدان تقدمك في هذا الدرس',
          style: TextStyle(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('متابعة'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back
            },
            child: const Text(
              'خروج',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
