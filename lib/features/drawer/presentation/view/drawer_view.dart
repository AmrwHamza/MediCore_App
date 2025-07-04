import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/shared_pref.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/helper_function/confirmation_dialog.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/logger_helper.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/auth/first_page/presentation/view/first_page_auth.dart';
import 'package:medicore_app/features/auth/logout/presentation/view_model/cubit/logout_cubit.dart';
import 'package:medicore_app/features/drawer/presentation/view/widgets/custom_drawer_header.dart';
import 'package:medicore_app/features/drawer/presentation/view_model/theme_cubit/theme_cubit.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = getIt<ThemeProvider>().themeData;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const CustomDrawerHeader(),

          const SizedBox(height: 12),
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<ThemeCubit>()),
              // BlocProvider(create: (context) => LogoutCubit()),
            ],
            child: BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, state) {
                final pref = getIt<SharedPrefHelper>();
                return SwitchListTile(
                  activeColor: KPrimaryColor,
                  secondary: Icon(
                    pref.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: Colors.blue[800],
                  ),
                  title: Text(
                    'Dark Mode'.tr(),
                    style: TextStyles.public.copyWith(
                      color: KDarkBlue,
                      shadows: [
                        BoxShadow(color: theme.shadowColor, blurRadius: 200),
                      ],
                    ),
                  ),
                  value: pref.isDarkMode,
                  onChanged: (_) {
                    context.read<ThemeCubit>().changeTheme();
                    getIt<ThemeProvider>().changeTheme();
                  },
                );
              },
            ),
          ),

          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.grey.withAlpha((255 * 0.2).round()),
            ),
            child: ExpansionTile(
              title: Text(
                'Favorite'.tr(),
                style: TextStyles.public.copyWith(color: KDarkBlue),
              ),
              leading: const Icon(Icons.favorite, color: Colors.red),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Doctors'.tr(),
                          style: TextStyles.public.copyWith(
                            color: KDarkBlue,
                            fontSize: 14,
                          ),
                        ),
                        onTap: () {},
                        leading: const Icon(
                          FontAwesomeIcons.userDoctor,
                          color: KOrange,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Articles'.tr(),
                          style: TextStyles.public.copyWith(
                            color: KDarkBlue,
                            fontSize: 14,
                          ),
                        ),
                        onTap: () {},
                        leading: const Icon(
                          FontAwesomeIcons.bookMedical,
                          color: KPurple,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.language, color: Colors.blue),
            title: Text(
              'Language'.tr(),
              style: TextStyles.public.copyWith(color: KDarkBlue),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: Text(
                      'select_language'.tr(),
                      style: TextStyles.H2.copyWith(color: theme.splashColor),
                    ),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(
                            'arabic'.tr(),
                            style: TextStyles.public.copyWith(
                              color: theme.canvasColor,
                            ),
                          ),
                          onTap: () async {
                            await context.setLocale(const Locale('ar'));
                            context.pop();
                          },
                        ),
                        ListTile(
                          title: Text(
                            'english'.tr(),
                            style: TextStyles.public.copyWith(
                              color: theme.canvasColor,
                            ),
                          ),
                          onTap: () async {
                            await context.setLocale(const Locale('en'));
                            context.pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            hoverColor: KPrimaryColor.withAlpha((0.1 * 255).round()),
          ),
          ListTile(
            title: Text('Archive'.tr()),
            leading: const Icon(Icons.archive, color: KOrange),
          ),
          BlocConsumer<LogoutCubit, LogoutState>(
            listener: (context, state) async {
              if (state is LogoutFailure) {
                CustomSnackbar.show(
                  context,
                  message: state.error,
                  type: SnackbarType.error,
                );
              } else if (state is LogoutSuccess) {
                await SharedPrefHelper.removeData(SharedPrefKeys.userToken);
                CustomSnackbar.show(
                  context,
                  message: state.message,
                  type: SnackbarType.success,
                );
                context.go(FirstPageAuth.routeName);
              }
            },
            builder: (context, state) {
              if (state is LogoutLoading) {
                return const Center(
                  child: SpinKitThreeBounce(color: KPrimaryColor),
                );
              }
              return ListTile(
                title: Text('Logout'.tr()),
                leading: const Icon(Icons.logout, color: KDarkBlue),
                onTap: () async {
                  final logout = await showConfirmationDialog(
                    context: context,
                    title: 'LogOut',
                    content: 'Do you want to LogOut',
                    confirmText: 'Yes',
                    cancelText: 'No',
                  );
                  LoggerHelper.success(logout.toString());
                  if (logout == true) {
                    context.read<LogoutCubit>().logout();
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
