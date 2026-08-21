import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medicore_app/core/helper_function/app_cache_service.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/utils/api_services.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/articles/domain/repos/article_repo.dart';

import '../../domain/entities/article_entity.dart';
import '../models/article_model.dart';

class ArticleRepoImpl implements ArticleRepo {
  int _lastPage = 1;

  static const String _articlesCacheKey = 'getArticlesApp';

  @override
  Future<Either<Failure, List<ArticleEntity>>> getArticles({
    int page = 1,
  }) async {
    final response = await getIt<Api>().getWithAuth(
      endPoint: 'getArticlesApp?page=$page',
    );
    return response.fold((failure) async {
      final cached = await getIt<AppCacheService>().get(
        '$_articlesCacheKey?page=$page',
        allowStale: true,
      );
      if (cached == null) return Left(failure);
      final List data = cached['data']['data'];
      _lastPage = cached['data']['last_page'];
      return Right(
        data.map((json) => ArticleModel.fromJson(json).toEntity()).toList(),
      );
    }, (response) async {
      await getIt<AppCacheService>().put(
        '$_articlesCacheKey?page=$page',
        response,
      );
      final List data = response['data']['data'];
      print('✅✅RESPOSE AFTER DECODE=${data.toString()}');
      _lastPage = response['data']['last_page'];

      return Right(
        data.map((json) => ArticleModel.fromJson(json).toEntity()).toList(),
      );
    });
  }

  @override
  Future<bool> hasMore(int currentPage) async {
    return currentPage < _lastPage;
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> getFavoriteArticles() async {
    final response = await getIt<Api>().getWithAuth(
      endPoint: 'getArticlesFav',
    );
    return response.fold((failure) => Left(failure), (response) {
      final data = response['data'];
      if (data is! List) {
        return const Right(<ArticleEntity>[]);
      }
      return Right(
        data
            .map((json) => ArticleModel.fromJson(json as Map<String, dynamic>))
            .toList(),
      );
    });
  }

  @override
  Future<Either<Failure, void>> addArticleFav(int articleId) async {
    final response = await getIt<Api>().postWithAuth(
      endPoint: 'addArticleFav/$articleId',
      data: null,
    );
    return response.fold((failure) => Left(failure), (json) {

      return const Right(null);
    });
  }

  @override
  Future<Either<Failure, void>> deleteArticleFav(int articleId) async {
    final response = await getIt<Api>().deleteWithAuth(
      endPoint: 'deleteArticleFav/$articleId',
      data: null,
    );
    return response.fold(
      (failure) => Left(failure),
      (json) => Right('delete_fav_success'.tr()),
    );
  }
}
