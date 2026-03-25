import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../theme/app_colors.dart';
import '../../../core/router/app_router.dart';
import '../providers/auth_provider.dart';
import '../../../shared/widgets/app_button.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String phone;
  const OtpScreen({super.key, required this.phone});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final _otpCtrl = TextEditingController();
  int _countdown = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      if (_countdown > 0) {
        setState(() => _countdown--);
        _startCountdown();
      } else {
        setState(() => _canResend = true);
      }
    });
  }

  Future<void> _verify() async {
    if (_otpCtrl.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the 6-digit OTP'), behavior: SnackBarBehavior.floating),
      );
      return;
    }
    // In production this would call a real OTP verification API.
    // For now we optimistically mark phone as verified and navigate to shell.
    await ref.read(authStateProvider.notifier).updateUserRecord({'is_phone_verified': true});
    if (mounted) context.go(AppRoutes.shell);
  }

  @override
  void dispose() {
    _otpCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authStateProvider).isLoading;
    final pinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE0E0E0)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
    );
    final focusedPinTheme = pinTheme.copyWith(
      decoration: pinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.primary, width: 2),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary, size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Verify your number 📱',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
              ).animate().fade().slideY(begin: 0.2),
              const SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 15, color: AppColors.textSecondary, height: 1.5),
                  children: [
                    const TextSpan(text: 'We sent a 6-digit OTP to\n'),
                    TextSpan(
                      text: '+91 ${widget.phone}',
                      style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                    ),
                  ],
                ),
              ).animate(delay: 100.ms).fade(),
              const SizedBox(height: 48),
              Center(
                child: Pinput(
                  controller: _otpCtrl,
                  length: 6,
                  defaultPinTheme: pinTheme,
                  focusedPinTheme: focusedPinTheme,
                  onCompleted: (_) => _verify(),
                  keyboardType: TextInputType.number,
                ),
              ).animate(delay: 200.ms).scale(begin: const Offset(0.9, 0.9)).fade(),
              const SizedBox(height: 40),
              AppButton(label: 'Verify OTP', isLoading: isLoading, onPressed: _verify)
                  .animate(delay: 300.ms).fade().slideY(begin: 0.1),
              const SizedBox(height: 24),
              Center(
                child: _canResend
                    ? TextButton(
                        onPressed: () {
                          setState(() {
                            _canResend = false;
                            _countdown = 30;
                          });
                          _startCountdown();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('OTP resent!'), behavior: SnackBarBehavior.floating),
                          );
                        },
                        child: const Text('Resend OTP', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
                      )
                    : Text(
                        'Resend OTP in ${_countdown}s',
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
