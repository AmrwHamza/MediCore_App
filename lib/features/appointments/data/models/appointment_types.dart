import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../domain/entities/privew_entity.dart';

enum AppointmentTypes { pending, accepted, incomplete, complete }

String fromAppointmentTypesToString(AppointmentTypes type) {
  switch (type) {
    case AppointmentTypes.pending:
      return 'waiting'.tr();
    case AppointmentTypes.accepted:
      return 'accepted'.tr();
    case AppointmentTypes.incomplete:
      return 'incomplete'.tr();
    case AppointmentTypes.complete:
      return 'completed'.tr();
  }
}

AppointmentTypes fromStringToAppointmentTypes(String type) {
  switch (type) {
    case 'waiting':
      return AppointmentTypes.pending;
    case 'accepted':
      return AppointmentTypes.accepted;
    case 'incomplete':
      return AppointmentTypes.incomplete;
    case 'completed':
      return AppointmentTypes.complete;
    default:
      return AppointmentTypes.pending;
  }
}

String fromAppointmentTypesToApiString(AppointmentTypes type) {
  switch (type) {
    case AppointmentTypes.pending:
      return 'pending';
    case AppointmentTypes.accepted:
      return 'accepted';
    case AppointmentTypes.incomplete:
      return 'incomplete';
    case AppointmentTypes.complete:
      return 'complete';
  }
}

String pickNote(AppointmentTypes status) {
  switch (status) {
    case AppointmentTypes.pending:
      return 'waiting_note';
    case AppointmentTypes.accepted:
      return 'progress_note';
    case AppointmentTypes.incomplete:
      return 'incomplete_note';
    case AppointmentTypes.complete:
      return 'done_note';
  }
}

Color pickStatusColor(String status) {
  switch (status) {
    case 'Waiting':
      return KPurple;
    case "In Progressing":
      return KOrange;
    case 'Done':
      return Colors.green;
    default:
      return Colors.grey;
  }
}

bool canUploadMedicalAnalysis(PrivewEntity preview) {
  return preview.diagnoseisType == 0;
}

bool isCompletedDiagnosis(PrivewEntity preview) {
  return preview.diagnoseisType == 1;
}

bool isIncompleteDiagnosis(PrivewEntity preview) {
  if (preview.diagnoseisType != 0) return false;
  final status = preview.status.toLowerCase();
  return status != 'pending' &&
      status != 'waiting' &&
      status != 'accepted';
}
