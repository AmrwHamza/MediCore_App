import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/utils/api_services.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/notification/domain/entities/notification_entity.dart';
import 'package:medicore_app/features/notification/domain/repos/notification_repo.dart';

import '../models/notification_model.dart';

class NotificationRepoImpl implements NotificationRepo {
  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    final response = await getIt<Api>().getWithAuth(
      endPoint: 'notifications',
    );
    return response.fold((failure) => Left(failure), (data) {
      final rawNotifications = _extractNotifications(data);
      if (rawNotifications == null) {
        return const Right(<NotificationEntity>[]);
      }

      final notifications = <NotificationEntity>[];
      for (final json in rawNotifications) {
        if (json is! Map<String, dynamic>) continue;
        try {
          notifications.add(
            NotificationModel.fromJson(json).toEntity(),
          );
        } catch (_) {

          continue;
        }
      }

      return Right(notifications);
    });
  }

  List<dynamic>? _extractNotifications(Map<String, dynamic> data) {
    final dataMap = data['data'];
    if (dataMap is List) return dataMap;
    if (dataMap is! Map) return null;

    for (final key in const [
      'notifications',
      'data',
      'items',
    ]) {
      final value = dataMap[key];
      if (value is List) return value;
    }

    final direct = data['notifications'];
    if (direct is List) return direct;

    return null;
  }
}
