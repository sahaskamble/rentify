import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutline;
  final Color? color;
  final IconData? icon;
  final double height;
  final double borderRadius;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isOutline = false,
    this.color,
    this.icon,
    this.height = 56,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.primary;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: isOutline
          ? OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: effectiveColor, width: 1.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
              ),
              child: _child(effectiveColor),
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: effectiveColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
                elevation: 0,
              ),
              child: _child(Colors.white),
            ),
    );
  }

  Widget _child(Color textColor) {
    if (isLoading) {
      return SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          color: isOutline ? AppColors.primary : Colors.white,
        ),
      );
    }
    if (icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: textColor),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: textColor)),
        ],
      );
    }
    return Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: textColor));
  }
}
