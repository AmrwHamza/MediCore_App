import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_form_field.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/auth/forget_password/presentation/view/forget_password_view.dart';
import 'package:medicore_app/features/auth/login/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:medicore_app/features/auth/public_cubits/auth_validate_cubit/auth_validate_cubit.dart';
import 'package:medicore_app/features/auth/public_cubits/auth_validate_cubit/auth_validate_state.dart';
import 'package:medicore_app/features/main_home/presentation/view/main_home_view.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  String? email;
  String? password;

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().login(
        email: email!,
        password: password!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthValidateCubit>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? KSurfaceDark : KSurfaceLight;
    final textPrimary = isDark ? KTextPrimaryDark : KTextPrimaryLight;
    final textSecondary = isDark ? KTextSecondaryDark : KTextSecondaryLight;
    final borderColor = isDark ? KBorderDark : KBorderLight;

    return Stack(
      children: [
        Positioned(
          top: -120,
          left: -60,
          child: Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  KPrimaryColor.withValues(alpha: 0.22),
                  KPrimaryColor.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -150,
          right: -80,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  KCyan.withValues(alpha: 0.18),
                  KCyan.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              KPrimaryDark,
                              KPrimaryColor,
                              KPrimaryLight,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: KPrimaryColor.withValues(alpha: 0.35),
                              blurRadius: 24,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.health_and_safety_rounded,
                          color: Colors.white,
                          size: 52,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'login_title'.tr(),
                        style: TextStyles.H1.copyWith(
                          color: textPrimary,
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'login_desc'.tr(),
                        style: TextStyle(
                          color: textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      Container(
                        decoration: BoxDecoration(
                          color: surfaceColor.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(color: borderColor, width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(
                                alpha: isDark ? 0.2 : 0.04,
                              ),
                              blurRadius: 32,
                              offset: const Offset(0, 16),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 24.0,
                                horizontal: 8,
                              ),
                              child: Column(
                                children: [
                                  CustomFormField(
                                    label: 'email_hint'.tr(),
                                    icon: Icons.email_rounded,
                                    keyboardType: TextInputType.emailAddress,
                                    focusNode: _emailFocusNode,
                                    textInputAction: TextInputAction.next,
                                    validator: cubit.validateEmail,
                                    onChanged: (value) {
                                      cubit.email = value.trim();
                                      email = value.trim();
                                    },
                                    onFieldSubmitted: (_) {
                                      _passwordFocusNode.requestFocus();
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  BlocBuilder<
                                    AuthValidateCubit,
                                    AuthValidateState
                                  >(
                                    buildWhen:
                                        (previous, current) =>
                                            current is ChangePasswordObscure,
                                    builder: (context, state) {
                                      final cubit =
                                          context.read<AuthValidateCubit>();
                                      return CustomFormField(
                                        label: 'password_hint'.tr(),
                                        icon: Icons.lock_rounded,
                                        isPassword: true,
                                        obscure: cubit.obscurePassword,
                                        focusNode: _passwordFocusNode,
                                        textInputAction: TextInputAction.done,
                                        pressOnEye: cubit.changeObscurePassword,
                                        validator: cubit.validateNewPassword,
                                        onChanged: (value) {
                                          cubit.password = value.trim();
                                          password = value.trim();
                                        },
                                        onFieldSubmitted: (_) => _submit(),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextButton(
                                      onPressed: () {
                                        context.pushNamed(
                                          ForgetPasswordView.routeName,
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        foregroundColor: KPrimaryColor,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'forget_password_q'.tr(),
                                        style: TextStyles.public.copyWith(
                                          color: KPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  BlocConsumer<LoginCubit, LoginState>(
                                    listener: (context, state) {
                                      if (state is LoginSuccess) {
                                        context.goNamed(MainHomeView.routeName);
                                      } else if (state is LoginFailure) {
                                        CustomSnackbar.show(
                                          context,
                                          message: state.message,
                                          type: SnackbarType.error,
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is LoginLoading) {
                                        return const Center(
                                          child: SpinKitThreeInOut(
                                            color: KPrimaryColor,
                                            size: 40,
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            gradient: const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                KPrimaryDark,
                                                KPrimaryColor,
                                                KPrimaryLight,
                                              ],
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: KPrimaryColor.withValues(
                                                  alpha: 0.3,
                                                ),
                                                blurRadius: 16,
                                                offset: const Offset(0, 8),
                                              ),
                                            ],
                                          ),
                                          child: CustomButton(
                                            title: 'login_btn'.tr(),
                                            onTap: _submit,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
