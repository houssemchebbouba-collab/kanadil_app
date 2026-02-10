// ==========================================
// نموذج الدرس - Lesson Model
// ==========================================

enum LessonType { text, image, video, mixed }

class LessonModel {
  final String id;
  final String unitId;
  final String title;
  final String arabicTitle;
  final String content;
  final String? imageUrl;
  final String? videoUrl;
  final LessonType type;
  final int order;
  final bool isCompleted;
  final bool isLocked;

  const LessonModel({
    required this.id,
    required this.unitId,
    required this.title,
    required this.arabicTitle,
    this.content = '',
    this.imageUrl,
    this.videoUrl,
    this.type = LessonType.text,
    this.order = 0,
    this.isCompleted = false,
    this.isLocked = true,
  });

  /// التحقق من توفر الدرس
  bool get isAvailable => !isLocked;

  /// التحقق من وجود صورة
  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;

  /// التحقق من وجود فيديو
  bool get hasVideo => videoUrl != null && videoUrl!.isNotEmpty;

  LessonModel copyWith({
    String? id,
    String? unitId,
    String? title,
    String? arabicTitle,
    String? content,
    String? imageUrl,
    String? videoUrl,
    LessonType? type,
    int? order,
    bool? isCompleted,
    bool? isLocked,
  }) {
    return LessonModel(
      id: id ?? this.id,
      unitId: unitId ?? this.unitId,
      title: title ?? this.title,
      arabicTitle: arabicTitle ?? this.arabicTitle,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      type: type ?? this.type,
      order: order ?? this.order,
      isCompleted: isCompleted ?? this.isCompleted,
      isLocked: isLocked ?? this.isLocked,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'unitId': unitId,
      'title': title,
      'arabicTitle': arabicTitle,
      'content': content,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'type': type.name,
      'order': order,
      'isCompleted': isCompleted,
      'isLocked': isLocked,
    };
  }

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] as String,
      unitId: json['unitId'] as String,
      title: json['title'] as String,
      arabicTitle: json['arabicTitle'] as String? ?? json['title'] as String,
      content: json['content'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
      type: LessonType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => LessonType.text,
      ),
      order: json['order'] as int? ?? 0,
      isCompleted: json['isCompleted'] as bool? ?? false,
      isLocked: json['isLocked'] as bool? ?? true,
    );
  }
}
