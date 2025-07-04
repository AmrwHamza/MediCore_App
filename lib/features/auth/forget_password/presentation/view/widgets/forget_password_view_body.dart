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
import 'package:medicore_app/features/auth/forget_password/presentation/view/back_page_view.dart';
import 'package:medicore_app/features/auth/forget_password/presentation/view_model/forget_cubit/forget_password_cubit.dart';
import 'package:medicore_app/features/auth/public_cubits/auth_validate_cubit/auth_validate_cubit.dart';

// ignore: must_be_immutable
class ForgetPasswordViewBody extends StatelessWidget {
  ForgetPasswordViewBody({super.key});

  String? email;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final cubit = context.read<AuthValidateCubit>();

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomCurvedShape(),
            const SizedBox(height: 32),
            Text(
              'forget_password'.tr(),
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
            const SizedBox(height: 32),

            BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
              listener: (context, state) {
                if (state is ForgetPasswordFailure) {
                  CustomSnackbar.show(
                    context,
                    message: state.error,
                    type: SnackbarType.error,
                  );
                }
              },
              builder: (context, state) {
                if (state is ForgetPasswordLoading) {
                  return const SpinKitThreeBounce(color: KPrimaryColor);
                } else if (state is ForgetPasswordSuccess) {
                  context.pushNamed(BackPageView.routeName);
                }
                return CustomButton(
                  title: 'send_code'.tr(),
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      context.read<ForgetPasswordCubit>().forgetPassword(
                        email!,
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
