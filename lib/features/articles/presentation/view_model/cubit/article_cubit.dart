import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/features/articles/data/repo/article_repo_impl.dart';
import 'package:medicore_app/features/articles/domain/entities/article_entity.dart';

import 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {

  int currentPage = 1;
  List<ArticleEntity> allArticles = [];

  ArticleCubit() : super(ArticleInitial());

  Future<void> fetchInitialArticles() async {
    emit(ArticleLoading());
    try {
      currentPage = 1;
      final response = await getIt<ArticleRepoImpl>().getArticles(page: currentPage);
      response.fold(
        (failure) {
          emit(ArticleError(failure.message));
        },
        (data) async {
          allArticles = data;
          final hasMore = await getIt<ArticleRepoImpl>().hasMore(currentPage);
          emit(
            ArticlePaginationLoaded(
              articles: allArticles,
              hasReachedEnd: !hasMore,
            ),
          );
        },
      );
    } catch (e) {
      emit(ArticleError(e.toString()));
    }
  }

  Future<void> fetchMoreArticles() async {
    if (state is ArticlePaginationLoaded) {
      final currentState = state as ArticlePaginationLoaded;
      if (currentState.hasReachedEnd) return;

      try {
        currentPage++;
        final response = await getIt<ArticleRepoImpl>().getArticles(page: currentPage);
        response.fold(
          (failure) {
            emit(ArticleError(failure.message));
          },
          (data) async {
            allArticles.addAll(data);
            final hasMore = await getIt<ArticleRepoImpl>().hasMore(currentPage);

            emit(
              ArticlePaginationLoaded(
                articles: allArticles,
                hasReachedEnd: !hasMore,
              ),
            );
          },
        );
      } catch (e) {
        emit(ArticleError(e.toString()));
      }
    }
  }
}
