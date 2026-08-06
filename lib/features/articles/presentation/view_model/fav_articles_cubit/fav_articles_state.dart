import 'package:equatable/equatable.dart';
import 'package:medicore_app/features/articles/domain/entities/article_entity.dart';

sealed class FavoriteArticlesState extends Equatable {
  const FavoriteArticlesState();

  @override
  List<Object?> get props => [];
}

final class FavoriteArticlesInitial extends FavoriteArticlesState {}

final class FavoriteArticlesLoading extends FavoriteArticlesState {}

final class FavoriteArticlesSuccess extends FavoriteArticlesState {
  final List<ArticleEntity> articles;

  const FavoriteArticlesSuccess({required this.articles});

  @override
  List<Object?> get props => [articles];
}

final class FavoriteArticlesFailure extends FavoriteArticlesState {
  final String error;

  const FavoriteArticlesFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
