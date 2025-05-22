import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/utils/api_services.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/auth/create_account/data/model/user_model.dart';
import 'package:medicore_app/features/auth/create_account/domain/entities/user_entity.dart';
import 'package:medicore_app/features/auth/create_account/domain/repos/create_account_repo.dart';

class CreateAccountRepoImp extends CreateAccountRepo {
  @override
  Future<Either<Failure, UserEntity>> createAccount(
    String email,
    String phoneNumber,
    String password,
    String confPassword,
  ) async {
    final response = await Api().post(
      endPoint: 'endPoint',
      data: {
        'email': email,
        'phone': phoneNumber,
        'password': password,
        'confirm_password': confPassword,
      },
    );
    return response.fold((failure) => Left(failure), (data) {
      final user = UserModel.fromJson(data);
      return Right(user);
    });
  }
}
