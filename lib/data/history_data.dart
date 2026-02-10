import '../models/unit_model.dart';
import '../models/stage_model.dart';
import '../models/lesson_model.dart';

// ==========================================
// بيانات مادة التاريخ
// ==========================================
// ملاحظة: سيتم إضافة المحتوى لاحقاً من لوحة التحكم

class HistoryData {
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
  //     id: 'history_unit_1',
  //     subjectId: 'history',
  //     unitName: 'الوحدة الأولى: الحرب الباردة',
  //     stages: [...],
  //     lessons: [...],
  //     isLocked: false,
  //     isCompleted: false,
  //     progress: 0.0,
  //   ),
  // ];
}
