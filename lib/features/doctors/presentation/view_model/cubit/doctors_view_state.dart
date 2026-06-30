part of 'doctors_view_cubit.dart';

sealed class DoctorsViewState extends Equatable {
  const DoctorsViewState();

  @override
  List<Object> get props => [];
}

final class DoctorsViewInitial extends DoctorsViewState {}

final class DoctorsViewLoading extends DoctorsViewState {}

final class DoctorsViewFailure extends DoctorsViewState {
  final String error;

  const DoctorsViewFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class DoctorsViewSuccess extends DoctorsViewState {
  final List<DoctorEntity> doctors;

  const DoctorsViewSuccess({required this.doctors});

  @override
  List<Object> get props => [doctors];
}
