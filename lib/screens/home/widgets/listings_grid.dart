import 'package:flutter/material.dart';
import '../../../data/mock_listings.dart';
import 'listing_card.dart';

class ListingsGrid extends StatelessWidget {
  const ListingsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.78,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        return ListingCard(item: mockListings[index]);
      }, childCount: mockListings.length),
    );
  }
}
