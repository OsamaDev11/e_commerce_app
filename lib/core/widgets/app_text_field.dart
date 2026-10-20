import 'package:flutter/material.dart';

import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_dimens.dart';
import 'package:e_commerce_app/core/theming/app_text_styles.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.prefixIcon,
    this.errorText,
    this.isPassword = false,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.onSubmitted,
  });

  final String hintText;
  final ValueChanged<String> onChanged;
  final IconData? prefixIcon;
  final String? errorText;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onSubmitted;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscured = true;

  void _toggleObscured() => setState(() => _obscured = !_obscured);

  @override
  Widget build(BuildContext context) {
    final prefixIcon = widget.prefixIcon;
    final iconSize = AppScale.s(AppSizes.iconMd);

    return TextField(
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      obscureText: widget.isPassword && _obscured,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      autofillHints: widget.autofillHints,
      style: AppTextStyles.body,
      decoration: InputDecoration(
        hintText: widget.hintText,
        errorText: widget.errorText,
        prefixIcon:
            prefixIcon == null ? null : Icon(prefixIcon, size: iconSize),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: _toggleObscured,
                icon: Icon(
                  _obscured
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: AppScale.s(AppSizes.iconSm),
                ),
              )
            : null,
      ),
    );
  }
}
