import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/constants/app_assets.dart';
import 'package:e_commerce_app/core/localization/localization_extension.dart';
import 'package:e_commerce_app/core/networking/app_failure.dart';
import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/routing/routes.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';
import 'package:e_commerce_app/core/theming/app_dimens.dart';
import 'package:e_commerce_app/core/theming/app_text_styles.dart';
import 'package:e_commerce_app/core/widgets/app_buttons.dart';
import 'package:e_commerce_app/core/widgets/app_page_frame.dart';
import 'package:e_commerce_app/core/widgets/app_text_field.dart';
import 'package:e_commerce_app/features/auth/logic/login_cubit.dart';
import 'package:e_commerce_app/features/auth/logic/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignInPressed() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    context.read<LoginCubit>().login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  void _onStateChanged(BuildContext context, LoginState state) {
    if (state is LoginSuccess) {
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (_) => false);
      return;
    }

    if (state is LoginFailure) {
      final message = switch (state.failure.type) {
        AppFailureType.invalidCredentials => context.l10n.invalidEmailOrPassword,
        AppFailureType.unknown => context.l10n.somethingWentWrong,
      };

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocListener<LoginCubit, LoginState>(
      listener: _onStateChanged,
      child: AppPageFrame(
        color: AppColors.surface,
        body: Stack(
          children: [
            PositionedDirectional(
              top: -AppScale.s(AppSizes.decorCircle / 3),
              end: -AppScale.s(AppSizes.decorCircle / 3),
              child: const _DecorCircle(color: AppColors.primarySoft),
            ),
            PositionedDirectional(
              bottom: -AppScale.s(AppSizes.decorCircle / 3),
              start: -AppScale.s(AppSizes.decorCircle / 3),
              child: const _DecorCircle(color: AppColors.primarySoftFaded),
            ),
            SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: AppScale.symmetric(
                horizontal: AppSpacing.pagePadding,
                vertical: AppSpacing.xxxl,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _Logo(),
                    AppScale.gh(AppSpacing.md),
                    Text(l10n.welcomeBack, style: AppTextStyles.h1),
                    AppScale.gh(AppSpacing.xs),
                    Text(
                      l10n.signInToContinue,
                      style: AppTextStyles.body.secondary,
                    ),
                    AppScale.gh(AppSpacing.xxl),
                    AppTextField(
                      label: l10n.email,
                      controller: _emailController,
                      hintText: l10n.emailHint,
                      prefixIconPath: AppAssets.icons.email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) => value == null || value.trim().isEmpty
                          ? l10n.emailRequired
                          : null,
                    ),
                    AppScale.gh(AppSpacing.xl),
                    AppTextField(
                      label: l10n.password,
                      controller: _passwordController,
                      hintText: l10n.passwordHint,
                      prefixIconPath: AppAssets.icons.lock,
                      isPassword: true,
                      textInputAction: TextInputAction.done,
                      validator: (value) => value == null || value.isEmpty
                          ? l10n.passwordRequired
                          : null,
                      onSubmitted: (_) => _onSignInPressed(),
                    ),
                    AppScale.gh(AppSpacing.xxl),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) => AppPrimaryButton(
                        label: l10n.signIn,
                        isLoading: state is LoginLoading,
                        onPressed: _onSignInPressed,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        width: AppScale.s(AppSizes.iconButton),
        height: AppScale.s(AppSizes.iconButton),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: AppScale.radius(AppRadius.md),
        ),
        child: Image.asset(
          AppAssets.icons.shoppingBag,
          width: AppScale.s(AppSizes.iconLg),
          height: AppScale.s(AppSizes.iconLg),
        ),
      ),
    );
  }
}

class _DecorCircle extends StatelessWidget {
  const _DecorCircle({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: AppScale.s(AppSizes.decorCircle),
        height: AppScale.s(AppSizes.decorCircle),
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}
