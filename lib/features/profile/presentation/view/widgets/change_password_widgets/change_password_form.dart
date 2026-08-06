import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_form_field.dart';

import '../../../view_model/cubit/change_password_cubit.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    newPasswordController.addListener(_onPasswordChanged);
  }

  void _onPasswordChanged() => setState(() {});

  @override
  void dispose() {
    newPasswordController.removeListener(_onPasswordChanged);
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  int get _strength => _passwordStrength(newPasswordController.text);

  int _passwordStrength(String value) {
    var score = 0;
    if (value.isEmpty) return 0;
    if (value.length >= 8) score++;
    if (value.length >= 12) score++;
    if (RegExp(r'[A-Z]').hasMatch(value)) score++;
    if (RegExp(r'[a-z]').hasMatch(value)) score++;
    if (RegExp(r'[0-9]').hasMatch(value)) score++;
    if (RegExp(r'[^A-Za-z0-9]').hasMatch(value)) score++;
    return score;
  }

  String get _strengthLabel {
    final s = _strength;
    if (s == 0) return '';
    if (s <= 2) return 'password_weak'.tr();
    if (s <= 4) return 'password_fair'.tr();
    return 'password_strong'.tr();
  }

  Color get _strengthColor {
    final s = _strength;
    if (s <= 2) return KError;
    if (s <= 4) return KWarning;
    return KSuccess;
  }

  Widget _buildStrengthMeter() {
    final s = _strength;
    if (s == 0) return const SizedBox.shrink();

    final segments = 5;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            children: List.generate(segments, (index) {
              final filled = index < s.clamp(1, segments);
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(
                    right: index == segments - 1 ? 0 : 4,
                  ),
                  decoration: BoxDecoration(
                    color: filled
                        ? _strengthColor
                        : _strengthColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 6),
          Text(
            _strengthLabel,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _strengthColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;
    final containerColor = isDark ? KSurfaceDark : Colors.white;
    final containerBorder = isDark ? KBorderDark : KBorderLight;
    final titleColor = isDark ? KTextPrimaryDark : KTextPrimaryLight;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [KPrimaryColor, KPrimaryDark],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: KPrimaryColor.withValues(alpha: 0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.white,
                    size: 34,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Change Password'.tr(),
                  style: TextStyles.H1.copyWith(
                    color: titleColor,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 40),
                BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                  builder: (context, state) {
                    final cubit = context.read<ChangePasswordCubit>();
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: containerBorder),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: isDark ? 0.15 : 0.05,
                            ),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          CustomFormField(
                            controller: newPasswordController,
                            label: 'new_password'.tr(),
                            hintText: 'new_password_hint'.tr(),
                            icon: Icons.lock,
                            isPassword: true,
                            obscure: _obscureNewPassword,
                            pressOnEye: () {
                              setState(() {
                                _obscureNewPassword = !_obscureNewPassword;
                              });
                            },
                            keyboardType: TextInputType.text,
                            validator: cubit.passwordValidator,
                          ),
                          _buildStrengthMeter(),
                          const SizedBox(height: 16),
                          CustomFormField(
                            controller: confirmNewPasswordController,
                            label: 'confirm_new_password'.tr(),
                            hintText: 'confirm_new_password_hint'.tr(),
                            icon: Icons.lock,
                            isPassword: true,
                            obscure: _obscureConfirmPassword,
                            pressOnEye: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                            keyboardType: TextInputType.text,
                            validator:
                                (value) => cubit.confirmPasswordValidator(
                                  value,
                                  newPasswordController.text,
                                ),
                          ),
                          const SizedBox(height: 35),
                          BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                            builder: (context, state) {
                              final isLoading = state.maybeWhen(
                                loading: () => true,
                                orElse: () => false,
                              );
                              return CustomButton(
                                title: 'Save Changes'.tr(),
                                color: KPrimaryColor,
                                isVisible: !isLoading,
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await context
                                        .read<ChangePasswordCubit>()
                                        .changePassword(
                                          newPassword:
                                              newPasswordController.text.trim(),
                                          confirmNewPassword:
                                              confirmNewPasswordController.text
                                                  .trim(),
                                        );
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}