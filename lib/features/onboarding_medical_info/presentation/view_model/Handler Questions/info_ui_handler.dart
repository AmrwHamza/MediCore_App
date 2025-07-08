import 'package:flutter/material.dart';

abstract class InfoUiHandler {
  bool get showDiseaseField;
  bool get showAllergyField;
  bool get showMedicationField;
  bool get showSurgeryField;
  bool get showPreviousIllnesses;

  TextEditingController get diseaseController;
  TextEditingController get allergyController;
  TextEditingController get medicationController;
  TextEditingController get surgeryController;
  TextEditingController get previousIllnessesController;

  void updateDisease(bool value);
  void updateAllergy(bool value);
  void updateMedication(bool value);
  void updateSurgery(bool value);
  void updatePreviousIllnesses(bool value);
}
