import 'package:bloc/bloc.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/features/articles/data/repo/article_repo_impl.dart';
import 'package:medicore_app/features/articles/presentation/view_model/fav_articles_cubit/fav_articles_state.dart';

class FavoriteArticlesCubit extends Cubit<FavoriteArticlesState> {
  FavoriteArticlesCubit() : super(FavoriteArticlesInitial());

  Future<void> getFavoriteArticles() async {
    emit(FavoriteArticlesLoading());
    final response = await getIt<ArticleRepoImpl>().getFavoriteArticles();
    response.fold(
      (failure) => emit(FavoriteArticlesFailure(error: failure.message)),
      (articles) => emit(FavoriteArticlesSuccess(articles: articles)),
    );
  }
}
