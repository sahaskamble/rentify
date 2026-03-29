import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify/providers/auth_provider.dart';
import 'package:rentify/screens/auth/login_screen.dart';
import 'package:rentify/theme/app_theme.dart';
import 'package:rentify/widgets/custom_bottom_navbar.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    if (authState.isInitializing) {
      return const _AuthLoadingScreen();
    }

    if (!authState.isAuthenticated) {
      return const LoginScreen();
    }

    return const CustomBottomNav();
  }
}

class _AuthLoadingScreen extends StatelessWidget {
  const _AuthLoadingScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.surfaceTint, AppColors.background],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Restoring your session...'),
            ],
          ),
        ),
      ),
    );
  }
}
