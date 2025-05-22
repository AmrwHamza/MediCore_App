import 'package:flutter/material.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/widget/controler_otp.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/widget/custom_field_otp.dart';

class OTPRowFields extends StatelessWidget {
  const OTPRowFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomTextFieldOTP(
            first: true,
            last: false,
            controller: c1,
          ),
          CustomTextFieldOTP(
            first: false,
            last: false,
            controller: c2,
          ),
          CustomTextFieldOTP(
            first: false,
            last: false,
            controller: c3,
          ),
          CustomTextFieldOTP(
            first: false,
            last: false,
            controller: c4,
          ),
          CustomTextFieldOTP(
            first: false,
            last: false,
            controller: c5,
          ),
          CustomTextFieldOTP(
            first: false,
            last: true,
            controller: c6,
          ),
        ],
      ),
    );
  }
}
