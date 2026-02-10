import 'stage_model.dart';
import 'lesson_model.dart';

// ==========================================
// نموذج الوحدة - Unit Model
// ==========================================

class UnitModel {
  final String id;
  final String subjectId;
  final String unitName;
  final String? description;
  final List<StageModel> stages;
  final List<LessonModel> lessons;
  final bool isLocked;
  final bool isCompleted;
  final double progress; // 0.0 to 1.0
  final int order;

  const UnitModel({
    required this.id,
    required this.subjectId,
    required this.unitName,
    this.description,
    this.stages = const [],
    this.lessons = const [],
    this.isLocked = true,
    this.isCompleted = false,
    this.progress = 0.0,
    this.order = 0,
  });

  /// عدد المراحل المكتملة
  int get completedStagesCount => stages.where((s) => s.isCompleted).length;

  /// عدد النجوم المكتسبة في الوحدة
  int get totalStarsEarned {
    int stars = 0;
    for (final stage in stages) {
      stars += stage.starsEarned;
    }
    return stars;
  }

  /// الحد الأقصى للنجوم في الوحدة
  int get maxStars => stages.length * 3;

  /// التحقق من توفر الوحدة
  bool get isAvailable => !isLocked;

  /// حساب التقدم الفعلي
  double get calculatedProgress {
    if (stages.isEmpty) return 0.0;
    return completedStagesCount / stages.length;
  }

  UnitModel copyWith({
    String? id,
    String? subjectId,
    String? unitName,
    String? description,
    List<StageModel>? stages,
    List<LessonModel>? lessons,
    bool? isLocked,
    bool? isCompleted,
    double? progress,
    int? order,
  }) {
    return UnitModel(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      unitName: unitName ?? this.unitName,
      description: description ?? this.description,
      stages: stages ?? this.stages,
      lessons: lessons ?? this.lessons,
      isLocked: isLocked ?? this.isLocked,
      isCompleted: isCompleted ?? this.isCompleted,
      progress: progress ?? this.progress,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subjectId': subjectId,
      'unitName': unitName,
      'description': description,
      'stages': stages.map((s) => s.toJson()).toList(),
      'lessons': lessons.map((l) => l.toJson()).toList(),
      'isLocked': isLocked,
      'isCompleted': isCompleted,
      'progress': progress,
      'order': order,
    };
  }

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'] as String,
      subjectId: json['subjectId'] as String,
      unitName: json['unitName'] as String,
      description: json['description'] as String?,
      stages: (json['stages'] as List<dynamic>?)
              ?.map((s) => StageModel.fromJson(s as Map<String, dynamic>))
              .toList() ??
          [],
      lessons: (json['lessons'] as List<dynamic>?)
              ?.map((l) => LessonModel.fromJson(l as Map<String, dynamic>))
              .toList() ??
          [],
      isLocked: json['isLocked'] as bool? ?? true,
      isCompleted: json['isCompleted'] as bool? ?? false,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      order: json['order'] as int? ?? 0,
    );
  }
}
