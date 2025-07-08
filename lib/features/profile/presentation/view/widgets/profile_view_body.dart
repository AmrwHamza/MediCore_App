import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/features/profile/presentation/view/change_password_view.dart';
import 'package:medicore_app/features/profile/presentation/view/edit_profile_view.dart';
import 'package:medicore_app/features/profile/presentation/view/widgets/profile_header.dart';
import 'package:medicore_app/features/profile/presentation/view/widgets/quick_action_button.dart';
import 'package:medicore_app/features/profile/presentation/view/widgets/settings_list_item.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 16),
          const ProfileHeader(
            name: 'Tarek Alasfour',
            email: 'tarekalasfour123@gmail.com',
            profileImageUrl: Assets.imagesMe,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      QuickActionButton(
                        icon: FontAwesomeIcons.kitMedical,
                        label: 'Medicines'.tr(),
                        onTap: () {},
                      ),
                      QuickActionButton(
                        icon: FontAwesomeIcons.syringe,
                        label: 'Diseases'.tr(),
                        onTap: () {},
                      ),
                      QuickActionButton(
                        icon: FontAwesomeIcons.star,
                        label: 'Reviews'.tr(),
                        onTap: () {},
                      ),
                      QuickActionButton(
                        icon: FontAwesomeIcons.userDoctor,
                        label: 'Your Doctors'.tr(),
                        onTap: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  SettingsListItem(
                    title: 'Edit Profile Information'.tr(),
                    icon: FontAwesomeIcons.userPen,
                    onTap: () {
                      context.pushNamed(EditProfileView.routeName);
                    },
                  ),
                  SettingsListItem(
                    title: 'Change Password'.tr(),
                    icon: FontAwesomeIcons.key,
                    onTap: () {
                      context.pushNamed(ChangePasswordView.routeName);
                    },
                  ),
                  SettingsListItem(
                    title: 'Notifications'.tr(),
                    icon: FontAwesomeIcons.solidBell,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
