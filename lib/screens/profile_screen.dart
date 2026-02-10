import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/user_provider.dart';
import '../providers/progress_provider.dart';
import '../widgets/stat_card.dart';
import '../widgets/achievement_badge.dart';
import '../theme/app_colors.dart';
import '../utils/helpers.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final userProvider = context.watch<UserProvider>();
    final progressProvider = context.watch<ProgressProvider>();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile header
            Center(
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity( 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary,
                        width: 3,
                      ),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      size: 50,
                      color: AppColors.primary,
                    ),
                  ).animate().scale(
                    begin: const Offset(0.5, 0.5),
                    end: const Offset(1, 1),
                    duration: 400.ms,
                  ),
                  const SizedBox(height: 16),
                  // Name
                  Text(
                    userProvider.user.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ).animate().fadeIn(delay: 100.ms),
                  const SizedBox(height: 4),
                  // Level
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity( 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'المستوى ${userProvider.user.level}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ).animate().fadeIn(delay: 200.ms),
                  const SizedBox(height: 16),
                  // Level progress
                  SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: userProvider.user.levelProgress,
                            backgroundColor: isDark
                                ? AppColors.progressBackgroundDark
                                : AppColors.progressBackground,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.primary,
                            ),
                            minHeight: 8,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${userProvider.user.xpInCurrentLevel}/${userProvider.user.xpForNextLevel} XP',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 300.ms),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Stats section
            Text(
              'الإحصائيات',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ).animate().fadeIn(delay: 400.ms),

            const SizedBox(height: 16),

            // Stats grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: [
                StatCard(
                  icon: Icons.bolt_rounded,
                  value: Helpers.formatXP(userProvider.user.xp),
                  label: 'نقاط الخبرة',
                  color: AppColors.xpGold,
                ).animate().fadeIn(delay: 500.ms).slideX(begin: -0.2, end: 0),
                StatCard(
                  icon: Icons.local_fire_department_rounded,
                  value: '${userProvider.user.streak}',
                  label: 'أيام متتالية',
                  color: AppColors.streakOrange,
                ).animate().fadeIn(delay: 550.ms).slideX(begin: 0.2, end: 0),
                StatCard(
                  icon: Icons.school_rounded,
                  value: '${progressProvider.totalCompletedLessons}',
                  label: 'دروس مكتملة',
                  color: AppColors.primary,
                ).animate().fadeIn(delay: 600.ms).slideX(begin: -0.2, end: 0),
                StatCard(
                  icon: Icons.emoji_events_rounded,
                  value: '${userProvider.unlockedAchievements.length}',
                  label: 'إنجازات',
                  color: AppColors.secondary,
                ).animate().fadeIn(delay: 650.ms).slideX(begin: 0.2, end: 0),
              ],
            ),

            const SizedBox(height: 32),

            // Achievements section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الإنجازات',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                ),
                Text(
                  '${userProvider.unlockedAchievements.length}/${userProvider.achievements.length}',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 700.ms),

            const SizedBox(height: 16),

            // Achievements list
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: userProvider.achievements.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final achievement = userProvider.achievements[index];
                return AchievementBadge(
                  achievement: achievement,
                ).animate(delay: Duration(milliseconds: 750 + (index * 50)))
                    .fadeIn()
                    .slideX(begin: 0.2, end: 0);
              },
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
