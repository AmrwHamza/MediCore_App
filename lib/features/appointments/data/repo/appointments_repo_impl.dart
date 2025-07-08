import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/utils/api_services.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/appointments/data/models/appointments_model.dart';
import 'package:medicore_app/features/appointments/domain/entities/appointments_entity.dart';
import 'package:medicore_app/features/appointments/domain/repos/appointments_repo.dart';

class AppointmentsRepoImpl implements AppointmentsRepo {
  @override
  Future<Either<Failure, AppointmentsEntity>> getAppointments() async {
    final response = await getIt<Api>().getWithAuth(
      endPoint: 'getAppointments',
    );
    return response.fold((failure) => Left(failure), (data) {
      final appointments = AppointmentsModel.fromJson(data);
      return Right(appointments);
    });
  }
}
