import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/widget/custom_scroll_widget.dart';
import 'package:medicore_app/core/widget/custom_shimer.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/family/presentation/view/child_details_view.dart';
import 'package:medicore_app/features/family/presentation/view/widgets/add_child_card.dart';
import 'package:medicore_app/features/family/presentation/view_model/family_cubit/family_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/child_card.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_cubit/children_info_cubit.dart';

class FamilyViewBody extends StatelessWidget {
  const FamilyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChildrenInfoCubit, ChildrenInfoState>(
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
      child: CustomScrollWidget(
        onRefresh: () {
          context.read<FamilyCubit>().getChilds();
          return Future.delayed(const Duration(seconds: 1));
        },
        child: BlocBuilder<FamilyCubit, FamilyState>(
          builder: (context, state) {
            if (state is GetFamilyFailure) {
              return Center(
                child: Text(
                  state.error,
                  style: TextStyles.H2.copyWith(color: Colors.red),
                ),
              );
            }

            final isLoading = state is GetFamilyLoading;
            final children =
                (state is GetFamilySuccess) ? state.children.childList : [];

            final itemCount = isLoading ? 5 : children.length + 1;

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.5,
              ),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                final animationDelay = Duration(milliseconds: 100 * index);

                if (index == 0) {
                  return const AddChildCard()
                      .animate()
                      .fade(duration: 500.ms, delay: animationDelay)
                      .slideY(
                        begin: 0.2,
                        duration: 500.ms,
                        curve: Curves.easeOut,
                      );
                }

                if (isLoading) {
                  return const CustomShimer()
                      .animate()
                      .fade(duration: 500.ms, delay: animationDelay)
                      .slideY(
                        begin: 0.2,
                        duration: 500.ms,
                        curve: Curves.easeOut,
                      );
                }

                final child = children[index - 1];
                final childName = '${child.firstName} ${child.lastName}';
                final isMale = child.gender == 'male';

                return ChildCard(
                      childId: child.id,
                      isMale: isMale,
                      childName: childName,
                      childAge: child.age,
                      onTap: () {
                        context.push(
                          ChildDetailsView.routeName,
                          extra: {'child': child},
                        );
                      },
                    )
                    .animate()
                    .fade(duration: 500.ms, delay: animationDelay)
                    .slideY(
                      begin: 0.2,
                      duration: 500.ms,
                      curve: Curves.easeOut,
                    );
              },
            );
          },
        ),
      ),
    );
  }
}
