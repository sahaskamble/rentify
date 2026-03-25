import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class ListingDetailScreen extends StatelessWidget {
  final String listingId;
  const ListingDetailScreen({super.key, required this.listingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Listing Details', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ),
      body: Center(
        child: Text('Listing: $listingId', style: const TextStyle(fontSize: 16, color: AppColors.textSecondary)),
      ),
    );
  }
}
