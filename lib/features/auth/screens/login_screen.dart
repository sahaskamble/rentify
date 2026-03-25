import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../theme/app_colors.dart';
import '../../../core/router/app_router.dart';
import '../providers/auth_provider.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(authStateProvider.notifier).login(
          _emailCtrl.text.trim(),
          _passCtrl.text,
        );
    if (!mounted) return;
    final state = ref.read(authStateProvider);
    state.whenOrNull(
      data: (s) {
        if (s.isAuthenticated) context.go(AppRoutes.shell);
      },
      error: (e, _) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_friendlyError(e.toString())),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
    );
  }

  String _friendlyError(String raw) {
    if (raw.contains('Failed to authenticate')) return 'Invalid email or password.';
    if (raw.contains('SocketException') || raw.contains('Connection')) return 'Cannot connect to server. Check your connection.';
    return 'Something went wrong. Please try again.';
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authStateProvider).isLoading;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                // Logo & header
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.storefront_rounded, color: Colors.white, size: 26),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Rentify',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ).animate().fade(duration: 400.ms).slideX(begin: -0.1),
                const SizedBox(height: 40),
                const Text(
                  'Welcome back! 👋',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                ).animate(delay: 100.ms).fade().slideY(begin: 0.2),
                const SizedBox(height: 8),
                const Text(
                  'Sign in to continue renting',
                  style: TextStyle(fontSize: 15, color: AppColors.textSecondary),
                ).animate(delay: 150.ms).fade(),
                const SizedBox(height: 40),
                AppTextField(
                  controller: _emailCtrl,
                  label: 'Email',
                  hint: 'you@example.com',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Email is required';
                    if (!v.contains('@')) return 'Enter a valid email';
                    return null;
                  },
                ).animate(delay: 200.ms).fade().slideY(begin: 0.1),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _passCtrl,
                  label: 'Password',
                  hint: '••••••••',
                  obscureText: _obscure,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  onSuffixTap: () => setState(() => _obscure = !_obscure),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Password is required';
                    if (v.length < 8) return 'Password must be at least 8 characters';
                    return null;
                  },
                ).animate(delay: 250.ms).fade().slideY(begin: 0.1),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Forgot password?', style: TextStyle(color: AppColors.primary)),
                  ),
                ),
                const SizedBox(height: 8),
                AppButton(
                  label: 'Sign In',
                  isLoading: isLoading,
                  onPressed: _login,
                ).animate(delay: 300.ms).fade().slideY(begin: 0.1),
                const SizedBox(height: 32),
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('OR', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? ", style: TextStyle(color: AppColors.textSecondary)),
                    GestureDetector(
                      onTap: () => context.go(AppRoutes.register),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
