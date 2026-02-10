import 'package:flutter/material.dart';
import '../models/subject_model.dart';

// ==========================================
// بيانات المواد الدراسية - Subjects Data
// ==========================================
// 8 مواد للسنة الرابعة متوسط (المنهج الجزائري)

class SubjectsData {
  static final List<SubjectModel> subjects = [
    const SubjectModel(
      id: 'arabic',
      name: 'Arabic',
      arabicName: 'اللغة العربية',
      iconPath: 'assets/images/subjects/arabic.png',
      color: Color(0xFF2B70C9),
      iconData: Icons.menu_book,
      units: [],
      isLocked: false,
    ),
    const SubjectModel(
      id: 'math',
      name: 'Mathematics',
      arabicName: 'الرياضيات',
      iconPath: 'assets/images/subjects/math.png',
      color: Color(0xFFFF6B35),
      iconData: Icons.calculate,
      units: [],
      isLocked: false,
    ),
    const SubjectModel(
      id: 'science',
      name: 'Science',
      arabicName: 'العلوم الطبيعية',
      iconPath: 'assets/images/subjects/science.png',
      color: Color(0xFF58CC02),
      iconData: Icons.science,
      backgroundImage: 'assets/images/subjects/science_bg.png',
      units: [],
      isLocked: false,
    ),
    const SubjectModel(
      id: 'french',
      name: 'French',
      arabicName: 'اللغة الفرنسية',
      iconPath: 'assets/images/subjects/french.png',
      color: Color(0xFFCE4257),
      iconData: Icons.translate,
      units: [],
      isLocked: false,
    ),
    const SubjectModel(
      id: 'history',
      name: 'History',
      arabicName: 'التاريخ',
      iconPath: 'assets/images/subjects/history.png',
      color: Color(0xFF6B4226),
      iconData: Icons.history_edu,
      units: [],
      isLocked: false,
    ),
    const SubjectModel(
      id: 'geography',
      name: 'Geography',
      arabicName: 'الجغرافيا',
      iconPath: 'assets/images/subjects/geography.png',
      color: Color(0xFF1CB0A6),
      iconData: Icons.public,
      units: [],
      isLocked: false,
    ),
    const SubjectModel(
      id: 'islamic',
      name: 'Islamic Education',
      arabicName: 'التربية الإسلامية',
      iconPath: 'assets/images/subjects/islamic.png',
      color: Color(0xFFFFC845),
      iconData: Icons.auto_stories,
      units: [],
      isLocked: false,
    ),
    const SubjectModel(
      id: 'english',
      name: 'English',
      arabicName: 'اللغة الإنجليزية',
      iconPath: 'assets/images/subjects/english.png',
      color: Color(0xFF7E3AF2),
      iconData: Icons.language,
      units: [],
      isLocked: false,
    ),
  ];

  /// الحصول على مادة بواسطة المعرف
  static SubjectModel? getSubjectById(String id) {
    try {
      return subjects.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  /// الحصول على لون المادة
  static Color getSubjectColor(String id) {
    return getSubjectById(id)?.color ?? Colors.grey;
  }
}
