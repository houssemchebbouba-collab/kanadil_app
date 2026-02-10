import 'package:flutter/foundation.dart';
import '../models/subject_model.dart';
import '../data/subjects_data.dart';

// ==========================================
// مزود المواد الدراسية - Subject Provider
// ==========================================

class SubjectProvider extends ChangeNotifier {
  List<SubjectModel> _subjects = [];
  String? _selectedSubjectId;
  bool _isLoading = false;

  // الحصول على قائمة المواد
  List<SubjectModel> get subjects => _subjects;

  // الحصول على المادة المحددة
  SubjectModel? get selectedSubject {
    if (_selectedSubjectId == null) return null;
    try {
      return _subjects.firstWhere((s) => s.id == _selectedSubjectId);
    } catch (_) {
      return null;
    }
  }

  // حالة التحميل
  bool get isLoading => _isLoading;

  // تهيئة المواد
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    // TODO: تحميل البيانات من Firebase
    _subjects = SubjectsData.subjects;

    _isLoading = false;
    notifyListeners();
  }

  // تحديد مادة
  void selectSubject(String subjectId) {
    _selectedSubjectId = subjectId;
    notifyListeners();
  }

  // تحديد مادة بواسطة المعرف (alias)
  void selectSubjectById(String subjectId) {
    selectSubject(subjectId);
  }

  // الحصول على مادة بواسطة المعرف
  SubjectModel? getSubjectById(String id) {
    try {
      return _subjects.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  // تحديث تقدم المادة
  void updateSubjectProgress(String subjectId, SubjectModel updatedSubject) {
    final index = _subjects.indexWhere((s) => s.id == subjectId);
    if (index != -1) {
      _subjects[index] = updatedSubject;
      notifyListeners();
    }
  }

  // الحصول على المواد المتاحة فقط
  List<SubjectModel> get availableSubjects {
    return _subjects.where((s) => !s.isLocked).toList();
  }

  // الحصول على إجمالي النجوم
  int get totalStars {
    int stars = 0;
    for (final subject in _subjects) {
      stars += subject.totalStarsEarned;
    }
    return stars;
  }
}
