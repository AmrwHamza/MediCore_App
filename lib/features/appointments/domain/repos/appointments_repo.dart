import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/appointments/domain/entities/appointments_entity.dart';

import '../../data/models/privew_model.dart';

abstract class AppointmentsRepo {
  Future<Either<Failure, AppointmentsEntity>> getAppointments();
  Future<Either<Failure, PrivewResponseModel>> getPrivews();
  Future<Either<Failure, String>> deleteAppointment({required int appointmentId});
}
