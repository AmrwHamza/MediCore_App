import 'dart:io';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/features/profile/presentation/view/widgets/delete_image_icon.dart';

import '../../../../../constants.dart';
import '../../../../../core/theme/theme_provider.dart';
import '../../../../drawer/presentation/view_model/cubit/profile_image_cubit.dart';

Future<dynamic> profileImageBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: context.read<ThemeProvider>().themeData.cardColor,
    builder: (context) {
      return BlocBuilder<ProfileImageCubit, ProfileImageState>(
        builder: (context, state) {
          final cubit = context.read<ProfileImageCubit>();

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (cubit.profileImagePath != null) ...[
                if (cubit.profileImagePath!.isNotEmpty) ...[
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.eye,
                      color:
                          context.read<ThemeProvider>().themeData.splashColor,
                    ),
                    title: Text('show_image'.tr()),
                    onTap: () {
                      Navigator.pop(context);

                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: 'dismiss'.tr(),
                        barrierColor: Colors.black.withAlpha(
                          (0.5 * 255).round(),
                        ),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Stack(
                            children: [
                              BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Container(
                                  color: Colors.black.withAlpha(
                                    (0.3 * 255).round(),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      '$base${cubit.profileImagePath!}',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 40,
                                right: 20,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ],
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.solidImages,
                  color: context.read<ThemeProvider>().themeData.splashColor,
                ),
                title: Text('pick_image_gallery'.tr()),
                onTap: () {
                  Navigator.pop(context);
                  pickAndEditImage(isCamera: false, cubit: cubit);
                },
              ),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.camera,
                  color: context.read<ThemeProvider>().themeData.splashColor,
                ),
                title: Text('pick_image_camera'.tr()),
                onTap: () {
                  Navigator.pop(context);
                  pickAndEditImage(isCamera: true, cubit: cubit);
                },
              ),
              if (cubit.profileImagePath != null) ...[
                if (cubit.profileImagePath!.isNotEmpty) ...[
                  ListTile(
                    leading: const FaIcon(
                      FontAwesomeIcons.trash,
                      color: Colors.red,
                    ),
                    title: Text('delete_image'.tr()),
                    onTap: () {
                      Navigator.pop(context);

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Column(
                              children: [
                                const DeleteImageIcon(),
                                const SizedBox(height: 6),
                                Text('delete_image'.tr()),
                              ],
                            ),
                            content: Text('delete_image_confirmation'.tr()),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'cancel'.tr(),
                                  style: TextStyles.button.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  cubit.deleteProfileImage();
                                },
                                child: Text(
                                  'delete'.tr(),
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ],
            ],
          );
        },
      );
    },
  );
}

Future<File?> pickAndEditImage({
  required bool isCamera,
  required ProfileImageCubit cubit,
}) async {
  final pickedFile = await ImagePicker().pickImage(
    source: isCamera ? ImageSource.camera : ImageSource.gallery,
  );

  if (pickedFile == null) return null;

  final croppedFile = await ImageCropper().cropImage(
    sourcePath: pickedFile.path,
    compressFormat: ImageCompressFormat.jpg,
    compressQuality: 90,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'edit_image'.tr(),
        toolbarColor: KPrimaryColor,
        toolbarWidgetColor: KWhite,
        statusBarColor: KDarkBlue,
        backgroundColor: KBackgroundLight,
        activeControlsWidgetColor: KPrimaryColor,
        dimmedLayerColor: KBlack.withValues(alpha: 0.6),
        cropFrameColor: KPrimaryColor,
        cropGridColor: KCyan,
        cropFrameStrokeWidth: 3,
        cropGridStrokeWidth: 1,
        showCropGrid: true,
        hideBottomControls: false,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        title: 'edit_image'.tr(),
        cancelButtonTitle: 'cancel'.tr(),
        doneButtonTitle: 'done'.tr(),
        aspectRatioLockEnabled: false,
        rotateButtonsHidden: false,
        rotateClockwiseButtonHidden: false,
        resetAspectRatioEnabled: true,
      ),
    ],
  );

  if (croppedFile != null) {
    cubit.addProfileImage(image: File(croppedFile.path));
  }

  return null;
}
