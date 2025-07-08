import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/profile/presentation/view/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  static const routeName = '/profile';
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.splashColor,
        foregroundColor: Colors.white,
      ),
      backgroundColor: theme.splashColor,

      body: const ProfileViewBody(),
    );
  }
}
