import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:rentify/providers/auth_provider.dart';
import 'package:rentify/screens/chat/chat_screen.dart';
import 'package:rentify/services/listing_service.dart';
import 'package:rentify/theme/app_theme.dart';

final listingDetailProvider = FutureProvider.family<RecordModel, String>((ref, id) {
  return ListingService().pb.collection('listings').getOne(id, expand: 'seller,category,location');
});

final listingReviewsProvider = FutureProvider.family<List<RecordModel>, String>((ref, id) async {
  final result = await ListingService().pb.collection('reviews').getList(
    filter: "listing = '$id'",
    sort: '-created',
    perPage: 50,
    expand: 'reviewer',
  );
  return result.items;
});

class ListingDetailScreen extends ConsumerWidget {
  const ListingDetailScreen({super.key, required this.listingId});
  final String listingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingAsync = ref.watch(listingDetailProvider(listingId));
    final reviewsAsync = ref.watch(listingReviewsProvider(listingId));
    final me = ref.watch(authStateProvider).user;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: listingAsync.when(
        data: (listing) {
          final images = (listing.data['images'] as List<dynamic>? ?? []).cast<String>();
          final price = (listing.data['price_per_day'] as num?)?.toDouble() ?? 0;
          final month = (listing.data['price_per_month'] as num?)?.toDouble();
          final sellerId = listing.getStringValue('seller');
          final isOwner = me?.id == sellerId;

          return Stack(children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _TopGallery(images: images, listingId: listing.id)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(listing.getStringValue('title'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.ink)),
                      const SizedBox(height: 8),
                      Text(month == null ? '₹${price.toStringAsFixed(0)}/day' : '₹${price.toStringAsFixed(0)}/day  •  ₹${month.toStringAsFixed(0)}/month', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      _ConditionBadge(condition: listing.getStringValue('condition')),
                      const SizedBox(height: 16),
                      _SellerRow(listing: listing),
                      const SizedBox(height: 16),
                      const Text('Description', style: TextStyle(fontWeight: FontWeight.w700)),
                      Text(listing.getStringValue('description'), style: const TextStyle(color: AppColors.muted)),
                      const SizedBox(height: 16),
                      const Text('Location', style: TextStyle(fontWeight: FontWeight.w700)),
                      Text(_location(listing), style: const TextStyle(color: AppColors.muted)),
                      const SizedBox(height: 16),
                      const Text('Reviews', style: TextStyle(fontWeight: FontWeight.w700)),
                      reviewsAsync.when(
                        data: (reviews) => Column(children: [
                          ...reviews.take(3).map((e) => _ReviewTile(e)),
                          if (reviews.length > 3) TextButton(onPressed: () {}, child: const Text('Show all reviews')),
                          if (reviews.isEmpty) const Padding(padding: EdgeInsets.only(top: 6), child: Text('No reviews yet', style: TextStyle(color: AppColors.muted))),
                        ]),
                        loading: () => const Padding(padding: EdgeInsets.only(top: 8), child: CircularProgressIndicator()),
                        error: (_, __) => const Text('Unable to load reviews'),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 48,
              left: 12,
              child: CircleAvatar(
                backgroundColor: Colors.black.withValues(alpha: 0.4),
                child: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back, color: Colors.white)),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _BottomBar(listing: listing, isOwner: isOwner),
            ),
          ]);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => Center(child: ElevatedButton(onPressed: () => ref.invalidate(listingDetailProvider(listingId)), child: const Text('Retry'))),
      ),
    );
  }

  String _location(RecordModel listing) {
    final location = listing.expand['location']?.isNotEmpty == true ? listing.expand['location']!.first : null;
    final city = location?.data['city']?.toString() ?? '';
    final area = location?.data['area']?.toString() ?? location?.data['address']?.toString() ?? '';
    final value = [area, city].where((e) => e.isNotEmpty).join(', ');
    return value.isEmpty ? 'Location not set' : value;
  }
}

class _TopGallery extends StatefulWidget {
  const _TopGallery({required this.images, required this.listingId});
  final List<String> images;
  final String listingId;

  @override
  State<_TopGallery> createState() => _TopGalleryState();
}

class _TopGalleryState extends State<_TopGallery> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return Container(height: 280, color: AppColors.surfaceTint, child: const Center(child: Icon(Icons.image, size: 42, color: AppColors.muted)));
    }
    return SizedBox(
      height: 300,
      child: Stack(children: [
        PageView.builder(
          itemCount: widget.images.length,
          onPageChanged: (value) => setState(() => index = value),
          itemBuilder: (_, i) => Image.network('https://backend.rentifystore.com/api/files/listings/${widget.listingId}/${widget.images[i]}', fit: BoxFit.cover),
        ),
        Positioned(
          bottom: 12,
          left: 0,
          right: 0,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(widget.images.length, (i) => Container(width: i == index ? 18 : 7, height: 7, margin: const EdgeInsets.symmetric(horizontal: 2), decoration: BoxDecoration(color: i == index ? AppColors.primary : AppColors.border, borderRadius: BorderRadius.circular(10))))),
        ),
      ]),
    );
  }
}

