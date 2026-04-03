import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:rentify/providers/auth_provider.dart';
import 'package:rentify/providers/profile_provider.dart';
import 'package:rentify/services/profile_service.dart';
import 'package:rentify/theme/app_theme.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _bio = TextEditingController();
  final _city = TextEditingController();
  final _upi = TextEditingController();
  final _picker = ImagePicker();
  XFile? _avatar;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authStateProvider).user;
    final profile = ref.read(sellerProfileProvider).value;
    _name.text = user?.name ?? '';
    _phone.text = user?.phone ?? '';
    _bio.text = profile?.bio ?? '';
    _city.text = profile?.businessName ?? '';
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _bio.dispose();
    _city.dispose();
    _upi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: AppColors.ink),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  final file = await _picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 70,
                  );
                  if (file != null) setState(() => _avatar = file);
                },
                child: CircleAvatar(
                  radius: 42,
                  backgroundColor: AppColors.surfaceTint,
                  backgroundImage: _avatar != null
                      ? FileImage(File(_avatar!.path))
                      : null,
                  child: _avatar == null
                      ? const Icon(Icons.camera_alt, color: AppColors.ink)
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phone,
                decoration: const InputDecoration(labelText: 'Phone number'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _bio,
                maxLength: 500,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Bio'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _city,
                decoration: const InputDecoration(labelText: 'City'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _upi,
                decoration: const InputDecoration(labelText: 'UPI ID'),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saving ? null : _save,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final user = ref.read(authStateProvider).user;
    if (user == null) return;

    setState(() => _saving = true);
    final service = ProfileService();
    try {
      final body = <String, dynamic>{
        'name': _name.text.trim(),
        'phone': _phone.text.trim(),
      };
      if (_avatar != null) {
        body['avatar'] = await http.MultipartFile.fromPath(
          'avatar',
          _avatar!.path,
        );
      }
      await service.pb.collection('users').update(user.id, body: body);

      final existing = await service.pb
          .collection('seller_profiles')
          .getList(filter: "user = '${user.id}'", perPage: 1);
      final sellerBody = {
        'user': user.id,
        'city': _city.text.trim(),
        'bio': _bio.text.trim(),
        'upi_id': _upi.text.trim(),
        'subscription_plan': 'free',
        'is_active': true,
      };
      if (existing.items.isEmpty) {
        await service.pb.collection('seller_profiles').create(body: sellerBody);
      } else {
        await service.pb
            .collection('seller_profiles')
            .update(existing.items.first.id, body: sellerBody);
      }

      ref.invalidate(sellerProfileProvider);
      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profile updated')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
