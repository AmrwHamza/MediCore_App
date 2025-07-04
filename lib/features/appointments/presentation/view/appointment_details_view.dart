import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_details_widgets/appointment_details_view_body.dart';

class AppointmentDetailsView extends StatelessWidget {
  static const routeName = '/appointment-details';

  const AppointmentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'appointment_title'.tr(), isMainBar: true),
      body: const AppointmentDetailsViewBody(),
    );
  }
}


