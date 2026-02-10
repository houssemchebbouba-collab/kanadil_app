import 'package:flutter/material.dart';
import '../../models/question_models.dart';

// ==========================================
// ودجت سؤال الترتيب - Ordering Widget
// ==========================================

class OrderingWidget extends StatefulWidget {
  final OrderingQuestion question;
  final bool showResult;
  final Function(List<int>) onOrderChanged;

  const OrderingWidget({
    super.key,
    required this.question,
    this.showResult = false,
    required this.onOrderChanged,
  });

  @override
  State<OrderingWidget> createState() => _OrderingWidgetState();
}

class _OrderingWidgetState extends State<OrderingWidget> {
  late List<int> _currentOrder;

  @override
  void initState() {
    super.initState();
    // ترتيب عشوائي للعناصر
    _currentOrder = List.generate(widget.question.items.length, (i) => i);
    _currentOrder.shuffle();
  }

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
          'اسحب العناصر لترتيبها بالشكل الصحيح',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 24),

        // قائمة العناصر القابلة للسحب
        ReorderableListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _currentOrder.length,
          onReorder: widget.showResult ? (_, __) {} : _onReorder,
          itemBuilder: (context, index) {
            final itemIndex = _currentOrder[index];
            final isCorrectPosition = widget.showResult &&
                itemIndex == widget.question.correctOrder[index];

            return _buildItem(
              key: ValueKey(itemIndex),
              index: index,
              text: widget.question.items[itemIndex],
              isCorrect: isCorrectPosition,
            );
          },
        ),
      ],
    );
  }

  Widget _buildItem({
    required Key key,
    required int index,
    required String text,
    bool isCorrect = false,
  }) {
    Color backgroundColor = Colors.white;
    Color borderColor = Colors.grey[300]!;

    if (widget.showResult) {
      if (isCorrect) {
        backgroundColor = const Color(0xFF58CC02).withOpacity(0.1);
        borderColor = const Color(0xFF58CC02);
      } else {
        backgroundColor = const Color(0xFFFF4B4B).withOpacity(0.1);
        borderColor = const Color(0xFFFF4B4B);
      }
    }

    return Container(
      key: key,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Row(
        children: [
          // رقم الترتيب
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: borderColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: borderColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // النص
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          // أيقونة السحب
          if (!widget.showResult)
            Icon(
              Icons.drag_handle,
              color: Colors.grey[400],
            ),
          // أيقونة النتيجة
          if (widget.showResult)
            Icon(
              isCorrect ? Icons.check_circle : Icons.cancel,
              color: isCorrect
                  ? const Color(0xFF58CC02)
                  : const Color(0xFFFF4B4B),
            ),
        ],
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      final item = _currentOrder.removeAt(oldIndex);
      _currentOrder.insert(newIndex, item);
    });
    widget.onOrderChanged(_currentOrder);
  }
}
