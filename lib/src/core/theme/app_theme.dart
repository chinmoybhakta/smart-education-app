import 'package:flutter/material.dart';
import 'package:smart_edu_again/src/core/theme/part/app_bar_theme.dart';
import 'package:smart_edu_again/src/core/theme/part/elevated_button_theme.dart';
import 'package:smart_edu_again/src/core/theme/part/input_decoration_theme.dart';
import 'package:smart_edu_again/src/core/theme/theme_extension/color_pallete.dart';
import 'package:smart_edu_again/src/core/theme/theme_extension/text_theme.dart';

class AppTheme {
  AppTheme._();
  static ThemeData lightTheme = ThemeData(
    textTheme: AppTextTheme.lightTextTheme,
    elevatedButtonTheme: AppEvaluatedButtonThemes.lightEvaluatedButtonTheme,
    inputDecorationTheme: AppInputDecorationTheme.lightInputDecorationTheme,
    colorScheme: AppColor.lightColorScheme,
    scaffoldBackgroundColor: AppColor.screenBackgroundColor,
    appBarTheme: CustomAppBarTheme.lightAppBarTheme,
  );
}
