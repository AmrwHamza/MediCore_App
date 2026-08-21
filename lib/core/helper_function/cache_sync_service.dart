import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/features/appointments/data/repo/appointments_repo_impl.dart';
import 'package:medicore_app/features/articles/data/repo/article_repo_impl.dart';

class CacheSyncService {
  bool _syncing = false;

  Future<void> syncAll() async {
    if (_syncing) return;
    _syncing = true;
    try {
      await getIt<AppointmentsRepoImpl>().getPrivews();
      await getIt<AppointmentsRepoImpl>().getAppointments();
      await getIt<ArticleRepoImpl>().getArticles(page: 1);
    } catch (_) {

    } finally {
      _syncing = false;
    }
  }
}
