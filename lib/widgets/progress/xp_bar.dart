import 'package:flutter/material.dart';

// ==========================================
// شريط نقاط الخبرة - XP Bar
// ==========================================

class XPBar extends StatelessWidget {
  final int currentXP;
  final int targetXP;
  final int level;
  final bool showLevel;
  final double height;

  const XPBar({
    super.key,
    required this.currentXP,
    required this.targetXP,
    required this.level,
    this.showLevel = true,
    this.height = 12,
  });

  @override
  Widget build(BuildContext context) {
    final progress = targetXP > 0 ? (currentXP % 500) / 500 : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLevel)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المستوى $level',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${currentXP % 500} / 500 XP',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        if (showLevel) const SizedBox(height: 8),
        Stack(
          children: [
            // الخلفية
            Container(
              height: height,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(height / 2),
              ),
            ),
            // التقدم
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              height: height,
              width: MediaQuery.of(context).size.width * progress * 0.9,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                ),
                borderRadius: BorderRadius.circular(height / 2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFD700).withOpacity(0.4),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
