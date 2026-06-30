part of 'profile_image_cubit.dart';

sealed class ProfileImageState extends Equatable {
  const ProfileImageState();

  @override
  List<Object?> get props => [];
}

final class ProfileImageInitial extends ProfileImageState {}

final class ProfileImageLoading extends ProfileImageState {}

final class ProfileImageEmpty extends ProfileImageState {}

final class ProfileImageFailure extends ProfileImageState {
  final String errorMessage;
  const ProfileImageFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

final class GetProfileImageSuccess extends ProfileImageState {
  final String profileImagePath;
  const GetProfileImageSuccess({required this.profileImagePath});

  @override
  List<Object?> get props => [profileImagePath];
}

final class AddProfileImageSuccess extends ProfileImageState {
  final String message;
  final String profileImagePath;
  const AddProfileImageSuccess({
    required this.message,
    required this.profileImagePath,
  });

  @override
  List<Object?> get props => [message, profileImagePath];
}

final class DeleteProfileImageSuccess extends ProfileImageState {
  final String message;
  const DeleteProfileImageSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}
