part of 'edit_child_cubit.dart';



@freezed
class EditChildState with _$EditChildState {
  const factory EditChildState.initial() = _Initial;
  const factory EditChildState.loading() = _Loading;
  const factory EditChildState.success(GetChildEntity child) = _Success;
  const factory EditChildState.failure(String message) = _Failure;
}
