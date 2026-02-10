import 'package:flutter/material.dart';
import 'metallic_frame.dart';

/// Displays the current stage and question number
/// Example: "مرحلة 1: مصادر الأغذية - سؤال 1/10"
class StageIndicator extends StatelessWidget {
  final int stageNumber;
  final String stageName;
  final int currentQuestion;
  final int totalQuestions;

  const StageIndicator({
    super.key,
    required this.stageNumber,
    required this.stageName,
    required this.currentQuestion,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: MetallicFrame(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        borderRadius: 12,
        showRivets: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'مرحلة $stageNumber: $stageName - سؤال $currentQuestion/$totalQuestions',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black45,
                    offset: Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
