import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/app_images.dart';

class SecoundPage extends StatelessWidget {
  const SecoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark =
        context.watch<ThemeProvider>().themeData.brightness == Brightness.dark;
    final primaryColor = isDark ? KPrimaryColor : KPrimaryDark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          SizedBox(
            height: size.height * 0.38,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.purple.withValues(alpha: isDark ? 0.12 : 0.18),
                          Colors.transparent,
                        ],
                        radius: 0.6,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: ShaderMask(
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          colors: [primaryColor, Colors.purple.shade400],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.srcIn,
                      child: Image.asset(
                        Assets.imagesLogoWithoutBackground,
                        fit: BoxFit.contain,
                        cacheWidth: 512,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.local_hospital_rounded,
                          color: isDark ? Colors.white54 : Colors.black26,
                          size: 80,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(flex: 2),
          ShaderMask(
            shaderCallback:
                (bounds) => LinearGradient(
                  colors: [primaryColor, Colors.purple.shade400],
                ).createShader(bounds),
            child: Text(
              'secound page title in onBoarding'.tr(),
              textAlign: TextAlign.center,
              style: TextStyles.H1.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 26,
                height: 1.3,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'second_page_subtitle_hint'.tr(),
            textAlign: TextAlign.center,
            style: TextStyles.public.copyWith(
              color: isDark ? Colors.white54 : Colors.black54,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
