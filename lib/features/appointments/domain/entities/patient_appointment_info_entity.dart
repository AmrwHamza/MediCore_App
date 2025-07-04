class PatientAppointmentInfoEntity {
  final String patientName;
  final String? patientImage;
  final String doctorName;
  final String gender;

  PatientAppointmentInfoEntity({
    required this.patientName,
    required this.patientImage,
    required this.doctorName,
    required this.gender,
  });
}
