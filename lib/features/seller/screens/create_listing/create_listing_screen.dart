import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class CreateListingScreen extends StatelessWidget {
  final String? editListingId;
  const CreateListingScreen({super.key, this.editListingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          editListingId != null ? 'Edit Listing' : 'Create Listing',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('📝', style: TextStyle(fontSize: 56)),
            SizedBox(height: 16),
            Text(
              'Create Listing form coming soon',
              style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
