import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/helper_function/confirmation_dialog.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/features/onboarding_medical_info/domain/entities/get_child_entity.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_cubit/children_info_cubit.dart';

class ChildCard extends StatefulWidget {
  final GetChildEntity child;
  final void Function()? onTap;
  final bool isSelected;
  final bool showDeleteButton;

  const ChildCard({
    super.key,
    required this.child,
    this.onTap,
    this.isSelected = false,
    this.showDeleteButton = true,
  });

  @override
  State<ChildCard> createState() => _ChildCardState();
}

class _ChildCardState extends State<ChildCard> {
  bool _isDeleting = false;
  bool _isHovered = false;

  Future<void> _deleteChild() async {
    final delete = await showConfirmationDialog(
      context: context,
      title: 'confirmationTitle'.tr(),
      content: 'confirmDeleteMessage'.tr(),
      confirmText: 'confirmationYes'.tr(),
      cancelText: 'confirmationCancel'.tr(),
    );

    if (delete == true) {
      setState(() => _isDeleting = true);
      final cubit = context.read<ChildrenInfoCubit>();
      await cubit.deleteChildById(widget.child.id);
      if (mounted) setState(() => _isDeleting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;
    final isMale = widget.child.gender.toLowerCase() == 'male';
    final childName = '${widget.child.firstName} ${widget.child.lastName}';
    final Color boyColor =
        isDark ? const Color(0xFF1E293B) : const Color(0xFFF0F7FF);
    final Color girlColor =
        isDark ? const Color(0xFF2D1B2D) : const Color(0xFFFFF0F5);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutCubic,
        transform:
            _isHovered ? Matrix4.identity().scaled(1.02) : Matrix4.identity(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:
                widget.isSelected
                    ? [
                      KPrimaryColor.withValues(alpha: 0.15),
                      KPrimaryColor.withValues(alpha: 0.02),
                    ]
                    : [
                      isMale ? boyColor : girlColor,
                      isDark ? theme.cardColor : Colors.white,
                    ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                widget.isSelected
                    ? KPrimaryColor
                    : (isDark
                        ? Colors.white.withValues(alpha: 0.06)
                        : KPrimaryColor.withValues(alpha: 0.08)),
            width: widget.isSelected ? 2.0 : 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color:
                  widget.isSelected
                      ? KPrimaryColor.withValues(alpha: 0.15)
                      : (_isHovered
                          ? Colors.black.withValues(alpha: 0.06)
                          : Colors.black.withValues(alpha: 0.02)),
              blurRadius: _isHovered ? 12 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child:
                _isDeleting
                    ? Center(
                      key: const ValueKey('deleting_state'),
                      child: SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.redAccent.shade200,
                          ),
                        ),
                      ),
                    )
                    : Stack(
                      key: const ValueKey('content_state'),
                      fit: StackFit.expand,
                      children: [
                        InkWell(
                          onTap: widget.onTap,
                          splashColor: (isMale ? Colors.blue : Colors.pink)
                              .withValues(alpha: 0.08),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final double avatarSize =
                                  constraints.maxHeight * 0.35;
                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color:
                                            isDark
                                                ? Colors.white.withValues(
                                                  alpha: 0.04,
                                                )
                                                : (isMale
                                                    ? Colors.blue.shade50
                                                    : Colors.pink.shade50),
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                        isMale
                                            ? Assets.imagesBoy
                                            : Assets.imagesGirl,
                                        width: avatarSize.clamp(36, 54),
                                        height: avatarSize.clamp(36, 54),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      childName,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.H2.copyWith(
                                        color: isDark ? Colors.white : KBlack,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            isDark
                                                ? Colors.black38
                                                : Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Text(
                                        'age'.tr(
                                          namedArgs: {
                                            'age': widget.child.age.toString(),
                                          },
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyles.public.copyWith(
                                          color:
                                              isDark
                                                  ? Colors.white60
                                                  : const Color(0xff64748B),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        if (widget.showDeleteButton)
                          Positioned(
                            top: 6,
                            right: 6,
                            child: Material(
                              color:
                                  isDark
                                      ? const Color(0xFF2D1616)
                                      : const Color(0xFFFEE2E2),
                              shape: const CircleBorder(),
                              child: InkWell(
                                onTap: _deleteChild,
                                customBorder: const CircleBorder(),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Icon(
                                    Icons.delete_rounded,
                                    color:
                                        isDark
                                            ? Colors.redAccent.shade100
                                            : Colors.red.shade600,
                                    size: 14,
                                  ),
                                ),
                              ),
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
