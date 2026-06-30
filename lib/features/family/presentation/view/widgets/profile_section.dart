import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/app_images.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    super.key,
    required this.name,
    this.imageUrl,
    this.isMale = true,
  });

  final String name;
  final String? imageUrl;
  final bool isMale;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: theme.cardColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.primary.withAlpha(100),
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child:
                  imageUrl != null && imageUrl!.isNotEmpty
                      ? Image.network(imageUrl!, fit: BoxFit.cover)
                      : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          isMale ? Assets.imagesBoy : Assets.imagesGirl,
                          fit: BoxFit.contain,
                        ),
                      ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              name,
              style: TextStyles.H2.copyWith(
                color: theme.canvasColor,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
