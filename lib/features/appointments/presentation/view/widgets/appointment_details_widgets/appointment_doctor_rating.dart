import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicore_app/features/appointments/domain/entities/privew_entity.dart';
import 'package:medicore_app/features/home/presentation/view/widgets/doctor_details_widgets/doctor_rating_section.dart';

import 'appointment_card_info.dart';

class AppointmentDoctorRating extends StatelessWidget {
  final PrivewEntity privewEntity;

  const AppointmentDoctorRating({super.key, required this.privewEntity});

  @override
  Widget build(BuildContext context) {

    final editable = privewEntity.diagnoseisType == 1;

    return AppointmentCardInfo(
      title: 'doctor_rating'.tr(),
      child: DoctorRatingSection(
        doctorId: privewEntity.doctorId,
        canRateOverride: editable ? true : null,
        forceReadOnly: !editable,
      ),
    );
  }
}