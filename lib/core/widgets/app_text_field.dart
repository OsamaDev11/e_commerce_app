import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';
import 'package:e_commerce_app/core/theming/app_dimens.dart';
import 'package:e_commerce_app/core/theming/app_text_styles.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.prefixIconPath,
    this.prefixIcon,
    this.isPassword = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onSubmitted,
  }) : assert(
          prefixIconPath == null || prefixIcon == null,
          'Provide either prefixIconPath or prefixIcon.',
        );

  final String label;
  final TextEditingController controller;
  final String? hintText;
  final String? prefixIconPath;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onSubmitted;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscured = true;

  void _toggleObscured() => setState(() => _obscured = !_obscured);

  Widget? _buildPrefixIcon() {
    final iconPath = widget.prefixIconPath;
    final icon = widget.prefixIcon;
    final size = AppScale.s(AppSizes.iconMd);

    if (iconPath != null) {
      return Padding(
        padding: AppScale.all(AppSpacing.sm),
        child: SvgPicture.asset(iconPath, width: size, height: size),
      );
    }

    if (icon != null) {
      return Icon(icon, size: size, color: AppColors.textSecondary);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(widget.label, style: AppTextStyles.bodySm.semiBold),
        AppScale.gh(AppSpacing.xs),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword && _obscured,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          validator: widget.validator,
          onFieldSubmitted: widget.onSubmitted,
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: _buildPrefixIcon(),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: _toggleObscured,
                    icon: Icon(
                      _obscured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: AppScale.s(AppSizes.iconMd),
                      color: AppColors.textSecondary,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
