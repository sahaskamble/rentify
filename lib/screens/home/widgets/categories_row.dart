import 'package:flutter/material.dart';
import '../../../data/mock_listings.dart';
import 'category_chip.dart';

class CategoriesRow extends StatelessWidget {
  const CategoriesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CategoryChip(
              emoji: category['icon']!,
              label: category['label']!,
            ),
          );
        },
      ),
    );
  }
}
