import '../../domain/entities/edit_profile_entity.dart';

class EditProfileModel extends EditProfileEntity {
  EditProfileModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phone,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) =>
      EditProfileModel(
        firstName: json['first_name'] ?? '',
        lastName: json['last_name'] ?? '',
        email: json['email'] ?? '',
        phone: json['phone'] ?? '',
      );
}
