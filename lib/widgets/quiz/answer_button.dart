import 'package:flutter/material.dart';

enum AnswerState { normal, selected, correct, wrong }

class AnswerButton extends StatelessWidget {
  final String label; // A, B, C, D
  final String text;
  final AnswerState state;
  final VoidCallback? onTap;
  final Color themeColor;

  const AnswerButton({
    super.key,
    required this.label,
    required this.text,
    this.state = AnswerState.normal,
    this.onTap,
    this.themeColor = const Color(0xFF4A5B4A),
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Determine colors based on state
    Color borderColor;
    Color bgColor;
    Color textColor = Colors.white;

    switch (state) {
      case AnswerState.correct:
        borderColor = const Color(0xFF4CAF50);
        bgColor = const Color(0xFF2E5A2E);
        break;
      case AnswerState.wrong:
        borderColor = const Color(0xFFE57373);
        bgColor = const Color(0xFF5A2E2E);
        break;
      case AnswerState.selected:
        borderColor = themeColor.withOpacity(0.8);
        bgColor = themeColor.withOpacity(0.6);
        break;
      case AnswerState.normal:
      default:
        borderColor = isDark ? const Color(0xFF6B7C6B) : const Color(0xFF8B9B8B);
        bgColor = isDark ? const Color(0xFF4A5B4A) : const Color(0xFF5A6B5A);
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              bgColor.withOpacity(0.9),
              bgColor,
            ],
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor,
            width: state == AnswerState.normal ? 2 : 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Show check icon for correct answer
            if (state == AnswerState.correct)
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.check_circle,
                  color: Color(0xFF4CAF50),
                  size: 20,
                ),
              ),
            // Show X icon for wrong answer
            if (state == AnswerState.wrong)
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.cancel,
                  color: Color(0xFFE57373),
                  size: 20,
                ),
              ),
            Flexible(
              child: Text(
                '$label. $text',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
