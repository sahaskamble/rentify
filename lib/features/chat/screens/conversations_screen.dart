import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class ConversationsScreen extends StatelessWidget {
  const ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Messages', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('💬', style: TextStyle(fontSize: 56)),
            SizedBox(height: 16),
            Text('No conversations yet', style: TextStyle(fontSize: 16, color: AppColors.textSecondary)),
            SizedBox(height: 8),
            Text('Start chatting with a seller by viewing any listing', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}
