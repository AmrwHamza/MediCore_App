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

  const ChildCard({
    super.key,
    required this.child,
    this.onTap,
    this.isSelected = false,
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

    // ألوان ديناميكية مبهجة مخصصة للأطفال ومبهرة للجنة التحكيم
    final Color boyColor =
        isDark ? const Color(0xFF1A365D) : const Color(0xFFE3F2FD);
    final Color girlColor =
        isDark ? const Color(0xFF4A154B) : const Color(0xFFFCE4EC);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutCubic,
        transform:
            _isHovered ? Matrix4.identity().scaled(1.03) : Matrix4.identity(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:
                widget.isSelected
                    ? [
                      KPrimaryColor.withValues(alpha: 0.25),
                      KPrimaryColor.withValues(alpha: 0.05),
                    ]
                    : [
                      isMale ? boyColor : girlColor,
                      isDark ? theme.cardColor : Colors.white,
                    ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color:
                widget.isSelected
                    ? KPrimaryColor
                    : (isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : KPrimaryColor.withValues(alpha: 0.1)),
            width: widget.isSelected ? 2.0 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color:
                  widget.isSelected
                      ? KPrimaryColor.withValues(alpha: 0.2)
                      : (_isHovered
                          ? Colors.black.withValues(alpha: 0.08)
                          : Colors.black.withValues(alpha: 0.03)),
              blurRadius: _isHovered ? 16 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              InkWell(
                onTap: _isDeleting ? null : widget.onTap,
                splashColor: (isMale ? Colors.blue : Colors.pink).withValues(
                  alpha: 0.1,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 12,
                  ),
                  child:
                      _isDeleting
                          ? Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.redAccent.shade200,
                                ),
                              ),
                            ),
                          )
                          : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // الصورة الرمزية بشكل مبهج ومحاطة بهالة ضوئية خفيفة
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color:
                                      isDark
                                          ? Colors.white.withValues(alpha: 0.06)
                                          : (isMale
                                              ? Colors.blue.shade50
                                              : Colors.pink.shade50),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: (isMale
                                              ? Colors.blue
                                              : Colors.pink)
                                          .withValues(alpha: 0.1),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: SvgPicture.asset(
                                  isMale ? Assets.imagesBoy : Assets.imagesGirl,
                                  width: 48,
                                  height: 48,
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
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isDark
                                          ? Colors.black26
                                          : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'age'.tr(
                                    namedArgs: {
                                      'age': widget.child.age.toString(),
                                    },
                                  ),
                                  style: TextStyles.public.copyWith(
                                    color:
                                        isDark
                                            ? Colors.white60
                                            : const Color(0xff7C8283),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                ),
              ),
              // زر الحذف المتطور والبارز بلمسة زجاجية حمراء فخمة وواضحة جداً للمستخدم واللجنة
              if (!_isDeleting)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withValues(alpha: 0.25),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Material(
                      color:
                          isDark
                              ? const Color(0xFF3A1212)
                              : const Color(0xFFFFEBEE),
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: _deleteChild,
                        customBorder: const CircleBorder(),
                        splashColor: Colors.red.withValues(alpha: 0.2),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.delete_forever_rounded,
                            color:
                                isDark
                                    ? Colors.redAccent.shade100
                                    : Colors.red.shade700,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
