import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/helper/shared_pref.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view_model/create_account_cubit/create_account_cubit.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view_model/id_cubit/id_cubit.dart';
import 'package:medicore_app/features/auth/first_page/presentation/view/widget/first_page_auth_body.dart';
import 'package:medicore_app/features/auth/first_page/presentation/view_model/change_lang_cubit/change_language_cubit.dart';
import 'package:medicore_app/features/auth/login/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:medicore_app/features/auth/public_cubits/auth_cubit/auth_cubit.dart';

class FirstPageAuth extends StatelessWidget {
  const FirstPageAuth({super.key});
  static const routeName = '/firstPageAuth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=> AuthCubit()),
          BlocProvider(create: (context)=> CreateAccountCubit()),
          BlocProvider(create: (context)=> LoginCubit()),
          BlocProvider(create: (context)=> IdCubit()),
          BlocProvider(create: (context)=> ChangeLanguageCubit(SharedPrefHelper())),
        ],
        child: FirstPageAuthBody(),
      ),
    );
  }
}
