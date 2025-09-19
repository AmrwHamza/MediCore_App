import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/core/widget/custom_scroll_widget.dart';
import 'package:medicore_app/core/widget/custom_shimer.dart';
import 'package:medicore_app/features/home/domain/entities/doctor_entity.dart';
import 'package:medicore_app/features/home/presentation/view_model/doctor_info_cubit/doctor_info_cubit.dart';
import 'package:provider/provider.dart';

class DoctorDetailsView extends StatelessWidget {
  static const routeName = '/doctorDetails';

  final DoctorEntity doctor;

  const DoctorDetailsView({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    return BlocProvider(
      create: (context) => DoctorInfoCubit()..getDoctorInfo(doctor.doctorId),
      child: Scaffold(
        appBar: CustomAppBar(title: 'details'.tr(), isMainBar: false),
        backgroundColor: theme.primaryColorLight,
        body: CustomScrollWidget(
          onRefresh: () {
            context.read<DoctorInfoCubit>().getDoctorInfo(doctor.doctorId);
            return Future.delayed(const Duration(seconds: 1));
          },
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: BlocBuilder<DoctorInfoCubit, DoctorInfoState>(
              builder: (context, state) {
                Widget image = CircleAvatar(
                  radius: 60,
                  backgroundColor: KDarkBlue.withAlpha((0.4 * 255).round()),
                );
                Widget name = const Text('');
                Widget department = const Text('');
                Widget rating = const Text('');
                Widget email = const Text('');
                Widget phone = const Text('');

                if (state is DoctorInfoLoading) {
                  image = const CustomShimer(hieght: 60, width: 60);
                  name = const CustomShimer();
                  department = const CustomShimer();
                  rating = const CustomShimer();
                  email = const CustomShimer();
                  phone = const CustomShimer();
                } else if (state is DoctorInfoFailure) {
                  return Center(
                    child: Text(state.error, style: TextStyles.notes),
                  );
                } else if (state is DoctorInfoSuccess) {
                  image = Image.network(state.doctorInfo.imagePath);
                  name = Text(
                    '${state.doctorInfo.firstName} ${state.doctorInfo.lastName}',
                    style: TextStyles.H1.copyWith(color: theme.canvasColor),
                  );
                  department = Text('${state.doctorInfo.department}');
                  rating = RatingBarIndicator(
                    rating: (state.doctorInfo.rate ?? 3.5).toDouble(),
                    itemBuilder:
                        (context, _) =>
                            const Icon(Icons.star, color: Colors.amberAccent),
                    itemCount: 5,
                    itemSize: 30,
                    direction: Axis.horizontal,
                  );
                  email = Text(
                    state.doctorInfo.email,
                    style: TextStyles.public.copyWith(
                      color: Provider.of<ThemeProvider>(
                        context,
                      ).themeData.canvasColor.withAlpha((255 * 0.6).round()),
                    ),
                  );
                  phone = Text(
                    state.doctorInfo.phone,
                    style: TextStyles.public.copyWith(
                      color: Provider.of<ThemeProvider>(
                        context,
                      ).themeData.canvasColor.withAlpha((255 * 0.6).round()),
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        child: image,
                        backgroundColor: KDarkBlue.withAlpha(
                          (0.4 * 255).round(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    name,
                    const SizedBox(height: 8),
                    department,
                    const SizedBox(height: 8),
                    rating,
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "phone".tr(),
                        style: TextStyles.H2.copyWith(color: theme.canvasColor),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      color: theme.cardColor,
                      elevation: 2,
                      margin: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.phone, color: KDarkBlue),
                            const SizedBox(width: 12),
                            phone,
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "email".tr(),
                        style: TextStyles.H2.copyWith(color: theme.canvasColor),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      color: theme.cardColor,
                      elevation: 2,
                      margin: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.email, color: KDarkBlue),
                            const SizedBox(width: 12),
                            email,
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text("note".tr(), style: TextStyles.notes),
                    // const SizedBox(height: 32),
                    // CustomButton(
                    //   title: 'book_appointment'.tr(),
                    //   color: KDarkBlue,
                    //   onTap: () {},
                    // ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
