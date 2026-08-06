import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/features/profile/presentation/view/widgets/change_password_widgets/change_password_view_body.dart';
import 'package:medicore_app/features/profile/presentation/view_model/password_cubit_obscure/change_password_obscure_cubit.dart';

import '../view_model/cubit/change_password_cubit.dart';

class ChangePasswordView extends StatelessWidget {
  static const routeName = '/changePassword';
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'change_password'.tr(),
        isMainBar: false,
        gradient: const LinearGradient(
          colors: [KPrimaryColor, KPrimaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
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