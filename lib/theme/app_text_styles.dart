import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle get appTitle => GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static TextStyle get sectionHeading => GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static TextStyle get tagline => GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle get cardTitle => GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get cardPrice => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.priceTag,
  );

  static TextStyle get categoryLabel => GoogleFonts.poppins(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static TextStyle get sectionTitle => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
}
