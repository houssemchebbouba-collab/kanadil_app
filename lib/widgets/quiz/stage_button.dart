import 'package:flutter/material.dart';

class StageButton extends StatelessWidget {
  final int stageNumber;
  final String stageName;
  final bool isLocked;
  final bool isCompleted;
  final bool isCurrent;
  final int starsEarned; // 0-3
  final int bestScore;
  final VoidCallback? onTap;
  final Color themeColor;

  const StageButton({
    super.key,
    required this.stageNumber,
    required this.stageName,
    this.isLocked = false,
    this.isCompleted = false,
    this.isCurrent = false,
    this.starsEarned = 0,
    this.bestScore = 0,
    this.onTap,
    this.themeColor = const Color(0xFF4A5B4A),
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color bgColor;
    Color borderColor;
    Color textColor;

    if (isLocked) {
      bgColor = isDark ? Colors.grey[800]! : Colors.grey[400]!;
      borderColor = isDark ? Colors.grey[700]! : Colors.grey[500]!;
      textColor = isDark ? Colors.grey[500]! : Colors.grey[600]!;
    } else if (isCompleted) {
      bgColor = themeColor;
      borderColor = const Color(0xFF4CAF50);
      textColor = Colors.white;
    } else if (isCurrent) {
      bgColor = themeColor.withOpacity(0.8);
      borderColor = const Color(0xFFFFB74D);
      textColor = Colors.white;
    } else {
      bgColor = themeColor.withOpacity(0.6);
      borderColor = themeColor;
      textColor = Colors.white;
    }

    return GestureDetector(
      onTap: isLocked ? null : onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              bgColor.withOpacity(0.9),
              bgColor,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: borderColor,
            width: isCurrent ? 3 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isLocked ? 0.1 : 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
            if (isCurrent)
              BoxShadow(
                color: borderColor.withOpacity(0.3),
                blurRadius: 12,
                spreadRadius: 2,
              ),
          ],
        ),
        child: Row(
          children: [
            // Stage number badge
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isLocked
                    ? Colors.grey[600]
                    : borderColor.withOpacity(0.3),
                shape: BoxShape.circle,
                border: Border.all(
                  color: borderColor,
                  width: 2,
                ),
              ),
              child: Center(
                child: isLocked
                    ? Icon(
                        Icons.lock,
                        color: Colors.grey[400],
                        size: 24,
                      )
                    : Text(
                        '$stageNumber',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
              ),
            ),

            const SizedBox(width: 16),

            // Stage info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مرحلة $stageNumber',
                    style: TextStyle(
                      fontSize: 12,
                      color: textColor.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stageName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (isCompleted) ...[
                    const SizedBox(height: 4),
                    Text(
                      'أفضل نتيجة: $bestScore%',
                      style: TextStyle(
                        fontSize: 12,
                        color: textColor.withOpacity(0.7),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Stars or lock icon
            if (isCompleted)
              Row(
                children: List.generate(3, (index) {
                  return Icon(
                    index < starsEarned ? Icons.star : Icons.star_border,
                    color: index < starsEarned
                        ? const Color(0xFFFFD700)
                        : Colors.grey[500],
                    size: 24,
                  );
                }),
              )
            else if (isCurrent)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFB74D),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'ابدأ',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            else if (!isLocked)
              Icon(
                Icons.arrow_forward_ios,
                color: textColor.withOpacity(0.5),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
