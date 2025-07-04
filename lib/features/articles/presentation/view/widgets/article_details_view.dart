import 'package:flutter/material.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/features/articles/domain/entities/article_entity.dart';
import 'package:medicore_app/features/articles/presentation/view/widgets/favorite_icons.dart';
import 'package:provider/provider.dart';

class ArticleDetailsView extends StatelessWidget {
  static const routeName = '/articlesDetails';

  final ArticleEntity article;

  const ArticleDetailsView({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: article.title, isMainBar: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text(article.title, style: TextStyles.H2)),
                const SizedBox(width: 16),
                FavoriteIcon(article: article),
              ],
            ),
            const SizedBox(height: 16),
            buildBody(article.body, context),
          ],
        ),
      ),
    );
  }

  /// تفكيك نص المقالة إلى أجزاء (نصوص وصور) بنفس الترتيب
  Widget buildBody(String body, BuildContext context) {
    final blocks = parseArticleBody(body);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          blocks.map((block) {
            if (block is TextBlock) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  block.text,
                  style: TextStyles.public.copyWith(
                    color: Provider.of<ThemeProvider>(
                      context,
                    ).themeData.canvasColor.withAlpha((0.8 * 255).round()),
                  ),
                ),
              );
            } else if (block is ImageBlock) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Image.network(
                  block.url,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }).toList(),
    );
  }

  /// تحليل body إلى TextBlock و ImageBlock حسب الترتيب
  List<ArticleContent> parseArticleBody(String body) {
    final List<ArticleContent> result = [];
    final regex = RegExp(r'\[(https?:\/\/.*?\.(?:png|jpg|jpeg|gif))\]');
    final matches = regex.allMatches(body);

    int lastIndex = 0;

    for (final match in matches) {
      if (match.start > lastIndex) {
        final text = body.substring(lastIndex, match.start).trim();
        if (text.isNotEmpty) result.add(TextBlock(text));
      }

      final imageUrl = match.group(1);
      if (imageUrl != null) {
        result.add(ImageBlock(imageUrl));
      }

      lastIndex = match.end;
    }

    if (lastIndex < body.length) {
      final lastText = body.substring(lastIndex).trim();
      if (lastText.isNotEmpty) result.add(TextBlock(lastText));
    }

    return result;
  }
}

/// الكلاسات المساعدة لتمثيل المحتوى المجزأ من body
abstract class ArticleContent {}

class TextBlock extends ArticleContent {
  final String text;
  TextBlock(this.text);
}

class ImageBlock extends ArticleContent {
  final String url;
  ImageBlock(this.url);
}
