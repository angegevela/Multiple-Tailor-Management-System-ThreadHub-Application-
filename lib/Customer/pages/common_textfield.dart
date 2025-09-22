import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final IconData? prefixIconData;
  final int maxLines;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final bool obscureText;

  const CommonTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.prefixIconData,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIconData != null ? Icon(prefixIconData) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 16.0,
        ),
      ),
    );
  }
}
