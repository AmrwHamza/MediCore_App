import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';

// ignore: must_be_immutable
class CustomScrollWidget extends StatelessWidget {
  CustomScrollWidget({
    super.key,
    required this.child,
    required this.onRefresh,
    this.color,
  });

  final Widget child;
  final Future<void> Function() onRefresh;
  Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      color: theme.splashColor,

      child: RefreshIndicator(
        backgroundColor:
            color == null
                ? theme.splashColor.withAlpha((0.95 * 255).round())
                : color,
        color: theme.cardColor,

        onRefresh: onRefresh,
        child: child,
      ),
    );
  }
}
