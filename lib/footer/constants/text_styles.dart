import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyles {
  static TextStyle heading1 = GoogleFonts.roboto(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
    height: 1.25,
  );

  static TextStyle heading2 = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    height: 1,
  );

  static TextStyle subheading = GoogleFonts.openSans(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1,
  );

  static TextStyle categoryText = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1,
  );

  static TextStyle footerText = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    height: 1,
  );
}