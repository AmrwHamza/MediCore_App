import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view/widget/create_account_body.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view_model/create_account_cubit/create_account_cubit.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view_model/id_cubit/id_cubit.dart';
import 'package:medicore_app/features/auth/public_cubits/auth_validate_cubit/auth_validate_cubit.dart';
import 'package:provider/provider.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});
  static const routeName = '/createAccount';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getIt<ThemeProvider>().themeData.primaryColor,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CreateAccountCubit()),
          Provider(create: (context) => getIt<AuthValidateCubit>()),
          BlocProvider(create: (context) => IdCubit()),
        ],
        child: const CreateAccountBody(),
      ),
    );
  }
}
