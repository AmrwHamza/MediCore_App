import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_curve_shape.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/widget/controler_otp.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/widget/otp_row_field.dart';

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
            SizedBox(height: 30),
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
            CustomButton(
              title: 'Confirm'.tr(),
              onTap: () {
                FocusScope.of(context).unfocus();
              },
            ),
            const SizedBox(height: 25),
            CustomButton(
              title: 'Resend the Code'.tr(),
              onTap: () {
                FocusScope.of(context).unfocus();

                // BlocProvider.of<VerifyCubit>(context, listen: false)
                //     .reSendClick(token: registerCubit.user?.token);
              },
            ),
          ],
        ),
      ),
    );
  }

  void dispose() {
    c1.dispose();
    c2.dispose();
    c3.dispose();
    c4.dispose();
    c5.dispose();
    c6.dispose();
  }
}
