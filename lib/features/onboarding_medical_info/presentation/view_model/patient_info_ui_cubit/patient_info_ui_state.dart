part of 'patient_info_ui_cubit.dart';

class PatientInfoUiState {
  final bool showDiseaseField;
  final bool showMedicationField;
  final bool showAllergyField;
  final bool showSurgeryField;
  final bool showPreviousIllnesses;
  final bool hasChildren;
  final String gender;

  final int age;
  final DateTime? birthDate;
  final String bloodType;

  final TextEditingController diseaseController;
  final TextEditingController medicationController;
  final TextEditingController allergyController;
  final TextEditingController surgeryController;
  final TextEditingController previousIllnessesController;

  final List<Map<String, dynamic>> children;

  PatientInfoUiState({
    this.showDiseaseField = false,
    this.showMedicationField = false,
    this.showAllergyField = false,
    this.showSurgeryField = false,
    this.showPreviousIllnesses = false,
    this.hasChildren = false,
    this.gender = 'male',
    this.birthDate,
    this.age = 18,
    this.bloodType = 'A+',
    TextEditingController? diseaseController,
    TextEditingController? medicationController,
    TextEditingController? allergyController,
    TextEditingController? surgeryController,
    TextEditingController? previousIllnessesController,
    this.children = const [],
  }) : diseaseController = diseaseController ?? TextEditingController(),
       medicationController = medicationController ?? TextEditingController(),
       allergyController = allergyController ?? TextEditingController(),
       surgeryController = surgeryController ?? TextEditingController(),
       previousIllnessesController =
           previousIllnessesController ?? TextEditingController();

  PatientInfoUiState copyWith({
    bool? showDiseaseField,
    bool? showMedicationField,
    bool? showAllergyField,
    bool? showSurgeryField,
    bool? showPreviousIllnesses,
    bool? hasChildren,
    String? gender,
    DateTime? birthDate,
    int? age,
    String? bloodType,

    List<Map<String, dynamic>>? children,
  }) {
    return PatientInfoUiState(
      showDiseaseField: showDiseaseField ?? this.showDiseaseField,
      showMedicationField: showMedicationField ?? this.showMedicationField,
      showAllergyField: showAllergyField ?? this.showAllergyField,
      showSurgeryField: showSurgeryField ?? this.showSurgeryField,
      showPreviousIllnesses:
          showPreviousIllnesses ?? this.showPreviousIllnesses,
      hasChildren: hasChildren ?? this.hasChildren,
      gender: gender ?? this.gender,
      diseaseController: diseaseController,
      medicationController: medicationController,
      allergyController: allergyController,
      surgeryController: surgeryController,
      previousIllnessesController: previousIllnessesController,
      children: children ?? this.children,
      birthDate: birthDate ?? this.birthDate,
      age: age ?? this.age,
      bloodType: bloodType ?? this.bloodType,
    );
  }

  void disposeControllers() {
    diseaseController.dispose();
    medicationController.dispose();
    allergyController.dispose();
    surgeryController.dispose();
    previousIllnessesController.dispose();
  }
}
