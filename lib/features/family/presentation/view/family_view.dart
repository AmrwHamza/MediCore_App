import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/family/presentation/view/widgets/family_view_body.dart';
import 'package:medicore_app/features/family/presentation/view_model/family_cubit/family_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/child_widgets/add_child_dialog.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_cubit/children_info_cubit.dart';

class FamilyView extends StatelessWidget {
  static const routeName = '/family';

  const FamilyView({super.key});

  Future<void> _handleAddChild(BuildContext context) async {
    final child = await showDialog(
      context: context,
      builder: (_) => const AddChildDialog(),
    );
    if (child != null && context.mounted) {
      context.read<ChildrenInfoCubit>().addChild(child);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.watch<ThemeProvider>().themeData.scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _handleAddChild(context),
        backgroundColor: KPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 6,
        highlightElevation: 12,
        icon: const Icon(Icons.add_rounded),
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'add_child'.tr(),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      )
          .animate()
          .scale(
            begin: const Offset(0.4, 0.4),
            end: const Offset(1, 1),
            duration: 500.ms,
            curve: Curves.elasticOut,
            delay: 200.ms,
          )
          .fadeIn(duration: 400.ms, delay: 200.ms),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => FamilyCubit()..getChilds()),
        ],
        child: const FamilyViewBody(),
      ),
    );
  }
}