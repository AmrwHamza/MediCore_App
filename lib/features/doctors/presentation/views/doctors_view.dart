import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/features/doctors/presentation/views/widgets/custom_search_field.dart';
import 'package:medicore_app/features/doctors/presentation/views/widgets/doctor_card.dart';
import 'package:medicore_app/features/doctors/presentation/views/widgets/search_header_delegate.dart';

import '../../../home/presentation/view/doctor_details_view.dart';
import '../view_model/cubit/doctors_view_cubit.dart';

class DoctorsView extends StatelessWidget {
  const DoctorsView({super.key});

  static const routeName = '/doctors-view';

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => DoctorsViewCubit()..getDoctors(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'doctors'.tr(), isMainBar: false),
        body: SafeArea(
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
                          if (state is DoctorsViewLoading) {
                            return const SliverFillRemaining(
                              hasScrollBody: false,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: KPrimaryColor,
                                ),
                              ),
                            );
                          } else if (state is DoctorsViewSuccess) {
                            if (state.doctors.isEmpty) {
                              return SliverFillRemaining(
                                hasScrollBody: false,
                                child: Center(
                                  child: Text(
                                    'no_doctors_found'.tr(),
                                    style: TextStyle(
                                      color: isDark ? Colors.white60 : KGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return SliverList(
                              delegate: SliverChildBuilderDelegate((
                                context,
                                index,
                              ) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: DoctorCard(
                                    doctor: state.doctors[index],
                                    onTap: () {
                                      context.push(
                                        DoctorDetailsView.routeName,
                                        extra: {'doctor': state.doctors[index]},
                                      );
                                    },
                                  ),
                                );
                              }, childCount: state.doctors.length),
                            );
                          } else if (state is DoctorsViewFailure) {
                            return SliverFillRemaining(
                              hasScrollBody: false,
                              child: Center(
                                child: Text(
                                  state.error,
                                  style: const TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            );
                          }
                          return const SliverToBoxAdapter(
                            child: SizedBox.shrink(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
