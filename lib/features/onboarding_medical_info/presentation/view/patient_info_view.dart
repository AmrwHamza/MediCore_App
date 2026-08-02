import 'package:flutter/material.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/patient_info_view_body.dart';

class PatientInfoView extends StatelessWidget {
  static const routeName = '/medical-info';
  const PatientInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xff0D1117) : const Color(0xffF8FAFC),
      body: const PatientInfoViewBody(),
    );
  }
}
