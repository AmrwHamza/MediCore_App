import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/features/auth/OTP/data/repo/otp_repo_impl.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/widget/otp_view_body.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view_model/otp_cubit/otp_cubit.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view_model/timer_cubit/timer_cubit.dart';

class OTPView extends StatelessWidget {
  const OTPView({super.key, required this.isForgetPassword});
  static const routeName = '/otp';

  final bool isForgetPassword;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xff0D1117) : const Color(0xffF8FAFC),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => OtpCubit(getIt<OtpRepoImpl>())),
          BlocProvider(create: (context) => TimerCubit()),
        ],
        child: OTPViewBody(isForgetPassword: isForgetPassword),
      ),
    );
  }
}