class _BottomBar extends ConsumerWidget {
  const _BottomBar({required this.listing, required this.isOwner});
  final RecordModel listing;
  final bool isOwner;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 14),
      child: SafeArea(
        top: false,
        child: isOwner
            ? SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, child: const Text('Edit Listing')))
            : Row(children: [
                Expanded(child: OutlinedButton(onPressed: () => _openChat(context, ref), child: const Text('Chat with Seller'))),
                const SizedBox(width: 10),
                Expanded(child: ElevatedButton(onPressed: () => _rentNow(context, ref), child: const Text('Rent Now'))),
              ]),
      ),
    );
  }

  Future<void> _openChat(BuildContext context, WidgetRef ref) async {
    final me = ref.read(authStateProvider).user;
    if (me == null) return;
    final pb = ListingService().pb;
    final seller = listing.getStringValue('seller');
    final existing = await pb.collection('conversations').getList(filter: "listing = '${listing.id}' && renter = '${me.id}' && seller = '$seller'", perPage: 1);
    final conversation = existing.items.isNotEmpty
        ? existing.items.first
        : await pb.collection('conversations').create(body: {'listing': listing.id, 'renter': me.id, 'seller': seller, 'is_active': true});

    final otherName = listing.expand['seller']?.isNotEmpty == true ? listing.expand['seller']!.first.data['name']?.toString() ?? 'Seller' : 'Seller';
    if (!context.mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => ChatConversationScreen(conversationId: conversation.id, otherUserName: otherName)));
  }

  Future<void> _rentNow(BuildContext context, WidgetRef ref) async {
    final me = ref.read(authStateProvider).user;
    if (me == null) return;
    final pricePerDay = (listing.data['price_per_day'] as num?)?.toDouble() ?? 0;
    final deposit = (listing.data['deposit_amount'] as num?)?.toDouble() ?? (listing.data['security_deposit'] as num?)?.toDouble() ?? 0;
    DateTime? start;
    DateTime? end;
    await showModalBottomSheet(
      context: context,
      builder: (_) => StatefulBuilder(builder: (context, setStateSheet) {
        final days = (start != null && end != null) ? end!.difference(start!).inDays.clamp(1, 999) : 0;
        final total = days * pricePerDay;
        return Container(
          color: AppColors.surface,
          padding: const EdgeInsets.all(16),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            ListTile(title: const Text('Start Date'), subtitle: Text(start?.toString().split(' ').first ?? 'Select'), onTap: () async {
              final picked = await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)));
              if (picked != null) setStateSheet(() => start = picked);
            }),
            ListTile(title: const Text('End Date'), subtitle: Text(end?.toString().split(' ').first ?? 'Select'), onTap: () async {
              final picked = await showDatePicker(context: context, firstDate: start ?? DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)));
              if (picked != null) setStateSheet(() => end = picked);
            }),
            Text('Total: ₹${total.toStringAsFixed(0)}    Deposit: ₹${deposit.toStringAsFixed(0)}'),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (start == null || end == null)
                    ? null
                    : () async {
                        final totalDays = end!.difference(start!).inDays.clamp(1, 999);
                        await ListingService().pb.collection('rentals').create(body: {
                          'listing': listing.id,
                          'renter': me.id,
                          'seller': listing.getStringValue('seller'),
                          'start_date': start!.toIso8601String(),
                          'end_date': end!.toIso8601String(),
                          'total_days': totalDays,
                          'base_amount': totalDays * pricePerDay,
                          'platform_fee': 0,
                          'security_deposit': deposit,
                          'total_amount': totalDays * pricePerDay,
                          'status': 'pending',
                          'payment_status': 'pending',
                          'pickup_type': 'self_pickup',
                        });
                        if (!context.mounted) return;
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Booking request sent')));
                      },
                child: const Text('Confirm Booking'),
              ),
            ),
          ]),
        );
      }),
    );
  }
}

class _SellerRow extends StatelessWidget {
  const _SellerRow({required this.listing});
  final RecordModel listing;
  @override
  Widget build(BuildContext context) {
    final seller = listing.expand['seller']?.isNotEmpty == true ? listing.expand['seller']!.first : null;
    final name = seller?.data['name']?.toString() ?? 'Seller';
    final rating = (seller?.data['avg_rating'] as num?)?.toDouble() ?? 0;
    return Row(children: [
      CircleAvatar(backgroundColor: AppColors.surfaceTint, child: Text(name[0].toUpperCase())),
      const SizedBox(width: 10),
      Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.w700))),
      const Icon(Icons.star, size: 16, color: AppColors.primary),
      Text(rating.toStringAsFixed(1)),
      TextButton(onPressed: () {}, child: const Text('View Profile')),
    ]);
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile(this.review);
  final RecordModel review;
  @override
  Widget build(BuildContext context) {
    final reviewer = review.expand['reviewer']?.isNotEmpty == true ? review.expand['reviewer']!.first : null;
    final name = reviewer?.data['name']?.toString() ?? 'User';
    final rating = (review.data['rating'] as num?)?.toDouble() ?? 0;
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Text(name), const SizedBox(width: 8), const Icon(Icons.star, size: 14, color: AppColors.primary), Text(rating.toStringAsFixed(1))]),
        const SizedBox(height: 4),
        Text(review.getStringValue('comment')),
      ]),
    );
  }
}

class _ConditionBadge extends StatelessWidget {
  const _ConditionBadge({required this.condition});
  final String condition;
  @override
  Widget build(BuildContext context) {
    var color = AppColors.muted;
    var text = condition;
    if (condition == 'brand_new') {
      color = Colors.green;
      text = 'Brand New';
    } else if (condition == 'like_new') {
      color = Colors.teal;
      text = 'Like New';
    } else if (condition == 'good') {
      color = Colors.orange;
      text = 'Good';
    } else if (condition == 'fair') {
      color = Colors.red;
      text = 'Fair';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(14)),
      child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
    );
  }
}
