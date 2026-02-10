import 'package:flutter/material.dart';
import '../../models/stage_model.dart';

// ==========================================
// بطاقة المرحلة - Stage Card
// ==========================================

class StageCard extends StatelessWidget {
  final StageModel stage;
  final int stageNumber;
  final Color color;
  final VoidCallback? onTap;

  const StageCard({
    super.key,
    required this.stage,
    required this.stageNumber,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: stage.isLocked ? null : onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: stage.isLocked
                ? Colors.grey[300]!
                : stage.isCompleted
                    ? const Color(0xFF58CC02)
                    : color,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // رقم المرحلة
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: stage.isLocked
                    ? Colors.grey[200]
                    : stage.isCompleted
                        ? const Color(0xFF58CC02)
                        : color,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: stage.isLocked
                    ? Icon(Icons.lock, color: Colors.grey[400], size: 20)
                    : stage.isCompleted
                        ? const Icon(Icons.check, color: Colors.white, size: 20)
                        : Text(
                            '$stageNumber',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
              ),
            ),

            const SizedBox(width: 16),

            // معلومات المرحلة
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stage.stageName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: stage.isLocked ? Colors.grey : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${stage.totalQuestions} أسئلة',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // النجوم
            if (stage.isCompleted)
              Row(
                children: List.generate(3, (index) {
                  return Icon(
                    index < stage.starsEarned ? Icons.star : Icons.star_border,
                    size: 20,
                    color: index < stage.starsEarned
                        ? const Color(0xFFFFD700)
                        : Colors.grey[300],
                  );
                }),
              )
            else if (!stage.isLocked)
              Icon(
                Icons.chevron_left,
                color: Colors.grey[400],
              ),
          ],
        ),
      ),
    );
  }
}
