import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:shimmer/shimmer.dart';

class ImageShimmer extends StatelessWidget {
  const ImageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

    return Shimmer.fromColors(
      baseColor: Colors.grey.withAlpha((255 * 0.25).round()),
      highlightColor: theme.shadowColor,
      child: Container(color: Colors.grey.shade300),
    );
  }
}
