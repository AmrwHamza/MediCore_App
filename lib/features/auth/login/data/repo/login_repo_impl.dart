import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/utils/api_services.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/auth/login/data/model/login_model.dart';
import 'package:medicore_app/features/auth/login/domain/entities/login_user_entity.dart';
import 'package:medicore_app/features/auth/login/domain/repos/login_repo.dart';

class LoginRepoImpl extends LoginRepo {
  @override
  Future<Either<Failure, LoginUserEntity>> login({
    required Map<String, dynamic> data,
  }) async {
    final response = await getIt<Api>().post(endPoint: 'auth/login', data: data);
    return response.fold((failure) => Left(failure), (json) {
      final data = LoginModel.fromJson(json);
      return Right(data);
    });
  }
}
