part of 'patient_info_cubit.dart';

sealed class PatientInfoState extends Equatable {
  const PatientInfoState();

  @override
  List<Object> get props => [];
}

final class PatientInfoInitial extends PatientInfoState {}

final class AddPatientInfoLoading extends PatientInfoState {}

final class AddPatientInfoSuccess extends PatientInfoState {
  final String message;

  AddPatientInfoSuccess({required this.message});
}

final class AddPatientInfoFailure extends PatientInfoState {
  final String error;

  AddPatientInfoFailure({required this.error});
}
