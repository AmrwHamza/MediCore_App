part of 'doctors_cubit.dart';

sealed class DoctorsState extends Equatable {
  const DoctorsState();

  @override
  List<Object> get props => [];
}

final class DoctorsInitial extends DoctorsState {}

final class DoctorsLoading extends DoctorsState {}

final class DoctorsFailure extends DoctorsState {
  final String error;

  DoctorsFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class DoctorsSuccess extends DoctorsState {
  final List<DoctorEntity> doctors;

    DoctorsSuccess(this.doctors);
}
