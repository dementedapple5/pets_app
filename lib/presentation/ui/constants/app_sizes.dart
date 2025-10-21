import 'package:flutter/material.dart';

/// Centralized design constants for spacing, radii, and icon sizes.
class AppSpacing {
  const AppSpacing._();

  static const double xs = 4.0;
  static const double s = 8.0;
  static const double m = 12.0;
  static const double l = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
}

class AppRadii {
  const AppRadii._();

  static const double small = 8.0;
  static const double medium = 12.0;
  static const double large = 16.0;
  static const double xlarge = 24.0;
  static const BorderRadius brSmall = BorderRadius.all(Radius.circular(small));
  static const BorderRadius brMedium = BorderRadius.all(
    Radius.circular(medium),
  );
  static const BorderRadius brLarge = BorderRadius.all(Radius.circular(large));
  static const BorderRadius brXLarge = BorderRadius.all(
    Radius.circular(xlarge),
  );
}

class AppIconSizes {
  const AppIconSizes._();

  static const double s = 16.0;
  static const double m = 20.0;
  static const double l = 24.0;
  static const double xl = 28.0;
  static const double xxl = 32.0;
  static const double xxxl = 40.0;
}
