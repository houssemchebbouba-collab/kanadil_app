enum LessonStatus {
  locked,
  available,
  completed,
  perfect,
}

enum LessonType {
  learn,
  practice,
  quiz,
  challenge,
}

class Lesson {
  final String id;
  final String subjectId;
  final String title;
  final String titleArabic;
  final LessonType type;
  final LessonStatus status;
  final int xpReward;
  final int stars; // 0-3 stars
  final int order;

  Lesson({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.titleArabic,
    this.type = LessonType.learn,
    this.status = LessonStatus.locked,
    this.xpReward = 10,
    this.stars = 0,
    required this.order,
  });

  bool get isLocked => status == LessonStatus.locked;
  bool get isAvailable => status == LessonStatus.available;
  bool get isCompleted => status == LessonStatus.completed || status == LessonStatus.perfect;
  bool get isPerfect => status == LessonStatus.perfect;

  Lesson copyWith({
    String? id,
    String? subjectId,
    String? title,
    String? titleArabic,
    LessonType? type,
    LessonStatus? status,
    int? xpReward,
    int? stars,
    int? order,
  }) {
    return Lesson(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      title: title ?? this.title,
      titleArabic: titleArabic ?? this.titleArabic,
      type: type ?? this.type,
      status: status ?? this.status,
      xpReward: xpReward ?? this.xpReward,
      stars: stars ?? this.stars,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subjectId': subjectId,
      'title': title,
      'titleArabic': titleArabic,
      'type': type.index,
      'status': status.index,
      'xpReward': xpReward,
      'stars': stars,
      'order': order,
    };
  }

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      subjectId: json['subjectId'],
      title: json['title'],
      titleArabic: json['titleArabic'],
      type: LessonType.values[json['type'] ?? 0],
      status: LessonStatus.values[json['status'] ?? 0],
      xpReward: json['xpReward'] ?? 10,
      stars: json['stars'] ?? 0,
      order: json['order'],
    );
  }
}
