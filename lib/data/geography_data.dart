import '../models/unit_model.dart';
import '../models/stage_model.dart';
import '../models/lesson_model.dart';

// ==========================================
// بيانات مادة الجغرافيا
// ==========================================
// ملاحظة: سيتم إضافة المحتوى لاحقاً من لوحة التحكم

class GeographyData {
  // قائمة الوحدات - فارغة حالياً
  static List<UnitModel> units = [];

  // قائمة الدروس - فارغة حالياً
  static List<LessonModel> lessons = [];

  // قائمة المراحل - فارغة حالياً
  static List<StageModel> stages = [];

  // TODO: سيتم ملء البيانات من Firebase
  // مثال على هيكل البيانات:
  // static List<UnitModel> units = [
  //   UnitModel(
  //     id: 'geography_unit_1',
  //     subjectId: 'geography',
  //     unitName: 'الوحدة الأولى: الجزائر الموقع والخصائص',
  //     stages: [...],
  //     lessons: [...],
  //     isLocked: false,
  //     isCompleted: false,
  //     progress: 0.0,
  //   ),
  // ];
}
