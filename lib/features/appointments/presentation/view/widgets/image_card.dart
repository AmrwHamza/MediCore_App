import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/utils/app_images.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.isChild,
    required this.imagePath,
    required this.isMale,
  });

  final bool isChild;
  final String imagePath;
  final bool? isMale;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: KDarkBlue.withAlpha((255 * 0.5).round()),
      backgroundImage: isChild ? null : AssetImage(imagePath),
      child:
          isChild
              ? Stack(
                alignment: Alignment.center,
                children: [
                  CachedNetworkImage(
                    color: Colors.amber,
                    imageUrl:
                        (imagePath.isEmpty)
                            ? (isMale! ? Assets.imagesBoy : Assets.imagesGirl)
                            : imagePath,
                    width: 100,
                    height: 100,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 11,
                      backgroundColor: KPurple,
                      child: Text(
                        'child'.tr(),
                        style: TextStyles.notes.copyWith(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ),
                ],
              )
              : null,
    );
  }
}
