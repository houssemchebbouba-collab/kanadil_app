import 'package:flutter/material.dart';
import '../../models/question_models.dart';

// ==========================================
// ودجت سؤال الاختيار المتعدد - MCQ Widget
// ==========================================

class MCQWidget extends StatelessWidget {
  final MCQQuestion question;
  final int? selectedIndex;
  final bool showResult;
  final Function(int) onSelect;

  const MCQWidget({
    super.key,
    required this.question,
    this.selectedIndex,
    this.showResult = false,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // السؤال
        if (question.hasImage)
          Container(
            height: 150,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(Icons.image, size: 50, color: Colors.grey),
            ),
            // TODO: استخدام cached_network_image لتحميل الصورة
          ),

        Text(
          question.question,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 24),

        // الخيارات
        ...List.generate(question.options.length, (index) {
          return _buildOption(context, index);
        }),
      ],
    );
  }

  Widget _buildOption(BuildContext context, int index) {
    final isSelected = selectedIndex == index;
    final isCorrect = index == question.correctAnswerIndex;

    Color borderColor = Colors.grey[300]!;
    Color backgroundColor = Colors.transparent;
    Color textColor = Colors.black;

    if (showResult) {
      if (isCorrect) {
        borderColor = const Color(0xFF58CC02);
        backgroundColor = const Color(0xFF58CC02).withOpacity(0.1);
      } else if (isSelected && !isCorrect) {
        borderColor = const Color(0xFFFF4B4B);
        backgroundColor = const Color(0xFFFF4B4B).withOpacity(0.1);
      }
    } else if (isSelected) {
      borderColor = const Color(0xFF2B70C9);
      backgroundColor = const Color(0xFF2B70C9).withOpacity(0.1);
    }

    return GestureDetector(
      onTap: showResult ? null : () => onSelect(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Row(
          children: [
            // حرف الخيار
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: borderColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  String.fromCharCode(65 + index), // A, B, C, D
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: borderColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // نص الخيار
            Expanded(
              child: Text(
                question.options[index],
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                ),
              ),
            ),
            // أيقونة النتيجة
            if (showResult && (isSelected || isCorrect))
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect
                    ? const Color(0xFF58CC02)
                    : const Color(0xFFFF4B4B),
              ),
          ],
        ),
      ),
    );
  }
}
