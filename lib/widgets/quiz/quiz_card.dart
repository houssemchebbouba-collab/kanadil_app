import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  final String questionText;
  final String? imageUrl;
  final Widget? imageWidget; // Custom widget for image/map
  final Color themeColor;

  const QuizCard({
    super.key,
    required this.questionText,
    this.imageUrl,
    this.imageWidget,
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
            themeColor.withOpacity(0.8),
            themeColor.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: themeColor.withOpacity(0.6),
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
        children: [
          // Image/Map section
          if (imageWidget != null) ...[
            imageWidget!,
            const SizedBox(height: 16),
          ] else if (imageUrl != null) ...[
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: themeColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: themeColor.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.white.withOpacity(0.5),
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Question text
          Text(
            questionText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
