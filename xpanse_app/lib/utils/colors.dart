import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF40196C);
  static const Color secondary = Color(0xFF14632F);
  static const Color background = Color(0xFFFAFAFA);
  static const Color text = Color(0xFF040404);

  // Purple-based swatch for primary color
  static const Map<int, Color> primarySwatch = {
    50: Color(0xFFECE6F3),
    100: Color(0xFFCFBFE2),
    200: Color(0xFFB095D0),
    300: Color(0xFF906BBE),
    400: Color(0xFF774BB1),
    500: Color(0xFF40196C), //primary color
    600: Color(0xFF391660),
    700: Color(0xFF311251),
    800: Color(0xFF290E43),
    900: Color(0xFF1B0829),
  };

  // Text color swatch (grayscale)
  static const Map<int, Color> textSwatch = {
    50: Color(0xFFEEEEEE),  // For the lines 
    100: Color(0xFFD6D6D6),
    200: Color(0xFFBFBFBF),
    300: Color(0xFFA8A8A8),
    400: Color(0xFF919191),
    500: Color(0xFF7A7A7A),
    600: Color(0xFF626262),
    700: Color(0xFF4B4B4B),
    800: Color(0xFF333333),
    900: Color(0xFF040404),  // text color
  };

  // Green-based swatch for secondary color
  static const Map<int, Color> secondarySwatch = {
    50: Color(0xFFE3F0E9),
    100: Color(0xFFB8D9C8),
    200: Color(0xFF8AC0A4),
    300: Color(0xFF5CA680),
    400: Color(0xFF399365),
    500: Color(0xFF14632F), //secondary color
    600: Color(0xFF11592A),
    700: Color(0xFF0E4D23),
    800: Color(0xFF0B411D),
    900: Color(0xFF072B13),
  };
}