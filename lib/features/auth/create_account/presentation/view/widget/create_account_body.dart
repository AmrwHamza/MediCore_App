import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_curve_shape.dart';
import 'package:medicore_app/core/widget/custom_form_field.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/otp_view.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view/widget/custom_phone_field.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view_model/cubit/create_account_cubit.dart';
import 'package:medicore_app/features/auth/cubits/auth_cubit/auth_cubit.dart';
import 'package:medicore_app/features/auth/cubits/auth_cubit/auth_state.dart';
import 'package:medicore_app/features/home/presentation/view/home_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CreateAccountBody extends StatelessWidget {
  const CreateAccountBody({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String? email;
    String? phoneNumber;
    String? password;
    String? confPassword;

    return BlocConsumer<CreateAccountCubit, CreateAccountState>(
      listener: (context, state) {
        if (state is CreateAccountFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is CreateAccountSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            OTPView.routeName,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is CreateAccountLoading ? true : false,
          color: KPrimaryColor,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomCurvedShape(),
                  SizedBox(height: 32),
                  Text(
                    'create_account_title'.tr(),
                    style: TextStyles.H1.copyWith(
                      color: KPrimaryColor,
                      fontSize: 35,
                    ),
                  ),
                  const SizedBox(height: 32),
                  CustomFormField(
                    label: 'email_hint'.tr(),
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val == null || !val.contains('@')) {
                        return 'invalid_email'.tr();
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(height: 10),

                  CustomPhoneField(
                    label: 'phone_hint'.tr(),
                    onChanged: (val) {
                      phoneNumber = val;
                    },
                    validator: (val) {
                      if (val == null || val.length != 9) {
                        return 'invalid_phone'.tr();
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10),

                  BlocBuilder<AuthCubit, AuthState>(
                    buildWhen:
                        (previous, current) => current is ChangePasswordObscure,
                    builder: (context, state) {
                      final cubit = context.read<AuthCubit>();
                      return CustomFormField(
                        label: 'password_hint'.tr(),
                        icon: Icons.lock,
                        isPassword: true,
                        obscure: cubit.obscurePassword,
                        toggleVisibility: cubit.changeObscurePassword,
                        validator: (val) {
                          if (val == null || val.length < 8) {
                            return 'password_too_short'.tr();
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          cubit.password = value;
                          password = value;
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 10),

                  BlocBuilder<AuthCubit, AuthState>(
                    buildWhen:
                        (previous, current) =>
                            current is ChangeConfirmPasswordObscure,
                    builder: (context, state) {
                      final cubit = context.read<AuthCubit>();
                      return CustomFormField(
                        label: 'confirm_password_hint'.tr(),
                        icon: Icons.lock,
                        isPassword: true,
                        obscure: cubit.obscureConfirmPassword,
                        toggleVisibility: cubit.changeObscureConfirmPassword,
                        validator: (val) {
                          if (val != password) {
                            return 'passwords_do_not_match'.tr();
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          cubit.confirmPassword = value;
                          confPassword = value;
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                  CustomButton(
                    title: 'create_account_btn'.tr(),
                    onTap: () {
                      print('=========sdss');
                      if (formKey.currentState!.validate()) {
                        context.read<CreateAccountCubit>().createAccount(
                          email: email!,
                          phoneNumber: phoneNumber!,
                          password: password!,
                          confPassword: confPassword!,
                        );
                        print('================');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
