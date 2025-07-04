import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/articles/domain/entities/article_entity.dart';

abstract class ArticleRepo {
  Future<Either<Failure, List<ArticleEntity>>> getArticles({int page = 1});
  Future<bool> hasMore(int currentPage);
  Future<Either<Failure,ArticleEntity>> addArticleFav(int articleId);
  Future<Either<Failure,String>> deleteArticleFav(int articleId);

}
