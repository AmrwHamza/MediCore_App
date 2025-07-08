import 'package:hive_flutter/adapters.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/features/home/data/models/hive/hive_department_model.dart';
import 'package:medicore_app/features/home/data/models/hive/hive_doctor_model.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HiveDepartmentModelAdapter());
  Hive.registerAdapter(HiveDoctorModelAdapter());

  final departmentBox = await Hive.openBox<HiveDepartmentModel>('departments');
  final doctorBox = await Hive.openBox<HiveDoctorModel>('doctors');

  getIt.registerLazySingleton<Box<HiveDepartmentModel>>(() => departmentBox);
  getIt.registerLazySingleton<Box<HiveDoctorModel>>(() => doctorBox);
}


