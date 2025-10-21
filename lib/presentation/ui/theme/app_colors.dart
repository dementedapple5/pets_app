import 'package:flutter/material.dart';

/// Centralized color schemes for light and dark themes.
class AppColors {
  const AppColors._();

  static const Color primary = Color.fromARGB(255, 237, 219, 57);
  static const Color secondary = Color.fromARGB(255, 16, 61, 185);
  static const Color error = Color(0xFFDC2626); // Red-600

  static const Color lightBackground = Color(0xFFF9FAFB); // Gray-50
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightOnBackground = Color(0xFF111827); // Gray-900
  static const Color lightOnSurface = Color.fromARGB(255, 106, 106, 106);
  static const Color lightOutline = Color.fromARGB(
    255,
    181,
    181,
    181,
  ); // Gray-200

  static const Color darkBackground = Color(0xFF0B1220); // Deep indigo
  static const Color darkSurface = Color(0xFF111827); // Gray-900
  static const Color darkOnBackground = Color(0xFFE5E7EB); // Gray-200
  static const Color darkOnSurface = Color(0xFFF9FAFB); // Gray-50
  static const Color darkOutline = Color(0xFF374151); // Gray-700

  static ColorScheme lightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: Colors.white,
    secondary: secondary,
    onSecondary: Colors.white,
    error: error,
    onError: Colors.white,
    surfaceBright: lightSurface,
    surface: lightBackground,
    onSurface: lightOnBackground,
    onSurfaceVariant: lightOnSurface,
    outline: lightOutline,
  );

  static ColorScheme darkColorScheme = const ColorScheme(
    brightness: Brightness.dark,
    primary: primary,
    onPrimary: Colors.white,
    secondary: secondary,
    onSecondary: Colors.white,
    error: error,
    onError: Colors.white,
    surfaceBright: darkSurface,
    surface: darkBackground,
    onSurface: darkOnBackground,
    onSurfaceVariant: darkOnSurface,
    outline: darkOutline,
  );
}
