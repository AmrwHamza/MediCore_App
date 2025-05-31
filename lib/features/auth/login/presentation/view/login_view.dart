import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/features/auth/login/presentation/view/widget/login_view_body.dart';
import 'package:medicore_app/features/auth/login/presentation/view_model/login_cubit/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginViewBody(),
    );
  }
}
