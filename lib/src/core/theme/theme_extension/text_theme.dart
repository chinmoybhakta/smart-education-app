import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'color_pallete.dart';

class AppTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: GoogleFonts.robotoFlex(
      fontSize: 28.sp,
      fontWeight: FontWeight.w700,
      color: AppColor.primaryTextColor,
    ),
    headlineMedium: GoogleFonts.robotoFlex(
      fontSize: 26.sp,
      fontWeight: FontWeight.w700,
      color: AppColor.primaryTextColor,
    ),
    headlineSmall: GoogleFonts.robotoFlex(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.primaryTextColor,
    ),
    titleLarge: GoogleFonts.robotoFlex(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.primaryTextColor,
    ),
    titleMedium: GoogleFonts.robotoFlex(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      color: AppColor.primaryTextColor,
    ),
    titleSmall: GoogleFonts.robotoFlex(
      fontSize: 18.sp,
      fontWeight: FontWeight.w400,
      color: AppColor.primaryTextColor,
    ),
    bodyLarge: GoogleFonts.robotoFlex(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: AppColor.primaryTextColor,
    ),
    bodyMedium: GoogleFonts.robotoFlex(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: AppColor.primaryTextColor,
    ),
    bodySmall: GoogleFonts.robotoFlex(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: AppColor.primaryTextColor,
    ),
    labelLarge: GoogleFonts.robotoFlex(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColor.secondaryTextColor,
    ),
    labelMedium: GoogleFonts.robotoFlex(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: AppColor.secondaryTextColor,
    ),
    labelSmall: GoogleFonts.robotoFlex(
      fontSize: 11.sp,
      fontWeight: FontWeight.w400,
      color: AppColor.secondaryTextColor,
    ),
  );
}
