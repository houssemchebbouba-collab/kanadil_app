import 'package:flutter/material.dart';

// ==========================================
// ودجت الحالة الفارغة - Empty State Widget
// ==========================================

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? actionText;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // الأيقونة
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 50,
                color: Colors.grey[400],
              ),
            ),

            const SizedBox(height: 24),

            // العنوان
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            // العنوان الفرعي
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],

            // زر الإجراء
            if (actionText != null && onAction != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(actionText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ==========================================
// ودجت حالة الخطأ - Error State Widget
// ==========================================

class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorState({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.error_outline,
      title: 'حدث خطأ',
      subtitle: message,
      actionText: onRetry != null ? 'إعادة المحاولة' : null,
      onAction: onRetry,
    );
  }
}

// ==========================================
// ودجت قيد التطوير - Coming Soon Widget
// ==========================================

class ComingSoon extends StatelessWidget {
  final String? feature;

  const ComingSoon({
    super.key,
    this.feature,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.construction,
      title: 'قيد التطوير',
      subtitle: feature != null
          ? 'ميزة "$feature" ستكون متاحة قريباً'
          : 'هذه الميزة ستكون متاحة قريباً',
    );
  }
}
