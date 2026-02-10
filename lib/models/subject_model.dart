import 'package:flutter/material.dart';
import 'unit_model.dart';

// ==========================================
// نموذج المادة - Subject Model
// ==========================================

class SubjectModel {
  final String id;
  final String name;
  final String arabicName;
  final String iconPath;
  final Color color;
  final List<UnitModel> units;
  final bool isLocked;
  final IconData? iconData;
  final String? backgroundImage;

  const SubjectModel({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.iconPath,
    required this.color,
    this.units = const [],
    this.isLocked = false,
    this.iconData,
    this.backgroundImage,
  });

  /// الحصول على الأيقونة - Get icon
  IconData get icon => iconData ?? Icons.book;

  /// التحقق من وجود صورة خلفية
  bool get hasBackgroundImage => backgroundImage != null && backgroundImage!.isNotEmpty;

  /// حساب التقدم الكلي في المادة
  double get totalProgress {
    if (units.isEmpty) return 0.0;
    final completedUnits = units.where((u) => u.isCompleted).length;
    return completedUnits / units.length;
  }

  /// عدد الوحدات المكتملة
  int get completedUnitsCount => units.where((u) => u.isCompleted).length;

  /// عدد النجوم المكتسبة
  int get totalStarsEarned {
    int stars = 0;
    for (final unit in units) {
      stars += unit.totalStarsEarned;
    }
    return stars;
  }

  /// الحد الأقصى للنجوم
  int get maxStars {
    int max = 0;
    for (final unit in units) {
      max += unit.maxStars;
    }
    return max;
  }

  SubjectModel copyWith({
    String? id,
    String? name,
    String? arabicName,
    String? iconPath,
    Color? color,
    List<UnitModel>? units,
    bool? isLocked,
    IconData? iconData,
    String? backgroundImage,
  }) {
    return SubjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
      arabicName: arabicName ?? this.arabicName,
      iconPath: iconPath ?? this.iconPath,
      color: color ?? this.color,
      units: units ?? this.units,
      isLocked: isLocked ?? this.isLocked,
      iconData: iconData ?? this.iconData,
      backgroundImage: backgroundImage ?? this.backgroundImage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'arabicName': arabicName,
      'iconPath': iconPath,
      'color': color.value,
      'units': units.map((u) => u.toJson()).toList(),
      'isLocked': isLocked,
      'backgroundImage': backgroundImage,
    };
  }

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'] as String,
      name: json['name'] as String,
      arabicName: json['arabicName'] as String,
      iconPath: json['iconPath'] as String,
      color: Color(json['color'] as int),
      units: (json['units'] as List<dynamic>?)
              ?.map((u) => UnitModel.fromJson(u as Map<String, dynamic>))
              .toList() ??
          [],
      isLocked: json['isLocked'] as bool? ?? false,
      backgroundImage: json['backgroundImage'] as String?,
    );
  }
}
