class PatientInfoModel {
  final String message;

  PatientInfoModel({required this.message});

  factory PatientInfoModel.fromJson(Map<String, dynamic> json) {
    return PatientInfoModel(message: json['message']);
  }
}
