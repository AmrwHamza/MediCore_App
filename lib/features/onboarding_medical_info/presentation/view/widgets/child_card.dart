import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/helper_function/confirmation_dialog.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
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

  const ChildCard({
    super.key,
    required this.childId,
    required this.isMale,
    required this.childName,
    required this.childAge,
    this.onTap,
    this.child,
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
    final theme = getIt<ThemeProvider>().themeData;

    return isDeleting
        ? Center(
          child: SpinKitCubeGrid(
            color: Colors.grey.withAlpha((255 * 0.8).round()),
            size: 40,
          ),
        )
        : InkWell(
          onTap: widget.onTap,
          highlightColor: theme.shadowColor,
          child: Card(
            elevation: 3,
            color: theme.cardColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    widget.isMale ? Assets.imagesBoy : Assets.imagesGirl,
                    width: MediaQuery.of(context).size.width / 7,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      widget.childName,
                      textAlign: TextAlign.center,
                      style: TextStyles.H2.copyWith(color: theme.canvasColor),
                      maxLines: 2,
                      softWrap: true,
                    ),
                  ),
                  Text(
                    "Age: ${widget.childAge}",
                    style: TextStyles.public.copyWith(color: theme.canvasColor),
                    textAlign: TextAlign.center,
                  ),
                  IconButton(
                    onPressed: _deleteChild,
                    icon: const Icon(Icons.delete_sharp, color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
