import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/auth/forget_password/presentation/view/widgets/forget_password_view_body.dart';
import 'package:medicore_app/features/auth/forget_password/presentation/view_model/forget_cubit/forget_password_cubit.dart';
import 'package:medicore_app/features/auth/public_cubits/auth_validate_cubit/auth_validate_cubit.dart';

class ForgetPasswordView extends StatelessWidget {
  static const routeName = '/forget_password';

  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getIt<ThemeProvider>().themeData.cardColor,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ForgetPasswordCubit()),
          BlocProvider(create: (context) => AuthValidateCubit()),
        ],

        child: ForgetPasswordViewBody(),
      ),
    );
  }
}
