import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/articles/presentation/view/widgets/articles_view_body.dart';
import 'package:medicore_app/features/articles/presentation/view_model/cubit/article_cubit.dart';
import 'package:medicore_app/features/articles/presentation/view_model/fav_cubit/favorite_cubit.dart';

class ArticlesView extends StatelessWidget {
  static const routeName = '/articles';

  const ArticlesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.watch<ThemeProvider>().themeData.scaffoldBackgroundColor,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<FavoriteCubit>()),
          BlocProvider(create: (context) => ArticleCubit()),
        ],
        child: const ArticlesViewBody(),
      ),
    );
  }
}
