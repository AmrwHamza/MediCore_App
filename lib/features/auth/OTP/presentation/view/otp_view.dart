import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/widget/otp_view_body.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view_model/cubit/otp_cubit.dart';

class OTPView extends StatelessWidget {
  const OTPView({super.key});
  static const routeName = '/otp';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => OtpCubit(),
        child: OTPViewBody(),
      ),
    );
  }
}
