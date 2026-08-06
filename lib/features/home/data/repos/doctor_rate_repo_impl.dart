import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/utils/api_services.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';

class DoctorRateRepoImpl {
  Future<Either<Failure, double?>> getUserRate(int doctorId) async {
    final response = await getIt<Api>().getWithAuth(
      endPoint: 'getDoctorRate/$doctorId',
    );
    return response.fold((failure) => Left(failure), (data) {
      final body = data['data'];
      if (body is num) return Right(body.toDouble());
      if (body is Map) {
        final rate =
            body['rate'] ?? body['value'] ?? body['rate_value'] ?? body['avg'];
        if (rate is num) return Right(rate.toDouble());
      }
      return const Right(null);
    });
  }

  Future<Either<Failure, String>> addRate(int doctorId, int rate) async {
    final response = await getIt<Api>().postWithAuth(
      endPoint: 'addDoctorRate/$doctorId',
      data: {'rate': rate},
    );
    return response.fold((failure) => Left(failure), _successMessage);
  }

  Future<Either<Failure, String>> updateRate(int doctorId, int rate) async {
    final response = await getIt<Api>().putWithAuth(
      endPoint: 'updateDoctorRate/$doctorId',
      data: {'rate': rate},
    );
    return response.fold((failure) => Left(failure), _successMessage);
  }

  Future<Either<Failure, String>> deleteRate(int doctorId) async {
    final response = await getIt<Api>().deleteWithAuth(
      endPoint: 'deleteDoctorRate/$doctorId',
      data: null,
    );
    return response.fold((failure) => Left(failure), _successMessage);
  }

  Right<Failure, String> _successMessage(Map<String, dynamic> data) {
    final message =
        data['message'] ??
        data['msg'] ??
        data['data'] ??
        'Rating updated successfully';
    return Right(message.toString());
  }
}
