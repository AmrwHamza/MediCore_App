import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/articles/domain/entities/article_entity.dart';
import 'package:medicore_app/features/articles/presentation/view/widgets/article_details_view.dart';
import 'package:medicore_app/features/articles/presentation/view/widgets/favorite_icons.dart';
import 'package:medicore_app/features/articles/presentation/view/widgets/left_arc_cliper.dart';
import 'package:provider/provider.dart';

class ArticleCard extends StatelessWidget {
  final ArticleEntity article;

  const ArticleCard({Key? key, required this.article}) : super(key: key);

  String extractFirstImage(String body) {
    final regex = RegExp(r'\[(https?:\/\/.*?\.(?:png|jpg|jpeg|gif))\]');
    final match = regex.firstMatch(body);
    return match?.group(1) ?? 'assets/images/placeholder.png';
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = extractFirstImage(article.body);
    final preview = article.body.replaceAll(RegExp(r'\[.*?\]'), '');

    return InkWell(
      onTap:
          () => context.push(
            ArticleDetailsView.routeName,
            extra: {'article': article, 'isFavorte': article.isFav},
          ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Card(
          color: context.watch<ThemeProvider>().themeData.primaryColor,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              ClipPath(
                clipper: LeftArcClipper(),
                child: Image.network(
                  imageUrl,
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 5,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: TextStyles.H2.copyWith(
                        color:
                            Provider.of<ThemeProvider>(
                              context,
                            ).themeData.canvasColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    RichText(
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: TextStyles.notes,
                        children: [TextSpan(text: preview + '....')],
                      ),
                    ),
                    Text(
                      'read_more',
                      style: TextStyles.H2.copyWith(
                        fontSize: 14,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ),
              FavoriteIcon(article: article),
            ],
          ),
        ),
      ),
    );
  }
}
