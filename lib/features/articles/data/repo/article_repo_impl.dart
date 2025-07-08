import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/utils/api_services.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/articles/domain/repos/article_repo.dart';

import '../../domain/entities/article_entity.dart';
import '../models/article_model.dart';

class ArticleRepoImpl implements ArticleRepo {
  int _lastPage = 1;

  @override
  Future<Either<Failure, List<ArticleEntity>>> getArticles({
    int page = 1,
  }) async {
    final response = await getIt<Api>().getWithAuth(
      endPoint: 'getArticlesApp?page=$page',
    );
    return response.fold((failure) => Left(failure), (response) {
      final List data = response.data['data']['data'];
      _lastPage = response.data['data']['last_page'];

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
  Future<Either<Failure, ArticleEntity>> addArticleFav(int articleId) async {
    final response = await getIt<Api>().postWithAuth(
      endPoint: 'addArticleFav/$articleId',
      data: null,
    );
    return response.fold((failure) => Left(failure), (json) {
      final data = ArticleModel.fromJson(json);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, String>> deleteArticleFav(int articleId) async {
    final response = await getIt<Api>().postWithAuth(
      endPoint: 'deleteArticleFav/$articleId',
      data: null,
    );
    return response.fold(
      (failure) => Left(failure),
      (json) => Right('delete_fav_success'.tr()),
    );
  }
}
