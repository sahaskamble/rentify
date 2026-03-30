import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:rentify/generated/pocketbase/categories_record.dart';
import 'package:rentify/services/listing_service.dart';
import 'package:rentify/theme/app_theme.dart';

// Riverpod providers for filter state
final selectedCategoryProvider = StateProvider<String?>((ref) => null);
final selectedConditionProvider = StateProvider<String?>((ref) => null);
final selectedSortProvider = StateProvider<String>((ref) => 'newest');
final priceRangeProvider = StateProvider<RangeValues>(
  (ref) => const RangeValues(0, 10000),
);
final cityFilterProvider = StateProvider<String>((ref) => '');

class FilterBottomSheet extends ConsumerStatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  ConsumerState<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends ConsumerState<FilterBottomSheet> {
  late TextEditingController _cityController;
  final List<String> _conditions = [
    'Any',
    'Brand New',
    'Like New',
    'Good',
    'Fair',
  ];

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController(text: ref.read(cityFilterProvider));
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Handle bar
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              // Title
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Filters',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
              // Scrollable content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    // Category section
                    _CategoryFilter(),
                    const SizedBox(height: 24),
                    // Location section
                    _LocationFilter(cityController: _cityController),
                    const SizedBox(height: 24),
                    // Price range section
                    _PriceRangeFilter(),
                    const SizedBox(height: 24),
                    // Sort by section
                    _SortByFilter(),
                    const SizedBox(height: 24),
                    // Condition section
                    _ConditionFilter(conditions: _conditions),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
              // Bottom buttons (fixed)
              Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey.shade200)),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          // Reset all filters
                          ref.read(selectedCategoryProvider.notifier).state =
                              null;
                          ref.read(selectedConditionProvider.notifier).state =
                              null;
                          ref.read(selectedSortProvider.notifier).state =
                              'newest';
                          ref.read(priceRangeProvider.notifier).state =
                              const RangeValues(0, 10000);
                          ref.read(cityFilterProvider.notifier).state = '';
                          _cityController.clear();
                        },
                        child: const Text(
                          'Reset',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.muted,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        child: const Text(
                          'Apply Filters',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Category filter section
class _CategoryFilter extends ConsumerWidget {
  const _CategoryFilter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return FutureBuilder<List<CategoriesRecord>>(
      future: ListingService().getCategories(),
      builder: (context, snapshot) {
        final categories = snapshot.data ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Category',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 10),
            if (snapshot.connectionState == ConnectionState.waiting)
              const CircularProgressIndicator()
            else if (categories.isEmpty)
              Text(
                'No categories available',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: categories
                    .map(
                      (cat) => _FilterChip(
                        label: cat.name,
                        isSelected: selectedCategory == cat.id,
                        onTap: () {
                          ref.read(selectedCategoryProvider.notifier).state =
                              selectedCategory == cat.id ? null : cat.id;
                        },
                      ),
                    )
                    .toList(),
              ),
          ],
        );
      },
    );
  }
}

/// Location filter section
class _LocationFilter extends StatelessWidget {
  final TextEditingController cityController;

  const _LocationFilter({required this.cityController});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Location',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: cityController,
              onChanged: (value) {
                ref.read(cityFilterProvider.notifier).state = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter city name',
                prefixIcon: const Icon(Icons.location_on, size: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Price range filter section
class _PriceRangeFilter extends ConsumerWidget {
  const _PriceRangeFilter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final priceRange = ref.watch(priceRangeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price Range',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.ink,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '₹${priceRange.start.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            Text(
              '₹${priceRange.end.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        RangeSlider(
          values: priceRange,
          min: 0,
          max: 10000,
          divisions: 100,
          activeColor: AppColors.primary,
          inactiveColor: Colors.grey.shade200,
          onChanged: (RangeValues values) {
            ref.read(priceRangeProvider.notifier).state = values;
          },
        ),
      ],
    );
  }
}

/// Sort by filter section
class _SortByFilter extends ConsumerWidget {
  const _SortByFilter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSort = ref.watch(selectedSortProvider);
    final sorts = [
      'Newest',
      'Price: Low to High',
      'Price: High to Low',
      'Top Rated',
    ];
    final sortValues = ['newest', 'price_asc', 'price_desc', 'top_rated'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sort By',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.ink,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: List.generate(sorts.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () {
                  ref.read(selectedSortProvider.notifier).state =
                      sortValues[index];
                },
                child: Row(
                  children: [
                    Radio<String>(
                      value: sortValues[index],
                      groupValue: selectedSort,
                      activeColor: AppColors.primary,
                      onChanged: (value) {
                        if (value != null) {
                          ref.read(selectedSortProvider.notifier).state = value;
                        }
                      },
                    ),
                    Text(
                      sorts[index],
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.ink,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

/// Condition filter section
class _ConditionFilter extends ConsumerWidget {
  final List<String> conditions;

  const _ConditionFilter({required this.conditions});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCondition = ref.watch(selectedConditionProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Condition',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.ink,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: conditions
              .map(
                (condition) => _FilterChip(
                  label: condition,
                  isSelected: selectedCondition == condition,
                  onTap: () {
                    ref.read(selectedConditionProvider.notifier).state =
                        selectedCondition == condition ? null : condition;
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

/// Reusable filter chip widget
class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.surface,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isSelected ? AppColors.primary : AppColors.ink,
          ),
        ),
      ),
    );
  }
}
