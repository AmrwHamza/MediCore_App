import 'package:medicore_app/features/book_appointment/data/model/symptom_model.dart';

class GetSymptomsModel {
  final int status;
  final List<SymptomModel> data;
  final String message;

  GetSymptomsModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory GetSymptomsModel.fromJson(Map<String, dynamic> json) {
    return GetSymptomsModel(
      status: json['status'] as int,
      data:
          (json['data'] as List)
              .map((e) => SymptomModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((e) => e.toJson()).toList(),
      'message': message,
    };
  }
}
