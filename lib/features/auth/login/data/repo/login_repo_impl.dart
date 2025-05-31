import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/utils/api_services.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/auth/login/data/model/login_model.dart';
import 'package:medicore_app/features/auth/login/domain/entities/login_user_entity.dart';
import 'package:medicore_app/features/auth/login/domain/repos/login_repo.dart';

class LoginRepoImpl extends LoginRepo {
  
  @override
  Future<Either<Failure, LoginUserEntity>> login({
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    final response = await Api().post(
      endPoint: 'login',
      data: {'email': email, 'password': password, 'phone': phoneNumber},
    );
    return response.fold((failure) => Left(failure), (json) {
      final data = LoginModel.fromJson(json);
      return Right(data);
    });
  }
}
