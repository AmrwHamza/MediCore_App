import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/features/articles/domain/entities/article_entity.dart';
import 'package:medicore_app/features/articles/presentation/view/widgets/article_details_widgets/atricle_details_body.dart';
import 'package:medicore_app/features/articles/presentation/view/widgets/article_details_widgets/atricle_details_header.dart';

import '../../../../core/helper_function/get_it_service.dart';
import '../view_model/fav_cubit/favorite_cubit.dart';

class ArticleDetailsView extends StatelessWidget {
  static const routeName = '/articlesDetails';
  final ArticleEntity article;

  const ArticleDetailsView({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FavoriteCubit>(),
      child: Scaffold(
        appBar: CustomAppBar(title: article.title, isMainBar: false),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AtricleDetailsHeader(article: article),
              const SizedBox(height: 20),
              AtricleDetailsBody(body: article.body),
            ],
          ),
        ),
      ),
    );
  }
}
