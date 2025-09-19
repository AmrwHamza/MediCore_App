import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';

// ignore: must_be_immutable
class ProfileSection extends StatelessWidget {
  ProfileSection({super.key, required this.name, this.imageUrl});

  final String name;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFFDCF5F9),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFB0E0E6), width: 2),
            ),
            child: const Center(
              //show image here later
              child: SizedBox(),
              // imageUrl != null
              //     ? Image.asset(imageUrl!)
              //     : SvgPicture.asset(
              //       isMale ? Assets.imagesBoy : Assets.imagesGirl,
              //     ),
            ),
          ),
          const SizedBox(width: 20),
          Text(
            name,
            style: TextStyles.H2.copyWith(
              color: context.watch<ThemeProvider>().themeData.canvasColor,
            ),
          ),
        ],
      ),
    );
  }
}
