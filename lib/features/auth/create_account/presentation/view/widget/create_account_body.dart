import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_curve_shape.dart';
import 'package:medicore_app/core/widget/custom_form_field.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/otp_view.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view/widget/custom_phone_field.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view_model/create_account_cubit/create_account_cubit.dart';
import 'package:medicore_app/features/auth/public_cubits/auth_cubit/auth_cubit.dart';
import 'package:medicore_app/features/auth/public_cubits/auth_cubit/auth_state.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view_model/id_cubit/id_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CreateAccountBody extends StatelessWidget {
  const CreateAccountBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    final formKey = GlobalKey<FormState>();
    String? firstName;
    String? lastName;
    String? email;
    String? phoneNumber;
    String? password;
    String? confPassword;
    String id = '';

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
                    label: 'first_name_hint'.tr(),
                    icon: Icons.person_pin,
                    keyboardType: TextInputType.text,
                    validator: cubit.validateName,
                    onChanged: (val) {
                      firstName = val;
                    },
                  ),
                  SizedBox(height: 10),
                  CustomFormField(
                    label: 'last_name_hint'.tr(),
                    icon: Icons.person_pin,
                    keyboardType: TextInputType.text,
                    validator: cubit.validateName,
                    onChanged: (val) {
                      lastName = val;
                    },
                  ),
                  SizedBox(height: 10),
                  CustomFormField(
                    label: 'email_hint'.tr(),
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: cubit.validateEmail,
                    onChanged: (value) {
                      cubit.email = value;
                      email = value;
                    },
                  ),
                  SizedBox(height: 10),

                  CustomPhoneField(
                    label: 'phone_hint'.tr(),
                    onChanged: (val) {
                      cubit.phone = val;
                      phoneNumber = val;
                    },
                    validator: cubit.validatePhone,
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
                        validator: cubit.validatePassword,
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
                        validator: cubit.validatePasswordMatch,
                        onChanged: (value) {
                          cubit.confirmPassword = value;
                          confPassword = value;
                        },
                      );
                    },
                  ),
                  SizedBox(height: 10),

                  BlocBuilder<IdCubit, IdState>(
                    builder: (context, state) {
                      final hasID = state is IsHasID && state.isHasID;
                      return Column(
                        children: [
                          Text('id_question'.tr()),
                          Switch(
                            value: hasID,
                            onChanged: (value) {
                              context.read<IdCubit>().showQeustion(
                                isHasID: value,
                              );
                            },
                          ),
                          hasID
                              ? CustomFormField(
                                label: 'ID_hint'.tr(),
                                icon: Icons.credit_card,
                                keyboardType: TextInputType.phone,
                                // validator: cubit.validateEmail,
                                onChanged: (value) => id = value,
                              )
                              : SizedBox(),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                  CustomButton(
                    title: 'create_account_btn'.tr(),
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        print('==============');
                        print(
                          '=====$firstName===$lastName===$email=====$phoneNumber===$id',
                        );
                        context.read<CreateAccountCubit>().createAccount(
                          firstName: firstName!,
                          lastName: lastName!,
                          email: email!,
                          phoneNumber: phoneNumber!,
                          password: password!,
                          confPassword: confPassword!,
                          id,
                        );
                      }
                    },
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
