import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/leaderboard_provider.dart';
import '../models/leaderboard_model.dart';
import '../core/constants/wilayas.dart';

// ==========================================
// شاشة لوحة المتصدرين - Leaderboard Screen
// ==========================================

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة المتصدرين'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'وطني'),
            Tab(text: 'الولاية'),
            Tab(text: 'السلسلة'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNationalTab(),
          _buildWilayaTab(),
          _buildStreakTab(),
        ],
      ),
    );
  }

  Widget _buildNationalTab() {
    return _buildLeaderboardList(LeaderboardType.national);
  }

  Widget _buildWilayaTab() {
    final provider = context.watch<LeaderboardProvider>();

    return Column(
      children: [
        // اختيار الولاية
        Padding(
          padding: const EdgeInsets.all(16),
          child: DropdownButtonFormField<String>(
            initialValue: provider.selectedWilaya,
            decoration: InputDecoration(
              labelText: 'اختر الولاية',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: AlgerianWilayas.wilayas.map((wilaya) {
              return DropdownMenuItem(value: wilaya, child: Text(wilaya));
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                provider.setWilaya(value);
              }
            },
          ),
        ),
        Expanded(
          child: _buildLeaderboardList(LeaderboardType.wilaya),
        ),
      ],
    );
  }

  Widget _buildStreakTab() {
    return _buildLeaderboardList(LeaderboardType.streak);
  }

  Widget _buildLeaderboardList(LeaderboardType type) {
    final provider = context.watch<LeaderboardProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // TODO: استخدام البيانات الفعلية من Provider
    // حالياً نعرض رسالة فارغة
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.leaderboard,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          const Text(
            'لا توجد بيانات حالياً',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'ابدأ التعلم لتظهر في لوحة المتصدرين!',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
