import 'package:hive/hive.dart';

part 'hive_doctor_model.g.dart';

@HiveType(typeId: 2)
class HiveDoctorModel extends HiveObject {
  @HiveField(0)
  int doctorId;

  @HiveField(1)
  int departmentId;

  @HiveField(2)
  int userId;

  @HiveField(3)
  String bio;

  @HiveField(4)
  String departmentName;

  @HiveField(5)
  String departmentImage;

  @HiveField(6)
  String doctorUserFirstName;

  @HiveField(7)
  String doctorUserLastName;

  @HiveField(8)
  String doctorUserImage;

  @HiveField(9)
  String doctorUserEmail;

  @HiveField(10)
  String doctorUserPhone;

  @HiveField(11)
  String doctorUserExperience;



  HiveDoctorModel({
    required this.doctorId,
    required this.departmentId,
    required this.userId,
    required this.bio,
    required this.departmentName,
    required this.departmentImage,
    required this.doctorUserFirstName,
    required this.doctorUserLastName,
    required this.doctorUserImage,
    required this.doctorUserEmail,
    required this.doctorUserPhone,
    required this.doctorUserExperience
  });
}
