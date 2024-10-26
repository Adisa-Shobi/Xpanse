import 'package:flutter/material.dart';
import 'colors.dart';

class AppTypography {
  // Base style that other styles will inherit from
  static const TextStyle _baseStyle = TextStyle(
    fontFamily: 'Montserrat',
    color: AppColors.text, // Using your custom text color (040404)
  );

  // Headings
  static TextStyle h1 = _baseStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h2 = _baseStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h3 = _baseStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  // Body text
  static TextStyle bodyLarge = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle bodyMedium = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static TextStyle bodySmall = _baseStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );

  // Button text
  static TextStyle button = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  // Caption text
  static TextStyle caption = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
  );
}
