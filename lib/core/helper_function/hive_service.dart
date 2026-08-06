import 'package:hive_flutter/adapters.dart';
import 'package:medicore_app/core/helper_function/app_cache_service.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/features/appointments/data/models/hive/hive_appointments_local_storge.dart';
import 'package:medicore_app/features/appointments/data/models/hive/hive_appointments_model.dart';
import 'package:medicore_app/features/home/data/models/hive/hive_department_model.dart';
import 'package:medicore_app/features/home/data/models/hive/hive_doctor_model.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HiveDepartmentModelAdapter());
  Hive.registerAdapter(HiveDoctorModelAdapter());
  Hive.registerAdapter(HiveAppointmentModelAdapter());

  final departmentBox = await Hive.openBox<HiveDepartmentModel>('departments');
  final doctorBox = await Hive.openBox<HiveDoctorModel>('doctors');
  final appointmentsBox = await Hive.openBox<HiveAppointmentModel>(
    'appointments',
  );
  final appCacheBox = await Hive.openBox<dynamic>('app_cache');

  getIt.registerLazySingleton<Box<HiveDepartmentModel>>(() => departmentBox);
  getIt.registerLazySingleton<Box<HiveDoctorModel>>(() => doctorBox);
  getIt.registerLazySingleton<Box<HiveAppointmentModel>>(() => appointmentsBox);
  getIt.registerLazySingleton<AppointmentsLocalDataSourceImpl>(
    () => AppointmentsLocalDataSourceImpl(appointmentsBox),
  );
  getIt.registerLazySingleton<AppCacheService>(
    () => AppCacheService(appCacheBox),
  );
}


