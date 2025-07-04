import 'package:flutter/material.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimer extends StatelessWidget {
  const CustomShimer({super.key, this.hieght, this.width});

  final double? hieght;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = getIt<ThemeProvider>().themeData;
    return Shimmer.fromColors(
      baseColor: Colors.grey.withAlpha((255 * 0.3).round()),
      highlightColor: theme.shadowColor,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: hieght ?? MediaQuery.of(context).size.height * 0.1,
                    width: width ?? 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            // Flexible(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Container(
            //         height: hieght ?? MediaQuery.of(context).size.height * 0.1,
            //         width: width ?? 100,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
