import 'package:flutter/material.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/widget/controler_otp.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/widget/custom_field_otp.dart';

class OTPRowFields extends StatelessWidget {
  const OTPRowFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomTextFieldOTP(first: true, last: false, controller: c1),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: CustomTextFieldOTP(
              first: false,
              last: false,
              controller: c2,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: CustomTextFieldOTP(
              first: false,
              last: false,
              controller: c3,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: CustomTextFieldOTP(
              first: false,
              last: false,
              controller: c4,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: CustomTextFieldOTP(
              first: false,
              last: false,
              controller: c5,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: CustomTextFieldOTP(first: false, last: true, controller: c6),
          ),
        ],
      ),
    );
  }
}
