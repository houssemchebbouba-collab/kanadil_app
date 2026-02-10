import 'package:flutter/material.dart';
import '../main.dart';
import '../theme/app_colors.dart';

// ==========================================
// شاشة نتائج الاختبار - Quiz Results Screen
// ==========================================

class QuizResultsScreen extends StatefulWidget {
  final int correctAnswers;
  final int totalQuestions;
  final int xpEarned;
  final int starsEarned;
  final bool isPerfect;

  const QuizResultsScreen({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.xpEarned,
    required this.starsEarned,
    this.isPerfect = false,
  });

  @override
  State<QuizResultsScreen> createState() => _QuizResultsScreenState();
}

class _QuizResultsScreenState extends State<QuizResultsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get _percentage =>
      widget.totalQuestions > 0
          ? (widget.correctAnswers / widget.totalQuestions) * 100
          : 0;

  String get _resultEmoji {
    if (widget.isPerfect) return '🎉';
    if (_percentage >= 90) return '🏆';
    if (_percentage >= 70) return '⭐';
    if (_percentage >= 50) return '👍';
    return '💪';
  }

  String get _resultMessage {
    if (widget.isPerfect) return 'ممتاز! إجابة مثالية!';
    if (_percentage >= 90) return 'أحسنت! أداء رائع!';
    if (_percentage >= 70) return 'جيد جداً!';
    if (_percentage >= 50) return 'جيد! واصل التقدم';
    return 'حاول مرة أخرى!';
  }

  Color get _resultColor {
    if (_percentage >= 70) return AppColors.success;
    if (_percentage >= 50) return AppColors.warning;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // أيقونة النتيجة
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: _resultColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      _resultEmoji,
                      style: const TextStyle(fontSize: 60),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // نص التهنئة
              Text(
                _resultMessage,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              Text(
                'لقد أكملت الاختبار',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 40),

              // بطاقة النتائج
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[850] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // النسبة المئوية
                    Text(
                      '${_percentage.round()}%',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: _resultColor,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // النجوم
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            index < widget.starsEarned
                                ? Icons.star
                                : Icons.star_border,
                            size: 40,
                            color: index < widget.starsEarned
                                ? AppColors.starFilled
                                : Colors.grey,
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 24),

                    // التفاصيل
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(
                          'الإجابات الصحيحة',
                          '${widget.correctAnswers}/${widget.totalQuestions}',
                          Icons.check_circle,
                          AppColors.success,
                        ),
                        _buildStatItem(
                          'نقاط الخبرة',
                          '+${widget.xpEarned}',
                          Icons.star,
                          AppColors.xpGold,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // الأزرار
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // TODO: إعادة الاختبار
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('إعادة'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        AppNavigator.goToHome(context);
                      },
                      icon: const Icon(Icons.home, color: Colors.white),
                      label: const Text(
                        'الرئيسية',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
