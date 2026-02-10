import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/subject_provider.dart';
import '../widgets/cards/subject_card.dart';

// ==========================================
// شاشة المواد - Subjects Screen
// ==========================================

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subjectProvider = context.watch<SubjectProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('المواد الدراسية'),
        centerTitle: true,
      ),
      body: subjectProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: subjectProvider.subjects.length,
              itemBuilder: (context, index) {
                final subject = subjectProvider.subjects[index];
                return SubjectCard(
                  subject: subject,
                  onTap: () {
                    subjectProvider.selectSubject(subject.id);
                    Navigator.pushNamed(context, '/subject-detail');
                  },
                );
              },
            ),
    );
  }
}
