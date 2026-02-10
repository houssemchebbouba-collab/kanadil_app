import 'package:flutter/material.dart';
import '../../models/question_models.dart';

// ==========================================
// ودجت سؤال المطابقة - Matching Widget
// ==========================================

class MatchingWidget extends StatefulWidget {
  final MatchingQuestion question;
  final bool showResult;
  final Function(Map<int, int>) onMatchChanged;

  const MatchingWidget({
    super.key,
    required this.question,
    this.showResult = false,
    required this.onMatchChanged,
  });

  @override
  State<MatchingWidget> createState() => _MatchingWidgetState();
}

class _MatchingWidgetState extends State<MatchingWidget> {
  final Map<int, int> _matches = {};
  int? _selectedLeftIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // السؤال
        Text(
          widget.question.question,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 8),

        Text(
          'اضغط على عنصر من اليمين ثم اضغط على العنصر المناسب من اليسار',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 24),

        // الأعمدة
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // العمود الأيمن
            Expanded(
              child: Column(
                children: List.generate(
                  widget.question.leftItems.length,
                  (index) => _buildLeftItem(index),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // العمود الأيسر
            Expanded(
              child: Column(
                children: List.generate(
                  widget.question.rightItems.length,
                  (index) => _buildRightItem(index),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLeftItem(int index) {
    final isSelected = _selectedLeftIndex == index;
    final isMatched = _matches.containsKey(index);
    final isCorrect = widget.showResult &&
        _matches[index] == widget.question.correctMatches[index];

    Color backgroundColor = Colors.white;
    Color borderColor = Colors.grey[300]!;

    if (widget.showResult && isMatched) {
      if (isCorrect) {
        backgroundColor = const Color(0xFF58CC02).withOpacity(0.1);
        borderColor = const Color(0xFF58CC02);
      } else {
        backgroundColor = const Color(0xFFFF4B4B).withOpacity(0.1);
        borderColor = const Color(0xFFFF4B4B);
      }
    } else if (isSelected) {
      borderColor = const Color(0xFF2B70C9);
      backgroundColor = const Color(0xFF2B70C9).withOpacity(0.1);
    } else if (isMatched) {
      borderColor = const Color(0xFFFFA800);
    }

    return GestureDetector(
      onTap: widget.showResult ? null : () => _selectLeft(index),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Text(
          widget.question.leftItems[index],
          style: const TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildRightItem(int index) {
    final matchedByLeft = _matches.entries
        .where((e) => e.value == index)
        .map((e) => e.key)
        .firstOrNull;
    final isMatched = matchedByLeft != null;
    final isCorrect = widget.showResult &&
        isMatched &&
        widget.question.correctMatches[matchedByLeft] == index;

    Color backgroundColor = Colors.white;
    Color borderColor = Colors.grey[300]!;

    if (widget.showResult && isMatched) {
      if (isCorrect) {
        backgroundColor = const Color(0xFF58CC02).withOpacity(0.1);
        borderColor = const Color(0xFF58CC02);
      } else {
        backgroundColor = const Color(0xFFFF4B4B).withOpacity(0.1);
        borderColor = const Color(0xFFFF4B4B);
      }
    } else if (isMatched) {
      borderColor = const Color(0xFFFFA800);
    }

    return GestureDetector(
      onTap: widget.showResult ? null : () => _selectRight(index),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Text(
          widget.question.rightItems[index],
          style: const TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _selectLeft(int index) {
    setState(() {
      if (_selectedLeftIndex == index) {
        _selectedLeftIndex = null;
      } else {
        _selectedLeftIndex = index;
      }
    });
  }

  void _selectRight(int index) {
    if (_selectedLeftIndex == null) return;

    setState(() {
      _matches[_selectedLeftIndex!] = index;
      _selectedLeftIndex = null;
    });

    widget.onMatchChanged(Map.from(_matches));
  }
}
