import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/child_widgets/add_child_dialog.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_cubit/children_info_cubit.dart';

class AddChildCard extends StatelessWidget {
  const AddChildCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;
    final state = context.watch<ChildrenInfoCubit>().state;

    if (state is AddChildLoading) {
      return Card(
        color: theme.cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: SpinKitPouringHourGlassRefined(
            color: theme.colorScheme.primary,
          ),
        ),
      );
    }

    final accentColor = isDark ? KCyan : KDarkBlue;

    return Card(
      elevation: 0,
      color: isDark
          ? Colors.white.withValues(alpha: 0.04)
          : KPrimaryColor.withValues(alpha: 0.04),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : KPrimaryColor.withValues(alpha: 0.15),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () async {
          final child = await showDialog(
            context: context,
            builder: (_) => const AddChildDialog(),
          );
          if (child != null && context.mounted) {
            context.read<ChildrenInfoCubit>().addChild(child);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_circle, size: 44, color: accentColor),
              const SizedBox(height: 8),
              Text(
                "add_child".tr(),
                style: TextStyles.button.copyWith(
                  color: accentColor,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
