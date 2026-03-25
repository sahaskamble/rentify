import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          controller: _searchCtrl,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search cameras, tools, furniture…',
            hintStyle: TextStyle(color: AppColors.textSecondary.withOpacity(0.6), fontSize: 14),
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary, size: 22),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded, color: AppColors.textPrimary),
            onPressed: () {
              // TODO: open filter bottom sheet
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('🔍', style: TextStyle(fontSize: 64)),
            SizedBox(height: 16),
            Text('Search for items to rent', style: TextStyle(fontSize: 17, color: AppColors.textSecondary)),
            SizedBox(height: 8),
            Text('Filter by category, location, price & more', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}
