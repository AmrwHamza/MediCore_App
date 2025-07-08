
import 'package:medicore_app/features/articles/domain/entities/article_entity.dart';

abstract class ArticleState {}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticlePaginationLoaded extends ArticleState {
  final List<ArticleEntity> articles;
  final bool hasReachedEnd;

  ArticlePaginationLoaded({
    required this.articles,
    required this.hasReachedEnd,
  });
}

class ArticleError extends ArticleState {
  final String message;

  ArticleError(this.message);
}
