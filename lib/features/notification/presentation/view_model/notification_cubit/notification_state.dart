import 'package:equatable/equatable.dart';
import 'package:medicore_app/features/notification/domain/entities/notification_entity.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

final class NotificationInitial extends NotificationState {}

final class NotificationLoading extends NotificationState {}

final class NotificationSuccess extends NotificationState {
  final List<NotificationEntity> notifications;

  const NotificationSuccess({required this.notifications});

  @override
  List<Object?> get props => [notifications];
}

final class NotificationFailure extends NotificationState {
  final String error;

  const NotificationFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
