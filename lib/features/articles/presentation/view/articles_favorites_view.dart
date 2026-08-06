import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/features/articles/presentation/view/widgets/article_card.dart';
import 'package:medicore_app/features/articles/presentation/view_model/fav_articles_cubit/fav_articles_cubit.dart';
import 'package:medicore_app/features/articles/presentation/view_model/fav_articles_cubit/fav_articles_state.dart';

class ArticlesFavoritesView extends StatelessWidget {
  static const routeName = '/articlesFavorites';

  const ArticlesFavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(title: 'favorite_articles'.tr(), isMainBar: false),
      body: BlocProvider(
        create: (context) => FavoriteArticlesCubit()..getFavoriteArticles(),
        child: BlocBuilder<FavoriteArticlesCubit, FavoriteArticlesState>(
          builder: (context, state) {
            if (state is FavoriteArticlesLoading) {
              return const Center(
                child: CircularProgressIndicator(color: KPrimaryColor),
              );
            } else if (state is FavoriteArticlesFailure) {
              return Center(child: Text('Error: ${state.error}'));
            } else if (state is FavoriteArticlesSuccess) {
              if (state.articles.isEmpty) {
                return Center(child: Text('no_favorite_articles'.tr()));
              }
              return RefreshIndicator.adaptive(
                color: theme.splashColor,
                backgroundColor: theme.cardColor,
                onRefresh: () async =>
                    context.read<FavoriteArticlesCubit>().getFavoriteArticles(),
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: state.articles.length,
                  itemBuilder: (context, index) {
                    return ArticleCard(article: state.articles[index]);
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
