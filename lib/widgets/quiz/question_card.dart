import 'package:flutter/material.dart';
import 'metallic_frame.dart';

/// Metallic-styled question card with optional image
class QuestionCard extends StatelessWidget {
  final String questionText;
  final String? imageUrl;
  final String? imagePath; // For local assets

  const QuestionCard({
    super.key,
    required this.questionText,
    this.imageUrl,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null || imagePath != null;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: MetallicFrame(
        padding: const EdgeInsets.all(16),
        borderRadius: 16,
        showRivets: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image section
            if (hasImage) ...[
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF4A9ABB),
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: _buildImage(),
                ),
              ),
              const SizedBox(height: 12),
            ],
            // Question text
            Text(
              questionText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.5,
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

  Widget _buildImage() {
    if (imagePath != null) {
      return Image.asset(
        imagePath!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    } else if (imageUrl != null) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
              color: Colors.white,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: const Color(0xFF1E4A63),
      child: const Center(
        child: Icon(
          Icons.image_rounded,
          color: Colors.white54,
          size: 48,
        ),
      ),
    );
  }
}
