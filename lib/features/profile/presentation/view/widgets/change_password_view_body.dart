import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_form_field.dart';
import 'package:medicore_app/features/profile/presentation/view_model/password_cubit/change_password_cubit.dart';

// ignore: must_be_immutable
class ChangePasswordViewBody extends StatelessWidget {
  ChangePasswordViewBody({super.key});

  String? oldPassword;
  String? newPassword;
  String? confirmPassword;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.primaryColor, KDarkBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
            buildWhen:
                (previous, current) =>
                    current is ChangeNewPasswordObscure ||
                    current is ChangeOldPasswordObscure ||
                    current is ChangeConfirmPasswordObscure,
            builder: (context, state) {
              final cubit = context.read<ChangePasswordCubit>();
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Column(
                    children: [
                      CustomFormField(
                        label: 'Enter your old password'.tr(),
                        icon: Icons.lock_outline_sharp,
                        keyboardType: TextInputType.text,
                        isPassword: true,
                        obscure: cubit.obscureOldPassword,
                        validator: cubit.validateOldPassword,
                        pressOnEye: cubit.changeObscureOldPassword,
                        onChanged: (value) {
                          cubit.oldPassword = value;
                          oldPassword = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomFormField(
                        label: 'Enter your new password'.tr(),
                        icon: Icons.lock_rounded,
                        keyboardType: TextInputType.text,
                        isPassword: true,
                        obscure: cubit.obscureNewPassword,
                        pressOnEye: cubit.changeObscureNewPassword,
                        validator: cubit.validateNewPassword,
                        onChanged: (value) {
                          cubit.newPassword = value;
                          newPassword = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomFormField(
                        label: 'Confirm your new password'.tr(),
                        icon: Icons.lock_rounded,
                        keyboardType: TextInputType.text,
                        isPassword: true,
                        obscure: cubit.obscureConfirmPassword,
                        pressOnEye: cubit.changeObscureConfirmPassword,
                        validator: cubit.validatePasswordMatch,
                        onChanged: (value) {
                          cubit.confirmPassword = value;
                          confirmPassword = value;
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: CustomButton(
                      title: 'submit'.tr(),
                      color: KDarkBlue,
                      onTap: () {
                        if (formKey.currentState!.validate()) {}
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
