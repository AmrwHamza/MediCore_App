import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failure.dart';
import '../../../home/domain/entities/doctor_entity.dart';

abstract class DoctorsViewRepo {
  Future<Either<Failure, List<DoctorEntity>>> getDoctors();
  Future<Either<Failure, List<DoctorEntity>>> searchDoctors({
    required String query,
  });
}
