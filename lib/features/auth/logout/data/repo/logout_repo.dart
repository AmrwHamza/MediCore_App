import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/utils/api_services.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/auth/logout/data/model/logout_model.dart';

class LogoutRepo {
  Future<Either<Failure, LogoutModel>> logout() async {
    final response = await getIt<Api>().postWithAuth(
      endPoint: 'auth/logout',
      data: null,
    );

    return response.fold(
      (failure) => Left(failure),
      (json) => Right(LogoutModel.fromJson(json)),
    );
  }
}
