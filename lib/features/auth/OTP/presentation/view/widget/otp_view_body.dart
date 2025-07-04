import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/helper_function/user_information.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_curve_shape.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/widget/controler_otp.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/widget/custom_dowm_timer.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/widget/otp_row_field.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view_model/otp_cubit/otp_cubit.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view_model/timer_cubit/timer_cubit.dart';
import 'package:medicore_app/features/auth/forget_password/presentation/view/back_page_view.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/patient_info_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class OTPViewBody extends StatelessWidget {
  const OTPViewBody({super.key, required this.isForgetPassword});

  final bool isForgetPassword;

  @override
  Widget build(BuildContext context) {
    context.read<TimerCubit>().startResendTimer();

    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is SendCodeSuccess) {
          isForgetPassword
              ? context.go(BackPageView.routeName)
              : context.go(PatientInfoView.routeName);
        } else if (state is SendCodeFailure) {
          CustomSnackbar.show(
            context,
            message: state.error,
            type: SnackbarType.error,
          );
        } else if (state is ResendFailure) {
          CustomSnackbar.show(
            context,
            message: state.error,
            type: SnackbarType.error,
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is OtpLoading,
          progressIndicator: const CircularProgressIndicator(
            color: KPrimaryColor,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const CustomCurvedShape(),
                  const SizedBox(height: 30),
                  Text(
                    'otp_title'.tr(),
                    style: TextStyles.H1.copyWith(
                      color: KPrimaryColor,
                      fontSize: 35,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SvgPicture.asset(
                    Assets.imagesDoctor,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: FutureBuilder<String>(
                      future: getUserEmail(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            snapshot.hasError) {
                          return Text(
                            'otp_desc'.tr() + '...',
                            style: TextStyles.notes,
                            textAlign: TextAlign.center,
                          );
                        } else {
                          return Text(
                            'otp_desc'.tr() + '${snapshot.data}',
                            style: TextStyles.notes,
                            textAlign: TextAlign.center,
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  const OTPRowFields(),
                  const SizedBox(height: 25),
                  const CountDownTimerOTP(),
                  const SizedBox(height: 25),
                  CustomButton(
                    title: 'confirm'.tr(),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      final otp = _getOtpCode(context);
                      if (otp != null) {
                        context.read<OtpCubit>().sendCode(code: otp);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<TimerCubit, TimerState>(
                    builder: (context, state) {
                      int? secondsLeft;
                      if (state is TimerUpdated) {
                        secondsLeft = state.secondsLeft;
                      }
                      final isDisabled = secondsLeft != null && secondsLeft > 0;

                      return CustomButton(
                        title: 'Resend_Code'.tr(),
                        onTap:
                            isDisabled
                                ? null
                                : () {
                                  FocusScope.of(context).unfocus();
                                  context.read<OtpCubit>().resendCode();
                                },
                        color: isDisabled ? Colors.grey : KPrimaryColor,
                      );
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

  String? _getOtpCode(BuildContext context) {
    final codeText = c1.text + c2.text + c3.text + c4.text + c5.text + c6.text;

    if (codeText.length != 6 || codeText.contains(RegExp(r'[^0-9]'))) {
      CustomSnackbar.show(
        context,
        message: 'validate_otp_code'.tr(),
        type: SnackbarType.error,
      );

      return null;
    }

    return codeText;
  }
}
