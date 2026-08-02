import 'package:flutter/material.dart';
import 'package:medicore_app/core/utils/app_images.dart';

class ImageCacheHelper {
  static Future<void> cacheAppImages(BuildContext context) async {
    final List<Future<void>> cacheFutures = [];

    cacheFutures.add(
      precacheImage(
        const AssetImage(Assets.imagesLogoWithoutBackground),
        context,
      ),
    );

    for (String imagePath in Assets.departmentsImages) {
      cacheFutures.add(precacheImage(AssetImage(imagePath), context));
    }

    for (String imagePath in Assets.doctorsImages) {
      cacheFutures.add(precacheImage(AssetImage(imagePath), context));
    }

    await Future.wait(cacheFutures);
  }
}
