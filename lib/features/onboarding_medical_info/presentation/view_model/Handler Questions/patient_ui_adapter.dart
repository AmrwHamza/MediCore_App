import 'package:flutter/material.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/Handler%20Questions/info_ui_handler.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/patient_info_ui_cubit/patient_info_ui_cubit.dart';

class PatientUiAdapter implements InfoUiHandler {
  final PatientInfoUiCubit cubit;
  final PatientInfoUiState state;

  PatientUiAdapter(this.cubit, this.state);

  @override
  bool get showDiseaseField => state.showDiseaseField;

  @override
  bool get showAllergyField => state.showAllergyField;

  @override
  bool get showMedicationField => state.showMedicationField;

  @override
  bool get showSurgeryField => state.showSurgeryField;

  @override
  bool get showPreviousIllnesses => state.showPreviousIllnesses;

  @override
  TextEditingController get diseaseController => state.diseaseController;

  @override
  TextEditingController get allergyController => state.allergyController;

  @override
  TextEditingController get medicationController => state.medicationController;

  @override
  TextEditingController get surgeryController => state.surgeryController;

  @override
  TextEditingController get previousIllnessesController =>
      state.previousIllnessesController;

  @override
  void updateDisease(bool value) => cubit.updateDisease(value);

  @override
  void updateAllergy(bool value) => cubit.updateAllergy(value);

  @override
  void updateMedication(bool value) => cubit.updateMedication(value);

  @override
  void updateSurgery(bool value) => cubit.updateSurgery(value);

  @override
  void updatePreviousIllnesses(bool value) =>
      cubit.updatePreviousIllnesses(value);
}
