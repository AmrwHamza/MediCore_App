import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/features/profile/presentation/view/widgets/edit_profile_widgets/edit_profile_view_body.dart';

import '../view_model/edit_profile_cubit/edit_profile_cubit.dart';

class EditProfileView extends StatelessWidget {
  static const routeName = '/editProfile-vieww';
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: BlocProvider(
        create: (context) => EditProfileCubit()..getProfileInfo(),
        child: const EditProfileViewBody(),
      ),
    );
  }
}
