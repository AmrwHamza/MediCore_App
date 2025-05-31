import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_curve_shape.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/widget/controler_otp.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/widget/otp_row_field.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view_model/cubit/otp_cubit.dart';
import 'package:medicore_app/features/home/presentation/view/home_view.dart';

class OTPViewBody extends StatelessWidget {
  const OTPViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const CustomCurvedShape(),
            const SizedBox(height: 30),
            Text(
              'otp_title'.tr(),
              style: TextStyles.H1.copyWith(color: KPrimaryColor, fontSize: 35),
            ),
            const SizedBox(height: 20),
            SvgPicture.asset(Assets.otpImage, height: 200, fit: BoxFit.fill),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'otp_desc'.tr(),
                style: TextStyles.notes,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            const OTPRowFields(),
            const SizedBox(height: 70),
            BlocConsumer<OtpCubit, OtpState>(
              listener: (context, state) {
                if (state is SendCodeSuccess) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    HomeView.routeName,
                    (route) => false,
                  );
                } else if (state is SendCodeFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                return ModalProgressHUD(
                  inAsyncCall: state is OtpLoading,
                  color: KPrimaryColor,
                  child: CustomButton(
                    title: 'Confirm'.tr(),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      final otp = _getOtpCode(context);
                      if (otp != null) {
                        context.read<OtpCubit>().sendCode(code: otp);
                      }
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 25),
            BlocBuilder<OtpCubit, OtpState>(
              builder: (context, state) {
                final canResend =
                    state is TimerUpdated ? state.secondsLeft == 0 : true;
                return ModalProgressHUD(
                  color: KPrimaryColor,
                  inAsyncCall: state is OtpLoading ? true : false,
                  child: CustomButton(
                    title:
                        canResend
                            ? 'Resend the Code'.tr()
                            : 'Resend in ${state is TimerUpdated ? state.secondsLeft : 60}s',
                    onTap:
                        canResend
                            ? () {
                              FocusScope.of(context).unfocus();
                              context.read<OtpCubit>().resendCode();
                            }
                          : () {},
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  int? _getOtpCode(BuildContext context) {
    final codeText = c1.text + c2.text + c3.text + c4.text + c5.text + c6.text;

    if (codeText.length != 6 || codeText.contains(RegExp(r'[^0-9]'))) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("validat_otp_coe".tr())));
      return null;
    }

    return int.tryParse(codeText);
  }
}
