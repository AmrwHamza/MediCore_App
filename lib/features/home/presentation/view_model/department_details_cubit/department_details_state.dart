part of 'department_details_cubit.dart';

sealed class DepartmentDetailsState extends Equatable {
  const DepartmentDetailsState();

  @override
  List<Object> get props => [];
}

final class DepartmentDetailsInitial extends DepartmentDetailsState {}

final class DepartmentDetailsLoading extends DepartmentDetailsState {}

final class DepartmentDetailsFailure extends DepartmentDetailsState {
  final String error;

  DepartmentDetailsFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class DepartmentDetailsSuccess extends DepartmentDetailsState {
  final List<DoctorEntity> doctors;

  DepartmentDetailsSuccess({required this.doctors});

  @override
  List<Object> get props => [doctors];
}
