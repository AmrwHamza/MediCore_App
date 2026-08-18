import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/core/helper_function/user_information.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/widget/controler_otp.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/widget/custom_dowm_timer.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/widget/otp_row_field.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view_model/otp_cubit/otp_cubit.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view_model/timer_cubit/timer_cubit.dart';
import 'package:medicore_app/features/auth/forget_password/presentation/view/back_page_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../../constants.dart';
import '../../../../../payment/presentation/views/payment_view.dart';

class OTPViewBody extends StatefulWidget {
  const OTPViewBody({super.key, required this.isForgetPassword});

  final bool isForgetPassword;

  @override
  State<OTPViewBody> createState() => _OTPViewBodyState();
}

class _OTPViewBodyState extends State<OTPViewBody> {
  double _progress = 0.0;
  int _filledFieldsCount = 0; // متغير جديد للاحتفاظ بعدد الحقول المكتملة مباشرة

  @override
  void initState() {
    super.initState();
    context.read<TimerCubit>().startResendTimer();
    _updateProgress();
    c1.addListener(_updateProgress);
    c2.addListener(_updateProgress);
    c3.addListener(_updateProgress);
    c4.addListener(_updateProgress);
    c5.addListener(_updateProgress);
    c6.addListener(_updateProgress);
  }

  @override
  void dispose() {
    c1.removeListener(_updateProgress);
    c2.removeListener(_updateProgress);
    c3.removeListener(_updateProgress);
    c4.removeListener(_updateProgress);
    c5.removeListener(_updateProgress);
    c6.removeListener(_updateProgress);
    super.dispose();
  }

  void _updateProgress() {
    int filledFields = 0;
    if (c1.text.isNotEmpty) filledFields++;
    if (c2.text.isNotEmpty) filledFields++;
    if (c3.text.isNotEmpty) filledFields++;
    if (c4.text.isNotEmpty) filledFields++;
    if (c5.text.isNotEmpty) filledFields++;
    if (c6.text.isNotEmpty) filledFields++;

    setState(() {
      _filledFieldsCount = filledFields;
      _progress = filledFields / 6;
    });

    if (filledFields == 6) {
      final otp = _getOtpCode(context);
      if (otp != null) {
        context.read<OtpCubit>().sendCode(code: otp);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? KPrimaryColor : KPrimaryDark;
    final cardColor = isDark ? const Color(0xff161B22) : Colors.white;
    final textPrimary =
        isDark ? const Color(0xffF9FAFB) : const Color(0xff111827);
    final textSecondary =
        isDark ? const Color(0xff9CA3AF) : const Color(0xff6B7280);

    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is SendCodeSuccess) {
          widget.isForgetPassword
              ? context.go(BackPageView.routeName)
              : context.go(PaymentView.routeName);
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
        } else if (state is ResendSuccess) {
          context.read<TimerCubit>().startResendTimer();
          CustomSnackbar.show(
            context,
            message: state.code,
            type: SnackbarType.success,
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is OtpLoading,
          progressIndicator: CircularProgressIndicator(color: primaryColor),
          child: Stack(
            children: [
              Positioned(
                top: -100,
                right: -100,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        primaryColor.withValues(alpha: 0.15),
                        primaryColor.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -150,
                left: -150,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xff06B6D4).withValues(alpha: 0.12),
                        const Color(0xff06B6D4).withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () => Navigator.maybePop(context),
                            child: Container(
                              height: 44,
                              width: 44,
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color:
                                      isDark
                                          ? const Color(0xff30363D)
                                          : const Color(0xffE2E8F0),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.03),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Directionality.of(context).name == 'rtl'
                                    ? Icons.arrow_forward_ios_rounded
                                    : Icons.arrow_back_ios_new_rounded,
                                size: 18,
                                color: textPrimary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: cardColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withValues(alpha: 0.08),
                                blurRadius: 24,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: SvgPicture.asset(
                            Assets.imagesDoctor,
                            height: 140,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'otp_title'.tr(),
                          style: TextStyle(
                            color: textPrimary,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: FutureBuilder<String>(
                            future: getUserEmail(),
                            builder: (context, snapshot) {
                              final email = snapshot.data ?? '...';
                              return Text(
                                'otp_desc'.tr() + ' $email',
                                style: TextStyle(
                                  color: textSecondary,
                                  fontSize: 15,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 32),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 28,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color:
                                  isDark
                                      ? const Color(0xff30363D)
                                      : const Color(0xffE2E8F0),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const OTPRowFields(),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'code_completion'.tr(),
                                    style: TextStyle(
                                      color: textSecondary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "$_filledFieldsCount/6",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                height: 6,
                                decoration: BoxDecoration(
                                  color:
                                      isDark
                                          ? const Color(0xff21262D)
                                          : const Color(0xffE2E8F0),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Stack(
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      width:
                                          MediaQuery.of(context).size.width *
                                          _progress,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            primaryColor,
                                            const Color(0xff06B6D4),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(3),
                                        boxShadow: [
                                          BoxShadow(
                                            color: primaryColor.withValues(
                                              alpha: 0.3,
                                            ),
                                            blurRadius: 6,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        const CountDownTimerOTP(),
                        const SizedBox(height: 32),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              colors: [
                                primaryColor,
                                primaryColor.withValues(alpha: 0.85),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withValues(alpha: 0.35),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: CustomButton(
                            title: 'confirm'.tr(),
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              final otp = _getOtpCode(context);
                              if (otp != null) {
                                context.read<OtpCubit>().sendCode(code: otp);
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<TimerCubit, TimerState>(
                          builder: (context, state) {
                            int? secondsLeft;
                            if (state is TimerUpdated) {
                              secondsLeft = state.secondsLeft;
                            }
                            final isDisabled =
                                secondsLeft != null && secondsLeft > 0;

                            return AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: isDisabled ? 0.6 : 1.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color:
                                        isDisabled
                                            ? (isDark
                                                ? const Color(0xff30363D)
                                                : const Color(0xffCBD5E1))
                                            : primaryColor.withValues(
                                              alpha: 0.3,
                                            ),
                                    width: 1.5,
                                  ),
                                ),
                                child: CustomButton(
                                  title: 'Resend_Code'.tr(),
                                  onTap:
                                      isDisabled
                                          ? null
                                          : () {
                                            FocusScope.of(context).unfocus();
                                            context
                                                .read<OtpCubit>()
                                                .resendCode();
                                          },
                                  color:
                                      isDisabled ? Colors.grey : KPrimaryColor,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String? _getOtpCode(BuildContext context) {
    final codeText = c1.text + c2.text + c3.text + c4.text + c5.text + c6.text;

    if (codeText.length != 6 || codeText.contains(RegExp(r'[^0-9]'))) {
      return null;
    }

    return codeText;
  }
}
