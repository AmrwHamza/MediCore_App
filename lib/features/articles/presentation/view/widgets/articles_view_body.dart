import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/widget/custom_scroll_widget.dart';
import 'package:medicore_app/features/articles/presentation/view_model/cubit/article_cubit.dart';
import 'package:medicore_app/features/articles/presentation/view_model/cubit/article_state.dart';
import '../widgets/article_card.dart';

class ArticlesViewBody extends StatefulWidget {
  const ArticlesViewBody({super.key});

  @override
  State<ArticlesViewBody> createState() => _ArticlesViewBodyState();
}

class _ArticlesViewBodyState extends State<ArticlesViewBody> {
  @override
  void initState() {
    super.initState();
    // context.read<ArticleCubit>().fetchInitialArticles();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollWidget(
      onRefresh: () async => context.read<ArticleCubit>().fetchInitialArticles(),
      child: BlocBuilder<ArticleCubit, ArticleState>(
        builder: (context, state) {
          if (state is ArticlePaginationLoaded) {
            return ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                return ArticleCard(article: state.articles[index]);
              },
            );
          } else if (state is ArticleError) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
