import 'package:flutter/material.dart';
import '../main.dart';

// ==========================================
// شاشة تفاصيل الوحدة - Unit Detail Screen
// ==========================================

class UnitDetailScreen extends StatelessWidget {
  final String subjectId;
  final String unitId;

  const UnitDetailScreen({
    super.key,
    required this.subjectId,
    required this.unitId,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: الحصول على بيانات الوحدة من Provider باستخدام subjectId و unitId

    return Scaffold(
      appBar: AppBar(
        title: const Text('الوحدة'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            const Text(
              'قيد التطوير',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'سيتم إضافة محتوى الوحدة قريباً',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // معلومات التصحيح
            Text(
              'معرف المادة: $subjectId',
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
            Text(
              'معرف الوحدة: $unitId',
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),

            const SizedBox(height: 32),

            // زر تجريبي للانتقال إلى الدرس
            ElevatedButton.icon(
              onPressed: () {
                AppNavigator.goToLesson(
                  context,
                  subjectId: subjectId,
                  unitId: unitId,
                  stageId: 'stage_1',
                  lessonId: 'lesson_1',
                );
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('بدء الدرس التجريبي'),
            ),
          ],
        ),
      ),
    );
  }
}
