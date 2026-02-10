import 'package:flutter/material.dart';
import '../models/subject.dart';
import '../models/lesson.dart';
import '../theme/app_colors.dart';
import '../services/storage_service.dart';

class ProgressProvider extends ChangeNotifier {
  List<Subject> _subjects = [];
  final Map<String, List<Lesson>> _lessons = {};

  List<Subject> get subjects => _subjects;

  ProgressProvider() {
    _initializeData();
  }

  void _initializeData() {
    _subjects = [
      Subject(
        id: 'math',
        name: 'Mathematics',
        nameArabic: 'الرياضيات',
        icon: Icons.calculate_rounded,
        color: AppColors.mathColor,
        totalLessons: 10,
      ),
      Subject(
        id: 'arabic',
        name: 'Arabic',
        nameArabic: 'اللغة العربية',
        icon: Icons.menu_book_rounded,
        color: AppColors.arabicColor,
        totalLessons: 10,
      ),
      Subject(
        id: 'french',
        name: 'French',
        nameArabic: 'اللغة الفرنسية',
        icon: Icons.language_rounded,
        color: AppColors.frenchColor,
        totalLessons: 10,
        backgroundImage: 'assets/images/subjects/french_bg.jpg',
      ),
      Subject(
        id: 'english',
        name: 'English',
        nameArabic: 'اللغة الإنجليزية',
        icon: Icons.translate_rounded,
        color: const Color(0xFFE53935),
        totalLessons: 10,
        backgroundImage: 'assets/images/subjects/english_bg.jpg',
      ),
      Subject(
        id: 'science',
        name: 'Science',
        nameArabic: 'العلوم الطبيعية',
        icon: Icons.science_rounded,
        color: AppColors.scienceColor,
        totalLessons: 10,
        backgroundImage: 'assets/images/subjects/science_bg.png',
      ),
      Subject(
        id: 'history',
        name: 'History',
        nameArabic: 'التاريخ',
        icon: Icons.history_edu_rounded,
        color: AppColors.historyColor,
        totalLessons: 10,
        backgroundImage: 'assets/images/subjects/history_bg.jpg',
      ),
      Subject(
        id: 'geography',
        name: 'Geography',
        nameArabic: 'الجغرافيا',
        icon: Icons.public_rounded,
        color: AppColors.geographyColor,
        totalLessons: 10,
      ),
      Subject(
        id: 'islamic',
        name: 'Islamic Education',
        nameArabic: 'التربية الإسلامية',
        icon: Icons.auto_stories_rounded,
        color: AppColors.islamicColor,
        totalLessons: 10,
        backgroundImage: 'assets/images/subjects/islamic_bg.jpg',
      ),
      Subject(
        id: 'civics',
        name: 'Civic Education',
        nameArabic: 'التربية المدنية',
        icon: Icons.people_rounded,
        color: AppColors.civicsColor,
        totalLessons: 10,
      ),
    ];

    // Initialize lessons for each subject
    for (var subject in _subjects) {
      _lessons[subject.id] = _generateLessons(subject.id);
    }

    _loadProgress();
  }

  List<Lesson> _generateLessons(String subjectId) {
    final lessonTitles = _getLessonTitles(subjectId);
    final completedLessons = StorageService.getCompletedLessons();

    return List.generate(10, (index) {
      final lessonId = '${subjectId}_lesson_$index';
      final isCompleted = completedLessons.contains(lessonId);
      final isFirstOrPreviousCompleted = index == 0 ||
          completedLessons.contains('${subjectId}_lesson_${index - 1}');

      LessonStatus status;
      if (isCompleted) {
        status = LessonStatus.completed;
      } else if (isFirstOrPreviousCompleted) {
        status = LessonStatus.available;
      } else {
        status = LessonStatus.locked;
      }

      return Lesson(
        id: lessonId,
        subjectId: subjectId,
        title: lessonTitles[index]['en']!,
        titleArabic: lessonTitles[index]['ar']!,
        type: _getLessonType(index),
        status: status,
        xpReward: 10 + (index * 2),
        order: index,
      );
    });
  }

