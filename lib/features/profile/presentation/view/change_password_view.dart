import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/features/profile/presentation/view/widgets/change_password_view_body.dart';
import 'package:medicore_app/features/profile/presentation/view_model/password_cubit/change_password_cubit.dart';

class ChangePasswordView extends StatelessWidget {
  static const routeName = '/changePassword';
  ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Profile Information'.tr(),
        isMainBar: false,
      ),
      body: BlocProvider(
        create: (context) => ChangePasswordCubit(),
        child: ChangePasswordViewBody(),
      ),
    );
  }
}
