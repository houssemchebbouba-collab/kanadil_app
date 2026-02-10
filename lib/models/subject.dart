import 'package:flutter/material.dart';

class Subject {
  final String id;
  final String name;
  final String nameArabic;
  final IconData icon;
  final Color color;
  final int totalLessons;
  final int completedLessons;
  final int totalXP;
  final String? backgroundImage;

  Subject({
    required this.id,
    required this.name,
    required this.nameArabic,
    required this.icon,
    required this.color,
    this.totalLessons = 10,
    this.completedLessons = 0,
    this.totalXP = 0,
    this.backgroundImage,
  });

  bool get hasBackgroundImage => backgroundImage != null && backgroundImage!.isNotEmpty;

  double get progress => totalLessons > 0 ? completedLessons / totalLessons : 0;

  Subject copyWith({
    String? id,
    String? name,
    String? nameArabic,
    IconData? icon,
    Color? color,
    int? totalLessons,
    int? completedLessons,
    int? totalXP,
    String? backgroundImage,
  }) {
    return Subject(
      id: id ?? this.id,
      name: name ?? this.name,
      nameArabic: nameArabic ?? this.nameArabic,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      totalLessons: totalLessons ?? this.totalLessons,
      completedLessons: completedLessons ?? this.completedLessons,
      totalXP: totalXP ?? this.totalXP,
      backgroundImage: backgroundImage ?? this.backgroundImage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameArabic': nameArabic,
      'totalLessons': totalLessons,
      'completedLessons': completedLessons,
      'totalXP': totalXP,
      'backgroundImage': backgroundImage,
    };
  }
}
