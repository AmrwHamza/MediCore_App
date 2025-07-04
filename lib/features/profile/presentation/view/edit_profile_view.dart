import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/features/profile/presentation/view/widgets/edit_profile_view_body.dart';
import 'package:medicore_app/features/profile/presentation/view_model/info_cubit/edit_profile_info_cubit.dart';

class EditProfileView extends StatelessWidget {
  static const routeName = '/editProfile';
  EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Profile Information'.tr(),
        isMainBar: false,
      ),
      body: BlocProvider(
        create: (context) => EditProfileInfoCubit(),
        child: EditProfileViewBody(),
      ),
    );
  }
}
