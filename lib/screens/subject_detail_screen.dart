import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/subject_provider.dart';
import '../widgets/cards/unit_card.dart';
import '../main.dart';

// ==========================================
// شاشة تفاصيل المادة - Subject Detail Screen
// ==========================================

class SubjectDetailScreen extends StatefulWidget {
  final String subjectId;

  const SubjectDetailScreen({
    super.key,
    required this.subjectId,
  });

  @override
  State<SubjectDetailScreen> createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends State<SubjectDetailScreen> {
  @override
  void initState() {
    super.initState();
    // تحديد المادة بناءً على المعرف
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.subjectId.isNotEmpty) {
        context.read<SubjectProvider>().selectSubjectById(widget.subjectId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final subjectProvider = context.watch<SubjectProvider>();
    final subject = subjectProvider.selectedSubject;

    if (subject == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('المادة')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('جاري التحميل...'),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // رأس الصفحة مع صورة الخلفية
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: subject.color,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                subject.arabicName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black45,
                      offset: Offset(0, 1),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // صورة الخلفية إذا كانت موجودة
                  if (subject.hasBackgroundImage)
                    Image.asset(
                      subject.backgroundImage!,
                      fit: BoxFit.cover,
                    )
                  else
                    Container(
                      color: subject.color,
                    ),

                  // طبقة التدرج فوق الصورة
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          subject.color.withOpacity(0.3),
                          subject.color.withOpacity(0.7),
                          subject.color.withOpacity(0.9),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),

                  // المحتوى (الأيقونة وعدد الوحدات)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // حاوية الأيقونة
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            subject.icon,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // عدد الوحدات
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${subject.units.length} وحدات',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // قائمة الوحدات
          subject.units.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: subject.color.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.hourglass_empty,
                            size: 50,
                            color: subject.color,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'لا توجد وحدات حالياً',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'سيتم إضافة المحتوى قريباً',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final unit = subject.units[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: UnitCard(
                          unit: unit,
                          subjectColor: subject.color,
                          onTap: () {
                            AppNavigator.goToUnit(
                              context,
                              widget.subjectId,
                              unit.id,
                            );
                          },
                        ),
                      );
                    },
                    childCount: subject.units.length,
                  ),
                ),
        ],
      ),
    );
  }
}
