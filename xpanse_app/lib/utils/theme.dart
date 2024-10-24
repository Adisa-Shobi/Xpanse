import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      // textTheme: TextTheme(
      //   displayLarge: AppTypography.displayLarge(),
      //   displayMedium: AppTypography.displayMedium(),
      //   bodyLarge: AppTypography.bodyLarge(),
      //   bodySmall: AppTypography.bodySmall(),
      // ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch:
            MaterialColor(AppColors.primary.value, AppColors.primarySwatch),
      ).copyWith(secondary: AppColors.secondary),
    );
  }
}
