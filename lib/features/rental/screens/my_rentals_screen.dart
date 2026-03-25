import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../core/router/app_router.dart';

class MyRentalsScreen extends ConsumerWidget {
  const MyRentalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('My Rentals', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          bottom: const TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _EmptyRentals(emoji: '📦', message: 'No active rentals'),
            _EmptyRentals(emoji: '✅', message: 'No completed rentals'),
            _EmptyRentals(emoji: '❌', message: 'No cancelled rentals'),
          ],
        ),
      ),
    );
  }
}

class _EmptyRentals extends StatelessWidget {
  final String emoji;
  final String message;
  const _EmptyRentals({required this.emoji, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 56)),
          const SizedBox(height: 16),
          Text(message, style: const TextStyle(fontSize: 16, color: AppColors.textSecondary)),
          const SizedBox(height: 8),
          const Text('Your rental history will appear here', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
