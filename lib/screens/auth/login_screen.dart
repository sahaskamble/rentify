import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify/generated/pocketbase/users_record.dart';
import 'package:rentify/providers/auth_provider.dart';
import 'package:rentify/services/auth_service.dart';
import 'package:rentify/theme/app_theme.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _areaController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  UsersRecordRoleEnum _selectedRole = UsersRecordRoleEnum.renter;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    final authState = ref.read(authStateProvider);
    _emailController.text = authState.rememberedEmail;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _areaController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit(AuthState authState) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    try {
      if (authState.mode == AuthMode.login) {
        await ref
            .read(authStateProvider.notifier)
            .login(_emailController.text, _passwordController.text);
      } else {
        await ref
            .read(authStateProvider.notifier)
            .register(
              RegisterPayload(
                email: _emailController.text,
                password: _passwordController.text,
                name: _nameController.text,
                role: _selectedRole,
                phone: _phoneController.text,
                city: _cityController.text,
                area: _areaController.text,
              ),
            );
      }
    } catch (error) {
      if (!mounted) {
        return;
      }

      final message = ref.read(authServiceProvider).readErrorMessage(error);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> _toggleMode(AuthMode mode) async {
    _formKey.currentState?.reset();
    _passwordController.clear();
    _confirmPasswordController.clear();

    await ref.read(authStateProvider.notifier).setMode(mode);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final isRegister = authState.mode == AuthMode.register;
    final theme = Theme.of(context);

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.surfaceTint,
              AppColors.background,
              Color(0xFFEAF7CC),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -110,
              right: -50,
              child: _BackdropOrb(
                size: 220,
                color: AppColors.primary.withValues(alpha: 0.14),
              ),
            ),
            Positioned(
              left: -70,
              bottom: 80,
              child: _BackdropOrb(
                size: 180,
                color: AppColors.accentStrong.withValues(alpha: 0.16),
              ),
            ),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const _BrandHeader(),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: AppColors.surface.withValues(alpha: 0.92),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(color: AppColors.border),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x1A4DAD39),
                                blurRadius: 30,
                                offset: Offset(0, 18),
                              ),
                            ],
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  isRegister
                                      ? 'Create your account'
                                      : 'Welcome back',
                                  style: theme.textTheme.titleLarge,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  isRegister
                                      ? 'Join Rentify to rent, lend, and manage listings with a secure account.'
                                      : 'Sign in to continue managing bookings, messages, and verified rentals.',
                                  style: theme.textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 20),
                                SegmentedButton<AuthMode>(
                                  showSelectedIcon: false,
                                  segments: const [
                                    ButtonSegment(
                                      value: AuthMode.login,
                                      label: Text('Sign in'),
                                    ),
                                    ButtonSegment(
                                      value: AuthMode.register,
                                      label: Text('Create account'),
                                    ),
                                  ],
                                  selected: {authState.mode},
                                  onSelectionChanged: (selection) {
                                    _toggleMode(selection.first);
                                  },
                                ),
                                const SizedBox(height: 24),
                                if (isRegister) ...[
                                  TextFormField(
                                    controller: _nameController,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                      labelText: 'Full name',
                                      prefixIcon: Icon(Icons.person_outline),
                                    ),
                                    validator: (value) {
                                      if (!isRegister) {
                                        return null;
                                      }

                                      if (value == null ||
                                          value.trim().length < 2) {
                                        return 'Enter your full name.';
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 14),
                                  DropdownButtonFormField<UsersRecordRoleEnum>(
                                    initialValue: _selectedRole,
                                    decoration: const InputDecoration(
                                      labelText: 'Account type',
                                      prefixIcon: Icon(Icons.badge_outlined),
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                        value: UsersRecordRoleEnum.renter,
                                        child: Text('Renter'),
                                      ),
                                      DropdownMenuItem(
                                        value: UsersRecordRoleEnum.seller,
                                        child: Text('Seller'),
                                      ),
                                      DropdownMenuItem(
                                        value: UsersRecordRoleEnum.both,
                                        child: Text('Both'),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      if (value == null) {
                                        return;
                                      }

                                      setState(() => _selectedRole = value);
                                    },
                                  ),
                                  const SizedBox(height: 14),
                                ],
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    labelText: 'Email address',
                                    prefixIcon: Icon(Icons.alternate_email),
                                  ),
                                  validator: (value) {
                                    final email = value?.trim() ?? '';
                                    if (email.isEmpty) {
                                      return 'Enter your email address.';
                                    }
                                    if (!email.contains('@') ||
                                        !email.contains('.')) {
                                      return 'Enter a valid email address.';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 14),
                                if (isRegister) ...[
                                  TextFormField(
                                    controller: _phoneController,
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                      labelText: 'Phone number',
                                      prefixIcon: Icon(Icons.call_outlined),
                                    ),
                                    validator: (value) {
                                      final phone = value?.trim() ?? '';
                                      if (phone.isEmpty) {
                                        return null;
                                      }

                                      final phonePattern = RegExp(
                                        r'^[0-9+]{10,15}$',
                                      );
                                      if (!phonePattern.hasMatch(phone)) {
                                        return 'Use a valid 10 to 15 digit phone number.';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 14),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: _cityController,
                                          textInputAction: TextInputAction.next,
                                          decoration: const InputDecoration(
                                            labelText: 'City',
                                            prefixIcon: Icon(
                                              Icons.location_city,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: TextFormField(
                                          controller: _areaController,
                                          textInputAction: TextInputAction.next,
                                          decoration: const InputDecoration(
                                            labelText: 'Area',
                                            prefixIcon: Icon(
                                              Icons.place_outlined,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 14),
                                ],
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: _obscurePassword,
                                  textInputAction: isRegister
                                      ? TextInputAction.next
                                      : TextInputAction.done,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon: const Icon(Icons.lock_outline),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.length < 8) {
                                      return 'Password must be at least 8 characters.';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 14),
                                if (isRegister) ...[
                                  TextFormField(
                                    controller: _confirmPasswordController,
                                    obscureText: _obscureConfirmPassword,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      labelText: 'Confirm password',
                                      prefixIcon: const Icon(
                                        Icons.verified_user_outlined,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obscureConfirmPassword =
                                                !_obscureConfirmPassword;
                                          });
                                        },
                                        icon: Icon(
                                          _obscureConfirmPassword
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (!isRegister) {
                                        return null;
                                      }

                                      if (value != _passwordController.text) {
                                        return 'Passwords do not match.';
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'By continuing you agree to use a secure email and keep your rental profile information accurate.',
                                    style: TextStyle(
                                      color: AppColors.muted,
                                      fontSize: 12,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 24),
                                ElevatedButton(
                                  onPressed: authState.isSubmitting
                                      ? null
                                      : () => _submit(authState),
                                  child: authState.isSubmitting
                                      ? const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          isRegister
                                              ? 'Create account'
                                              : 'Sign in',
                                        ),
                                ),
                                const SizedBox(height: 14),
                                TextButton(
                                  onPressed: authState.isSubmitting
                                      ? null
                                      : () => _toggleMode(
                                          isRegister
                                              ? AuthMode.login
                                              : AuthMode.register,
                                        ),
                                  child: Text(
                                    isRegister
                                        ? 'Already have an account? Sign in'
                                        : 'New to Rentify? Create an account',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          height: 92,
          width: 92,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A4DAD39),
                blurRadius: 26,
                offset: Offset(0, 12),
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/rentify_logo-1.jpeg', fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Rentify',
          style: theme.textTheme.headlineMedium?.copyWith(letterSpacing: -0.8),
        ),
        const SizedBox(height: 8),
        const Text(
          'Professional rentals, trusted profiles, and a cleaner way to book what you need.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.muted, fontSize: 15, height: 1.5),
        ),
      ],
    );
  }
}

class _BackdropOrb extends StatelessWidget {
  const _BackdropOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}
