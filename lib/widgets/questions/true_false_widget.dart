import 'package:flutter/material.dart';
import '../../models/question_models.dart';

// ==========================================
// ودجت سؤال صح أم خطأ - True/False Widget
// ==========================================

class TrueFalseWidget extends StatelessWidget {
  final TrueFalseQuestion question;
  final bool? selectedAnswer;
  final bool showResult;
  final Function(bool) onSelect;

  const TrueFalseWidget({
    super.key,
    required this.question,
    this.selectedAnswer,
    this.showResult = false,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // الصورة إن وجدت
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
          ),

        // السؤال
        Text(
          question.question,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 32),

        // الأزرار
        Row(
          children: [
            Expanded(child: _buildButton(context, true, 'صح')),
            const SizedBox(width: 16),
            Expanded(child: _buildButton(context, false, 'خطأ')),
          ],
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context, bool value, String label) {
    final isSelected = selectedAnswer == value;
    final isCorrect = value == question.correctAnswer;

    Color backgroundColor;
    Color borderColor;
    Color textColor = Colors.white;

    if (showResult) {
      if (isCorrect) {
        backgroundColor = const Color(0xFF58CC02);
        borderColor = const Color(0xFF58CC02);
      } else if (isSelected && !isCorrect) {
        backgroundColor = const Color(0xFFFF4B4B);
        borderColor = const Color(0xFFFF4B4B);
      } else {
        backgroundColor = Colors.grey[200]!;
        borderColor = Colors.grey[300]!;
        textColor = Colors.grey;
      }
    } else if (isSelected) {
      backgroundColor = const Color(0xFF2B70C9);
      borderColor = const Color(0xFF2B70C9);
    } else {
      backgroundColor = Colors.grey[100]!;
      borderColor = Colors.grey[300]!;
      textColor = Colors.grey[700]!;
    }

    return GestureDetector(
      onTap: showResult ? null : () => onSelect(value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Column(
          children: [
            Icon(
              value ? Icons.check : Icons.close,
              size: 40,
              color: textColor,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
