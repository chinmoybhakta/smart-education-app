import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme_extension/color_pallete.dart';

class AppInputDecorationTheme {
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
    filled: true,
    fillColor: Colors.transparent,
    hintStyle: GoogleFonts.inter(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: AppColor.secondaryTextColor,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.r),
      borderSide: BorderSide(color: AppColor.borderColor, width: 1.w),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.r),
      borderSide: BorderSide(color: AppColor.primaryColor, width: 1.w),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.r),
      borderSide: BorderSide(color: Colors.red, width: 1.w),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.r),
      borderSide: BorderSide(color: AppColor.borderColor, width: 1.w),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme();
}
