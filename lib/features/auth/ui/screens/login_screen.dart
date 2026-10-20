import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/localization/localization_extension.dart';
import 'package:e_commerce_app/core/networking/app_failure_message.dart';
import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/routing/routes.dart';
import 'package:e_commerce_app/core/theming/app_dimens.dart';
import 'package:e_commerce_app/core/theming/app_text_styles.dart';
import 'package:e_commerce_app/core/utils/snack_bar_extension.dart';
import 'package:e_commerce_app/core/widgets/app_buttons.dart';
import 'package:e_commerce_app/core/widgets/app_logo.dart';
import 'package:e_commerce_app/core/widgets/app_text_field.dart';
import 'package:e_commerce_app/features/auth/logic/login_cubit.dart';
import 'package:e_commerce_app/features/auth/logic/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _onStatusChanged(BuildContext context, LoginState state) {
    if (state.status == LoginStatus.success) {
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (_) => false);
      return;
    }

    final failure = state.failure;
    if (state.status == LoginStatus.failure && failure != null) {
      context.showSnackBarMessage(failure.userMessage(context.l10n));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _onStatusChanged,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: AppScale.all(AppSpacing.page),
                  child: const _LoginForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Center(child: AppLogo()),
        AppScale.gh(AppSpacing.md),
        Text(
          l10n.welcomeTitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.title,
        ),
        AppScale.gh(AppSpacing.xs),
        Text(
          l10n.signInToContinue,
          textAlign: TextAlign.center,
          style: AppTextStyles.body.secondary,
        ),
        AppScale.gh(AppSpacing.xl),
        AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _UsernameInput(),
              AppScale.gh(AppSpacing.xs),
              const _PasswordInput(),
            ],
          ),
        ),
        AppScale.gh(AppSpacing.md),
        const _SignInButton(),
      ],
    );
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput();

  @override
  Widget build(BuildContext context) {
    final showError = context.select(
      (LoginCubit cubit) => cubit.state.showUsernameError,
    );

    return AppTextField(
      hintText: context.l10n.usernameHint,
      prefixIcon: Icons.person_outline_rounded,
      errorText: showError ? context.l10n.usernameRequired : null,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.username],
      onChanged: (value) => context.read<LoginCubit>().usernameChanged(value),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    final showError = context.select(
      (LoginCubit cubit) => cubit.state.showPasswordError,
    );

    return AppTextField(
      hintText: context.l10n.passwordHint,
      prefixIcon: Icons.lock_outline_rounded,
      errorText: showError ? context.l10n.passwordRequired : null,
      isPassword: true,
      textInputAction: TextInputAction.done,
      autofillHints: const [AutofillHints.password],
      onChanged: (value) => context.read<LoginCubit>().passwordChanged(value),
      onSubmitted: (_) => context.read<LoginCubit>().submit(),
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton();

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (LoginCubit cubit) => cubit.state.isLoading,
    );

    return AppPrimaryButton(
      label: context.l10n.signIn,
      isLoading: isLoading,
      onPressed: () {
        FocusScope.of(context).unfocus();
        context.read<LoginCubit>().submit();
      },
    );
  }
}
