import 'package:flutter/material.dart';
import 'package:pp191225/core/core.dart';

/// Ô nhập liệu có nhãn phía trên (Email / Password) của màn Login.
class AuthTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  static OutlineInputBorder _border(Color color, [double width = 1]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimens.fieldRadius),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.body),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          style: AppTextStyles.body,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.fieldHint,
            filled: true,
            fillColor: AppColors.white,
            suffixIcon: suffixIcon,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            border: _border(AppColors.gray[2]),
            enabledBorder: _border(AppColors.gray[2]),
            focusedBorder: _border(AppColors.brand, 1.5),
            errorBorder: _border(AppColors.red[5]),
            focusedErrorBorder: _border(AppColors.red[5], 1.5),
          ),
        ),
      ],
    );
  }
}
