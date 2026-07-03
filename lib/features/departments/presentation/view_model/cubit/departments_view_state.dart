part of 'departments_view_cubit.dart';

@freezed
class DepartmentsViewState with _$DepartmentsViewState {
  const factory DepartmentsViewState.initial() = _Initial;
  const factory DepartmentsViewState.getDepartmentsLoading() =
      _GetDepartmentsLoading;
  const factory DepartmentsViewState.searchDepartmentsLoading() =
      _SearchDepartmentsLoading;
  const factory DepartmentsViewState.getDepartmentsFailure({
    required String errorMessage,
  }) = _GetDepartmentsFailure;
  const factory DepartmentsViewState.searchDepartmentsFailure({
    required String errorMessage,
  }) = _SearchDepartmentsFailure;
  const factory DepartmentsViewState.getDepartmentsSuccess({
    required List<DepartmentEntity> departments,
  }) = _GetDepartmentsSuccess;
  const factory DepartmentsViewState.searchDepartmentsSuccess({
    required List<DepartmentEntity> departments,
  }) = _SearchDepartmentsSuccess;
}
