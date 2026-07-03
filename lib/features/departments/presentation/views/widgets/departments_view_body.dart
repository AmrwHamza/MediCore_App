import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/app_lottie.dart';
import 'package:medicore_app/core/widget/lottie_state.dart';
import 'package:medicore_app/features/departments/presentation/view_model/cubit/departments_view_cubit.dart';
import 'package:medicore_app/features/departments/presentation/views/widgets/department_card_in_details.dart';
import 'package:medicore_app/features/departments/presentation/views/widgets/department_details_loading_list_shimmier.dart';
import 'package:medicore_app/features/doctors/presentation/views/widgets/custom_search_field.dart';
import 'package:medicore_app/features/doctors/presentation/views/widgets/search_header_delegate.dart';
import 'package:medicore_app/features/home/presentation/view/department_details_view.dart';

class DepartmentsViewBody extends StatelessWidget {
  const DepartmentsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

    return SafeArea(
      child: Builder(
        builder: (context) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<DepartmentsViewCubit>().getDepartments();
            },
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SearchHeaderDelegate(
                    height: 88,
                    child: Container(
                      color: theme.scaffoldBackgroundColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: CustomSearchField(
                        hintText: 'search_department_hint'.tr(),
                        onChanged: (query) {
                          context
                              .read<DepartmentsViewCubit>()
                              .searchDepartments(query: query);
                        },
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                  sliver: BlocBuilder<
                    DepartmentsViewCubit,
                    DepartmentsViewState
                  >(
                    builder: (context, state) {
                      return state.maybeWhen(
                        getDepartmentsLoading:
                            () => const DepartmentDetailsLoadingListShimmier(),
                        searchDepartmentsLoading:
                            () => SliverFillRemaining(
                              child: Center(
                                child: LottieState(
                                  asset: AppLottie.loadingSearch,
                                  message: '',
                                  height: 150.h,
                                ),
                              ),
                            ),
                        getDepartmentsFailure:
                            (error) => SliverFillRemaining(
                              hasScrollBody: false,
                              child: Center(
                                child: LottieState(
                                  asset: AppLottie.failure,
                                  message: error,
                                  height: 150.h,
                                ),
                              ),
                            ),
                        searchDepartmentsFailure:
                            (error) => SliverFillRemaining(
                              hasScrollBody: false,
                              child: Center(
                                child: LottieState(
                                  asset: AppLottie.failure,
                                  message: 'no_departments_found'.tr(),
                                  height: 150.h,
                                ),
                              ),
                            ),
                        getDepartmentsSuccess:
                            (departments) => _buildDepartmentsList(departments),
                        searchDepartmentsSuccess:
                            (departments) => _buildDepartmentsList(departments),
                        orElse:
                            () => const SliverToBoxAdapter(
                              child: SizedBox.shrink(),
                            ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDepartmentsList(List<dynamic> departments) {
    if (departments.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: LottieState(
            asset: AppLottie.emptySearchState,
            message: 'no_departments_found'.tr(),
            height: 150.h,
          ),
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final department = departments[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: DepartmentCardInDetails(
            department: department,
            onTap: () {
              context.push(
                DepartmentDetailsView.routeName,
                extra: {
                  "department": department.departmentName,
                  'departmentId': department.id,
                },
              );
            },
          ),
        );
      }, childCount: departments.length),
    );
  }
}
