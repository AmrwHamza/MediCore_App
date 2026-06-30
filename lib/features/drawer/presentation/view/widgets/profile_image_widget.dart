import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicore_app/core/utils/app_images.dart';

import '../../../../../constants.dart';
import '../../view_model/cubit/profile_image_cubit.dart';

class ProfileImageWidget extends StatelessWidget {
  final double radius;

  const ProfileImageWidget({super.key, this.radius = 40});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileImageCubit, ProfileImageState>(
      builder: (context, state) {
        if (state is ProfileImageLoading) {
          return CircleAvatar(
            radius: radius,
            backgroundColor: Colors.white10,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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

        if (state is ProfileImageEmpty || state is DeleteProfileImageSuccess) {
          return CircleAvatar(
            radius: radius,
            backgroundColor: const Color(0xFFEBF3FF),
            child: SvgPicture.asset(
              Assets.profile,
              width: radius * 2,
              height: radius * 2,
            ),
          );
        }

        if (state is GetProfileImageSuccess) {
          return CircleAvatar(
            radius: radius,
            backgroundImage: NetworkImage(
              '$baseurlImg${state.profileImagePath}',
            ),
          );
        }

        if (state is AddProfileImageSuccess) {
          return CircleAvatar(
            radius: radius,
            backgroundImage: NetworkImage(state.profileImagePath),
          );
        }

        return CircleAvatar(
          radius: radius,
          backgroundImage: const AssetImage(Assets.imagesMe),
        );
      },
    );
  }
}
