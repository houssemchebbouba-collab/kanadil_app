import 'package:flutter/material.dart';
import 'metallic_frame.dart';

/// Metallic feedback box with lightbulb icon and explanation
class FeedbackBox extends StatelessWidget {
  final String title;
  final String explanation;
  final bool isCorrect;
  final VoidCallback? onContinue;

  const FeedbackBox({
    super.key,
    this.title = 'تغذية راجعة:',
    required this.explanation,
    required this.isCorrect,
    this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Feedback content box
          MetallicFrame(
            primaryColor: isCorrect
                ? const Color(0xFF2E5A3A)
                : const Color(0xFF5A3A3A),
            secondaryColor: isCorrect
                ? const Color(0xFF1E4A2A)
                : const Color(0xFF4A2A2A),
            borderRadius: 16,
            showRivets: true,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with lightbulb icon
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const RadialGradient(
                          colors: [
                            Color(0xFFFFD54F),
                            Color(0xFFFFA000),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFD54F).withOpacity(0.5),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.lightbulb_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            offset: Offset(1, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Status icon
                    Icon(
                      isCorrect
                          ? Icons.check_circle_rounded
                          : Icons.cancel_rounded,
                      color: isCorrect
                          ? const Color(0xFF4CAF50)
                          : const Color(0xFFEF5350),
                      size: 28,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Divider
                Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.white.withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Explanation text
                Text(
                  explanation,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    height: 1.5,
                    shadows: const [
                      Shadow(
                        color: Colors.black45,
                        offset: Offset(1, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Continue button
          if (onContinue != null)
            SizedBox(
              width: double.infinity,
              child: _ContinueButton(
                onTap: onContinue!,
                isCorrect: isCorrect,
              ),
            ),
        ],
      ),
    );
  }
}

class _ContinueButton extends StatefulWidget {
  final VoidCallback onTap;
  final bool isCorrect;

  const _ContinueButton({
    required this.onTap,
    required this.isCorrect,
  });

  @override
  State<_ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<_ContinueButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: Matrix4.identity()..scale(_isPressed ? 0.98 : 1.0),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: widget.isCorrect
                ? [
                    const Color(0xFF4CAF50),
                    const Color(0xFF388E3C),
                    const Color(0xFF2E7D32),
                  ]
                : [
                    const Color(0xFF42A5F5),
                    const Color(0xFF1976D2),
                    const Color(0xFF1565C0),
                  ],
          ),
          border: Border.all(
            color: widget.isCorrect
                ? const Color(0xFF66BB6A)
                : const Color(0xFF64B5F6),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: (widget.isCorrect
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFF42A5F5))
                  .withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'متابعة',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black45,
                    offset: Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
