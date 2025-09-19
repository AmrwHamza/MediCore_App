import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/child_widgets/add_child_dialog.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_cubit/children_info_cubit.dart';

class AddChildCard extends StatelessWidget {
  const AddChildCard({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ChildrenInfoCubit>().state;

    if (state is AddChildLoading) {
      return const Card(
        color: Colors.transparent,
        elevation: 0,
        child: Center(child: SpinKitPouringHourGlassRefined(color: KDarkBlue)),
      );
    }

    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final child = await showDialog(
            context: context,
            builder: (_) => AddChildDialog(),
          );
          if (child != null) {
            context.read<ChildrenInfoCubit>().addChild(child);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add_circle, size: 50, color: KDarkBlue),
              const SizedBox(height: 12),
              Text(
                "add_child".tr(),
                style: TextStyles.button.copyWith(color: KDarkBlue),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
