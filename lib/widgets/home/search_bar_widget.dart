import 'package:flutter/material.dart';
import 'package:rentify/screens/search/search_page.dart';

/// SearchBarWidget is a non-focusable search input that taps to navigate to SearchPage.
/// Used in HomeAppBar and other screens as a search gateway.
class SearchBarWidget extends StatelessWidget {
  /// Optional callback when tapped (alternative to default navigation)
  final VoidCallback? onTap;

  /// Hint text displayed in the search bar
  final String hintText;

  /// Whether to show mic icon on the right
  final bool showMicIcon;

  const SearchBarWidget({
    super.key,
    this.onTap,
    this.hintText = 'Search for anything...',
    this.showMicIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => _navigateToSearchPage(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade100,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Icon(Icons.search, size: 18, color: Colors.grey.shade600),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                hintText,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            if (showMicIcon)
              Icon(Icons.mic, size: 18, color: Colors.grey.shade600),
          ],
        ),
      ),
    );
  }

  /// Default navigation behavior: push SearchPage
  void _navigateToSearchPage(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const SearchPage()));
  }
}
