import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/family/presentation/view/widgets/family_view_body.dart';
import 'package:medicore_app/features/family/presentation/view_model/family_cubit/family_cubit.dart';

class FamilyView extends StatelessWidget {
  static const routeName = '/family';

  const FamilyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.watch<ThemeProvider>().themeData.scaffoldBackgroundColor,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => FamilyCubit()..getChilds()),
        ],
        child: const FamilyViewBody(),
      ),
    );
  }
}
