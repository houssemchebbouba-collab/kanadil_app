import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// ==========================================
// شاشة الإنجازات - Achievements Screen
// ==========================================

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإنجازات'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // أيقونة قيد التطوير
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.xpGold.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emoji_events,
                size: 60,
                color: AppColors.xpGold,
              ),
            ),

            const SizedBox(height: 24),

            // العنوان
            const Text(
              'الإنجازات',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // الوصف
            Text(
              'قريباً ستتمكن من رؤية إنجازاتك هنا',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // TODO: عرض قائمة الإنجازات
            // استخدم AchievementModel لعرض الإنجازات
          ],
        ),
      ),
    );
  }
}
