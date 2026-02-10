import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/user_provider.dart';
import '../providers/progress_provider.dart';
import '../models/quiz_data.dart';
import '../services/color_extraction_service.dart';
import '../widgets/quiz/hexagonal_option_button.dart';
import '../widgets/quiz/feedback_box.dart';
import '../widgets/bottom_nav_bar.dart';
import 'results_screen.dart';

/// A generic, dynamic quiz screen that adapts to any subject
///
/// Features:
/// - Dynamic background based on subject
/// - Dynamic color extraction from background images
/// - Metallic UI components with rivets
/// - Hexagonal answer buttons
/// - Animated feedback system
class GamifiedQuizScreen extends StatefulWidget {
  final String lessonId;
  final String subjectId;

  const GamifiedQuizScreen({
    super.key,
    required this.lessonId,
    required this.subjectId,
  });

  @override
  State<GamifiedQuizScreen> createState() => _GamifiedQuizScreenState();
}

class _GamifiedQuizScreenState extends State<GamifiedQuizScreen>
    with TickerProviderStateMixin {
  late QuizData _quizData;
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  int? _selectedAnswer;
  bool _answered = false;
  bool _showFeedback = false;

  // Dynamic colors extracted from background
  ExtractedColors _extractedColors = ExtractedColors.defaultColors();

  late AnimationController _feedbackController;
  late Animation<double> _feedbackAnimation;

  @override
  void initState() {
    super.initState();
    _initializeQuizData();
    _setupAnimations();
    _extractColors();
  }

  void _initializeQuizData() {
    final progressProvider = context.read<ProgressProvider>();
    final subject = progressProvider.getSubject(widget.subjectId);
    final lesson = progressProvider.getLessonsForSubject(widget.subjectId)
        .firstWhere(
          (l) => l.id == widget.lessonId,
          orElse: () => progressProvider.getLessonsForSubject(widget.subjectId).first,
        );

    _quizData = QuizData.forSubject(
      subjectId: widget.subjectId,
      subjectName: subject?.nameArabic ?? 'المادة',
      lessonId: widget.lessonId,
      lessonName: lesson.titleArabic,
      stageNumber: lesson.order + 1,
      backgroundImage: subject?.backgroundImage,
    );
  }

  /// Extract colors from background image for dynamic theming
  Future<void> _extractColors() async {
    final progressProvider = context.read<ProgressProvider>();
    final subject = progressProvider.getSubject(widget.subjectId);

    final colors = await ColorExtractionService().getColorsForSubject(
      backgroundImage: subject?.backgroundImage,
      fallbackColor: subject?.color,
    );

    if (mounted) {
      setState(() {
        _extractedColors = colors;
      });
    }
  }

  void _setupAnimations() {
    _feedbackController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _feedbackAnimation = CurvedAnimation(
      parent: _feedbackController,
      curve: Curves.easeOutBack,
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _selectAnswer(int index) {
    if (_answered) return;

    setState(() {
      _selectedAnswer = index;
      _answered = true;
      if (_quizData.questions[_currentQuestionIndex].isCorrect(index)) {
        _correctAnswers++;
      }
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() => _showFeedback = true);
        _feedbackController.forward();
      }
    });
  }

  void _nextQuestion() {
    _feedbackController.reverse().then((_) {
      if (_currentQuestionIndex < _quizData.questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _selectedAnswer = null;
          _answered = false;
          _showFeedback = false;
        });
      } else {
        _finishQuiz();
      }
    });
  }

  Future<void> _finishQuiz() async {
    final progressProvider = context.read<ProgressProvider>();
    final userProvider = context.read<UserProvider>();

    final isPerfect = _correctAnswers == _quizData.questions.length;
    final xpEarned = isPerfect ? 15 : 10;

    await progressProvider.completeLesson(widget.lessonId);
    await userProvider.addXP(xpEarned);
    await userProvider.completeLesson(isPerfect: isPerfect);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          correctAnswers: _correctAnswers,
          totalQuestions: _quizData.questions.length,
          xpEarned: xpEarned,
          subjectId: widget.subjectId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final currentQuestion = _quizData.questions[_currentQuestionIndex];

    return Scaffold(
      body: Stack(
        children: [
          // ===== Background Layer =====
          _buildBackground(),

          // ===== Semi-transparent overlay =====
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.4),
                  ],
                ),
              ),
            ),
          ),

          // ===== Main Content =====
          SafeArea(
            child: Column(
              children: [
                // Header with dynamic colors
                _DynamicQuizHeader(
                  xp: userProvider.user.xp,
                  streak: userProvider.user.streak,
                  colors: _extractedColors,
                  onBackTap: () => _showExitDialog(),
                ).animate().fadeIn().slideY(begin: -0.2, end: 0),

                // Stage Indicator with dynamic colors
                _DynamicStageIndicator(
                  stageNumber: _quizData.stageNumber,
                  stageName: _quizData.lessonName,
                  currentQuestion: _currentQuestionIndex + 1,
                  totalQuestions: _quizData.questions.length,
                  colors: _extractedColors,
                ).animate().fadeIn(delay: 100.ms).slideY(begin: -0.1, end: 0),

                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        // Question Card with dynamic colors
                        _DynamicQuestionCard(
                          questionText: currentQuestion.questionText,
                          imagePath: currentQuestion.imagePath,
                          imageUrl: currentQuestion.imageUrl,
                          colors: _extractedColors,
                        ).animate().fadeIn(delay: 200.ms).scale(
                              begin: const Offset(0.95, 0.95),
                              end: const Offset(1, 1),
                            ),

                        const SizedBox(height: 16),

                        // Answer Options with dynamic colors
                        _buildOptionsGrid(currentQuestion),

                        // Feedback Box
                        if (_showFeedback)
                          AnimatedBuilder(
                            animation: _feedbackAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _feedbackAnimation.value,
                                child: Opacity(
                                  opacity: _feedbackAnimation.value.clamp(0.0, 1.0),
                                  child: child,
                                ),
                              );
                            },
                            child: FeedbackBox(
                              explanation: currentQuestion.explanation,
                              isCorrect: currentQuestion.isCorrect(_selectedAnswer ?? -1),
                              onContinue: _nextQuestion,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index != 2) {
            _showExitDialog();
          }
        },
      ),
    );
  }

  Widget _buildBackground() {
    if (_quizData.backgroundImage != null &&
        _quizData.backgroundImage!.isNotEmpty) {
      return Positioned.fill(
        child: Image.asset(
          _quizData.backgroundImage!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildDefaultBackground();
          },
        ),
      );
    }
    return _buildDefaultBackground();
  }

  Widget _buildDefaultBackground() {
    Color bgColor;
    try {
      final colorHex = _quizData.defaultBackgroundColor ?? '#2A2A3A';
      bgColor = Color(int.parse(colorHex.replaceFirst('#', '0xFF')));
    } catch (e) {
      bgColor = const Color(0xFF2A2A3A);
    }

    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              bgColor,
              bgColor.withOpacity(0.8),
              Color.lerp(bgColor, Colors.black, 0.3)!,
            ],
          ),
        ),
        child: CustomPaint(
          painter: _MetallicPatternPainter(baseColor: bgColor),
        ),
      ),
    );
  }

  Widget _buildOptionsGrid(QuizQuestion question) {
    final labels = ['A', 'B', 'C', 'D'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildOptionButton(labels[0], question.options[0], 0, question)
                    .animate().fadeIn(delay: 300.ms).slideX(begin: -0.1, end: 0),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildOptionButton(labels[1], question.options[1], 1, question)
                    .animate().fadeIn(delay: 350.ms).slideX(begin: 0.1, end: 0),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildOptionButton(labels[2], question.options[2], 2, question)
                    .animate().fadeIn(delay: 400.ms).slideX(begin: -0.1, end: 0),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildOptionButton(labels[3], question.options[3], 3, question)
                    .animate().fadeIn(delay: 450.ms).slideX(begin: 0.1, end: 0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(String label, String text, int index, QuizQuestion question) {
    OptionState state = OptionState.normal;

    if (_answered) {
      if (question.isCorrect(index)) {
        state = OptionState.correct;
      } else if (_selectedAnswer == index) {
        state = OptionState.incorrect;
      }
    } else if (_selectedAnswer == index) {
      state = OptionState.selected;
    }

    return _DynamicHexagonalButton(
      label: label,
      text: text,
      state: state,
      enabled: !_answered,
      colors: _extractedColors,
      onTap: () => _selectAnswer(index),
    );
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _extractedColors.dark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: _extractedColors.accent,
            width: 2,
          ),
        ),
        title: const Text(
          'هل تريد الخروج؟',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: const Text(
          'سيتم فقدان تقدمك في هذا الدرس',
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('متابعة', style: TextStyle(color: _extractedColors.light)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('خروج', style: TextStyle(color: Color(0xFFEF5350))),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// DYNAMIC COLOR WIDGETS
// ============================================================================

/// Quiz header with dynamic colors
class _DynamicQuizHeader extends StatelessWidget {
  final int xp;
  final int streak;
  final ExtractedColors colors;
  final VoidCallback? onBackTap;

  const _DynamicQuizHeader({
    required this.xp,
    required this.streak,
    required this.colors,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colors.muted,
            colors.primary,
            colors.secondary,
          ],
        ),
        border: Border.all(color: colors.accent, width: 2),
        boxShadow: [
          BoxShadow(
            color: colors.dark.withOpacity(0.5),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIconButton(Icons.arrow_back_rounded, onBackTap),
          _buildStatBadge(Icons.star_rounded, const Color(0xFFFFD700), xp.toString()),
          _buildStatBadge(Icons.local_fire_department_rounded, const Color(0xFFFF6B35), streak.toString()),
          _buildIconButton(Icons.notifications_rounded, null, showBadge: true),
        ],
      ),
    );
  }

  Widget _buildStatBadge(IconData icon, Color iconColor, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colors.dark.withOpacity(0.3),
        border: Border.all(color: colors.light.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(width: 6),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback? onTap, {bool showBadge = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors.dark.withOpacity(0.3),
          border: Border.all(color: colors.light.withOpacity(0.3), width: 1),
        ),
        child: Stack(
          children: [
            Center(child: Icon(icon, color: Colors.white, size: 22)),
            if (showBadge)
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Stage indicator with dynamic colors
class _DynamicStageIndicator extends StatelessWidget {
  final int stageNumber;
  final String stageName;
  final int currentQuestion;
  final int totalQuestions;
  final ExtractedColors colors;

  const _DynamicStageIndicator({
    required this.stageNumber,
    required this.stageName,
    required this.currentQuestion,
    required this.totalQuestions,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [colors.primary, colors.secondary],
        ),
        border: Border.all(color: colors.accent, width: 2),
        boxShadow: [
          BoxShadow(
            color: colors.dark.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        'مرحلة $stageNumber: $stageName - سؤال $currentQuestion/$totalQuestions',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// Question card with dynamic colors
class _DynamicQuestionCard extends StatelessWidget {
  final String questionText;
  final String? imagePath;
  final String? imageUrl;
  final ExtractedColors colors;

  const _DynamicQuestionCard({
    required this.questionText,
    this.imagePath,
    this.imageUrl,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imagePath != null || imageUrl != null;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [colors.primary, colors.secondary, colors.primary.withOpacity(0.9)],
        ),
        border: Border.all(color: colors.accent, width: 3),
        boxShadow: [
          BoxShadow(
            color: colors.dark.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          children: [
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hasImage) ...[
                    Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: colors.accent, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: _buildImage(),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  Text(
                    questionText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // Rivets
            Positioned(top: 8, left: 8, child: _buildRivet()),
            Positioned(top: 8, right: 8, child: _buildRivet()),
            Positioned(bottom: 8, left: 8, child: _buildRivet()),
            Positioned(bottom: 8, right: 8, child: _buildRivet()),
          ],
        ),
      ),
    );
  }

  Widget _buildRivet() {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [colors.light, colors.muted, colors.primary],
        ),
        border: Border.all(color: colors.secondary, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (imagePath != null) {
      return Image.asset(
        imagePath!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildPlaceholder(),
      );
    } else if (imageUrl != null) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildPlaceholder(),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: colors.secondary,
      child: const Center(
        child: Icon(Icons.image_rounded, color: Colors.white54, size: 48),
      ),
    );
  }
}

/// Hexagonal button with dynamic colors
class _DynamicHexagonalButton extends StatefulWidget {
  final String label;
  final String text;
  final OptionState state;
  final bool enabled;
  final ExtractedColors colors;
  final VoidCallback? onTap;

  const _DynamicHexagonalButton({
    required this.label,
    required this.text,
    required this.state,
    required this.enabled,
    required this.colors,
    this.onTap,
  });

  @override
  State<_DynamicHexagonalButton> createState() => _DynamicHexagonalButtonState();
}

class _DynamicHexagonalButtonState extends State<_DynamicHexagonalButton> {
  bool _isPressed = false;

  Color get _backgroundColor {
    switch (widget.state) {
      case OptionState.correct:
        return const Color(0xFF2E7D32);
      case OptionState.incorrect:
        return const Color(0xFFC62828);
      case OptionState.selected:
        return widget.colors.primary;
      case OptionState.normal:
      default:
        return widget.colors.dark;
    }
  }

  Color get _borderColor {
    switch (widget.state) {
      case OptionState.correct:
        return const Color(0xFF4CAF50);
      case OptionState.incorrect:
        return const Color(0xFFEF5350);
      case OptionState.selected:
        return widget.colors.light;
      case OptionState.normal:
      default:
        return widget.colors.muted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.enabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: widget.enabled ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel: widget.enabled ? () => setState(() => _isPressed = false) : null,
      onTap: widget.enabled ? widget.onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: Matrix4.identity()..scale(_isPressed ? 0.95 : 1.0),
        child: CustomPaint(
          painter: _DynamicHexagonPainter(
            backgroundColor: _backgroundColor,
            borderColor: _borderColor,
            showGlow: widget.state != OptionState.normal,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                    border: Border.all(color: Colors.white.withOpacity(0.4), width: 1),
                  ),
                  child: Center(
                    child: Text(
                      widget.label,
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    widget.text,
                    style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (widget.state == OptionState.correct) ...[
                  const SizedBox(width: 8),
                  const Icon(Icons.check_circle, color: Colors.white, size: 20),
                ] else if (widget.state == OptionState.incorrect) ...[
                  const SizedBox(width: 8),
                  const Icon(Icons.cancel, color: Colors.white, size: 20),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DynamicHexagonPainter extends CustomPainter {
  final Color backgroundColor;
  final Color borderColor;
  final bool showGlow;

  _DynamicHexagonPainter({
    required this.backgroundColor,
    required this.borderColor,
    this.showGlow = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = _createHexagonPath(size);

    if (showGlow) {
      final glowPaint = Paint()
        ..color = borderColor.withOpacity(0.4)
        ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 8);
      canvas.drawPath(path, glowPaint);
    }

    final shadowPath = path.shift(const Offset(2, 3));
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawPath(shadowPath, shadowPaint);

    final rect = path.getBounds();
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        backgroundColor.withOpacity(0.9),
        backgroundColor,
        backgroundColor.withOpacity(0.8),
      ],
    );
    final backgroundPaint = Paint()..shader = gradient.createShader(rect);
    canvas.drawPath(path, backgroundPaint);

    final highlightPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.center,
        colors: [Colors.white.withOpacity(0.2), Colors.transparent],
      ).createShader(rect);
    canvas.drawPath(path, highlightPaint);

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawPath(path, borderPaint);
  }

  Path _createHexagonPath(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;
    const cornerRadius = 8.0;
    const sideInset = 15.0;

    path.moveTo(sideInset, h / 2);
    path.lineTo(cornerRadius + 2, cornerRadius);
    path.quadraticBezierTo(cornerRadius, 0, cornerRadius * 2, 0);
    path.lineTo(w - cornerRadius * 2, 0);
    path.quadraticBezierTo(w - cornerRadius, 0, w - cornerRadius - 2, cornerRadius);
    path.lineTo(w - sideInset, h / 2);
    path.lineTo(w - cornerRadius - 2, h - cornerRadius);
    path.quadraticBezierTo(w - cornerRadius, h, w - cornerRadius * 2, h);
    path.lineTo(cornerRadius * 2, h);
    path.quadraticBezierTo(cornerRadius, h, cornerRadius + 2, h - cornerRadius);
    path.close();

    return path;
  }

  @override
  bool shouldRepaint(covariant _DynamicHexagonPainter oldDelegate) {
    return backgroundColor != oldDelegate.backgroundColor ||
        borderColor != oldDelegate.borderColor ||
        showGlow != oldDelegate.showGlow;
  }
}

class _MetallicPatternPainter extends CustomPainter {
  final Color baseColor;

  _MetallicPatternPainter({required this.baseColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.03)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const spacing = 30.0;
    for (double i = -size.height; i < size.width + size.height; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i + size.height, size.height), paint);
    }

    final circlePaint = Paint()
      ..color = Colors.white.withOpacity(0.02)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 5; i++) {
      final x = (size.width / 4) * (i % 3);
      final y = (size.height / 3) * (i ~/ 3);
      canvas.drawCircle(Offset(x, y), 100 + (i * 20), circlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
