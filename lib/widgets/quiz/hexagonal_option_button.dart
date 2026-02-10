import 'package:flutter/material.dart';

/// Hexagonal-shaped option button for quiz answers
enum OptionState {
  normal,
  selected,
  correct,
  incorrect,
}

class HexagonalOptionButton extends StatefulWidget {
  final String label;
  final String text;
  final OptionState state;
  final VoidCallback? onTap;
  final bool enabled;

  const HexagonalOptionButton({
    super.key,
    required this.label,
    required this.text,
    this.state = OptionState.normal,
    this.onTap,
    this.enabled = true,
  });

  @override
  State<HexagonalOptionButton> createState() => _HexagonalOptionButtonState();
}

class _HexagonalOptionButtonState extends State<HexagonalOptionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get _backgroundColor {
    switch (widget.state) {
      case OptionState.correct:
        return const Color(0xFF2E7D32);
      case OptionState.incorrect:
        return const Color(0xFFC62828);
      case OptionState.selected:
        return const Color(0xFF1565C0);
      case OptionState.normal:
      default:
        return const Color(0xFF37474F);
    }
  }

  Color get _borderColor {
    switch (widget.state) {
      case OptionState.correct:
        return const Color(0xFF4CAF50);
      case OptionState.incorrect:
        return const Color(0xFFEF5350);
      case OptionState.selected:
        return const Color(0xFF42A5F5);
      case OptionState.normal:
      default:
        return const Color(0xFF607D8B);
    }
  }

  Color get _glowColor {
    switch (widget.state) {
      case OptionState.correct:
        return const Color(0xFF4CAF50);
      case OptionState.incorrect:
        return const Color(0xFFEF5350);
      case OptionState.selected:
        return const Color(0xFF42A5F5);
      case OptionState.normal:
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.enabled ? (_) => _controller.forward() : null,
      onTapUp: widget.enabled ? (_) => _controller.reverse() : null,
      onTapCancel: widget.enabled ? () => _controller.reverse() : null,
      onTap: widget.enabled ? widget.onTap : null,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: CustomPaint(
            painter: HexagonPainter(
              backgroundColor: _backgroundColor,
              borderColor: _borderColor,
              glowColor: _glowColor,
              showGlow: widget.state != OptionState.normal,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Label (A, B, C, D)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.4),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        widget.label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Text
                  Flexible(
                    child: Text(
                      widget.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            offset: Offset(1, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Check/X icon for answered state
                  if (widget.state == OptionState.correct) ...[
                    const SizedBox(width: 8),
                    const Icon(Icons.check_circle, color: Colors.white, size: 20),
                  ] else if (widget.state == OptionState.incorrect) ...[
                    const SizedBox(width: 8),
                    const Icon(Icons.cancel, color: Colors.white, size: 20),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom painter for hexagonal shape
class HexagonPainter extends CustomPainter {
  final Color backgroundColor;
  final Color borderColor;
  final Color glowColor;
  final bool showGlow;

  HexagonPainter({
    required this.backgroundColor,
    required this.borderColor,
    required this.glowColor,
    this.showGlow = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = _createHexagonPath(size);

    // Draw glow effect
    if (showGlow) {
      final glowPaint = Paint()
        ..color = glowColor.withOpacity(0.4)
        ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 8);
      canvas.drawPath(path, glowPaint);
    }

    // Draw shadow
    final shadowPath = path.shift(const Offset(2, 3));
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawPath(shadowPath, shadowPaint);

    // Draw background with gradient
    final rect = path.getBounds();
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        backgroundColor.withOpacity(0.9),
        backgroundColor,
        backgroundColor.withOpacity(0.8),
      ],
    );
    final backgroundPaint = Paint()
      ..shader = gradient.createShader(rect);
    canvas.drawPath(path, backgroundPaint);

    // Draw metallic highlight
    final highlightPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.center,
        colors: [
          Colors.white.withOpacity(0.2),
          Colors.transparent,
        ],
      ).createShader(rect);
    canvas.drawPath(path, highlightPaint);

    // Draw border
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawPath(path, borderPaint);
  }

  Path _createHexagonPath(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;
    const cornerRadius = 8.0;
    const sideInset = 15.0; // How much the sides cut in

    // Create hexagon with slightly rounded corners
    // Starting from left point, going clockwise
    path.moveTo(sideInset, h / 2);
    path.lineTo(cornerRadius + 2, cornerRadius);
    path.quadraticBezierTo(cornerRadius, 0, cornerRadius * 2, 0);
    path.lineTo(w - cornerRadius * 2, 0);
    path.quadraticBezierTo(w - cornerRadius, 0, w - cornerRadius - 2, cornerRadius);
    path.lineTo(w - sideInset, h / 2);
    path.lineTo(w - cornerRadius - 2, h - cornerRadius);
    path.quadraticBezierTo(w - cornerRadius, h, w - cornerRadius * 2, h);
    path.lineTo(cornerRadius * 2, h);
    path.quadraticBezierTo(cornerRadius, h, cornerRadius + 2, h - cornerRadius);
    path.close();

    return path;
  }

  @override
  bool shouldRepaint(covariant HexagonPainter oldDelegate) {
    return backgroundColor != oldDelegate.backgroundColor ||
        borderColor != oldDelegate.borderColor ||
        glowColor != oldDelegate.glowColor ||
        showGlow != oldDelegate.showGlow;
  }
}
