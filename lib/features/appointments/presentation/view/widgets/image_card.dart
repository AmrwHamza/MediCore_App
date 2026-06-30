import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/utils/app_images.dart';

class ImageCard extends StatelessWidget {
  final bool isChild;
  final String imagePath;
  final bool isMale;

  const ImageCard({
    super.key,
    required this.isChild,
    required this.imagePath,
    required this.isMale,
  });

  @override
  Widget build(BuildContext context) {
    final bool isNetworkImage =
        imagePath.startsWith('http') || imagePath.contains('/');

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: KPrimaryColor.withValues(alpha: 0.2),
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child:
                isNetworkImage
                    ? CachedNetworkImage(
                      imageUrl: imagePath,
                      fit: BoxFit.cover,
                      placeholder:
                          (_, __) => Container(color: Colors.grey.shade200),
                      errorWidget:
                          (_, __, ___) => Image.asset(
                            isMale ? Assets.imagesBoy : Assets.imagesGirl,
                            fit: BoxFit.cover,
                          ),
                    )
                    : Image.asset(
                      imagePath.isNotEmpty
                          ? imagePath
                          : (isMale ? Assets.imagesBoy : Assets.imagesGirl),
                      fit: BoxFit.cover,
                    ),
          ),
        ),
        if (isChild)
          Positioned(
            bottom: -4,
            right: -4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: KPurple,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: Text(
                'child'.tr(),
                style: TextStyles.notes.copyWith(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
