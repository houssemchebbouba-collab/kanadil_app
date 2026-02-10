import 'package:flutter/material.dart';

// ==========================================
// ثوابت الحركات - Animation Constants
// ==========================================

class AppAnimations {
  // مدد الحركات - Animation Durations
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);

  // حركات صفحة الدرس - Lesson Screen Animations
  static const Duration lessonTransition = Duration(milliseconds: 400);
  static const Duration questionAppear = Duration(milliseconds: 350);
  static const Duration feedbackDelay = Duration(milliseconds: 200);
  static const Duration resultReveal = Duration(milliseconds: 600);

  // حركات XP والنقاط - XP and Points Animations
  static const Duration xpCountUp = Duration(milliseconds: 1500);
  static const Duration starReveal = Duration(milliseconds: 400);
  static const Duration streakFlame = Duration(milliseconds: 500);

  // المنحنيات - Animation Curves
  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve bounceCurve = Curves.bounceOut;
  static const Curve elasticCurve = Curves.elasticOut;
  static const Curve sharpCurve = Curves.easeOutCubic;
  static const Curve smoothCurve = Curves.easeInOutCubic;

  // حركات البطاقات - Card Animations
  static const Duration cardHover = Duration(milliseconds: 200);
  static const Duration cardPress = Duration(milliseconds: 100);
  static const Duration cardFlip = Duration(milliseconds: 400);

  // حركات شريط التقدم - Progress Bar Animations
  static const Duration progressFill = Duration(milliseconds: 800);
  static const Duration progressPulse = Duration(milliseconds: 1000);

  // حركات الانتقال بين الصفحات - Page Transition
  static const Duration pageTransition = Duration(milliseconds: 300);

  // تأخيرات متتالية للقوائم - Stagger Delays
  static const Duration staggerDelay = Duration(milliseconds: 50);
  static const Duration staggerDelayLong = Duration(milliseconds: 100);
}

// ==========================================
// انتقالات الصفحات - Page Transitions
// ==========================================

class AppPageTransitions {
  // انتقال انزلاقي من اليمين (للـ RTL)
  static PageRouteBuilder<T> slideFromRight<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0); // RTL: من اليسار
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: AppAnimations.pageTransition,
    );
  }

  // انتقال تلاشي
  static PageRouteBuilder<T> fade<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: AppAnimations.pageTransition,
    );
  }

  // انتقال تكبير
  static PageRouteBuilder<T> scale<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeOutCubic;
        var tween = Tween(begin: 0.9, end: 1.0).chain(
          CurveTween(curve: curve),
        );

        return ScaleTransition(
          scale: animation.drive(tween),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      transitionDuration: AppAnimations.pageTransition,
    );
  }

  // انتقال من الأسفل (للنوافذ المنبثقة)
  static PageRouteBuilder<T> slideFromBottom<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeOutCubic;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: AppAnimations.pageTransition,
    );
  }
}

// ==========================================
// حركات مخصصة - Custom Animation Helpers
// ==========================================

class AnimationHelpers {
  // حساب تأخير متتالي للعنصر في القائمة
  static Duration staggerDelay(int index, {Duration? baseDelay}) {
    final delay = baseDelay ?? AppAnimations.staggerDelay;
    return Duration(milliseconds: delay.inMilliseconds * index);
  }

  // منحنى ارتداد مخصص
  static Curve get customBounce => const _CustomBounceCurve();
}

// منحنى ارتداد مخصص
class _CustomBounceCurve extends Curve {
  const _CustomBounceCurve();

  @override
  double transform(double t) {
    if (t < 0.5) {
      return 4 * t * t * t;
    } else {
      final f = (2 * t) - 2;
      return 0.5 * f * f * f + 1;
    }
  }
}
