import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';

class HomeErrorState extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const HomeErrorState({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? KCardDark.withValues(alpha: 0.5) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: KOrange.withValues(alpha: 0.2), width: 1),
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline_rounded, color: KOrange, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                errorMessage,
                style: TextStyles.notes.copyWith(
                  color:
                      isDark ? Colors.white70 : KBlack.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: onRetry,
              style: TextButton.styleFrom(
                backgroundColor: KOrange.withValues(alpha: 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "retry".tr(),
                style: TextStyles.button.copyWith(
                  color: KOrange,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
