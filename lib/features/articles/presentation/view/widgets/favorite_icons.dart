import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/articles/domain/entities/article_entity.dart';
import 'package:medicore_app/features/articles/presentation/view_model/fav_cubit/favorite_cubit.dart';
import 'package:medicore_app/features/articles/presentation/view_model/fav_cubit/favorite_state.dart';

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({super.key, required this.article});

  final ArticleEntity article;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteCubit, FavoriteState>(
      listener: (context, state) {
        if (state is AddArticleFavFailure) {
          CustomSnackbar.show(
            context,
            message: state.error,
            type: SnackbarType.error,
          );
        } else if (state is AddArticleFavSuccess) {
          CustomSnackbar.show(
            context,
            message: state.message,
            type: SnackbarType.success,
          );
        }
      },
      builder: (context, state) {
        if (state is AddArticleFavLoading) {
          return SpinKitPumpingHeart(
            color: Colors.red.withAlpha((255 * 0.7).round()),
          );
        }
        return IconButton(
          icon: Icon(
            article.isFav ? Icons.favorite : Icons.favorite_border,
            color: Colors.redAccent,
          ),
          onPressed: () {
            article.isFav
                ? context.read<FavoriteCubit>().deleteArticleFav(article.id)
                : context.read<FavoriteCubit>().addArticleFav(article.id);
          },
        );
      },
    );
  }
}
