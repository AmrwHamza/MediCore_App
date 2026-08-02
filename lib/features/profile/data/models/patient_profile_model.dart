import '../../domain/entities/patient_profile_entity.dart';

class PatientProfileModel extends PatientProfileEntity {
  PatientProfileModel({
    required super.birthDate,
    required super.gender,
    required super.age,
    required super.bloodType,
    required super.medicationAllergies,
    required super.chronicDiseases,
    required super.permanentMedications,
    required super.previousSurgeries,
    required super.previousIllnesses,
  });

  factory PatientProfileModel.fromJson(Map<String, dynamic> json) =>
      PatientProfileModel(
        birthDate: json['birth_date'],
        gender: json['gender'],
        age: int.parse(json['age']),
        bloodType: json['blood_type'],
        medicationAllergies: json['medication_allergies'],
        chronicDiseases: json['chronic_diseases'],
        permanentMedications: json['permanent_medications'],
        previousSurgeries: json['previous_surgeries'],
        previousIllnesses: json['previous_illnesses'],
      );
}
