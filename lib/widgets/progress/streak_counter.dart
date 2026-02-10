import 'package:flutter/material.dart';

// ==========================================
// عداد السلسلة - Streak Counter
// ==========================================

class StreakCounter extends StatelessWidget {
  final int streakDays;
  final bool isActiveToday;
  final bool showLabel;

  const StreakCounter({
    super.key,
    required this.streakDays,
    this.isActiveToday = false,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _getBorderColor(),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // أيقونة النار
          Text(
            _getFireEmoji(),
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 6),
          // العدد
          Text(
            '$streakDays',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _getTextColor(),
            ),
          ),
          if (showLabel) ...[
            const SizedBox(width: 4),
            Text(
              'يوم',
              style: TextStyle(
                fontSize: 12,
                color: _getTextColor().withOpacity(0.8),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getFireEmoji() {
    if (streakDays >= 30) return '🔥';
    if (streakDays >= 7) return '🔥';
    if (streakDays >= 3) return '🔥';
    return isActiveToday ? '🔥' : '❄️';
  }

  Color _getBackgroundColor() {
    if (!isActiveToday) return Colors.grey[100]!;
    if (streakDays >= 30) return const Color(0xFFFFD700).withOpacity(0.2);
    if (streakDays >= 7) return const Color(0xFFC0C0C0).withOpacity(0.2);
    if (streakDays >= 3) return const Color(0xFFCD7F32).withOpacity(0.2);
    return const Color(0xFFFF6B35).withOpacity(0.1);
  }

  Color _getBorderColor() {
    if (!isActiveToday) return Colors.grey[300]!;
    if (streakDays >= 30) return const Color(0xFFFFD700);
    if (streakDays >= 7) return const Color(0xFFC0C0C0);
    if (streakDays >= 3) return const Color(0xFFCD7F32);
    return const Color(0xFFFF6B35);
  }

  Color _getTextColor() {
    if (!isActiveToday) return Colors.grey;
    if (streakDays >= 30) return const Color(0xFFB8860B);
    if (streakDays >= 7) return Colors.grey[700]!;
    if (streakDays >= 3) return const Color(0xFF8B4513);
    return const Color(0xFFFF6B35);
  }
}
