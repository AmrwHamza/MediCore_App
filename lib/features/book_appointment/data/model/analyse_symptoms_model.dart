import 'package:medicore_app/features/book_appointment/domain/entities/analyse_symptoms_entity.dart';

class AnalyseSymptomsModel extends AnalyseSymptomsEntity {
  AnalyseSymptomsModel({
    required super.message,
    required super.suggestedDepartment,
    required super.suggestedDepartmentId,
    required super.symptomsProvided,
  });

  factory AnalyseSymptomsModel.fromJson(Map<String, dynamic> json) {
    final result = json['data']['suggested_department'];
    return AnalyseSymptomsModel(
      message: json['msg'],
      suggestedDepartment: result['name'],
      suggestedDepartmentId: result['id'],
      symptomsProvided: json['data']['symptoms_provided'],
    );
  }
}
