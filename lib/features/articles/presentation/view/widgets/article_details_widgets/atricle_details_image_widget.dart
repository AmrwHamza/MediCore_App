import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:medicore_app/features/articles/presentation/view/widgets/article_details_widgets/image_shimmer.dart';

class AtricleDetailsImageWidget extends StatelessWidget {
  final String url;
  final int index;

  const AtricleDetailsImageWidget({super.key, required this.url, required this.index});

  @override
  Widget build(BuildContext context) {
    final fixedUrl = url.trim().replaceAll('[', '').replaceAll(']', '');

    return Container(
          margin: const EdgeInsets.symmetric(vertical: 14),
          height: 220,
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.grey.shade200,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: CachedNetworkImage(
            imageUrl: fixedUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => const ImageShimmer(),
            errorWidget: (context, url, error) {
              return const Center(child: Icon(Icons.broken_image, size: 40));
            },
          ),
        )
        .animate()
        .fade(delay: (120 * index).ms, duration: 400.ms)
        .scale(begin: const Offset(0.98, 0.98));
  }
}
