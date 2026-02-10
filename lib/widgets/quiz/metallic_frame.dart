import 'package:flutter/material.dart';

/// A metallic-styled frame with rivets/bolts in corners
/// Used as a base for question frames and other UI elements
class MetallicFrame extends StatelessWidget {
  final Widget child;
  final Color primaryColor;
  final Color secondaryColor;
  final double borderRadius;
  final EdgeInsets padding;
  final bool showRivets;
  final double? width;
  final double? height;

  const MetallicFrame({
    super.key,
    required this.child,
    this.primaryColor = const Color(0xFF2A5A7B),
    this.secondaryColor = const Color(0xFF1E4A63),
    this.borderRadius = 16,
    this.padding = const EdgeInsets.all(16),
    this.showRivets = true,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            primaryColor,
            secondaryColor,
            primaryColor.withOpacity(0.9),
          ],
        ),
        border: Border.all(
          color: const Color(0xFF4A8AAB),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius - 2),
        child: Stack(
          children: [
            // Inner gradient overlay for metallic effect
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.transparent,
                      Colors.black.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: padding,
              child: child,
            ),
            // Rivets/Bolts
            if (showRivets) ...[
              Positioned(top: 8, left: 8, child: _buildRivet()),
              Positioned(top: 8, right: 8, child: _buildRivet()),
              Positioned(bottom: 8, left: 8, child: _buildRivet()),
              Positioned(bottom: 8, right: 8, child: _buildRivet()),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRivet() {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          colors: [
            Color(0xFF6AABCC),
            Color(0xFF3A7A9B),
            Color(0xFF2A5A7B),
          ],
        ),
        border: Border.all(
          color: const Color(0xFF1E4A63),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.4),
          ),
        ),
      ),
    );
  }
}
