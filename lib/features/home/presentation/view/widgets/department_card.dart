import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';

class DepartmentCard extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final bool? isSelected;
  final void Function()? onTap;

  const DepartmentCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    this.onTap,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = getIt<ThemeProvider>().themeData;

    // LoggerHelper.info(imageUrl!);

    return Container(
      width: MediaQuery.of(context).size.width / 4.1,
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color:
            (isSelected != null)
                ? isSelected!
                    ? KPrimaryColor
                    : theme.cardColor
                : theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color:
                (isSelected != null)
                    ? isSelected!
                        ? KDarkBlue.withAlpha((0.2 * 255).round())
                        : theme.shadowColor
                    : theme.shadowColor,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        highlightColor: KPrimaryColor,
        onTap: onTap,
        child: Column(
          children: [
            (imageUrl != null && imageUrl!.isNotEmpty)
                ? Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: CachedNetworkImage(
                    placeholder:
                        (context, url) => const CircularProgressIndicator(),
                    errorWidget:
                        (context, url, error) => CircleAvatar(
                          backgroundColor: KDarkBlue,
                          child: Icon(
                            Icons.broken_image,
                            color:
                                (isSelected != null)
                                    ? isSelected!
                                        ? KPrimaryColor
                                        : Colors.white70
                                    : Colors.white70,
                            size: 35,
                          ),
                        ),
                    imageUrl: '$base$imageUrl',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                )
                : const CircleAvatar(
                  backgroundColor: KDarkBlue,
                  radius: 25,
                  child: Icon(
                    FontAwesomeIcons.hospitalUser,
                    color: Colors.white70,
                  ),
                ),

            const SizedBox(height: 16),
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyles.public.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color:
                      (isSelected != null)
                          ? isSelected!
                              ? Colors.white
                              : KDarkBlue
                          : KDarkBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
