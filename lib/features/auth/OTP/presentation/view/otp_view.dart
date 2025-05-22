import 'package:flutter/material.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/widget/otp_view_body.dart';

class OTPView extends StatelessWidget {
  const OTPView({super.key});
  static const routeName = '/otp';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: OTPViewBody());
  }
}
