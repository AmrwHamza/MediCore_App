import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_details_widgets/appointment_details_view_body.dart';

import '../../domain/entities/privew_entity.dart';

class AppointmentDetailsView extends StatelessWidget {
  static const routeName = '/appointment-details';

  final PrivewEntity privewEntity;

  const AppointmentDetailsView({super.key, required this.privewEntity});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(title: 'appointment_title'.tr(), isMainBar: false),
      body: AppointmentDetailsViewBody(privewEntity: privewEntity),
    );
  }
}
