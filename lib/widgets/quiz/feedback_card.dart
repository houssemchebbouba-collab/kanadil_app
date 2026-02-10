import 'package:flutter/material.dart';

class FeedbackCard extends StatelessWidget {
  final bool isCorrect;
  final String explanation;
  final VoidCallback onContinue;
  final String continueText;
  final Color themeColor;

  const FeedbackCard({
    super.key,
    required this.isCorrect,
    required this.explanation,
    required this.onContinue,
    this.continueText = 'السؤال التالي',
    this.themeColor = const Color(0xFF4A5B4A),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            themeColor.withOpacity(0.9),
            themeColor,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: themeColor.withOpacity(0.7),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Result header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isCorrect
                      ? const Color(0xFF4CAF50).withOpacity(0.2)
                      : const Color(0xFFE57373).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isCorrect ? Icons.check_circle : Icons.cancel,
                  color: isCorrect
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFFE57373),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                isCorrect ? 'إجابة صحيحة!' : 'إجابة خاطئة',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isCorrect
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFFE57373),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Explanation header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFB74D).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.lightbulb_rounded,
                  color: Color(0xFFFFB74D),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'تغذية راجعة:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFB74D),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Explanation text
          Text(
            explanation,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              height: 1.6,
            ),
            textAlign: TextAlign.justify,
          ),

          const SizedBox(height: 16),

          // Continue button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: isCorrect
                    ? const Color(0xFF4CAF50)
                    : const Color(0xFF5B9BD5),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                continueText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
