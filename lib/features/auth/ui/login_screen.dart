import 'package:e_commerce_app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/localization/localization_extension.dart';
import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/networking/app_failure.dart';
import '../logic/login_cubit.dart';
import '../logic/login_state.dart';
import '../../../core/routing/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.home,
            (route) => false,
          );
        }

        if (state is LoginFailure) {
          final message = switch (state.failure.type) {
            AppFailureType.invalidCredentials =>
              context.l10n.invalidEmailOrPassword,

            AppFailureType.unknown => context.l10n.somethingWentWrong,
          };

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: AppScale.symmetric(horizontal: 12, vertical: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppScale.r(28)),
              child: Container(
                width: double.infinity,
                color: AppColors.surface,
                child: Stack(
                  children: [
                    Positioned(
                      top: AppScale.s(-45),
                      right: AppScale.s(-45),
                      child: Container(
                        width: AppScale.s(150),
                        height: AppScale.s(150),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.blueSoft,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: AppScale.s(-55),
                      left: AppScale.s(-55),
                      child: Container(
                        width: AppScale.s(150),
                        height: AppScale.s(150),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.blueSoft.withValues(alpha: 0.6),
                        ),
                      ),
                    ),

                    SingleChildScrollView(
                      padding: AppScale.symmetric(horizontal: 28, vertical: 52),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLogo(),

                            AppScale.gh(18),

                            Text(
                              context.l10n.welcomeBack,
                              style: TextStyle(
                                fontSize: AppScale.sp(25),
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                                height: 1.15,
                              ),
                            ),

                            AppScale.gh(8),

                            Text(
                              context.l10n.signInToContinue,
                              style: TextStyle(
                                fontSize: AppScale.sp(13),
                                fontWeight: FontWeight.w400,
                                color: AppColors.textSecondary,
                              ),
                            ),

                            AppScale.gh(38),

                            _buildLabel(context.l10n.email),

                            AppScale.gh(8),

                            _buildEmailField(),

                            AppScale.gh(24),

                            _buildLabel(context.l10n.password),

                            AppScale.gh(8),

                            _buildPasswordField(),

                            AppScale.gh(32),

                            _buildSignInButton(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: AppScale.s(42),
      height: AppScale.s(42),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppScale.r(12)),
      ),
      alignment: Alignment.center,
      child: Image.asset(
        AppAssets.icons.shoppingBag,
        width: AppScale.s(23),
        height: AppScale.s(23),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: AppScale.sp(12),
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      style: TextStyle(fontSize: AppScale.sp(13), color: AppColors.textPrimary),
      decoration: _inputDecoration(
        hintText: context.l10n.emailHint,
        prefixIcon: SvgPicture.asset(
          AppAssets.icons.email,
          width: AppScale.s(22),
          height: AppScale.s(16),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return context.l10n.emailRequired;
        }

        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      textInputAction: TextInputAction.done,
      style: TextStyle(fontSize: AppScale.sp(13), color: AppColors.textPrimary),
      decoration:
          _inputDecoration(
            hintText: '••••••••',
            prefixIcon: SvgPicture.asset(
              AppAssets.icons.lock,
              width: AppScale.s(19),
              height: AppScale.s(26),
            ),
          ).copyWith(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              icon: Icon(
                _isPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: AppScale.s(20),
                color: AppColors.textSecondary,
              ),
            ),
          ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return context.l10n.passwordRequired;
        }

        return null;
      },
      onFieldSubmitted: (_) => _onSignInPressed(),
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    required Widget prefixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: AppScale.sp(13),
        color: AppColors.textSecondary,
      ),
      filled: true,
      fillColor: AppColors.inputBackground,
      contentPadding: AppScale.symmetric(horizontal: 16, vertical: 17),
      prefixIcon: Padding(
        padding: EdgeInsets.all(AppScale.s(14)),
        child: prefixIcon,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppScale.r(12)),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppScale.r(12)),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.3),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppScale.r(12)),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppScale.r(12)),
        borderSide: const BorderSide(color: AppColors.error, width: 1.3),
      ),
    );
  }

  Widget _buildSignInButton() {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final isLoading = state is LoginLoading;

        return SizedBox(
          width: double.infinity,
          height: AppScale.s(52),
          child: ElevatedButton(
            onPressed: isLoading ? null : _onSignInPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              disabledBackgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              disabledForegroundColor: AppColors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppScale.r(12)),
              ),
            ),
            child: isLoading
                ? SizedBox(
                    width: AppScale.s(20),
                    height: AppScale.s(20),
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.white,
                    ),
                  )
                : Text(
                    context.l10n.signIn,
                    style: TextStyle(
                      fontSize: AppScale.sp(14),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        );
      },
    );
  }

  void _onSignInPressed() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<LoginCubit>().login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }
}
