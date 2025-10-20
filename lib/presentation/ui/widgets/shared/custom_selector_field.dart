import 'package:flutter/material.dart';

class CustomSelectorField<T> extends StatelessWidget {
  final String labelText;
  final String hintText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final double borderRadius;
  final Color backgroundColor;
  final String? Function(T?)? validator;
  final bool isExpanded;
  final TextStyle? textStyle;
  final Widget? icon;

  const CustomSelectorField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
    this.borderRadius = 12.0,
    this.backgroundColor = Colors.black12,
    this.validator,
    this.isExpanded = true,
    this.textStyle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      items: items,
      onChanged: onChanged,
      validator: validator,
      isExpanded: isExpanded,
      icon: icon,
      style: textStyle,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        filled: true,
        fillColor: backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
