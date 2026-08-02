import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';

class SettingsListItem extends StatelessWidget {
  final String title;
  final FaIconData icon;
  final VoidCallback onTap;

  const SettingsListItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),

        child: Column(
          children: [
            Row(
              children: [
                FaIcon(icon, color: theme.splashColor, size: 22),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyles.public.copyWith(color: theme.canvasColor),
                  ),
                ),
                Icon(Icons.chevron_right, color: theme.canvasColor, size: 20),
              ],
            ),
            SizedBox(height: 4.h),
            Divider(color: theme.dividerColor, thickness: 0.8),
          ],
        ),
      ),
    );
  }
}
