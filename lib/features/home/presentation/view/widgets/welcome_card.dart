import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/helper_function/user_information.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/app_images.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors:
              isDark
                  ? [KAppBarDark, KCardDark.withValues(alpha: 0.9)]
                  : [KPrimaryColor, KCyan.withValues(alpha: 0.85)],
        ),
        boxShadow: [
          BoxShadow(
            color:
                isDark
                    ? Colors.black.withValues(alpha: 0.35)
                    : KPrimaryColor.withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color:
                isDark
                    ? Colors.black.withValues(alpha: 0.1)
                    : KCyan.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          children: [
            Positioned(
              top: -60,
              right: -30,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.15),
                      Colors.white.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -40,
              left: 20,
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.1),
                      Colors.white.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.stars_rounded,
                                color: Colors.amber,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'welcome'.tr(),
                                style: TextStyles.public.copyWith(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        FutureBuilder<String>(
                          future: getFullName(),
                          builder: (context, snapshot) {
                            final name = snapshot.data ?? '...';
                            return Text(
                              name,
                              style: TextStyles.H1.copyWith(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            );
                          },
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'welcome_card_desc'.tr(),
                          style: TextStyles.public.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 13,
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    height: 130,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 0.2),
                          Colors.white.withValues(alpha: 0.05),
                        ],
                      ),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.25),
                        width: 1.5,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 4,
                          right: 4,
                          left: 4,
                        ),
                        child: Image.asset(
                          Assets.imagesWelcomeDoctor,
                          width: 100,
                          height: 130,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
