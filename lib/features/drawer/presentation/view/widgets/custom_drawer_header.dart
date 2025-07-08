import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/helper_function/user_information.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/features/profile/presentation/view/profile_view.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: UserAccountsDrawerHeader(
        decoration: BoxDecoration(color: theme.splashColor),
        currentAccountPicture: const CircleAvatar(
          backgroundImage: AssetImage(Assets.imagesMe),
          radius: 40,
        ),

        accountName: FutureBuilder<String>(
          future: getFullName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.hasError) {
              return Text(
                'loading'.tr(),
                style: TextStyles.notes.copyWith(color: Colors.white),
              );
            } else {
              return Text(
                snapshot.data!,
                style: TextStyles.notes.copyWith(color: Colors.white),
              );
            }
          },
        ),
        accountEmail: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.phone, size: 16, color: Colors.white70),
                const SizedBox(width: 4),
                FutureBuilder<String>(
                  future: getUserPhone(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.hasError) {
                      return Text(
                        'loading'.tr(),
                        style: TextStyles.notes.copyWith(color: Colors.white),
                      );
                    } else {
                      return Text(
                        '${snapshot.data}',
                        style: TextStyles.notes.copyWith(
                          color: Colors.white.withAlpha((0.6 * 255).round()),
                          fontSize: 12,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.mail, size: 16, color: Colors.white70),
                const SizedBox(width: 4),
                Expanded(
                  child: FutureBuilder<String>(
                    future: getUserEmail(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.hasError) {
                        return Text(
                          'loading'.tr(),
                          style: TextStyles.notes.copyWith(color: Colors.white),
                        );
                      } else {
                        return Text(
                          '${snapshot.data}',
                          style: TextStyles.notes.copyWith(
                            color: Colors.white.withAlpha((0.6 * 255).round()),
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        otherAccountsPictures: [
          IconButton(
            onPressed: () {
              context.pushNamed(ProfileView.routeName);
            },
            icon: const Icon(Icons.edit_note, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