  List<Map<String, String>> _getLessonTitles(String subjectId) {
    switch (subjectId) {
      case 'math':
        return [
          {'en': 'Numbers 1-10', 'ar': 'الأعداد من 1 إلى 10'},
          {'en': 'Addition', 'ar': 'الجمع'},
          {'en': 'Subtraction', 'ar': 'الطرح'},
          {'en': 'Numbers 11-20', 'ar': 'الأعداد من 11 إلى 20'},
          {'en': 'Shapes', 'ar': 'الأشكال الهندسية'},
          {'en': 'Counting', 'ar': 'العد'},
          {'en': 'Comparison', 'ar': 'المقارنة'},
          {'en': 'Patterns', 'ar': 'الأنماط'},
          {'en': 'Measurement', 'ar': 'القياس'},
          {'en': 'Review', 'ar': 'مراجعة'},
        ];
      case 'arabic':
        return [
          {'en': 'Letters أ-ث', 'ar': 'الحروف أ-ث'},
          {'en': 'Letters ج-ذ', 'ar': 'الحروف ج-ذ'},
          {'en': 'Letters ر-ض', 'ar': 'الحروف ر-ض'},
          {'en': 'Letters ط-ق', 'ar': 'الحروف ط-ق'},
          {'en': 'Letters ك-ي', 'ar': 'الحروف ك-ي'},
          {'en': 'Short Vowels', 'ar': 'الحركات القصيرة'},
          {'en': 'Long Vowels', 'ar': 'الحركات الطويلة'},
          {'en': 'Simple Words', 'ar': 'كلمات بسيطة'},
          {'en': 'Reading', 'ar': 'القراءة'},
          {'en': 'Review', 'ar': 'مراجعة'},
        ];
      case 'french':
        return [
          {'en': 'Greetings', 'ar': 'التحيات'},
          {'en': 'Colors', 'ar': 'الألوان'},
          {'en': 'Numbers', 'ar': 'الأرقام'},
          {'en': 'Family', 'ar': 'العائلة'},
          {'en': 'Animals', 'ar': 'الحيوانات'},
          {'en': 'Food', 'ar': 'الطعام'},
          {'en': 'Body Parts', 'ar': 'أجزاء الجسم'},
          {'en': 'Classroom', 'ar': 'القسم'},
          {'en': 'Days & Months', 'ar': 'الأيام والأشهر'},
          {'en': 'Review', 'ar': 'مراجعة'},
        ];
      case 'science':
        return [
          {'en': 'Living Things', 'ar': 'الكائنات الحية'},
          {'en': 'Plants', 'ar': 'النباتات'},
          {'en': 'Animals', 'ar': 'الحيوانات'},
          {'en': 'Human Body', 'ar': 'جسم الإنسان'},
          {'en': 'Senses', 'ar': 'الحواس'},
          {'en': 'Water', 'ar': 'الماء'},
          {'en': 'Air', 'ar': 'الهواء'},
          {'en': 'Materials', 'ar': 'المواد'},
          {'en': 'Environment', 'ar': 'البيئة'},
          {'en': 'Review', 'ar': 'مراجعة'},
        ];
      case 'history':
        return [
          {'en': 'My Country', 'ar': 'بلدي'},
          {'en': 'Past & Present', 'ar': 'الماضي والحاضر'},
          {'en': 'Family History', 'ar': 'تاريخ العائلة'},
          {'en': 'National Symbols', 'ar': 'الرموز الوطنية'},
          {'en': 'Holidays', 'ar': 'الأعياد'},
          {'en': 'Famous People', 'ar': 'شخصيات مشهورة'},
          {'en': 'Old & New', 'ar': 'القديم والجديد'},
          {'en': 'Traditions', 'ar': 'التقاليد'},
          {'en': 'Historical Places', 'ar': 'الأماكن التاريخية'},
          {'en': 'Review', 'ar': 'مراجعة'},
        ];
      case 'geography':
        return [
          {'en': 'My Home', 'ar': 'منزلي'},
          {'en': 'My Neighborhood', 'ar': 'حيي'},
          {'en': 'My City', 'ar': 'مدينتي'},
          {'en': 'Directions', 'ar': 'الاتجاهات'},
          {'en': 'Maps', 'ar': 'الخرائط'},
          {'en': 'Land & Water', 'ar': 'اليابسة والماء'},
          {'en': 'Weather', 'ar': 'الطقس'},
          {'en': 'Seasons', 'ar': 'الفصول'},
          {'en': 'Algeria', 'ar': 'الجزائر'},
          {'en': 'Review', 'ar': 'مراجعة'},
        ];
      case 'islamic':
        return [
          {'en': 'Allah', 'ar': 'الله'},
          {'en': 'Prophet Muhammad', 'ar': 'النبي محمد'},
          {'en': 'Prayer', 'ar': 'الصلاة'},
          {'en': 'Wudu', 'ar': 'الوضوء'},
          {'en': 'Good Manners', 'ar': 'الأخلاق الحسنة'},
          {'en': 'Honesty', 'ar': 'الصدق'},
          {'en': 'Respect', 'ar': 'الاحترام'},
          {'en': 'Short Surahs', 'ar': 'السور القصيرة'},
          {'en': 'Daily Duas', 'ar': 'الأدعية اليومية'},
          {'en': 'Review', 'ar': 'مراجعة'},
        ];
      case 'civics':
        return [
          {'en': 'School Rules', 'ar': 'قواعد المدرسة'},
          {'en': 'Respect Others', 'ar': 'احترام الآخرين'},
          {'en': 'Helping Others', 'ar': 'مساعدة الآخرين'},
          {'en': 'Cleanliness', 'ar': 'النظافة'},
          {'en': 'Safety', 'ar': 'السلامة'},
          {'en': 'Environment', 'ar': 'حماية البيئة'},
          {'en': 'Rights & Duties', 'ar': 'الحقوق والواجبات'},
          {'en': 'Citizenship', 'ar': 'المواطنة'},
          {'en': 'Community', 'ar': 'المجتمع'},
          {'en': 'Review', 'ar': 'مراجعة'},
        ];
      default:
        return List.generate(10, (i) => {'en': 'Lesson ${i + 1}', 'ar': 'الدرس ${i + 1}'});
    }
  }

