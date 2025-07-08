import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/patient_info_view_body.dart';

class PatientInfoView extends StatelessWidget {
  static const routeName = '/medical-info';
  const PatientInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: const PatientInfoViewBody(),
    );
  }
}
