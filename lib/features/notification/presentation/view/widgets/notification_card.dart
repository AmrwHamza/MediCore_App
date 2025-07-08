import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/app_images.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              offset: const Offset(1, 1),
              color: theme.shadowColor,
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(
            width: 2,
            color: KDarkBlue.withAlpha((255 * 0.5).round()),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Image.asset(
                Assets.imagesNotification,
                width: 70,
                height: 70,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyles.H2.copyWith(color: theme.canvasColor),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subTitle,
                      style: TextStyles.notes.copyWith(
                        color: theme.canvasColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
