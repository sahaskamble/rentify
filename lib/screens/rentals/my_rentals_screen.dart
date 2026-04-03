import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:rentify/providers/auth_provider.dart';
import 'package:rentify/services/listing_service.dart';
import 'package:rentify/theme/app_theme.dart';

final myRentingProvider = FutureProvider<List<RecordModel>>((ref) async {
  final user = ref.watch(authStateProvider).user;
  if (user == null) return [];
  final result = await ListingService().pb.collection('rentals').getList(
    filter: "renter = '${user.id}'",
    sort: '-created',
    expand: 'listing,seller,renter',
    perPage: 200,
  );
  return result.items;
});

final myRentingOutProvider = FutureProvider<List<RecordModel>>((ref) async {
  final user = ref.watch(authStateProvider).user;
  if (user == null) return [];
  final result = await ListingService().pb.collection('rentals').getList(
    filter: "seller = '${user.id}'",
    sort: '-created',
    expand: 'listing,seller,renter',
    perPage: 200,
  );
  return result.items;
});

class MyRentalsScreen extends ConsumerWidget {
  const MyRentalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('My Rentals', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink)),
          backgroundColor: AppColors.surface,
          bottom: const TabBar(tabs: [Tab(text: 'Renting'), Tab(text: 'Renting Out')]),
        ),
        body: TabBarView(
          children: [
            _RentalList(asyncRentals: ref.watch(myRentingProvider)),
            _RentalList(asyncRentals: ref.watch(myRentingOutProvider)),
          ],
        ),
      ),
    );
  }
}

class _RentalList extends StatelessWidget {
  const _RentalList({required this.asyncRentals});

  final AsyncValue<List<RecordModel>> asyncRentals;

  @override
  Widget build(BuildContext context) {
    return asyncRentals.when(
      data: (rentals) {
        if (rentals.isEmpty) return const Center(child: Text('No rentals yet'));
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: rentals.length,
          itemBuilder: (_, i) => _RentalCard(rentals[i]),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(child: Text('Failed to load rentals')),
    );
  }
}

class _RentalCard extends StatelessWidget {
  const _RentalCard(this.rental);

  final RecordModel rental;

  @override
  Widget build(BuildContext context) {
    final listing = rental.expand['listing']?.isNotEmpty == true ? rental.expand['listing']!.first : null;
    final images = (listing?.data['images'] as List<dynamic>? ?? []).cast<String>();
    final imageUrl = images.isNotEmpty ? 'https://backend.rentifystore.com/api/files/listings/${listing!.id}/${images.first}' : null;
    final title = listing?.data['title']?.toString() ?? 'Listing';
    final total = (rental.data['total_amount'] as num?)?.toDouble() ?? 0;
    final start = DateTime.tryParse(rental.data['start_date']?.toString() ?? '');
    final end = DateTime.tryParse(rental.data['end_date']?.toString() ?? '');
    final status = rental.data['status']?.toString() ?? 'pending';
    final payStatus = rental.data['payment_status']?.toString() ?? 'pending';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
      child: Row(children: [
        ClipRRect(
          borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
          child: imageUrl == null ? Container(width: 100, height: 100, color: AppColors.surfaceTint) : Image.network(imageUrl, width: 100, height: 100, fit: BoxFit.cover),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text('${_fmt(start)} → ${_fmt(end)}', style: const TextStyle(color: AppColors.muted, fontSize: 12)),
              const SizedBox(height: 4),
              Text('₹${total.toStringAsFixed(0)}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Wrap(spacing: 8, children: [_chip(status, _statusColor(status)), _chip(payStatus, AppColors.muted)]),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _chip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(12)),
      child: Text(text, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }

  Color _statusColor(String status) {
    return switch (status) {
      'pending' => Colors.orange,
      'confirmed' => Colors.blue,
      'active' => Colors.green,
      'completed' => Colors.grey,
      'cancelled' => Colors.red,
      _ => AppColors.muted,
    };
  }

  String _fmt(DateTime? date) {
    if (date == null) return '-';
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]}';
  }
}
