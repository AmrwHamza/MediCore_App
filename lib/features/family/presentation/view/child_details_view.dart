import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/features/appointments/domain/entities/privew_entity.dart';
import 'package:medicore_app/features/family/presentation/view/widgets/child_details_widgets/child_appointments_tab.dart';
import 'package:medicore_app/features/family/presentation/view/widgets/child_details_widgets/child_hero_header.dart';
import 'package:medicore_app/features/family/presentation/view/widgets/child_details_widgets/child_profile_tab.dart';
import 'package:medicore_app/features/family/presentation/view/widgets/child_details_widgets/child_records_tab.dart';
import 'package:medicore_app/features/family/presentation/view_model/child_visits_cubit/child_visits_cubit.dart';
import 'package:medicore_app/features/family/presentation/view_model/child_visits_cubit/child_visits_state.dart';
import 'package:medicore_app/features/onboarding_medical_info/domain/entities/get_child_entity.dart';

class ChildDetailsView extends StatefulWidget {
  static const routeName = '/childDetails';

  const ChildDetailsView({super.key, required this.child});

  final GetChildEntity child;

  @override
  State<ChildDetailsView> createState() => _ChildDetailsViewState();
}

class _ChildDetailsViewState extends State<ChildDetailsView> {
  late GetChildEntity _child;

  @override
  void initState() {
    super.initState();
    _child = widget.child;
  }

  void _onChildUpdated(GetChildEntity updated) {
    if (!mounted) return;
    setState(() => _child = updated);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: '${_child.firstName} ${_child.lastName}',
        isMainBar: false,
      ),
      body: BlocProvider(
        create:
            (context) =>
                ChildVisitsCubit()..getChildVisits(patientId: _child.patientId),
        child: BlocBuilder<ChildVisitsCubit, ChildVisitsState>(
          builder: (context, state) {
            final List<PrivewEntity> previews =
                state is ChildVisitsSuccess ? state.previews : const [];

            return DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  ChildHeroHeader(child: _child, visitsCount: previews.length),
                  const SizedBox(height: 16),
                  _buildTabBar(context, theme),
                  Expanded(child: _buildTabContent(state, previews, _child)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context, ThemeData theme) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.3)),
      ),
      child: TabBar(
        indicator: BoxDecoration(
          color: KPrimaryColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: KPrimaryColor,
        unselectedLabelColor: theme.hintColor.withValues(alpha: 0.7),
        labelStyle: TextStyles.public.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 13.sp,
        ),
        unselectedLabelStyle: TextStyles.public.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 13.sp,
        ),
        tabs: [
          Tab(text: 'health_profile'.tr()),
          Tab(text: 'medical_records'.tr()),
          Tab(text: 'appointments'.tr()),
        ],
      ),
    );
  }

  Widget _buildTabContent(
    ChildVisitsState state,
    List<PrivewEntity> previews,
    GetChildEntity child,
  ) {
    return TabBarView(
      children: [
        ChildProfileTab(child: child, onChildUpdated: _onChildUpdated),
        ChildRecordsTab(previews: previews),
        ChildAppointmentsTab(previews: previews, child: child),
      ],
    );
  }
}
