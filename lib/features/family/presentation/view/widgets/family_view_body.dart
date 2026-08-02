import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/widget/custom_shimer.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/family/presentation/view/child_details_view.dart';
import 'package:medicore_app/features/family/presentation/view/widgets/add_child_card.dart';
import 'package:medicore_app/features/family/presentation/view_model/family_cubit/family_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/child_card.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_cubit/children_info_cubit.dart';

import '../../../../../core/theme/theme_provider.dart';

class FamilyViewBody extends StatelessWidget {
  const FamilyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

    return RefreshIndicator.adaptive(
      color: theme.splashColor,
      backgroundColor: theme.cardColor,
      onRefresh: () async {
        context.read<FamilyCubit>().getChilds();
        return Future.delayed(const Duration(seconds: 1));
      },
      child: ListView(
        children: [
          BlocListener<ChildrenInfoCubit, ChildrenInfoState>(
            listener: (context, childState) {
              if (childState is AddChildSuccess) {
                CustomSnackbar.show(
                  context,
                  message: childState.child.message,
                  type: SnackbarType.success,
                );
                context.read<FamilyCubit>().getChilds();
              } else if (childState is DeleteChildSuccess) {
                CustomSnackbar.show(
                  context,
                  message: childState.message,
                  type: SnackbarType.success,
                );
                context.read<FamilyCubit>().getChilds();
              } else if (childState is ChildFailure) {
                CustomSnackbar.show(
                  context,
                  message: childState.error,
                  type: SnackbarType.error,
                );
              }
            },
            child: BlocBuilder<FamilyCubit, FamilyState>(
              builder: (context, state) {
                if (state is GetFamilyFailure) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        state.error,
                        style: TextStyles.H2.copyWith(color: Colors.red),
                      ),
                    ),
                  );
                }

                final isLoading = state is GetFamilyLoading;
                final children =
                    (state is GetFamilySuccess) ? state.children.childList : [];
                final itemCount = isLoading ? 6 : children.length + 1;

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    final animationDelay = Duration(milliseconds: 80 * index);

                    if (index == 0) {
                      return const AddChildCard()
                          .animate()
                          .fade(duration: 400.ms, delay: animationDelay)
                          .slideY(
                            begin: 0.1,
                            duration: 400.ms,
                            curve: Curves.easeOut,
                          );
                    }

                    if (isLoading) {
                      return const CustomShimer()
                          .animate()
                          .fade(duration: 400.ms, delay: animationDelay)
                          .slideY(
                            begin: 0.1,
                            duration: 400.ms,
                            curve: Curves.easeOut,
                          );
                    }

                    final child = children[index - 1];

                    return ChildCard(
                          child: child,

                          onTap: () {
                            context.push(
                              ChildDetailsView.routeName,
                              extra: {'child': child},
                            );
                          },
                        )
                        .animate()
                        .fade(duration: 400.ms, delay: animationDelay)
                        .slideY(
                          begin: 0.1,
                          duration: 400.ms,
                          curve: Curves.easeOut,
                        );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
