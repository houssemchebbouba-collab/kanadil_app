import 'package:flutter/material.dart';
import '../main.dart';

// ==========================================
// شاشة الدرس - Lesson Screen
// ==========================================

class LessonScreen extends StatefulWidget {
  final String subjectId;
  final String unitId;
  final String stageId;
  final String lessonId;

  const LessonScreen({
    super.key,
    required this.subjectId,
    required this.unitId,
    required this.stageId,
    required this.lessonId,
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int _currentQuestion = 0;
  int _correctAnswers = 0;
  final int _totalQuestions = 5; // TODO: الحصول من البيانات

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدرس'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _showExitDialog(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (_currentQuestion + 1) / _totalQuestions,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation(Color(0xFF58CC02)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu_book,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            const Text(
              'محتوى الدرس',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'سيتم عرض الأسئلة هنا',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // معلومات التصحيح
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'السؤال ${_currentQuestion + 1} من $_totalQuestions',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'معرف المادة: ${widget.subjectId}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  Text(
                    'معرف الوحدة: ${widget.unitId}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  Text(
                    'معرف المرحلة: ${widget.stageId}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  Text(
                    'معرف الدرس: ${widget.lessonId}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // أزرار تجريبية
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // إجابة خاطئة
                      setState(() {
                        if (_currentQuestion < _totalQuestions - 1) {
                          _currentQuestion++;
                        } else {
                          _finishLesson();
                        }
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('إجابة خاطئة'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // إجابة صحيحة
                      setState(() {
                        _correctAnswers++;
                        if (_currentQuestion < _totalQuestions - 1) {
                          _currentQuestion++;
                        } else {
                          _finishLesson();
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF58CC02),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'إجابة صحيحة',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إنهاء الدرس'),
        content: const Text('هل تريد الخروج؟ سيتم فقدان التقدم الحالي.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // إغلاق الحوار
              Navigator.pop(context); // العودة للصفحة السابقة
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('خروج', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _finishLesson() {
    // حساب النتائج
    final percentage = (_correctAnswers / _totalQuestions) * 100;
    int stars = 0;
    if (percentage >= 90) {
      stars = 3;
    } else if (percentage >= 70) {
      stars = 2;
    } else if (percentage >= 50) {
      stars = 1;
    }

    // الانتقال لشاشة النتائج
    AppNavigator.goToQuizResults(
      context,
      correctAnswers: _correctAnswers,
      totalQuestions: _totalQuestions,
      xpEarned: _correctAnswers * 10, // 10 XP لكل إجابة صحيحة
      starsEarned: stars,
      isPerfect: _correctAnswers == _totalQuestions,
    );
  }
}
