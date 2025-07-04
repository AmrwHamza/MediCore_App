import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'patient_info_ui_state.dart';

class PatientInfoUiCubit extends Cubit<PatientInfoUiState> {
  int currentPageIndex = 0;
  String? gender;
  DateTime? birthDate;

  PatientInfoUiCubit() : super(PatientInfoUiState()) {}

  void updateAge(int age) {
    if (age >= 0) {
      emit(state.copyWith(age: age));
    }
  }

  void updateBloodType(String bloodType) =>
      emit(state.copyWith(bloodType: bloodType));

  void updateBirthDate(DateTime date) {
    birthDate = date;
    emit(state.copyWith(birthDate: date));
  }

  void updateGender(String value) {
    gender = value;
    emit(state.copyWith(gender: value));
  }

  void updateDisease(bool val) => emit(state.copyWith(showDiseaseField: val));
  void updateMedication(bool val) =>
      emit(state.copyWith(showMedicationField: val));
  void updateAllergy(bool val) => emit(state.copyWith(showAllergyField: val));
  void updateSurgery(bool val) => emit(state.copyWith(showSurgeryField: val));
  void updatePreviousIllnesses(bool val) =>
      emit(state.copyWith(showPreviousIllnesses: val));

  void updateHasChildren(bool val) => emit(state.copyWith(hasChildren: val));

  @override
  Future<void> close() {
    state.disposeControllers();
    return super.close();
  }
}
