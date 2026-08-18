import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/articles/domain/entities/article_entity.dart';
import 'package:medicore_app/features/articles/presentation/view_model/fav_cubit/favorite_cubit.dart';
import 'package:medicore_app/features/articles/presentation/view_model/fav_cubit/favorite_state.dart';

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({super.key, required this.article});

  final ArticleEntity article;

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
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
          return Center(
            child: SizedBox(
              width: 48.w,
              height: 48.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SpinKitPumpingHeart(
                    color: Colors.redAccent.withValues(alpha: 0.8),
                    size: 36.0,
                  ),
                  Positioned(
                    child: Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return IconButton(
          icon: Icon(
            widget.article.isFav ? Icons.favorite : Icons.favorite_border,
            color: Colors.redAccent,
          ),
          onPressed: () async {
            final favoriteCubit = context.read<FavoriteCubit>();

            setState(() {
              widget.article.isFav = !widget.article.isFav;
            });

            try {
              if (!widget.article.isFav) {
                await favoriteCubit.deleteArticleFav(widget.article.id);
              } else {
                await favoriteCubit.addArticleFav(widget.article.id);
              }
            } catch (error) {
              setState(() {
                widget.article.isFav = !widget.article.isFav;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('error_generic'.tr())),
              );
            }
          },
        );
      },
    );
  }
}
