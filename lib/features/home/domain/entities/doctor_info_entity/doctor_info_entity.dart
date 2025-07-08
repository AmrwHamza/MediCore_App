class DoctorInfoEntity {
  final int doctorId;
  final String firstName;
  final String lastName;
  final String department;
  final String email;
  final String phone;
  final String imagePath;
  final num? rate;

  DoctorInfoEntity({
    required this.doctorId,
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.email,
    required this.phone,
    required this.imagePath,
    required this.rate,
  });
}