  LessonType _getLessonType(int index) {
    if (index == 9) return LessonType.challenge;
    if (index % 3 == 0) return LessonType.learn;
    if (index % 3 == 1) return LessonType.practice;
    return LessonType.quiz;
  }

  void _loadProgress() {
    final completedLessons = StorageService.getCompletedLessons();

    for (int i = 0; i < _subjects.length; i++) {
      final subjectId = _subjects[i].id;
      final completedCount = completedLessons
          .where((id) => id.startsWith('${subjectId}_'))
          .length;

      _subjects[i] = _subjects[i].copyWith(completedLessons: completedCount);
    }

    notifyListeners();
  }

  List<Lesson> getLessonsForSubject(String subjectId) {
    return _lessons[subjectId] ?? [];
  }

  Subject? getSubject(String subjectId) {
    try {
      return _subjects.firstWhere((s) => s.id == subjectId);
    } catch (e) {
      return null;
    }
  }

  Future<void> completeLesson(String lessonId) async {
    await StorageService.addCompletedLesson(lessonId);

    // Update lessons map
    final parts = lessonId.split('_lesson_');
    if (parts.length == 2) {
      final subjectId = parts[0];
      _lessons[subjectId] = _generateLessons(subjectId);
    }

    _loadProgress();
  }

  int get totalCompletedLessons {
    return _subjects.fold(0, (sum, s) => sum + s.completedLessons);
  }

  double get overallProgress {
    final total = _subjects.fold(0, (sum, s) => sum + s.totalLessons);
    final completed = totalCompletedLessons;
    return total > 0 ? completed / total : 0;
  }
}
