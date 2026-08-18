import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';

Future<bool?> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  String? lottie,
  required String confirmText,
  required String cancelText,
}) {
  final splashColor = getIt<ThemeProvider>().themeData.splashColor;
  final theme = Theme.of(context);

  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: theme.cardColor,
        title: Column(
          children: [
            if (lottie != null) ...[
              SizedBox(height: 120.h, child: Lottie.asset(lottie)),
            ],
            SizedBox(height: 6.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: theme.canvasColor),
            ),
          ],
        ),
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(color: theme.canvasColor),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: splashColor),
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText, style: TextStyle(color: theme.canvasColor)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: splashColor,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              confirmText,
              style: TextStyle(color: theme.canvasColor),
            ),
          ),
        ],
      );
    },
  );
}
