import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/articles/domain/entities/article_entity.dart';
import 'package:medicore_app/features/articles/presentation/view/article_details_view.dart';
import 'package:medicore_app/features/articles/presentation/view/widgets/favorite_icons.dart';

import '../../view_model/fav_cubit/favorite_cubit.dart';

class ArticleCard extends StatelessWidget {
  final ArticleEntity article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final imageUrl =
        article.images.isNotEmpty
            ? article.images.first
            : 'assets/images/placeholder.png';

    final preview =
        article.paragraphs.isNotEmpty ? article.paragraphs.first : '';

    return BlocProvider(
      create: (context) => FavoriteCubit(initialValue: false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: GestureDetector(
          onTap:
              () => context.push(
                ArticleDetailsView.routeName,
                extra: {'article': article, 'isFavorte': article.isFav},
              ),
          child: Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.network(
                      imageUrl,
                      width: 120,
                      height: 130,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (_, __, ___) => Container(
                            width: 120,
                            height: 130,
                            color: theme.disabledColor.withValues(alpha: 0.1),
                            child: const Icon(Icons.image, size: 32),
                          ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 12, 16, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                article.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.H2.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: theme.textTheme.titleLarge?.color,
                                ),
                              ),
                            ),
                            FavoriteIcon(article: article),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          preview,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.notes.copyWith(
                            fontSize: 13,
                            color: theme.textTheme.bodyMedium?.color
                                ?.withValues(alpha: 0.6),
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'read_more',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: theme.primaryColor,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 16,
                              color: theme.primaryColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
