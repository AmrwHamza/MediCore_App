import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/features/auth/login/presentation/view/widget/login_view_body.dart';
import 'package:medicore_app/features/auth/login/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:medicore_app/features/auth/public_cubits/auth_validate_cubit/auth_validate_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? KBackgroundDark : KBackgroundLight;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginCubit()),
          BlocProvider(create: (context) => AuthValidateCubit()),
        ],
        child: LoginViewBody(),
      ),
    );
  }
}
