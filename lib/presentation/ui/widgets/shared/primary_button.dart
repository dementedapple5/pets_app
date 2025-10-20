import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;

  const PrimaryButton({
    super.key,
    required this.title,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor = Colors.black87,
    this.textColor = Colors.white,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
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
              style: TextStyle(
                color: textColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
    );
  }
}
