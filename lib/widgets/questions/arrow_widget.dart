import 'package:flutter/material.dart';
import '../../models/question_models.dart';

// ==========================================
// ودجت سؤال الأسهم - Arrow Widget
// ==========================================
// مشابه لـ MatchingWidget لكن مع رسم الأسهم

class ArrowWidget extends StatefulWidget {
  final ArrowQuestion question;
  final bool showResult;
  final Function(Map<int, int>) onConnectionChanged;

  const ArrowWidget({
    super.key,
    required this.question,
    this.showResult = false,
    required this.onConnectionChanged,
  });

  @override
  State<ArrowWidget> createState() => _ArrowWidgetState();
}

class _ArrowWidgetState extends State<ArrowWidget> {
  final Map<int, int> _connections = {};
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
          'اربط العناصر المتناسبة بالأسهم',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 24),

        // الأعمدة مع الأسهم
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

            // مساحة للأسهم
            const SizedBox(width: 40),

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

        // TODO: رسم الأسهم بين العناصر المتصلة
        // يمكن استخدام CustomPainter لرسم الخطوط
      ],
    );
  }

  Widget _buildLeftItem(int index) {
    final isSelected = _selectedLeftIndex == index;
    final isConnected = _connections.containsKey(index);
    final isCorrect = widget.showResult &&
        _connections[index] == widget.question.correctConnections[index];

    Color backgroundColor = Colors.white;
    Color borderColor = Colors.grey[300]!;

    if (widget.showResult && isConnected) {
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
    } else if (isConnected) {
      borderColor = const Color(0xFFFFA800);
    }

    return GestureDetector(
      onTap: widget.showResult ? null : () => _selectLeft(index),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.question.leftItems[index],
                style: const TextStyle(fontSize: 14),
              ),
            ),
            // نقطة الاتصال
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: isConnected || isSelected ? borderColor : Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightItem(int index) {
    final connectedByLeft = _connections.entries
        .where((e) => e.value == index)
        .map((e) => e.key)
        .firstOrNull;
    final isConnected = connectedByLeft != null;
    final isCorrect = widget.showResult &&
        isConnected &&
        widget.question.correctConnections[connectedByLeft] == index;

    Color backgroundColor = Colors.white;
    Color borderColor = Colors.grey[300]!;

    if (widget.showResult && isConnected) {
      if (isCorrect) {
        backgroundColor = const Color(0xFF58CC02).withOpacity(0.1);
        borderColor = const Color(0xFF58CC02);
      } else {
        backgroundColor = const Color(0xFFFF4B4B).withOpacity(0.1);
        borderColor = const Color(0xFFFF4B4B);
      }
    } else if (isConnected) {
      borderColor = const Color(0xFFFFA800);
    }

    return GestureDetector(
      onTap: widget.showResult ? null : () => _selectRight(index),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Row(
          children: [
            // نقطة الاتصال
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: isConnected ? borderColor : Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.question.rightItems[index],
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
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
      _connections[_selectedLeftIndex!] = index;
      _selectedLeftIndex = null;
    });

    widget.onConnectionChanged(Map.from(_connections));
  }
}
