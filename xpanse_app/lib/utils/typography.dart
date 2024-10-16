import 'package:flutter/material.dart';

class AppTypography {
  static TextStyle _baseStyle = TextStyle(fontFamily: 'Roboto');

  static TextStyle heading1({Color? color}) => _baseStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: color,
      );

  static TextStyle heading2({Color? color}) => _baseStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle bodyText({Color? color}) => _baseStyle.copyWith(
        fontSize: 16,
        color: color,
      );

  static TextStyle caption({Color? color}) => _baseStyle.copyWith(
        fontSize: 14,
        fontStyle: FontStyle.italic,
        color: color,
      );
}
