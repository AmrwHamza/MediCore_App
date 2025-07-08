import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/features/auth/first_page/presentation/view/widget/first_page_auth_body.dart';
import 'package:medicore_app/features/auth/first_page/presentation/view_model/change_lang_cubit/change_language_cubit.dart';

class FirstPageAuth extends StatelessWidget {
  const FirstPageAuth({super.key});
  static const routeName = '/firstPageAuth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<ChangeLanguageCubit>(),
        child: const FirstPageAuthBody(),
      ),
    );
  }
}
