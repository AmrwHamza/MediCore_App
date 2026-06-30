import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/helper_function/confirmation_dialog.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/features/onboarding_medical_info/domain/entities/child_entity.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_cubit/children_info_cubit.dart';

class ChildCard extends StatefulWidget {
  final int childId;
  final bool isMale;
  final String childName;
  final int childAge;
  final void Function()? onTap;
  final ChildEntity? child;
  final bool isSelected;

  const ChildCard({
    super.key,
    required this.childId,
    required this.isMale,
    required this.childName,
    required this.childAge,
    this.onTap,
    this.child,
    this.isSelected = false,
  });

  @override
  State<ChildCard> createState() => _ChildCardState();
}

class _ChildCardState extends State<ChildCard> {
  bool isDeleting = false;

  Future<void> _deleteChild() async {
    final delete = await showConfirmationDialog(
      context: context,
      title: 'confirmationTitle'.tr(),
      content: 'confirmDeleteMessage'.tr(),
      confirmText: 'confirmationYes'.tr(),
      cancelText: 'confirmationCancel'.tr(),
    );

    if (delete == true) {
      setState(() => isDeleting = true);
      final cubit = context.read<ChildrenInfoCubit>();

      if (widget.child != null) {
        await cubit.deleteChild(widget.child!);
      } else {
        await cubit.deleteChildById(widget.childId);
      }
      setState(() => isDeleting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    if (isDeleting) {
      return Container(
        width: 130,
        alignment: Alignment.center,
        child: SpinKitCubeGrid(
          color: Colors.grey.withAlpha((255 * 0.8).round()),
          size: 40,
        ),
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 135,
      child: Card(
        elevation: widget.isSelected ? 6 : 2,
        color:
            widget.isSelected
                ? (isDark
                    ? KPrimaryColor.withAlpha(30)
                    : const Color(0xffE7F9FE))
                : theme.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: widget.isSelected ? KPrimaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(20),
          highlightColor: theme.shadowColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 14, 10, 8),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color:
                            isDark
                                ? Colors.white10
                                : Colors.black.withAlpha(10),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        widget.isMale ? Assets.imagesBoy : Assets.imagesGirl,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Text(
                        widget.childName,
                        textAlign: TextAlign.center,
                        style: TextStyles.H2.copyWith(
                          color: theme.canvasColor,
                          fontSize: 14,
                          fontWeight:
                              widget.isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "${'age'.tr()}: ${widget.childAge}",
                      style: TextStyles.public.copyWith(
                        color: const Color(0xff7C8283),
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
                Positioned(
                  top: -10,
                  right: -10,
                  child: IconButton(
                    onPressed: _deleteChild,
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.redAccent,
                      size: 18,
                    ),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
