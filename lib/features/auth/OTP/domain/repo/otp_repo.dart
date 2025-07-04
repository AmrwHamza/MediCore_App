import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/auth/OTP/domain/entities/otp_entity.dart';

abstract class OtpRepo {
  Future<Either<Failure, OtpEntity>> sendCode(String code);
  Future<Either<Failure, OtpEntity>> resendCode();
}
