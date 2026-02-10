import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

// Services
import 'services/storage_service.dart';

// Providers
import 'providers/theme_provider.dart';
import 'providers/user_provider.dart';
import 'providers/progress_provider.dart';
import 'providers/leaderboard_provider.dart';
import 'providers/daily_challenge_provider.dart';
import 'providers/streak_provider.dart';

// Theme
import 'theme/app_theme.dart';

// Screens
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/unit_detail_screen.dart';
import 'screens/lesson_screen.dart';
import 'screens/quiz_results_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/daily_challenge_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/achievements_screen.dart';

// ==========================================
// مسارات التنقل - Named Routes
// ==========================================

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String subjects = '/subjects';
  static const String subjectDetail = '/subject';
  static const String unitDetail = '/unit';
  static const String lesson = '/lesson';
  static const String quizResults = '/quiz-results';
  static const String leaderboard = '/leaderboard';
  static const String dailyChallenge = '/daily-challenge';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String achievements = '/achievements';
}

// ==========================================
// نقطة البداية - Entry Point
// ==========================================

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة خدمة التخزين
  await StorageService.init();

  // تعيين اتجاه الشاشة
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // تعيين لون شريط الحالة
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const KanadilApp());
}

// ==========================================
// التطبيق الرئيسي - Main App
// ==========================================

class KanadilApp extends StatelessWidget {
  const KanadilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // مزودات الحالة - State Providers
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ProgressProvider()),
        ChangeNotifierProvider(create: (_) => LeaderboardProvider()),
        ChangeNotifierProvider(create: (_) => DailyChallengeProvider()),
        ChangeNotifierProvider(create: (_) => StreakProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            // معلومات التطبيق
            title: 'قناديل - Kanadil',
            debugShowCheckedModeBanner: false,

            // دعم اللغة العربية والـ RTL
            locale: const Locale('ar'),
            supportedLocales: const [
              Locale('ar'), // العربية
              Locale('fr'), // الفرنسية
              Locale('en'), // الإنجليزية
            ],

            // مندوبي الترجمة
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            // فرض اتجاه RTL للعربية
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: child!,
              );
            },

            // الثيمات
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,

            // الصفحة الرئيسية
            initialRoute: AppRoutes.splash,

            // مسارات التنقل
            routes: _buildRoutes(),

            // معالجة المسارات مع المعاملات
            onGenerateRoute: _onGenerateRoute,

            // معالجة المسارات غير المعروفة
            onUnknownRoute: (settings) {
              return MaterialPageRoute(
                builder: (_) => const HomeScreen(),
              );
            },
          );
        },
      ),
    );
  }

  // بناء المسارات الثابتة
  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      AppRoutes.splash: (_) => const SplashScreen(),
      AppRoutes.onboarding: (_) => const OnboardingScreen(),
      AppRoutes.home: (_) => const HomeScreen(),
      AppRoutes.leaderboard: (_) => const LeaderboardScreen(),
      AppRoutes.dailyChallenge: (_) => const DailyChallengeScreen(),
      AppRoutes.profile: (_) => const ProfileScreen(),
      AppRoutes.settings: (_) => const SettingsScreen(),
      AppRoutes.achievements: (_) => const AchievementsScreen(),
    };
  }

  // معالجة المسارات مع المعاملات
  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.subjectDetail:
        final args = settings.arguments as Map<String, dynamic>?;

      case AppRoutes.unitDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => UnitDetailScreen(
            subjectId: args?['subjectId'] ?? '',
            unitId: args?['unitId'] ?? '',
          ),
        );

      case AppRoutes.lesson:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => LessonScreen(
            subjectId: args?['subjectId'] ?? '',
            unitId: args?['unitId'] ?? '',
            stageId: args?['stageId'] ?? '',
            lessonId: args?['lessonId'] ?? '',
          ),
        );

      case AppRoutes.quizResults:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => QuizResultsScreen(
            correctAnswers: args?['correctAnswers'] ?? 0,
            totalQuestions: args?['totalQuestions'] ?? 0,
            xpEarned: args?['xpEarned'] ?? 0,
            starsEarned: args?['starsEarned'] ?? 0,
            isPerfect: args?['isPerfect'] ?? false,
          ),
        );

      default:
        return null;
    }
  }
}

// ==========================================
// مساعدات التنقل - Navigation Helpers
// ==========================================

class AppNavigator {
  static void goToSubject(BuildContext context, String subjectId) {
    Navigator.pushNamed(
      context,
      AppRoutes.subjectDetail,
      arguments: {'subjectId': subjectId},
    );
  }

  static void goToUnit(BuildContext context, String subjectId, String unitId) {
    Navigator.pushNamed(
      context,
      AppRoutes.unitDetail,
      arguments: {
        'subjectId': subjectId,
        'unitId': unitId,
      },
    );
  }

  static void goToLesson(
    BuildContext context, {
    required String subjectId,
    required String unitId,
    required String stageId,
    required String lessonId,
  }) {
    Navigator.pushNamed(
      context,
      AppRoutes.lesson,
      arguments: {
        'subjectId': subjectId,
        'unitId': unitId,
        'stageId': stageId,
        'lessonId': lessonId,
      },
    );
  }

  static void goToQuizResults(
    BuildContext context, {
    required int correctAnswers,
    required int totalQuestions,
    required int xpEarned,
    required int starsEarned,
    bool isPerfect = false,
  }) {
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.quizResults,
      arguments: {
        'correctAnswers': correctAnswers,
        'totalQuestions': totalQuestions,
        'xpEarned': xpEarned,
        'starsEarned': starsEarned,
        'isPerfect': isPerfect,
      },
    );
  }

  static void goToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
  }

  static void goToOnboarding(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
  }

  static void goToLeaderboard(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.leaderboard);
  }

  static void goToDailyChallenge(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.dailyChallenge);
  }

  static void goToProfile(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.profile);
  }

  static void goToSettings(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.settings);
  }

  static void goToAchievements(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.achievements);
  }
}
