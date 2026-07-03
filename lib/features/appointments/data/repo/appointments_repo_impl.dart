import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/utils/api_services.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/appointments/data/models/appointments_model.dart';
import 'package:medicore_app/features/appointments/domain/entities/appointments_entity.dart';
import 'package:medicore_app/features/appointments/domain/repos/appointments_repo.dart';

import '../models/privew_model.dart';

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

  @override
  Future<Either<Failure, PrivewResponseModel>> getPrivews() async {
    final response = await getIt<Api>().getWithAuth(endPoint: 'getPreviews');
    return response.fold((failure) => Left(failure), (data) {
      final privews = PrivewResponseModel.fromJson(data);
      return Right(privews);
    });
  }
  
  @override
  Future<Either<Failure, String>> deleteAppointment({required int appointmentId})async {
    final response = await getIt<Api>().deleteWithAuth(endPoint: 'deleteAppointment/$appointmentId',data:{});
    return response.fold((failure) => Left(failure), (data) {
      return Right('delete_appointment_success'.tr());
    });
  }
}
