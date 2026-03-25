import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class BookingScreen extends StatelessWidget {
  final String listingId;
  const BookingScreen({super.key, required this.listingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.textPrimary), onPressed: () => Navigator.pop(context)),
        title: const Text('Book Item', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ),
      body: const Center(child: Text('📅 Booking flow coming soon', style: TextStyle(fontSize: 16, color: AppColors.textSecondary))),
    );
  }
}
