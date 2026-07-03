import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicore_app/core/utils/app_images.dart';

import '../../../../../constants.dart';
import '../../../../../core/theme/theme_provider.dart';
import '../../view_model/cubit/profile_image_cubit.dart';

class ProfileImageWidget extends StatelessWidget {
  final double radius;
  final void Function()? onTap;
  final bool isInHome;

  const ProfileImageWidget({
    super.key,
    this.radius = 40,
    this.onTap,
    this.isInHome = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          BlocBuilder<ProfileImageCubit, ProfileImageState>(
            builder: (context, state) {
              if (state is ProfileImageLoading) {
                return CircleAvatar(
                  radius: radius,
                  backgroundColor: Colors.white10,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(KPrimaryColor),
                  ),
                );
              }

              if (state is ProfileImageFailure) {
                return CircleAvatar(
                  radius: radius,
                  backgroundColor: Colors.red.withValues(alpha: 0.2),
                  child: IconButton(
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    onPressed: () {
                      context.read<ProfileImageCubit>().getProfileImage(
                        forceRefresh: true,
                      );
                    },
                  ),
                );
              }

              if (state is ProfileImageEmpty ||
                  state is DeleteProfileImageSuccess) {
                return CircleAvatar(
                  radius: radius,
                  backgroundColor: theme.cardColor,
                  child: SvgPicture.asset(
                    Assets.profile,
                    width: radius * 2,
                    height: radius * 2,
                    colorFilter: const ColorFilter.mode(
                      KPrimaryColor,
                      BlendMode.color,
                    ),
                  ),
                );
              }

              if (state is GetProfileImageSuccess) {
                return CircleAvatar(
                  radius: radius,
                  backgroundImage: NetworkImage(
                    '$base${state.profileImagePath}',
                  ),
                );
              }

              if (state is AddProfileImageSuccess) {
                return CircleAvatar(
                  radius: radius,
                  backgroundColor: KPrimaryColor,
                  backgroundImage: NetworkImage(
                    '$base${state.profileImagePath}',
                  ),
                );
              }

              return CircleAvatar(
                radius: radius,
                backgroundColor: theme.cardColor,
              );
            },
          ),
          if (!isInHome)
            Positioned(
              right: 0,
              bottom: 0,
              child: CircleAvatar(
                maxRadius: 15,
                backgroundColor: theme.cardColor,
                child: FaIcon(
                  FontAwesomeIcons.pen,
                  color: theme.splashColor,
                  size: 15,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
