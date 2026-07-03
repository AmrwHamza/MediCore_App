import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/app_lottie.dart';
import 'package:medicore_app/core/widget/lottie_state.dart';
import 'package:medicore_app/features/doctors/presentation/view_model/cubit/doctors_view_cubit.dart';
import 'package:medicore_app/features/doctors/presentation/views/widgets/custom_search_field.dart';
import 'package:medicore_app/features/doctors/presentation/views/widgets/doctor_card.dart';
import 'package:medicore_app/features/doctors/presentation/views/widgets/search_header_delegate.dart';
import 'package:medicore_app/features/home/presentation/view/doctor_details_view.dart';

class DoctorsViewBody extends StatelessWidget {
  const DoctorsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

    return SafeArea(
      child: Builder(
        builder: (context) {
          return RefreshIndicator(
            color: KPrimaryColor,
            backgroundColor: theme.cardColor,
            onRefresh: () async {
              context.read<DoctorsViewCubit>().getDoctors();
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
                        hintText: 'search_doctor_hint'.tr(),
                        onChanged: (query) {
                          context.read<DoctorsViewCubit>().searchDoctors(
                            query: query,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                  sliver: BlocBuilder<DoctorsViewCubit, DoctorsViewState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        getDoctorsLoading:
                            () => const SliverFillRemaining(
                              hasScrollBody: false,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: KPrimaryColor,
                                ),
                              ),
                            ),
                        searchDoctorsLoading:
                            () => SliverFillRemaining(
                              child: Center(
                                child: LottieState(
                                  asset: AppLottie.loadingSearch,
                                  message: '',
                                  height: 150.h,
                                ),
                              ),
                            ),
                        getDoctorsFailure:
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
                        searchDoctorsFailure:
                            (error) => SliverFillRemaining(
                              hasScrollBody: false,
                              child: Center(
                                child: LottieState(
                                  asset: AppLottie.failure,
                                  message: 'no_doctors_found'.tr(),
                                  height: 150.h,
                                ),
                              ),
                            ),
                        getDoctorsSuccess:
                            (doctors) => _buildDoctorsList(doctors),
                        searchDoctorsSuccess:
                            (doctors) => _buildDoctorsList(doctors),
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

  Widget _buildDoctorsList(List<dynamic> doctors) {
    if (doctors.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: LottieState(
            asset: AppLottie.emptySearchState,
            message: 'no_doctors_found'.tr(),
            height: 150.h,
          ),
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final doctor = doctors[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: DoctorCard(
            doctor: doctor,
            onTap: () {
              context.push(
                DoctorDetailsView.routeName,
                extra: {'doctor': doctor},
              );
            },
          ),
        );
      }, childCount: doctors.length),
    );
  }
}
