import 'package:medicore_app/features/book_appointment/domain/entities/symptom_entity.dart';

class SymptomModel extends SymptomEntity {
  SymptomModel({required super.symptomName});

  factory SymptomModel.fromJson(Map<String, dynamic> json) {
    return SymptomModel(symptomName: json['symbtom_name'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'symbtom_name': symptomName};
  }
}
