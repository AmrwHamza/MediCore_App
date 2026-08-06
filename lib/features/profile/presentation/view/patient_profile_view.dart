import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/features/profile/presentation/view/widgets/patient_profile_widgets/patient_profile_view_body.dart';
import 'package:medicore_app/features/profile/presentation/view_model/edit_patient_profile_cubit/edit_patient_profile_cubit.dart';

class PatientProfileView extends StatelessWidget {
  static const routeName = '/patientProfile-vieww';
  const PatientProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'edit_medical_info'.tr(),
        isMainBar: false,
        gradient: const LinearGradient(
          colors: [KPrimaryColor, KPrimaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      body: BlocProvider(
        create: (context) => EditPatientProfileCubit()..getPatientProfileInfo(),
        child: const PatientProfileViewBody(),
      ),
    );
  }
}