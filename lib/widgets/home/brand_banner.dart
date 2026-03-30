import 'package:flutter/material.dart';
import 'package:rentify/theme/app_theme.dart';

/// BrandBanner: promotional banner with gradient, text, button, and decorative icon
///
/// Features:
/// - LinearGradient background (primary to accentStrong)
/// - Left-side text content: headline + subheadline
/// - "Explore Now" action button
/// - Right-side decorative icon with Stack positioning
/// - Fully responsive and production-ready
class BrandBanner extends StatelessWidget {
  /// Callback when "Explore Now" button is pressed
  final VoidCallback? onExploreTap;

  /// Headline text (default: "Rent Anything, Anytime")
  final String headlineText;

  /// Subheadline text (default: "Use karo, Kharido mat")
  final String subheadlineText;

  /// Button text (default: "Explore Now")
  final String buttonText;

  /// Decorative icon (default: inventory_2_outlined)
  final IconData decorativeIcon;

  /// Horizontal margin (default: 16)
  final double margin;

  /// Padding inside the banner (default: 24)
  final double padding;

  const BrandBanner({
    super.key,
    this.onExploreTap,
    this.headlineText = 'Rent Anything, Anytime',
    this.subheadlineText = 'Use karo, Kharido mat',
    this.buttonText = 'Explore Now',
    this.decorativeIcon = Icons.inventory_2_outlined,
    this.margin = 16,
    this.padding = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.accentStrong],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Main content (left side, takes 70% of space)
          Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Headline
                Text(
                  headlineText,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),

                // Subheadline
                Text(
                  subheadlineText,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 16),

                // "Explore Now" button
                OutlinedButton(
                  onPressed: onExploreTap,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white, width: 1.5),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Decorative icon (right bottom, absolutely positioned via Stack)
          Positioned(
            right: -16,
            bottom: -8,
            child: Opacity(
              opacity: 0.15,
              child: Icon(decorativeIcon, size: 120, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
