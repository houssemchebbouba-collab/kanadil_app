import 'package:flutter/material.dart';

class Achievement {
  final String id;
  final String title;
  final String titleArabic;
  final String description;
  final String descriptionArabic;
  final IconData icon;
  final Color color;
  final bool unlocked;
  final DateTime? unlockedAt;
  final int xpReward;

  Achievement({
    required this.id,
    required this.title,
    required this.titleArabic,
    required this.description,
    required this.descriptionArabic,
    required this.icon,
    required this.color,
    this.unlocked = false,
    this.unlockedAt,
    this.xpReward = 50,
  });

  Achievement copyWith({
    String? id,
    String? title,
    String? titleArabic,
    String? description,
    String? descriptionArabic,
    IconData? icon,
    Color? color,
    bool? unlocked,
    DateTime? unlockedAt,
    int? xpReward,
  }) {
    return Achievement(
      id: id ?? this.id,
      title: title ?? this.title,
      titleArabic: titleArabic ?? this.titleArabic,
      description: description ?? this.description,
      descriptionArabic: descriptionArabic ?? this.descriptionArabic,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      unlocked: unlocked ?? this.unlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      xpReward: xpReward ?? this.xpReward,
    );
  }

  static List<Achievement> defaultAchievements = [
    Achievement(
      id: 'first_lesson',
      title: 'First Steps',
      titleArabic: 'الخطوات الأولى',
      description: 'Complete your first lesson',
      descriptionArabic: 'أكمل درسك الأول',
      icon: Icons.star_rounded,
      color: const Color(0xFFFFC800),
    ),
    Achievement(
      id: 'streak_3',
      title: 'Getting Started',
      titleArabic: 'البداية',
      description: 'Reach a 3-day streak',
      descriptionArabic: 'حقق سلسلة 3 أيام',
      icon: Icons.local_fire_department_rounded,
      color: const Color(0xFFFF9600),
    ),
    Achievement(
      id: 'streak_7',
      title: 'Week Warrior',
      titleArabic: 'محارب الأسبوع',
      description: 'Reach a 7-day streak',
      descriptionArabic: 'حقق سلسلة 7 أيام',
      icon: Icons.local_fire_department_rounded,
      color: const Color(0xFFFF4B4B),
    ),
    Achievement(
      id: 'perfect_5',
      title: 'Perfectionist',
      titleArabic: 'المثالي',
      description: 'Get perfect scores on 5 lessons',
      descriptionArabic: 'احصل على درجات كاملة في 5 دروس',
      icon: Icons.workspace_premium_rounded,
      color: const Color(0xFFCE82FF),
    ),
    Achievement(
      id: 'xp_500',
      title: 'XP Hunter',
      titleArabic: 'صائد النقاط',
      description: 'Earn 500 XP',
      descriptionArabic: 'اكسب 500 نقطة خبرة',
      icon: Icons.bolt_rounded,
      color: const Color(0xFF58CC02),
    ),
    Achievement(
      id: 'all_subjects',
      title: 'Explorer',
      titleArabic: 'المستكشف',
      description: 'Try a lesson in every subject',
      descriptionArabic: 'جرب درسًا في كل مادة',
      icon: Icons.explore_rounded,
      color: const Color(0xFF1CB0F6),
    ),
  ];
}
