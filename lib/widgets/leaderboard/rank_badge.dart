import 'package:flutter/material.dart';

// ==========================================
// شارة الترتيب - Rank Badge
// ==========================================

class RankBadge extends StatelessWidget {
  final int rank;
  final double size;

  const RankBadge({
    super.key,
    required this.rank,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    if (rank <= 3) {
      return _buildMedalBadge();
    }
    return _buildNumberBadge();
  }

  Widget _buildMedalBadge() {
    String emoji;
    Color color;

    switch (rank) {
      case 1:
        emoji = '🥇';
        color = const Color(0xFFFFD700);
        break;
      case 2:
        emoji = '🥈';
        color = const Color(0xFFC0C0C0);
        break;
      case 3:
        emoji = '🥉';
        color = const Color(0xFFCD7F32);
        break;
      default:
        emoji = '';
        color = Colors.grey;
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
      child: Center(
        child: Text(
          emoji,
          style: TextStyle(fontSize: size * 0.5),
        ),
      ),
    );
  }

  Widget _buildNumberBadge() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '$rank',
          style: TextStyle(
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// شارة المستوى - Level Badge
// ==========================================

class LevelBadge extends StatelessWidget {
  final int level;
  final double size;

  const LevelBadge({
    super.key,
    required this.level,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size * 0.4,
        vertical: size * 0.15,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _getLevelColors(),
        ),
        borderRadius: BorderRadius.circular(size / 2),
        boxShadow: [
          BoxShadow(
            color: _getLevelColors().first.withOpacity(0.4),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        'Lv.$level',
        style: TextStyle(
          fontSize: size * 0.4,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  List<Color> _getLevelColors() {
    if (level >= 50) {
      return [const Color(0xFFFF6B35), const Color(0xFFFF4500)];
    }
    if (level >= 30) {
      return [const Color(0xFFFFD700), const Color(0xFFFFA500)];
    }
    if (level >= 10) {
      return [const Color(0xFF58CC02), const Color(0xFF2E8B57)];
    }
    return [const Color(0xFF2B70C9), const Color(0xFF1E4D8C)];
  }
}
