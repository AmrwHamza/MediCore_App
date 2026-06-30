import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/core/widget/custom_scroll_widget.dart';
import 'package:medicore_app/features/articles/presentation/view_model/cubit/article_cubit.dart';
import 'package:medicore_app/features/articles/presentation/view_model/cubit/article_state.dart';

import '../../../../../core/widget/custom_shimer.dart';
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
    context.read<ArticleCubit>().fetchInitialArticles();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollWidget(
      onRefresh:
          () async => context.read<ArticleCubit>().fetchInitialArticles(),
      child: BlocBuilder<ArticleCubit, ArticleState>(
        builder: (context, state) {
          if (state is ArticlePaginationLoaded) {
            return ListView.builder(
              padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                return ArticleCard(article: state.articles[index])
                    .animate()
                    .fadeIn(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOutCubic,
                    )
                    .slideY(
                      begin: 0.15,
                      end: 0,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutBack,
                    );
              },
            );
          } else if (state is ArticleError) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            return ListView.builder(
              padding: EdgeInsets.only(
                top: 8.h,
                bottom: 16.h,
                right: 16.w,
                left: 16.w,
              ),
              itemCount: 6,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: const CustomShimer()
                      .animate()
                      .fadeIn(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                      )
                      .slideY(
                        begin: 0.2,
                        end: 0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOutCubic,
                      )
                      .shimmer(
                        delay: Duration(milliseconds: index * 100),
                        duration: const Duration(milliseconds: 1200),
                        color: Colors.white24,
                      ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
