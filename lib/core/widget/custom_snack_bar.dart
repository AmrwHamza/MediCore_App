import 'package:flutter/material.dart';

const Color KPrimaryColor = Color(0xff32B2CF);
const Color KCyan = Color(0xff81D2E4);
const Color KDarkBlue = Color(0xff46707A);
const Color KOrange = Color(0xffCF7C32);
const Color KPurple = Color(0xffAE32CF);
const Color KWhite = Color(0xffE7F9FE);
const Color KGrey = Color(0xff7C8283);

enum SnackBarType { success, error, warning, info }

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.success,
  }) {
    final color = _getBackgroundColor(type);
    final icon = _getIcon(type);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: KWhite),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: KWhite, fontSize: 16),
              ),
            ),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  static Color _getBackgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return KPrimaryColor;
      case SnackBarType.error:
        return KOrange;
      case SnackBarType.warning:
        return KCyan;
      case SnackBarType.info:
        return KDarkBlue;
    }
  }

  static IconData _getIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle;
      case SnackBarType.error:
        return Icons.error;
      case SnackBarType.warning:
        return Icons.warning;
      case SnackBarType.info:
        return Icons.info;
    }
  }
}