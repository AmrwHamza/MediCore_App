import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';

class HomeSectionsHeader extends StatelessWidget {
  final String titleKey;
  final VoidCallback onSeeAllPressed;

  const HomeSectionsHeader({
    super.key,
    required this.titleKey,
    required this.onSeeAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titleKey.tr(),
          style: TextStyles.H2.copyWith(
            color: isDark ? Colors.white : KBlack,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.3,
          ),
        ),
        TextButton(
          onPressed: onSeeAllPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            backgroundColor: isDark ? KCardDark : KBackgroundLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            "see_all".tr(),
            style: TextStyles.button.copyWith(
              color: KPrimaryColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
