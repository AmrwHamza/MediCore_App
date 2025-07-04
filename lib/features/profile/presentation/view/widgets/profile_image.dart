import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/app_images.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.profileImageUrl});

  final String? profileImageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = getIt<ThemeProvider>().themeData;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: theme.cardColor,
          context: context,
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (profileImageUrl != null)
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.eye,
                      color: theme.splashColor,
                    ),
                    title: const Text('Show Image'),
                    onTap: () {
                      Navigator.pop(context);
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: "Dismiss",
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
                                    child: Image.asset(
                                      profileImageUrl!,
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
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.solidImages,
                    color: theme.splashColor,
                  ),
                  title: const Text('Pick Image From Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    pickAndEditImage(isCamera: false);
                  },
                ),
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.camera,
                    color: theme.splashColor,
                  ),
                  title: const Text('Pick Image From Camera'),
                  onTap: () async {
                    Navigator.pop(context);
                    pickAndEditImage(isCamera: true);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    FontAwesomeIcons.trash,
                    color: Colors.red,
                  ),
                  title: const Text('Delete Image'),
                  onTap: () {
                    Navigator.pop(context);

                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text("Delete Image"),
                            content: const Text(
                              "Are you sure you want to delete this image ?",
                            ),
                            actions: [
                              TextButton(
                                child: const Text("Cancel"),
                                onPressed: () => Navigator.pop(context),
                              ),
                              TextButton(
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  //delete from backend
                                },
                              ),
                            ],
                          ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },

      child: Stack(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: theme.cardColor, width: 3),
              image: DecorationImage(
                image: AssetImage(profileImageUrl ?? Assets.imagesBoy),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: CircleAvatar(
              maxRadius: 15,
              backgroundColor: theme.cardColor,
              child: Icon(
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

  Future<File?> pickAndEditImage({required bool isCamera}) async {
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
          toolbarTitle: 'Edit Image',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(title: 'Edit Image'),
      ],
    );
    if (croppedFile != null) {
      //send image to backend
    }
    return null;
  }
}
