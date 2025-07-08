import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/features/articles/data/repo/article_repo_impl.dart';

import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit({required bool initialValue}) : super(ArticleFavInitial());

  // void changeFavorite() {
  //   emit(state.copyWith(isFavorite: !state.isFavorite));
  // }

  Future<void> addArticleFav(int articleId) async {
    emit(AddArticleFavLoading());
    final response = await getIt<ArticleRepoImpl>().addArticleFav(articleId);
    response.fold(
      (failure) => emit(AddArticleFavFailure(error: failure.message)),
      (data) => emit(AddArticleFavSuccess(message: 'add_fav_success'.tr())),
    );
  }

  Future<void> deleteArticleFav(int articleId) async {
    emit(AddArticleFavLoading());
    final response = await getIt<ArticleRepoImpl>().deleteArticleFav(articleId);
    response.fold(
      (failure) => emit(AddArticleFavFailure(error: failure.message)),
      (message) => emit(AddArticleFavSuccess(message: message)),
    );
  }
}
