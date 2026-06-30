import 'package:easy_localization/easy_localization.dart';

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
