import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/utils/api_services.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';

class ForgetPasswordRepo {
  Future<Either<Failure, dynamic>> forgetPassword({
    required String email,
  }) async {
    final response = await getIt<Api>().post(
      endPoint: 'password/request',
      data: {'email': email},
    );
    return response.fold((failure) => Left(failure), (json) => Right(json));
  }
}
