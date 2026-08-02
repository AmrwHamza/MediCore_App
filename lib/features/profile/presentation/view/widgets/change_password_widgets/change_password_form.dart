import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../constants.dart';
import '../../../../../../core/helper/text_styles.dart';
import '../../../../../../core/widget/custom_button.dart';
import '../../../../../../core/widget/custom_form_field.dart';
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
  void dispose() {
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                Text(
                  'Change Password'.tr(),
                  style: TextStyles.H1.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 40),
                BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                  builder: (context, state) {
                    final cubit = context.read<ChangePasswordCubit>();
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.15),
                        ),
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
                              state.maybeWhen(
                                orElse: () {},
                                loading:
                                    () => const CircularProgressIndicator(
                                      color: KPrimaryColor,
                                    ),
                              );
                              return CustomButton(
                                title: 'Save Changes'.tr(),
                                color: KDarkBlue.withValues(alpha: 0.9),
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
