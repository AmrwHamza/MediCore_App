import 'package:hive/hive.dart';
import 'package:medicore_app/features/appointments/data/models/hive/hive_appointments_model.dart';

abstract class AppointmentsLocalDataSource {
  Future<void> cacheAppointments(List<HiveAppointmentModel> appointments);
  Future<List<HiveAppointmentModel>> getCachedAppointments();
}

class AppointmentsLocalDataSourceImpl implements AppointmentsLocalDataSource {
  final Box<HiveAppointmentModel> hiveBox;

  AppointmentsLocalDataSourceImpl(this.hiveBox);

  @override
  Future<void> cacheAppointments(List<HiveAppointmentModel> appointments) async {
    await hiveBox.clear();
    await hiveBox.addAll(appointments);
  }

  @override
  Future<List<HiveAppointmentModel>> getCachedAppointments() async {
    return hiveBox.values.toList();
  }
}
