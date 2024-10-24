import 'package:flutter/material.dart';
import 'colors.dart';

class AppTypography {
  // Base style that other styles will inherit from
  static const TextStyle _baseStyle = TextStyle(
    fontFamily: 'Montserrat',
    color: AppColors.text,  // Using your custom text color (040404)
  );

  // Headings
  static TextStyle h1 = _baseStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h2 = _baseStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h3 = _baseStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  // Body text
  static TextStyle bodyLarge = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static TextStyle bodyMedium = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static TextStyle bodySmall = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.normal,
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