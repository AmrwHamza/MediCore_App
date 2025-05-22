import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_curve_shape.dart';
import 'package:medicore_app/core/widget/custom_form_field.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view/widget/custom_phone_field.dart';
import 'package:medicore_app/features/auth/cubits/auth_cubit/auth_cubit.dart';
import 'package:medicore_app/features/auth/cubits/auth_cubit/auth_state.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    final formKey = GlobalKey<FormState>();

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            CustomCurvedShape(),
            SizedBox(height: 32),
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
              onChanged: (value) => cubit.email = value,
            ),
            SizedBox(height: 10),

            CustomPhoneField(
              label: 'phone_hint'.tr(),
              onChanged: (val) => cubit.phone = val,
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
                  onChanged: (value) => cubit.password = value,
                );
              },
            ),

            const SizedBox(height: 30),
            CustomButton(
              title: 'login_btn'.tr(),
              onTap: () {
                if (formKey.currentState!.validate()) {}
              },
            ),
          ],
        ),
      ),
    );
  }
}
