import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/utils/api_services.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/auth/create_account/data/model/create_account_model.dart';
import 'package:medicore_app/features/auth/create_account/domain/entities/user_entity.dart';
import 'package:medicore_app/features/auth/create_account/domain/repos/create_account_repo.dart';

class CreateAccountRepoImp extends CreateAccountRepo {
  @override
  Future<Either<Failure, UserEntity>> createAccount(
    Map<String, dynamic> data,
  ) async {
    final response = await getIt<Api>().post(
      endPoint: 'auth/register',
      data: data,
    );
    return response.fold((failure) => Left(failure), (data) {
      final user = CreateAccountModel.fromJson(data);
      return Right(user);
    });
  }
}
