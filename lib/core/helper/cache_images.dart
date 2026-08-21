import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/core/utils/logger_helper.dart';

class ImageCacheHelper {

  static const int _logoTargetWidth = 512;

  static Future<void> cacheOnboardingImages(BuildContext context) async {
    await Future.wait([
      _safePrecache(
        ResizeImage(
          const AssetImage(Assets.imagesLogoWithoutBackground),
          width: _logoTargetWidth,
        ),
        context,
      ),
      _precacheSvg(Assets.imagesDoctors),
    ]);
  }

  static Future<void> _safePrecache(
    ImageProvider provider,
    BuildContext context,
  ) async {
    try {
      await precacheImage(provider, context);
    } catch (error, stackTrace) {
      LoggerHelper.error('Failed to precache image: $error');
      LoggerHelper.error(stackTrace.toString());
    }
  }

  static Future<void> _precacheSvg(String assetPath) async {
    try {
      final loader = SvgAssetLoader(assetPath);
      await vg.loadPicture(loader, null);
    } catch (error, stackTrace) {
      LoggerHelper.error('Failed to precache svg: $error');
      LoggerHelper.error(stackTrace.toString());
    }
  }

  static Future<void> cacheAppImages(BuildContext context) async {
    await cacheOnboardingImages(context);

    final List<Future<void>> cacheFutures = [];

    for (String imagePath in Assets.departmentsImages) {
      cacheFutures.add(_safePrecache(AssetImage(imagePath), context));
    }

    for (String imagePath in Assets.doctorsImages) {
      cacheFutures.add(_safePrecache(AssetImage(imagePath), context));
    }

    await Future.wait(cacheFutures);
  }
}