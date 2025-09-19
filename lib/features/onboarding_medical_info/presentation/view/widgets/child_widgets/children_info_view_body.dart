import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/main_home/presentation/view/main_home_view.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/child_card.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/child_widgets/add_child_dialog.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_cubit/children_info_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_ui_cubit/children_info_ui_cubit.dart';

class ChildrenInfoViewBody extends StatelessWidget {
  const ChildrenInfoViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildrenInfoUiCubit, ChildrenInfoUiState>(
      builder: (context, state) {
        final theme = context.watch<ThemeProvider>().themeData;
        final childUiCubit = context.read<ChildrenInfoUiCubit>();
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 4),
              Text(
                "children_q".tr(),
                style: TextStyles.H2.copyWith(color: theme.canvasColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<bool>(
                    activeColor: KPrimaryColor,
                    value: true,
                    groupValue: state.hasChildren,
                    onChanged: (_) => childUiCubit.updateHasChildren(true),
                  ),
                  Text(
                    "Yes",
                    style: TextStyles.public.copyWith(color: theme.canvasColor),
                  ),
                  Radio<bool>(
                    activeColor: KPrimaryColor,
                    value: false,
                    groupValue: state.hasChildren,
                    onChanged: (_) => childUiCubit.updateHasChildren(false),
                  ),
                  Text(
                    "No",
                    style: TextStyles.public.copyWith(color: theme.canvasColor),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (state.hasChildren)
                Column(
                  children: [
                    BlocConsumer<ChildrenInfoCubit, ChildrenInfoState>(
                      listener: (context, state) {
                        if (state is ChildFailure) {
                          CustomSnackbar.show(
                            context,
                            message: state.error,
                            type: SnackbarType.error,
                          );
                        } else if (state is AddChildSuccess) {
                          CustomSnackbar.show(
                            context,
                            message: state.child.message,
                            type: SnackbarType.success,
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AddChildLoading) {
                          return const SpinKitPouringHourGlassRefined(
                            color: KDarkBlue,
                          );
                        }
                        return InkWell(
                          onTap: () async {
                            final child =
                                await showDialog<Map<String, dynamic>>(
                                  context: context,
                                  builder: (_) => AddChildDialog(),
                                );
                            if (child != null) {
                              context.read<ChildrenInfoCubit>().addChild(child);
                            }
                          },
                          child: Column(
                            children: [
                              const Icon(
                                Icons.add_circle,
                                size: 50,
                                color: KDarkBlue,
                              ),
                              Text(
                                "add_child".tr(),
                                style: TextStyles.button.copyWith(
                                  color: KDarkBlue,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<ChildrenInfoCubit, ChildrenInfoState>(
                      builder: (context, state) {
                        final allChildren =
                            context.read<ChildrenInfoCubit>().children;

                        if (allChildren.isEmpty) {
                          return Text('no_child'.tr());
                        }

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: allChildren.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.5,
                              ),
                          itemBuilder: (context, index) {
                            final child = allChildren[index];
                            return ChildCard(
                              child: child,
                              childId: child.id,
                              isMale: child.gender == 'male',
                              childName: '${child.firstName} ${child.lastName}',
                              childAge: child.age,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              const SizedBox(height: 30),

              CustomButton(
                title: 'submit'.tr(),
                onTap: () {
                  context.go(MainHomeView.routeName);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
