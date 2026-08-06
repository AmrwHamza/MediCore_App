import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';

class ProfileImageViewer extends StatefulWidget {
  final String imageUrl;
  final String heroTag;
  final String? title;

  const ProfileImageViewer({
    super.key,
    required this.imageUrl,
    this.heroTag = 'profile_image_hero',
    this.title,
  });

  @override
  State<ProfileImageViewer> createState() => _ProfileImageViewerState();

  static void show(BuildContext context, {
    required String imageUrl,
    String heroTag = 'profile_image_hero',
    String? title,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black87,
        pageBuilder: (context, animation, secondaryAnimation) =>
            ProfileImageViewer(
              imageUrl: imageUrl,
              heroTag: heroTag,
              title: title,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}

class _ProfileImageViewerState extends State<ProfileImageViewer> {
  bool _showCloseButton = true;
  TransformationController _transformationController = TransformationController();

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background tap to close
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: Colors.black87,
            ),
          ),

          // Image with zoom/pan support
          Center(
            child: InteractiveViewer(
              transformationController: _transformationController,
              minScale: 0.5,
              maxScale: 4.0,
              onInteractionStart: (_) {
                setState(() => _showCloseButton = false);
              },
              onInteractionEnd: (_) {
                setState(() => _showCloseButton = true);
              },
              child: Hero(
                tag: widget.heroTag,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.95,
                    maxHeight: MediaQuery.of(context).size.height * 0.95,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: 200.w,
                          height: 200.h,
                          color: Colors.grey[900],
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                              color: KPrimaryColor,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 200.w,
                          height: 200.h,
                          color: Colors.grey[900],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.broken_image_outlined,
                                size: 48.r,
                                color: Colors.white54,
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                'Failed to load image'.tr(),
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Close button
          if (_showCloseButton)
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Material(
                    color: Colors.black54,
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      borderRadius: BorderRadius.circular(28.r),
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 24.r,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // Title (if provided)
          if (widget.title != null && _showCloseButton)
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 60.h),
                  child: Text(
                    widget.title!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Extension to easily show the viewer from any widget
extension ProfileImageViewerExtension on BuildContext {
  void showProfileImageViewer({
    required String imageUrl,
    String heroTag = 'profile_image_hero',
    String? title,
  }) {
    ProfileImageViewer.show(
      this,
      imageUrl: imageUrl,
      heroTag: heroTag,
      title: title,
    );
  }
}