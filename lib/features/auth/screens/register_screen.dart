import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../theme/app_colors.dart';
import '../../../core/router/app_router.dart';
import '../providers/auth_provider.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(authStateProvider.notifier).register(
          name: _nameCtrl.text.trim(),
          email: _emailCtrl.text.trim(),
          password: _passCtrl.text,
          phone: _phoneCtrl.text.trim(),
        );
    if (!mounted) return;
    final state = ref.read(authStateProvider);
    state.whenOrNull(
      data: (s) {
        if (s.isAuthenticated) {
          // Send to OTP screen for phone verification
          context.go('${AppRoutes.otp}?phone=${_phoneCtrl.text.trim()}');
        }
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
    if (raw.contains('email') && raw.contains('unique')) return 'This email is already registered.';
    if (raw.contains('phone') && raw.contains('unique')) return 'This phone number is already registered.';
    if (raw.contains('SocketException')) return 'Cannot connect to server. Check your connection.';
    return 'Registration failed. Please try again.';
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authStateProvider).isLoading;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary, size: 20),
          onPressed: () => context.go(AppRoutes.login),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create Account 🚀',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                ).animate().fade().slideY(begin: 0.2),
                const SizedBox(height: 8),
                const Text(
                  'Join Rentify and start renting or listing today',
                  style: TextStyle(fontSize: 15, color: AppColors.textSecondary),
                ).animate(delay: 50.ms).fade(),
                const SizedBox(height: 32),
                AppTextField(
                  controller: _nameCtrl,
                  label: 'Full Name',
                  hint: 'Rahul Sharma',
                  prefixIcon: Icons.person_outline,
                  validator: (v) => (v == null || v.trim().length < 2) ? 'Enter your full name' : null,
                ).animate(delay: 100.ms).fade().slideY(begin: 0.1),
                const SizedBox(height: 14),
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
                ).animate(delay: 150.ms).fade().slideY(begin: 0.1),
                const SizedBox(height: 14),
                AppTextField(
                  controller: _phoneCtrl,
                  label: 'Mobile Number',
                  hint: '9876543210',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone_outlined,
                  prefixText: '+91 ',
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Phone number is required';
                    if (v.length != 10) return 'Enter a valid 10-digit mobile number';
                    return null;
                  },
                ).animate(delay: 200.ms).fade().slideY(begin: 0.1),
                const SizedBox(height: 14),
                AppTextField(
                  controller: _passCtrl,
                  label: 'Password',
                  hint: '8+ characters',
                  obscureText: _obscurePass,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: _obscurePass ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  onSuffixTap: () => setState(() => _obscurePass = !_obscurePass),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Password is required';
                    if (v.length < 8) return 'At least 8 characters required';
                    return null;
                  },
                ).animate(delay: 250.ms).fade().slideY(begin: 0.1),
                const SizedBox(height: 14),
                AppTextField(
                  controller: _confirmCtrl,
                  label: 'Confirm Password',
                  hint: 'Retype your password',
                  obscureText: _obscureConfirm,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: _obscureConfirm ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  onSuffixTap: () => setState(() => _obscureConfirm = !_obscureConfirm),
                  validator: (v) {
                    if (v != _passCtrl.text) return 'Passwords do not match';
                    return null;
                  },
                ).animate(delay: 300.ms).fade().slideY(begin: 0.1),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'By signing up you agree to our Terms of Service & Privacy Policy.',
                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary.withOpacity(0.8), height: 1.4),
                  ),
                ),
                const SizedBox(height: 28),
                AppButton(
                  label: 'Create Account',
                  isLoading: isLoading,
                  onPressed: _register,
                ).animate(delay: 350.ms).fade().slideY(begin: 0.1),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? ', style: TextStyle(color: AppColors.textSecondary)),
                    GestureDetector(
                      onTap: () => context.go(AppRoutes.login),
                      child: const Text(
                        'Sign In',
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
