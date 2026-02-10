import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

// ==========================================
// شاشة الإعدادات - Settings Screen
// ==========================================

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // قسم المظهر
          _buildSectionTitle('المظهر'),
          _buildSettingCard(
            icon: Icons.dark_mode,
            title: 'الوضع الداكن',
            subtitle: isDark ? 'مفعل' : 'معطل',
            trailing: Switch(
              value: isDark,
              onChanged: (value) => themeProvider.toggleDarkMode(),
            ),
          ),

          const SizedBox(height: 24),

          // قسم الصوت
          _buildSectionTitle('الصوت والإشعارات'),
          _buildSettingCard(
            icon: Icons.volume_up,
            title: 'الأصوات',
            subtitle: 'تفعيل أصوات التطبيق',
            trailing: Switch(
              value: true, // TODO: ربط مع الإعدادات
              onChanged: (value) {},
            ),
          ),
          _buildSettingCard(
            icon: Icons.notifications,
            title: 'الإشعارات',
            subtitle: 'تذكير بالتعلم اليومي',
            trailing: Switch(
              value: true, // TODO: ربط مع الإعدادات
              onChanged: (value) {},
            ),
          ),

          const SizedBox(height: 24),

          // قسم التعلم
          _buildSectionTitle('التعلم'),
          _buildSettingCard(
            icon: Icons.lock_open,
            title: 'فتح جميع الدروس',
            subtitle: 'تجاوز نظام القفل',
            trailing: Switch(
              value: false, // TODO: ربط مع الإعدادات
              onChanged: (value) {},
            ),
          ),

          const SizedBox(height: 24),

          // قسم الحساب
          _buildSectionTitle('الحساب'),
          _buildSettingCard(
            icon: Icons.person,
            title: 'الملف الشخصي',
            subtitle: 'تعديل بيانات الحساب',
            onTap: () => Navigator.pushNamed(context, '/profile'),
          ),
          _buildSettingCard(
            icon: Icons.delete_outline,
            title: 'حذف البيانات',
            subtitle: 'مسح جميع التقدم والإعدادات',
            textColor: Colors.red,
            onTap: () => _showDeleteConfirmation(context),
          ),

          const SizedBox(height: 24),

          // قسم حول
          _buildSectionTitle('حول التطبيق'),
          _buildSettingCard(
            icon: Icons.info_outline,
            title: 'عن قناديل',
            subtitle: 'الإصدار 1.0.0',
            onTap: () => _showAboutDialog(context),
          ),
          _buildSettingCard(
            icon: Icons.privacy_tip_outlined,
            title: 'سياسة الخصوصية',
            onTap: () {
              // TODO: فتح صفحة سياسة الخصوصية
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, right: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    Color? textColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: textColor),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: trailing ?? (onTap != null ? const Icon(Icons.chevron_left) : null),
        onTap: onTap,
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف البيانات'),
        content: const Text(
          'هل أنت متأكد من حذف جميع البيانات؟\nلا يمكن التراجع عن هذا الإجراء.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              // TODO: حذف البيانات
              Navigator.pop(context);
            },
            child: const Text(
              'حذف',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Text('🕯️', style: TextStyle(fontSize: 24)),
            SizedBox(width: 8),
            Text('قناديل'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الإصدار: 1.0.0'),
            SizedBox(height: 8),
            Text(
              'تطبيق تعليمي ممتع لطلاب السنة الرابعة متوسط في الجزائر.',
            ),
            SizedBox(height: 16),
            Text(
              '© 2024 قناديل',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }
}
