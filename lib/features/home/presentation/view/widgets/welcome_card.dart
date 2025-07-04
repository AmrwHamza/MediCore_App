import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/helper_function/user_information.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/app_images.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = getIt<ThemeProvider>().themeData;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.splashColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              Assets.imagesWelcomeDoctor,
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.3,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<String>(
                  future: getFullName(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.hasError) {
                      return Text(
                        'welcome'.tr() + '...',
                        style: TextStyles.H1.copyWith(color: Colors.white),
                      );
                    } else {
                      return Text(
                        'welcome'.tr() + '${snapshot.data} !',
                        style: TextStyles.H1.copyWith(color: Colors.white),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      );
                    }
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  'welcome_card_desc'.tr(),
                  style: TextStyles.public.copyWith(
                    color: Colors.white.withAlpha((255 * 0.7).round()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
