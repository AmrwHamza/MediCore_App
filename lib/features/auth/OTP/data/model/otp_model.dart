import 'package:medicore_app/features/auth/OTP/domain/entities/otp_entity.dart';

class OtpModel extends OtpEntity {
  OtpModel({required super.message, required super.code});

  factory OtpModel.fromJson(Map<String, dynamic> json) {
    return OtpModel(message: json['message'] ?? '', code: json['code'] ?? 0);
  }
}
