class PatientProfileEntity {
  final String birthDate;
  final String gender;
  final int age;
  final String bloodType;
  final String medicationAllergies;
  final String chronicDiseases;
  final String permanentMedications;
  final String previousSurgeries;
  final String previousIllnesses;

  PatientProfileEntity({
    required this.birthDate,
    required this.gender,
    required this.age,
    required this.bloodType,
    required this.medicationAllergies,
    required this.chronicDiseases,
    required this.permanentMedications,
    required this.previousSurgeries,
    required this.previousIllnesses,
  });

  @override
  String toString() {
    return 'PatientProfileEntity(birthDate: $birthDate, gender: $gender, age: $age, bloodType: $bloodType, medicationAllergies: $medicationAllergies, chronicDiseases: $chronicDiseases, permanentMedications: $permanentMedications, previousSurgeries: $previousSurgeries, previousIllnesses: $previousIllnesses)';
  }
}
