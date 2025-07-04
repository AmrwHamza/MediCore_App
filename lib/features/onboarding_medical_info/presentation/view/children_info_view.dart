import 'package:flutter/material.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/child_widgets/children_info_view_body.dart';

class ChildrenInfoView extends StatelessWidget {
  static const routeName = '/children-info';
  @override
  Widget build(BuildContext context) {
    final theme = getIt<ThemeProvider>().themeData;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: const ChildrenInfoViewBody(),
    );
  }
}
