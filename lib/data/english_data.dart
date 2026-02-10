import '../models/unit_model.dart';
import '../models/stage_model.dart';
import '../models/lesson_model.dart';

// ==========================================
// بيانات مادة اللغة الإنجليزية
// ==========================================
// ملاحظة: سيتم إضافة المحتوى لاحقاً من لوحة التحكم

class EnglishData {
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
  //     id: 'english_unit_1',
  //     subjectId: 'english',
  //     unitName: 'Unit 1: Personal Information',
  //     stages: [...],
  //     lessons: [...],
  //     isLocked: false,
  //     isCompleted: false,
  //     progress: 0.0,
  //   ),
  // ];
}
