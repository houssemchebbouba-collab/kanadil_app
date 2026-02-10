import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/progress_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/hexagon_lesson.dart';
import '../widgets/bottom_nav_bar.dart';
import 'gamified_quiz_screen.dart';

class LessonsScreen extends StatefulWidget {
  final String subjectId;

  const LessonsScreen({
    super.key,
    required this.subjectId,
  });

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final progressProvider = context.watch<ProgressProvider>();
    final userProvider = context.watch<UserProvider>();
    final subject = progressProvider.getSubject(widget.subjectId);
    final lessons = progressProvider.getLessonsForSubject(widget.subjectId);

    if (subject == null) {
      return const Scaffold(
        body: Center(child: Text('Subject not found')),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // ===== صورة الخلفية الكاملة =====
          Positioned.fill(
            child: subject.hasBackgroundImage
                ? Image.asset(
                    subject.backgroundImage!,
                    fit: BoxFit.cover,
                  )
                : Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          subject.color.withOpacity(0.3),
                          subject.color.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
          ),

          // ===== طبقة شفافة فوق الخلفية =====
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.15),
            ),
          ),

          // ===== المحتوى الرئيسي =====
          SafeArea(
            child: Column(
              children: [
                // ===== شريط علوي =====
                _buildTopBar(userProvider, subject.color),

                // ===== بطاقة معلومات الوحدة =====
                _buildUnitInfoCard(subject),

                // ===== قائمة الدروس =====
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        // الدروس بشكل متعرج
                        _buildLessonRow(lessons, 0, 1, subject.color),
                        _buildStageLabel('مرحلة 1: ${lessons.isNotEmpty ? lessons[0].titleArabic : ""}'),
                        const SizedBox(height: 10),

                        _buildLessonRow(lessons, 1, 1, subject.color, offset: 60),
                        _buildStageLabel('مرحلة 2: ${lessons.length > 1 ? lessons[1].titleArabic : ""}', offset: 60),
                        const SizedBox(height: 10),

                        _buildLessonRow(lessons, 2, 1, subject.color, offset: -60),
                        _buildStageLabel('مرحلة 3: ${lessons.length > 2 ? lessons[2].titleArabic : ""}', offset: -60),
                        const SizedBox(height: 10),

                        _buildLessonRow(lessons, 3, 1, subject.color, offset: 60),
                        _buildStageLabel('مرحلة 4: ${lessons.length > 3 ? lessons[3].titleArabic : ""}', offset: 60),
                        const SizedBox(height: 10),

                        _buildLessonRow(lessons, 4, 1, subject.color),
                        _buildStageLabel('مرحلة 5: ${lessons.length > 4 ? lessons[4].titleArabic : ""}'),
                        const SizedBox(height: 10),

                        _buildLessonRow(lessons, 5, 1, subject.color, offset: -60),
                        _buildStageLabel('مرحلة 6: ${lessons.length > 5 ? lessons[5].titleArabic : ""}', offset: -60),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          } else {
            setState(() => _currentNavIndex = index);
          }
        },
      ),
    );
  }

  // ===== شريط علوي =====
  Widget _buildTopBar(UserProvider userProvider, Color subjectColor) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // زر الرجوع
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(Icons.arrow_back_rounded, color: subjectColor, size: 24),
            ),
          ),
          const SizedBox(width: 12),

          // XP
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.star_rounded, color: Color(0xFFFFD700), size: 22),
                const SizedBox(width: 6),
                Text(
                  '${userProvider.user.xp}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // Streak
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.local_fire_department_rounded, color: Color(0xFFFF6B35), size: 22),
                const SizedBox(width: 6),
                Text(
                  '${userProvider.user.streak}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // جرس الإشعارات
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                Icon(Icons.notifications_rounded, color: subjectColor, size: 24),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===== بطاقة معلومات الوحدة =====
  Widget _buildUnitInfoCard(subject) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: subject.color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: subject.color.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            '${subject.nameArabic} 4 متوسط',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'الوحدة 1: التغذية عند الإنسان',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'عنوان الدرس: تحولات الأغذية في الأنبوب الهضمي',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ===== تسمية المرحلة =====
  Widget _buildStageLabel(String label, {double offset = 0}) {
    return Transform.translate(
      offset: Offset(offset, 0),
      child: Container(
        margin: const EdgeInsets.only(top: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xFF555555),
          ),
        ),
      ),
    );
  }

  // ===== صف الدروس =====
  Widget _buildLessonRow(List lessons, int startIndex, int count, Color color, {double offset = 0}) {
    if (startIndex >= lessons.length) return const SizedBox();

    List<Widget> items = [];
    for (int i = 0; i < count && (startIndex + i) < lessons.length; i++) {
      final lesson = lessons[startIndex + i];
      items.add(
        HexagonLesson(
          isCompleted: lesson.isCompleted,
          isLocked: lesson.isLocked,
          isCurrent: lesson.isAvailable,
          icon: _getLessonIcon(startIndex + i),
          color: color,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GamifiedQuizScreen(
                  lessonId: lesson.id,
                  subjectId: widget.subjectId,
                ),
              ),
            );
          },
        ),
      );
      if (i < count - 1) {
        items.add(const SizedBox(width: 20));
      }
    }

    return Transform.translate(
      offset: Offset(offset, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: items,
      ),
    );
  }

  // ===== أيقونة الدرس حسب الترتيب =====
  IconData _getLessonIcon(int index) {
    final icons = [
      Icons.restaurant_menu_rounded, // مصادر الأغذية
      Icons.emoji_food_beverage_rounded, // الهضم الآلي
      Icons.science_rounded, // الهضم الكيميائي
      Icons.water_drop_rounded, // الامتصاص
      Icons.delete_outline_rounded, // طرح الفضلات
      Icons.recycling_rounded, // مراجعة
      Icons.quiz_rounded,
      Icons.star_rounded,
      Icons.emoji_events_rounded,
      Icons.check_circle_rounded,
    ];
    return icons[index % icons.length];
  }
}
