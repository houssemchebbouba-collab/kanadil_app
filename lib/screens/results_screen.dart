import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/progress_provider.dart';
import '../theme/app_colors.dart';

class ResultsScreen extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final int xpEarned;
  final String subjectId;

  const ResultsScreen({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.xpEarned,
    required this.subjectId,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progressProvider = context.watch<ProgressProvider>();
    final subject = progressProvider.getSubject(subjectId);

    final percentage = (correctAnswers / totalQuestions * 100).round();
    final isPerfect = correctAnswers == totalQuestions;
    final stars = _calculateStars();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Trophy or result icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: (isPerfect ? AppColors.xpGold : AppColors.primary)
                      .withOpacity( 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isPerfect
                      ? Icons.emoji_events_rounded
                      : Icons.check_circle_rounded,
                  size: 60,
                  color: isPerfect ? AppColors.xpGold : AppColors.primary,
                ),
              )
                  .animate()
                  .scale(
                    begin: const Offset(0, 0),
                    end: const Offset(1, 1),
                    duration: 600.ms,
                    curve: Curves.elasticOut,
                  ),

              const SizedBox(height: 32),

              // Result message
              Text(
                isPerfect ? 'ممتاز!' : 'أحسنت!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),

              const SizedBox(height: 8),

              Text(
                'لقد أكملت الدرس بنجاح',
                style: TextStyle(
                  fontSize: 16,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ).animate().fadeIn(delay: 300.ms),

              const SizedBox(height: 40),

              // Stars
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  final isEarned = index < stars;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      Icons.star_rounded,
                      size: 50,
                      color: isEarned
                          ? AppColors.xpGold
                          : (isDark
                              ? AppColors.progressBackgroundDark
                              : AppColors.progressBackground),
                    )
                        .animate(delay: Duration(milliseconds: 400 + (index * 100)))
                        .scale(
                          begin: const Offset(0, 0),
                          end: const Offset(1, 1),
                          duration: 400.ms,
                          curve: Curves.elasticOut,
                        ),
                  );
                }),
              ),

              const SizedBox(height: 40),

              // Stats
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : AppColors.cardLight,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: (subject?.color ?? AppColors.primary)
                          .withOpacity( 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _StatRow(
                      icon: Icons.check_circle_rounded,
                      label: 'الإجابات الصحيحة',
                      value: '$correctAnswers/$totalQuestions',
                      color: AppColors.success,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _StatRow(
                      icon: Icons.percent_rounded,
                      label: 'النسبة المئوية',
                      value: '$percentage%',
                      color: AppColors.secondary,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _StatRow(
                      icon: Icons.bolt_rounded,
                      label: 'نقاط الخبرة',
                      value: '+$xpEarned XP',
                      color: AppColors.xpGold,
                      isDark: isDark,
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.2, end: 0),

              const Spacer(),

              // Continue button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: subject?.color ?? AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'متابعة',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: 900.ms).slideY(begin: 0.2, end: 0),
            ],
          ),
        ),
      ),
    );
  }

  int _calculateStars() {
    final percentage = correctAnswers / totalQuestions;
    if (percentage >= 1.0) return 3;
    if (percentage >= 0.7) return 2;
    if (percentage >= 0.5) return 1;
    return 0;
  }
}

class _StatRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isDark;

  const _StatRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity( 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
