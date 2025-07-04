import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_curve_shape.dart';
import 'package:medicore_app/core/widget/custom_form_field.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/auth/forget_password/presentation/view/forget_password_view.dart';
import 'package:medicore_app/features/auth/login/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:medicore_app/features/auth/public_cubits/auth_validate_cubit/auth_validate_cubit.dart';
import 'package:medicore_app/features/auth/public_cubits/auth_validate_cubit/auth_validate_state.dart';
import 'package:medicore_app/features/main_home/presentation/view/main_home_view.dart';

// ignore: must_be_immutable
class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});

  String? email;
  String? password;
  int? id;
  String? phine;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthValidateCubit>();
    final formKey = GlobalKey<FormState>();

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            const CustomCurvedShape(),
            const SizedBox(height: 32),
            Text(
              'login_title'.tr(),
              style: TextStyles.H1.copyWith(color: KPrimaryColor, fontSize: 35),
            ),
            const SizedBox(height: 32),

            CustomFormField(
              label: 'email_hint'.tr(),
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: cubit.validateEmail,
              onChanged: (value) {
                cubit.email = value.trim();
                email = value.trim();
              },
            ),
            const SizedBox(height: 10),
            BlocBuilder<AuthValidateCubit, AuthValidateState>(
              buildWhen:
                  (previous, current) => current is ChangePasswordObscure,
              builder: (context, state) {
                final cubit = context.read<AuthValidateCubit>();
                return CustomFormField(
                  label: 'password_hint'.tr(),
                  icon: Icons.lock,
                  isPassword: true,
                  obscure: cubit.obscurePassword,
                  pressOnEye: cubit.changeObscurePassword,
                  validator: cubit.validateNewPassword,
                  onChanged: (value) {
                    cubit.password = value.trim();
                    password = value.trim();
                  },
                );
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    context.pushNamed(ForgetPasswordView.routeName);
                  },
                  child: Text(
                    'forget_password_q'.tr(),
                    style: TextStyles.public.copyWith(color: KPrimaryColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
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
                    child: SpinKitThreeInOut(color: KPrimaryColor),
                  );
                } else {
                  return CustomButton(
                    title: 'login_btn'.tr(),
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        context.read<LoginCubit>().login(
                          email: email!,
                          // phoneNumber: phine!,
                          password: password!,
                        );
                      }
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
