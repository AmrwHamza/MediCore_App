import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/notification/presentation/view/notification_view.dart';
import 'package:medicore_app/features/profile/presentation/view/change_password_view.dart';
import 'package:medicore_app/features/profile/presentation/view/edit_profile_view.dart';
import 'package:medicore_app/features/profile/presentation/view/widgets/profile_header.dart';
import 'package:medicore_app/features/profile/presentation/view/widgets/settings_list_item.dart';

import '../patient_profile_view.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          SizedBox(height: 16.h),
          const ProfileHeader(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(30).r,
                  topRight: const Radius.circular(30).r,
                ),
              ),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                children: [
                  SizedBox(height: 16.h),
                  SettingsListItem(
                    title: 'Edit Profile Information'.tr(),
                    icon: FontAwesomeIcons.userPen,
                    onTap: () {
                      context.pushNamed(EditProfileView.routeName);
                    },
                  ),
                  SettingsListItem(
                    title: 'Edit Patient Profile'.tr(),
                    icon: FontAwesomeIcons.pumpMedical,
                    onTap: () {
                      context.pushNamed(PatientProfileView.routeName);
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
                    onTap: () {
                      context.pushNamed(NotificationView.routeName);
                    },
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
