import 'package:flutter/material.dart';
import 'package:medicore_app/core/helper/text_styles.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Expanded(child: Divider(color: Colors.white54)),
          const SizedBox(width: 8),
          Text(title, style: TextStyles.public.copyWith(color: Colors.white)),
          const SizedBox(width: 8),
          const Expanded(child: Divider(color: Colors.white54)),
        ],
      ),
    );
  }
}
