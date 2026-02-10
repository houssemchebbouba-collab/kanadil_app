import 'package:flutter/material.dart';
import '../../models/subject_model.dart';

// ==========================================
// بطاقة المادة - Subject Card
// ==========================================

class SubjectCard extends StatelessWidget {
  final SubjectModel subject;
  final VoidCallback? onTap;

  const SubjectCard({
    super.key,
    required this.subject,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: subject.isLocked ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          // صورة الخلفية إذا كانت موجودة
          image: subject.hasBackgroundImage
              ? DecorationImage(
                  image: AssetImage(subject.backgroundImage!),
                  fit: BoxFit.cover,
                  colorFilter: subject.isLocked
                      ? const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.saturation,
                        )
                      : null,
                )
              : null,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: (subject.isLocked ? Colors.grey : subject.color)
                  .withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Container(
          // طبقة التدرج فوق الصورة
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: subject.isLocked
                  ? [
                      Colors.grey[400]!.withOpacity(0.9),
                      Colors.grey[500]!.withOpacity(0.85),
                    ]
                  : subject.hasBackgroundImage
                      ? [
                          subject.color.withOpacity(0.7),
                          subject.color.withOpacity(0.5),
                        ]
                      : [
                          subject.color,
                          subject.color.withOpacity(0.8),
                        ],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              // المحتوى الرئيسي
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // الأيقونة
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Icon(
                          subject.icon,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),

                    const Spacer(),

                    // اسم المادة
                    Text(
                      subject.arabicName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 4),

                    // عدد الوحدات
                    Text(
                      '${subject.units.length} وحدات',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.9),
                        shadows: const [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // شريط التقدم
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: subject.totalProgress,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
              ),

              // أيقونة القفل
              if (subject.isLocked)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.lock,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),

              // عدد النجوم
              if (!subject.isLocked && subject.totalStarsEarned > 0)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFFD700),
                          size: 14,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${subject.totalStarsEarned}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
