import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:rentify/generated/pocketbase/categories_record.dart';
import 'package:rentify/providers/auth_provider.dart';
import 'package:rentify/providers/location_provider.dart';
import 'package:rentify/screens/categories/categories_screen.dart';
import 'package:rentify/services/listing_service.dart';
import 'package:rentify/theme/app_theme.dart';

final listingCategoriesProvider = FutureProvider<List<CategoriesRecord>>((ref) {
  return ListingService().getCategories();
});

class GiveOnRentScreen extends ConsumerStatefulWidget {
  const GiveOnRentScreen({super.key});

  @override
  ConsumerState<GiveOnRentScreen> createState() => _GiveOnRentScreenState();
}

class _GiveOnRentScreenState extends ConsumerState<GiveOnRentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _priceDay = TextEditingController();
  final _priceMonth = TextEditingController();
  final _deposit = TextEditingController();
  final _city = TextEditingController();
  final _area = TextEditingController();
  final _address = TextEditingController();
  final _pincode = TextEditingController();
  final _picker = ImagePicker();

  int _step = 0;
  bool _submitting = false;
  String? _category;
  String _condition = 'good';
  final List<XFile> _images = [];

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _priceDay.dispose();
    _priceMonth.dispose();
    _deposit.dispose();
    _city.dispose();
    _area.dispose();
    _address.dispose();
    _pincode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(listingCategoriesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Give on Rent', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink)),
        backgroundColor: AppColors.surface,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            _StepIndicator(step: _step),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: switch (_step) {
                  0 => _buildBasic(categories),
                  1 => _buildPhotos(),
                  2 => _buildPricing(),
                  _ => _buildLocation(),
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                if (_step > 0)
                  Expanded(child: OutlinedButton(onPressed: () => setState(() => _step -= 1), child: const Text('Back'))),
                if (_step > 0) const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submitting ? null : (_step == 3 ? _submit : _next),
                    child: Text(_step == 3 ? 'Submit Listing' : 'Next'),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasic(AsyncValue<List<CategoriesRecord>> categoriesAsync) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextFormField(controller: _title, maxLength: 100, decoration: const InputDecoration(labelText: 'Title'), validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null),
      const SizedBox(height: 10),
      TextFormField(controller: _description, maxLength: 500, maxLines: 5, decoration: const InputDecoration(labelText: 'Description'), validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null),
      const SizedBox(height: 10),
      categoriesAsync.when(
        data: (categories) => DropdownButtonFormField<String>(
          value: _category,
          items: categories.map((e) => DropdownMenuItem(value: e.id, child: Text(e.name))).toList(),
          onChanged: (value) => setState(() => _category = value),
          decoration: const InputDecoration(labelText: 'Category'),
          validator: (v) => v == null ? 'Required' : null,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Text('Failed to load categories'),
      ),
      const SizedBox(height: 10),
      DropdownButtonFormField<String>(
        value: _condition,
        items: const [
          DropdownMenuItem(value: 'brand_new', child: Text('Brand New')),
          DropdownMenuItem(value: 'like_new', child: Text('Like New')),
          DropdownMenuItem(value: 'good', child: Text('Good')),
          DropdownMenuItem(value: 'fair', child: Text('Fair')),
        ],
        onChanged: (v) => setState(() => _condition = v ?? 'good'),
        decoration: const InputDecoration(labelText: 'Condition'),
      ),
    ]);
  }

  Widget _buildPhotos() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 110,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _images.length,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (_, i) {
            return Stack(children: [
              ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(File(_images[i].path), width: 110, height: 110, fit: BoxFit.cover)),
              Positioned(
                top: 4,
                right: 4,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 14,
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => setState(() => _images.removeAt(i)),
                  ),
                ),
              ),
            ]);
          },
        ),
      ),
      const SizedBox(height: 12),
      OutlinedButton.icon(onPressed: _pickPhotoSheet, icon: const Icon(Icons.add_a_photo), label: const Text('Add Photo')),
      if (_images.isEmpty) const Padding(padding: EdgeInsets.only(top: 10), child: Text('At least 1 image required', style: TextStyle(color: Colors.red))),
    ]);
  }

  Widget _buildPricing() {
    return Column(children: [
      TextFormField(
        controller: _priceDay,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: 'Price per day', prefixText: '₹ '),
        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
        onChanged: (v) {
          final day = double.tryParse(v);
          if (day != null && _priceMonth.text.isEmpty) {
            _priceMonth.text = (day * 25).toStringAsFixed(0);
          }
        },
      ),
      const SizedBox(height: 10),
      TextFormField(controller: _priceMonth, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Price per month', prefixText: '₹ ')),
      const SizedBox(height: 10),
      TextFormField(controller: _deposit, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Deposit amount', prefixText: '₹ ')),
    ]);
  }

  Widget _buildLocation() {
    return Column(children: [
      TextFormField(controller: _city, decoration: const InputDecoration(labelText: 'City'), validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null),
      const SizedBox(height: 10),
      TextFormField(controller: _area, decoration: const InputDecoration(labelText: 'Area/Locality'), validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null),
      const SizedBox(height: 10),
      TextFormField(controller: _address, decoration: const InputDecoration(labelText: 'Full address')),
      const SizedBox(height: 10),
      TextFormField(controller: _pincode, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Pincode')),
      const SizedBox(height: 10),
      OutlinedButton(
        onPressed: () async {
          await ref.read(locationProvider.notifier).fetchCurrentLocation();
          final location = ref.read(locationProvider).valueOrNull;
          if (location != null) {
            _city.text = location.city;
            _area.text = location.area;
          }
        },
        child: const Text('Use My Location'),
      ),
    ]);
  }

  void _next() {
    if (_step == 1 && _images.isEmpty) {
      setState(() {});
      return;
    }
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _step += 1);
    }
  }

  Future<void> _pickPhotoSheet() async {
    if (_images.length >= 5) return;
    await showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(title: const Text('Camera'), onTap: () async {
            final image = await _picker.pickImage(source: ImageSource.camera, imageQuality: 70);
            if (image != null && _images.length < 5) setState(() => _images.add(image));
            if (mounted) Navigator.pop(context);
          }),
          ListTile(title: const Text('Gallery'), onTap: () async {
            final image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
            if (image != null && _images.length < 5) setState(() => _images.add(image));
            if (mounted) Navigator.pop(context);
          }),
        ]),
      ),
    );
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false) || _images.isEmpty) return;
    final user = ref.read(authStateProvider).user;
    if (user == null || _category == null) return;
    setState(() => _submitting = true);

    try {
      final files = <http.MultipartFile>[];
      for (final image in _images) {
        files.add(await http.MultipartFile.fromPath('images', image.path));
      }

      final listing = await ListingService().pb.collection('listings').create(body: {
        'title': _title.text.trim(),
        'description': _description.text.trim(),
        'category': _category,
        'seller': user.id,
        'condition': _condition,
        'status': 'active',
        'price_per_day': double.tryParse(_priceDay.text) ?? 0,
        'price_per_month': _priceMonth.text.trim().isEmpty ? null : double.tryParse(_priceMonth.text),
        'deposit_amount': _deposit.text.trim().isEmpty ? null : double.tryParse(_deposit.text),
        'security_deposit': _deposit.text.trim().isEmpty ? 0 : double.tryParse(_deposit.text) ?? 0,
        'quantity': 1,
        'is_featured': false,
        'images': files,
      });

      await ListingService().pb.collection('listing_locations').create(body: {
        'listing': listing.id,
        'city': _city.text.trim(),
        'address': _area.text.trim(),
        'state': '',
        'pincode': _pincode.text.trim(),
        'country': 'India',
      });

      if (!mounted) return;
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Listing Created'),
          content: const Text('Your item is now live on Rentify.'),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context);
              _formKey.currentState?.reset();
              setState(() {
                _step = 0;
                _images.clear();
              });
            }, child: const Text('List Another')),
            ElevatedButton(onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                this.context,
                MaterialPageRoute(builder: (_) => CategoriesScreen(categoryId: _category)),
              );
            }, child: const Text('View My Listing')),
          ],
        ),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.step});
  final int step;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: List.generate(4, (index) {
          final active = index <= step;
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: index == 3 ? 0 : 6),
              height: 6,
              decoration: BoxDecoration(
                color: active ? AppColors.primary : AppColors.border,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        }),
      ),
    );
  }
}
