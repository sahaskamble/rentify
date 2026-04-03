import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify/providers/auth_provider.dart';
import 'package:rentify/screens/auth/login_screen.dart';
import 'package:rentify/theme/app_theme.dart';
import 'package:rentify/widgets/home/home_container.dart';
import 'package:rentify/widgets/location_permission_handler.dart';

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

    // Request location permission after successful authentication
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LocationPermissionHandler.requestLocationPermission(context);
    });

    return const HomeContainer();
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
