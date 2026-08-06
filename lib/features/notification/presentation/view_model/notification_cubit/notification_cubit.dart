import 'package:bloc/bloc.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/features/notification/data/repo/notification_repo_impl.dart';
import 'package:medicore_app/features/notification/presentation/view_model/notification_cubit/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  Future<void> getNotifications() async {
    emit(NotificationLoading());
    final response = await getIt<NotificationRepoImpl>().getNotifications();
    response.fold(
      (failure) => emit(NotificationFailure(error: failure.message)),
      (notifications) =>
          emit(NotificationSuccess(notifications: notifications)),
    );
  }
}
