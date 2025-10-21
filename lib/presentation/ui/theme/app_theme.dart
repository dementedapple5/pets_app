import 'package:flutter/material.dart';
import 'package:pets_app/presentation/ui/constants/app_sizes.dart';
import 'package:pets_app/presentation/ui/theme/app_colors.dart';
import 'package:pets_app/presentation/ui/theme/app_text_theme.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    final scheme = AppColors.lightColorScheme;
    final textTheme = AppTextTheme.lightTextTheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: textTheme.titleLarge,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.black12,
        labelStyle: textTheme.bodyMedium,
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onSurface.withValues(alpha: 0.6),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: AppRadii.brMedium,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: AppRadii.brMedium,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: AppRadii.brMedium,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          textStyle: textTheme.titleMedium,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.l),
          shape: const RoundedRectangleBorder(borderRadius: AppRadii.brMedium),
          elevation: 0,
        ),
      ),
      cardTheme: const CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppRadii.brLarge),
        margin: EdgeInsets.all(AppSpacing.l),
      ),
      iconTheme: const IconThemeData(size: AppIconSizes.l),
    );
  }

  static ThemeData dark() {
    final scheme = AppColors.darkColorScheme;
    final textTheme = AppTextTheme.darkTextTheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: textTheme.titleLarge,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white12,
        labelStyle: textTheme.bodyMedium,
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onSurface.withValues(alpha: 0.7),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: AppRadii.brMedium,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: AppRadii.brMedium,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: AppRadii.brMedium,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          textStyle: textTheme.titleMedium,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.l),
          shape: const RoundedRectangleBorder(borderRadius: AppRadii.brMedium),
          elevation: 0,
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: AppRadii.brLarge),
        margin: const EdgeInsets.all(AppSpacing.l),
      ),
      iconTheme: const IconThemeData(
        size: AppIconSizes.l,
        color: Colors.white70,
      ),
    );
  }
}
