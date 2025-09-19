import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/child_widgets/children_info_view_body.dart';

class ChildrenInfoView extends StatelessWidget {
  static const routeName = '/children-info';
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: const ChildrenInfoViewBody(),
    );
  }
}
