import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/notification/presentation/view/notification_view.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isMainBar;
  final Color? color;

  String _getFirstWords(String text, int wordCount) {
    final words = text.trim().split(RegExp(r'\s+'));
    return words.take(wordCount).join(' ');
  }

  const CustomAppBar({
    super.key,
    required this.title,
    required this.isMainBar,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

    return Container(
      decoration: BoxDecoration(
        color:
            (color != null)
                ? color
                : (isMainBar ? (theme.primaryColor) : KDarkBlue),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [BoxShadow(color: theme.shadowColor, blurRadius: 4)],
      ),
      child: AppBar(
        actions:
            isMainBar
                ? [
                  IconButton(
                    onPressed: () {
                      context.push(NotificationView.routeName);
                    },
                    icon: const Icon(FontAwesomeIcons.bell, color: KOrange),
                  ),
                  const SizedBox(width: 5),
                ]
                : null,
        title: Text(
          _getFirstWords(title, 2),
          style: TextStyle(
            color: isMainBar ? KPrimaryColor : KWhite,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.values[3],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        // elevation: 2,
        iconTheme: IconThemeData(color: isMainBar ? KDarkBlue : KWhite),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
