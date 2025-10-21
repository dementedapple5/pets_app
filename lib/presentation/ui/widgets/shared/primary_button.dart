import 'package:flutter/material.dart';
import 'package:pets_app/presentation/ui/constants/app_sizes.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;

  const PrimaryButton({
    super.key,
    required this.title,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = AppRadii.xlarge,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: 0.0,
      ),
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(
              title,
              style:
                  Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: textColor) ??
                  TextStyle(
                    color: textColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
            ),
    );
  }
}
