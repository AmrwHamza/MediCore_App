part of 'children_info_ui_cubit.dart';

class ChildrenInfoUiState {
  final bool showDiseaseField;
  final bool showMedicationField;
  final bool showAllergyField;
  final bool showSurgeryField;
  final bool showPreviousIllnesses;
  final bool hasChildren;

  final int age;
  final String gender;
  final DateTime? birthDate;
  final String bloodType;

  final TextEditingController childFirstNameController;
  final TextEditingController childLastNameController;
  final TextEditingController diseaseController;
  final TextEditingController medicationController;
  final TextEditingController allergyController;
  final TextEditingController surgeryController;
  final TextEditingController previousIllnessesController;

  final List<Map<String, dynamic>> children;

  ChildrenInfoUiState({
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
    TextEditingController? childFirstNameController,
    TextEditingController? childLastNameController,
    TextEditingController? diseaseController,
    TextEditingController? medicationController,
    TextEditingController? allergyController,
    TextEditingController? surgeryController,
    TextEditingController? previousIllnessesController,
    this.children = const [],
  }) : childFirstNameController =
           childFirstNameController ?? TextEditingController(),
       childLastNameController =
           childLastNameController ?? TextEditingController(),
       diseaseController = diseaseController ?? TextEditingController(),
       medicationController = medicationController ?? TextEditingController(),
       allergyController = allergyController ?? TextEditingController(),
       surgeryController = surgeryController ?? TextEditingController(),
       previousIllnessesController =
           previousIllnessesController ?? TextEditingController();

  ChildrenInfoUiState copyWith({
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
    return ChildrenInfoUiState(
      showDiseaseField: showDiseaseField ?? this.showDiseaseField,
      showMedicationField: showMedicationField ?? this.showMedicationField,
      showAllergyField: showAllergyField ?? this.showAllergyField,
      showSurgeryField: showSurgeryField ?? this.showSurgeryField,
      showPreviousIllnesses:
          showPreviousIllnesses ?? this.showPreviousIllnesses,
      hasChildren: hasChildren ?? this.hasChildren,
      gender: gender ?? this.gender,
      childFirstNameController: childFirstNameController,
      childLastNameController: childLastNameController,
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
    childFirstNameController.dispose();
    childLastNameController.dispose();
    diseaseController.dispose();
    medicationController.dispose();
    allergyController.dispose();
    surgeryController.dispose();
    previousIllnessesController.dispose();
  }
}
