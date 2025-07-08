import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:medicore_app/core/helper/shared_pref.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/api_services.dart';
import 'package:medicore_app/features/articles/data/repo/article_repo_impl.dart';
import 'package:medicore_app/features/articles/presentation/view_model/fav_cubit/favorite_cubit.dart';
import 'package:medicore_app/features/auth/OTP/data/repo/otp_repo_impl.dart';
import 'package:medicore_app/features/auth/first_page/presentation/view_model/change_lang_cubit/change_language_cubit.dart';
import 'package:medicore_app/features/auth/forget_password/data/repo/forget_password_repo.dart';
import 'package:medicore_app/features/auth/public_cubits/auth_validate_cubit/auth_validate_cubit.dart';
import 'package:medicore_app/features/book_appointment/data/repo/book_appointment_repo_impl.dart';
import 'package:medicore_app/features/home/data/models/hive/hive_department_model.dart';
import 'package:medicore_app/features/home/data/models/hive/hive_doctor_model.dart';
import 'package:medicore_app/features/home/data/models/hive/hive_home_local_storge.dart';
import 'package:medicore_app/features/home/data/repos/home_repo_impl.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/patient_info_ui_cubit/patient_info_ui_cubit.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<ThemeProvider>(() => ThemeProvider());
  getIt.registerLazySingleton<AuthValidateCubit>(() => AuthValidateCubit());
  getIt.registerLazySingleton<PatientInfoUiCubit>(() => PatientInfoUiCubit());
  getIt.registerLazySingleton<SharedPrefHelper>(() => SharedPrefHelper());
  getIt.registerLazySingleton<FavoriteCubit>(
    () => FavoriteCubit(initialValue: false),
  );
  getIt.registerLazySingleton<ChangeLanguageCubit>(
    () => ChangeLanguageCubit(SharedPrefHelper()),
  );
  getIt.registerLazySingleton<OtpRepoImpl>(() => OtpRepoImpl());
  getIt.registerLazySingleton<ForgetPasswordRepo>(() => ForgetPasswordRepo());

  getIt.registerLazySingleton<Api>(() => Api());
  getIt.registerLazySingleton<HiveHomeLocalStorge>(
    () => HiveHomeLocalStorge(
      getIt<Box<HiveDepartmentModel>>(),
      getIt<Box<HiveDoctorModel>>(),
    ),
  );
  getIt.registerLazySingleton<HomeRepoImpl>(() => HomeRepoImpl());
  getIt.registerLazySingleton<ArticleRepoImpl>(() => ArticleRepoImpl());
  getIt.registerLazySingleton<BookAppointmentRepoImpl>(
    () => BookAppointmentRepoImpl(),
  );
}
