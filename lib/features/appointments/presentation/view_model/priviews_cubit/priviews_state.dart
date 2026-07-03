part of 'priviews_cubit.dart';

sealed class PriviewsState extends Equatable {
  const PriviewsState();

  @override
  List<Object> get props => [];
}

final class PriviewsInitial extends PriviewsState {}

final class PriviewsLoading extends PriviewsState {}

final class PriviewsFailure extends PriviewsState {
  final String error;
  PriviewsFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class PriviewsSuccess extends PriviewsState {
  final List<PrivewEntity> completePreviews;
  final List<PrivewEntity> partlyPreviews;
  final List<PrivewEntity> completeSons;
  final List<PrivewEntity> partlyPreviewsSons;

  PriviewsSuccess({
    required this.completePreviews,
    required this.partlyPreviews,
    required this.completeSons,
    required this.partlyPreviewsSons,
  });

  @override
  List<Object> get props => [completePreviews, partlyPreviews, completeSons, partlyPreviewsSons ];
}
