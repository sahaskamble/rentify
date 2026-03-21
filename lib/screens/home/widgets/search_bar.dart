import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class RentifySearchBar extends StatelessWidget {
  const RentifySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'What do you want to rent?',
          hintStyle: TextStyle(color: AppColors.navInactive, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: AppColors.navInactive),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
