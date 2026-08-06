import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/app_images.dart';
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
    final hasImage =
        article.images.isNotEmpty && article.images.first.isNotEmpty;
    final imageUrl = hasImage ? article.images.first : '';

    final preview =
        article.paragraphs.isNotEmpty ? article.paragraphs.first : '';

    Widget buildPlaceholder() {
      return Container(
        width: 115,
        height: 125,
        decoration: BoxDecoration(
          color: const Color(0xFF0F2B48),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(painter: MedicalGridAndPulsePainter()),
              ),
              Container(
                width: 115,
                height: 125,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.3),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: SizedBox(
                  width: 45,
                  height: 45,
                  child: Opacity(
                    opacity: 0.7,
                    child: Image.asset(
                      Assets.imagesLogoWithoutBackground,
                      fit: BoxFit.contain,
                      errorBuilder:
                          (_, __, ___) => const Icon(
                            Icons.local_hospital_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return BlocProvider(
      create: (context) => FavoriteCubit(initialValue: false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: GestureDetector(
          onTap:
              () => context.push(
                ArticleDetailsView.routeName,
                extra: {'article': article, 'isFavorte': article.isFav},
              ),
          child: Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child:
                        hasImage
                            ? CachedNetworkImage(
                              imageUrl: imageUrl,
                              width: 115,
                              height: 125,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                width: 115,
                                height: 125,
                                color: theme.cardColor,
                              ),
                              errorWidget: (context, url, error) =>
                                  buildPlaceholder(),
                            )
                            : buildPlaceholder(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 16, 16, 12),
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
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: theme.textTheme.titleLarge?.color,
                                  height: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            FavoriteIcon(article: article),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          preview,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.notes.copyWith(
                            fontSize: 12,
                            color: theme.textTheme.bodyMedium?.color
                                ?.withValues(alpha: 0.55),
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'read_more'.tr(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: theme.primaryColor,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 14,
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

class MedicalGridAndPulsePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint =
        Paint()
          ..color = const Color(0xFF1E3A8A).withValues(alpha: 0.3)
          ..strokeWidth = 0.8;

    const double gridSpacing = 12.0;
    for (double x = 0; x < size.width; x += gridSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += gridSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final pulsePaint =
        Paint()
          ..color = const Color(0xFF10B981)
          ..strokeWidth = 2.2
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final path = Path();
    final h = size.height;
    final w = size.width;

    path.moveTo(0, h * 0.6);
    path.lineTo(w * 0.15, h * 0.6);
    path.lineTo(w * 0.22, h * 0.53);
    path.lineTo(w * 0.28, h * 0.67);
    path.lineTo(w * 0.35, h * 0.25);
    path.lineTo(w * 0.45, h * 0.85);
    path.lineTo(w * 0.52, h * 0.55);
    path.lineTo(w * 0.60, h * 0.6);
    path.lineTo(w * 0.68, h * 0.57);
    path.lineTo(w * 0.74, h * 0.6);
    path.lineTo(w, h * 0.6);

    canvas.drawPath(path, pulsePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
