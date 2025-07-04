part of 'doctor_info_cubit.dart';

sealed class DoctorInfoState extends Equatable {
  const DoctorInfoState();

  @override
  List<Object> get props => [];
}

final class DoctorInfoInitial extends DoctorInfoState {}

final class DoctorInfoLoading extends DoctorInfoState {}

final class DoctorInfoFailure extends DoctorInfoState {
  final String error;

  const DoctorInfoFailure({required this.error});
}

final class DoctorInfoSuccess extends DoctorInfoState {
  final DoctorInfoEntity doctorInfo;

  const DoctorInfoSuccess({required this.doctorInfo});
}
