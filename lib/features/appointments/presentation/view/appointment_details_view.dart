import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_details_widgets/appointment_details_view_body.dart';

import '../../domain/entities/privew_entity.dart';

class AppointmentDetailsView extends StatelessWidget {
  static const routeName = '/appointment-details';

  final PrivewEntity privewEntity;

  const AppointmentDetailsView({super.key, required this.privewEntity});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'appointment_title'.tr(),
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDark ? KDarkBlue : KPrimaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20.r,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: AppointmentDetailsViewBody(privewEntity: privewEntity),
    );
  }
}
