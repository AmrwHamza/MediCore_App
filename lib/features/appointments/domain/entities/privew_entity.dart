class PrivewEntity {
  final int id;
  final num patientId;
  final int doctorId;
  final int departmentId;
  final String patientName;
  final String doctorName;
  final String gender;
  final String imgPath;
  final String diagnoseis;
  final String medicine;
  final String notes;
  final String date;
  final String status;
  final num price;
  final String createdAt;
  final String updatedAt;
  final int diagnoseisType;
  final bool isChild;
  final int appointmentId;
  final String analysisFile;

  PrivewEntity({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.departmentId,
    required this.patientName,
    required this.doctorName,
    required this.gender,
    required this.imgPath,
    required this.diagnoseis,
    required this.medicine,
    required this.notes,
    required this.date,
    required this.status,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.diagnoseisType,
    required this.isChild,
    required this.appointmentId,
    this.analysisFile = ''
  });
}
