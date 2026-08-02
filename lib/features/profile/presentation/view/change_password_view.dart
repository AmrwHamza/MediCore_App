import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/features/profile/presentation/view/widgets/change_password_widgets/change_password_view_body.dart';
import 'package:medicore_app/features/profile/presentation/view_model/password_cubit_obscure/change_password_obscure_cubit.dart';

import '../view_model/cubit/change_password_cubit.dart';

class ChangePasswordView extends StatelessWidget {
  static const routeName = '/changePassword';
  ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ChangePasswordCubit()),
          BlocProvider(create: (context) => ChangeObscurePasswordCubit()),
        ],
        child: ChangePasswordViewBody(),
      ),
    );
  }
}
