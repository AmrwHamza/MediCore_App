import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:medicore_app/core/helper/text_styles.dart';

class AtricleDetailsTextWidget extends StatelessWidget {
  final String text;
  final int index;

  const AtricleDetailsTextWidget({super.key, required this.text, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Theme.of(context).cardColor.withValues(alpha: 0.3),
          ),
          child: Text(text, style: TextStyles.public.copyWith(height: 1.6)),
        )
        .animate()
        .fade(delay: (80 * index).ms, duration: 350.ms)
        .slideY(begin: 0.1);
  }
}
