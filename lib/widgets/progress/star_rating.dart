import 'package:flutter/material.dart';

// ==========================================
// تقييم النجوم - Star Rating
// ==========================================

class StarRating extends StatelessWidget {
  final int stars;
  final int maxStars;
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final MainAxisAlignment alignment;
  final bool animated;

  const StarRating({
    super.key,
    required this.stars,
    this.maxStars = 3,
    this.size = 24,
    this.activeColor = const Color(0xFFFFD700),
    this.inactiveColor = const Color(0xFFE0E0E0),
    this.alignment = MainAxisAlignment.center,
    this.animated = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxStars, (index) {
        final isActive = index < stars;

        if (animated) {
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: isActive ? 1.0 : 0.0),
            duration: Duration(milliseconds: 300 + (index * 150)),
            curve: Curves.elasticOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: 0.5 + (value * 0.5),
                child: Opacity(
                  opacity: 0.5 + (value * 0.5),
                  child: Icon(
                    isActive ? Icons.star : Icons.star_border,
                    size: size,
                    color: isActive ? activeColor : inactiveColor,
                  ),
                ),
              );
            },
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: size * 0.05),
          child: Icon(
            isActive ? Icons.star : Icons.star_border,
            size: size,
            color: isActive ? activeColor : inactiveColor,
          ),
        );
      }),
    );
  }
}

// ==========================================
// تقييم النجوم الكبير للنتائج
// ==========================================

class LargeStarRating extends StatelessWidget {
  final int stars;

  const LargeStarRating({
    super.key,
    required this.stars,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final isActive = index < stars;
        final isMiddle = index == 1;

        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 500 + (index * 200)),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, isMiddle ? -10 * value : 0),
              child: Transform.scale(
                scale: value * (isMiddle ? 1.2 : 1.0),
                child: Icon(
                  isActive ? Icons.star : Icons.star_border,
                  size: isMiddle ? 60 : 48,
                  color: isActive
                      ? const Color(0xFFFFD700)
                      : Colors.grey[300],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
