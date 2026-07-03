import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/widget/custom_shimer.dart';

import '../../../../drawer/presentation/view/widgets/profile_image_widget.dart';
import '../../../../drawer/presentation/view_model/cubit/profile_image_cubit.dart';
import '../../view_model/profile_header_info_cubit/profile_header_info_cubit.dart';
import 'profile_image_bottom_sheet.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileImageCubit, ProfileImageState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              ProfileImageWidget(
                radius: 60,
                isInHome: false,
                onTap: () async {
                  await profileImageBottomSheet(context);
                },
              ),
              const SizedBox(height: 12),

              BlocBuilder<ProfileHeaderInfoCubit, ProfileHeaderInfoState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    getProfileHeaderInfoFailure:
                        (errorMessage) => Text(
                          errorMessage,
                          style: TextStyles.public.copyWith(color: Colors.red),
                        ),
                    getProfileHeaderInfoLoading:
                        () => Column(
                          children: [
                            CustomShimer(height: 2.h, width: 150.w),
                            SizedBox(height: 4.h),
                            CustomShimer(height: 2.h, width: 150.w),
                          ],
                        ),
                    getProfileHeaderInfoSuccess:
                        (name, email) => Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  name,
                                  style: TextStyles.H2.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 4),
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 4.h),
                            Text(
                              email,
                              style: TextStyles.public.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
