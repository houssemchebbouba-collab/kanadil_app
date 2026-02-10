import 'package:flutter/material.dart';
import '../../models/leaderboard_model.dart';

// ==========================================
// عنصر لوحة المتصدرين - Leaderboard Item
// ==========================================

class LeaderboardItem extends StatelessWidget {
  final LeaderboardEntry entry;
  final bool isCurrentUser;

  const LeaderboardItem({
    super.key,
    required this.entry,
    this.isCurrentUser = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? const Color(0xFF2B70C9).withOpacity(0.1)
            : isDark
                ? Colors.grey[850]
                : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isCurrentUser
            ? Border.all(color: const Color(0xFF2B70C9), width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // الترتيب
          SizedBox(
            width: 40,
            child: entry.isTopThree
                ? Text(
                    entry.rankBadge,
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  )
                : Text(
                    '${entry.rank}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
          ),

          const SizedBox(width: 12),

          // الصورة الشخصية
          CircleAvatar(
            radius: 20,
            backgroundColor: _getRankColor().withOpacity(0.2),
            child: entry.avatarUrl != null
                ? ClipOval(
                    child: Image.network(
                      entry.avatarUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildDefaultAvatar(),
                    ),
                  )
                : _buildDefaultAvatar(),
          ),

          const SizedBox(width: 12),

          // المعلومات
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      entry.userName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            isCurrentUser ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                    if (isCurrentUser)
                      Container(
                        margin: const EdgeInsets.only(right: 6),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2B70C9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'أنت',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                if (entry.wilaya != null)
                  Text(
                    entry.wilaya!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
              ],
            ),
          ),

          // النقاط
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    size: 16,
                    color: Color(0xFFFFD700),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${entry.totalXP}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                'Lv.${entry.level}',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Text(
      entry.userName.isNotEmpty ? entry.userName[0].toUpperCase() : '?',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: _getRankColor(),
      ),
    );
  }

  Color _getRankColor() {
    switch (entry.rank) {
      case 1:
        return const Color(0xFFFFD700);
      case 2:
        return const Color(0xFFC0C0C0);
      case 3:
        return const Color(0xFFCD7F32);
      default:
        return const Color(0xFF2B70C9);
    }
  }
}
