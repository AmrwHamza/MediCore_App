import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/utils/api_services.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/auth/OTP/data/model/otp_model.dart';
import 'package:medicore_app/features/auth/OTP/domain/entities/otp_entity.dart';
import 'package:medicore_app/features/auth/OTP/domain/repo/otp_repo.dart';

class OtpRepoImpl extends OtpRepo {
  @override
  Future<Either<Failure, OtpEntity>> resendCode() async {
    final response = await getIt<Api>().getWithAuth(endPoint: 'resendCode');
    return response.fold((failure) => Left(failure), (json) {
      final data = OtpModel.fromJson(json);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, OtpEntity>> sendCode(String code) async {
    final response = await getIt<Api>().postWithAuth(
      endPoint: 'varify',
      data: {"code": code},
    );
    return response.fold((failure) => Left(failure), (json) {
      final data = OtpModel.fromJson(json);
      return Right(data);
    });
  }
}
