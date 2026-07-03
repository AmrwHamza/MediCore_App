part of 'family_details_cubit.dart';

@freezed
class FamilyDetailsState with _$FamilyDetailsState {
  const factory FamilyDetailsState.initial() = _Initial;
  const factory FamilyDetailsState.loading() = _Loading;
  const factory FamilyDetailsState.success(PrivewEntity model) = _Success;
  const factory FamilyDetailsState.failure(String message) = _Failure;
}
