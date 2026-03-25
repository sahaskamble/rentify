import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class RentalDetailScreen extends StatelessWidget {
  final String rentalId;
  const RentalDetailScreen({super.key, required this.rentalId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.textPrimary), onPressed: () => Navigator.pop(context)),
        title: const Text('Rental Details', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ),
      body: Center(child: Text('Rental: $rentalId', style: const TextStyle(fontSize: 16, color: AppColors.textSecondary))),
    );
  }
}
