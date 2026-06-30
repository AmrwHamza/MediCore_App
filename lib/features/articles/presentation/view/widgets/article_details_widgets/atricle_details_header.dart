import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/features/articles/domain/entities/article_entity.dart';
import 'package:medicore_app/features/articles/presentation/view/widgets/favorite_icons.dart';

class AtricleDetailsHeader extends StatelessWidget {
  final ArticleEntity article;

  const AtricleDetailsHeader({required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Theme.of(context).cardColor.withValues(alpha: 0.4),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              article.title,
              style: TextStyles.H2.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          FavoriteIcon(article: article),
        ],
      ),
    ).animate().fade(duration: 300.ms).slideY(begin: 0.1);
  }
}
