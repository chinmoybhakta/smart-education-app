import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme_extension/color_pallete.dart';

class AppEvaluatedButtonThemes {
  AppEvaluatedButtonThemes._();

  //Light mode Evaluated Button Theme
  static final lightEvaluatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99.r)),
      foregroundColor: Colors.white,
      backgroundColor: AppColor.primaryColor,
      textStyle: GoogleFonts.inter(
        textStyle: TextStyle(fontSize: 16.sp),
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
    ),
  );
}
