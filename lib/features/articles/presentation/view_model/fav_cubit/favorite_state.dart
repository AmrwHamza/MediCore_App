abstract class FavoriteState {}

class AddArticleFav extends FavoriteState {}

class ArticleFavInitial extends FavoriteState {}


class AddArticleFavLoading extends FavoriteState {}

class AddArticleFavFailure extends FavoriteState {
  final String error;

  AddArticleFavFailure({required this.error});
}

class AddArticleFavSuccess extends FavoriteState {
  final String message;

  AddArticleFavSuccess({required this.message});
}

