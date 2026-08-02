import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/features/profile/presentation/view/widgets/patient_profile_widgets/patient_profile_view_body.dart';
import 'package:medicore_app/features/profile/presentation/view_model/edit_patient_profile_cubit/edit_patient_profile_cubit.dart';

class PatientProfileView extends StatelessWidget {
  static const routeName = '/patientProfile-vieww';
  const PatientProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: BlocProvider(
        create: (context) => EditPatientProfileCubit()..getPatientProfileInfo(),
        child: const PatientProfileViewBody(),
      ),
    );
  }
}
