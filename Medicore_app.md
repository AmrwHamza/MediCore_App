# MediCore App — Technical Documentation & Knowledge Transfer

> This document is written so a **new developer or another AI** can fully understand, modify, and defend the MediCore Flutter project **without any verbal explanation**.
> Everything here is taken from the **actual source code** of this repository. Nothing is invented. Where a reason is inferred (not written in code), it is marked with: **بحسب implementation الحالي** (meaning "according to the current implementation").

---

## 1. Project Overview

| | |
|---|---|
| **Project Name** | MediCore App (`medicore_app`) |
| **Type** | Medical / health-care booking Flutter application (appointments, doctors, articles, family, medical analyses) |
| **Languages** | English (LTR) + Arabic (RTL) — full localization |
| **Backend** | Laravel-style REST API, run locally at `http://127.0.0.1:8000` |
| **Flutter SDK** | `^3.7.2` |
| **State Management** | `flutter_bloc` (Cubits) + `provider` (for `ThemeProvider`) |
| **DI** | `get_it` |
| **Navigation** | `go_router` |
| **Local Storage** | `Hive` (structured cache) + `SharedPreferences` (session / small data) |
| **Count of feature folders** | 16 (`lib/features/`) |

The app is a medical appointment & wellness platform: the patient registers/logs in (with OTP), fills medical profile info, browses departments & doctors, rates doctors, books appointments (optionally for a child), uploads medical-analysis PDF files with progress, reads medical articles, and views notifications.

---

## 2. Project Architecture

The project uses a **feature-first layered architecture**. Every feature under `lib/features/<feature>/` is split into the standard clean-architecture layers:

```
feature/
├── presentation/
│   ├── view/            → Screens + widgets (stateless/stateful)
│   ├── view_model/      → Cubits + States (state management)
│   └── view/widgets/    → Screen sub-widgets
├── domain/
│   ├── entities/        → Pure business models
│   └── repos/           → Abstract repository contracts
└── data/
    ├── models/          → JSON models (fromJson/toJson)
    ├── repo/            → Repository implementations (network + cache)
    └── mapper/          → Entity <-> Model mappers
```

**Core building blocks (in `lib/core/`):**

- `main.dart` → app bootstrap & global providers.
- `core/helper/router.dart` → **single** `GoRouter` instance with all routes.
- `core/utils/api_services.dart` → the `Api` class (Dio wrapper).
- `core/utils/errors/failure.dart` → `Failure` hierarchy.
- `core/helper/shared_pref.dart` → `SharedPrefHelper` + `SharedPrefKeys`.
- `core/helper_function/get_it_service.dart` → `setup()` registers all singletons.
- `core/helper_function/hive_service.dart` → `initHive()` opens boxes.
- `core/helper_function/app_cache_service.dart` → TTL-based JSON cache over Hive.
- `core/helper_function/cache_sync_service.dart` → offline→online re-sync.
- `core/theme/theme.dart` + `core/theme/theme_provider.dart` → light/dark themes.
- `constants.dart` → base URLs + the full color palette.

**App startup sequence (`lib/main.dart`):**

```
main()
 ├─ WidgetsFlutterBinding.ensureInitialized()
 ├─ SharedPrefHelper().init()                // load prefs
 ├─ EasyLocalization.ensureInitialized()
 ├─ ThemeProvider().init()                   // read saved dark/light
 ├─ Bloc.observer = CounterObserver()
 └─ runApp(EasyLocalization( ... ChangeNotifierProvider(ThemeProvider)
        └─ ScreenUtilInit(designSize 390x844, minTextAdapt, splitScreenMode)
             └─ MediCoreApp
                  └─ MultiBlocProvider (global cubits)
                       └─ ConnectivityWatcher
                            └─ MaterialApp.router(routerConfig: router)
```

Notes (بحسب implementation الحالي):
- Global cubits created at the root: `PatientInfoCubit`, `ChildrenInfoUiCubit`, `PatientInfoUiCubit`, `ChildrenInfoCubit`, `LogoutCubit`, `AppointmentsCubit`, `AppointmentsTabCubit`, `ProfileImageCubit` (fires `getProfileImage()` immediately).
- `ConnectivityWatcher` listens to `connectivity_plus`; when connection returns after being offline it calls `getIt<CacheSyncService>().syncAll()`.
- `initHive()` and `Firebase.initializeApp()` run inside the Splash screen, not `main()`.

---

## 3. Dependencies & Packages

> Table columns: **Package** | **الاستخدام (Usage)** | **أين يستخدم (Where)** | **لماذا استخدمناه (Why)** | **لماذا لم نستخدم بديل (Why not the alternative)**

| Package | الاستخدام | أين يستخدم | لماذا استخدمناه | لماذا لم نستخدم بديل |
|---|---|---|---|---|
| `flutter_bloc` | State management (Cubit) | All features' `view_model/` | Predictable, testable, well-known | Riverpod/GetX: heavier divergence from team's known pattern |
| `provider` | ChangeNotifier for theme | `main.dart`, theme toggles | Simple reactive for single notifier | Bloc is overkill for theme |
| `get_it` | Service locator / DI | `get_it_service.dart` + all repos | No BuildContext needed in repos/cubits | manual singletons: not testable, no lazy init |
| `go_router` | Declarative routing | `core/helper/router.dart` | Route constants, `state.extra` args, deep linking | Named routes (`Navigator.pushNamed`): no deep-linking, messy args |
| `dio` | HTTP client | `core/utils/api_services.dart` | Interceptors, upload progress (`onSendProgress`), cancel tokens | `http`: no progress/cancel/interceptor built-in |
| `dartz` | `Either<Failure, T>` functional errors | All repos return `Future<Either<...>>` | Explicit error channel | `Result` custom class: reinventing |
| `easy_localization` | en/ar + RTL + live switching | Every screen (`.tr()`) | Built-in locale switching + delegates | `intl` alone: manual RTL handling & switching |
| `hive` + `hive_flutter` | Fast NoSQL local DB | Departments/Doctors/Appointments boxes + `app_cache` | No codegen adapters needed (manual adapters), fast | sqflite: SQL overhead; shared_prefs: only primitives |
| `shared_preferences` | Small key-value | `SharedPrefHelper` (token, profile, BMI, water) | Synchronous-feeling simple storage | Hive for tiny keys: overkill |
| `firebase_core` + `firebase_messaging` | Notifications | `main.dart`, splash, `notification` feature | FCM for push notifications | OneSignal: adds 3rd party |
| `flutter_screenutil` | Responsive sizing | Everywhere (`.w/.h/.r/.sp`) | Fixed design size 390x844 | MediaQuery only: verbose |
| `flutter_datetime_picker_plus` | Date picker (birth date) | `birth_date_card.dart` | Localized date picker (en/ar) | Material showDatePicker: no Arabic locale built-in |
| `flutter_pdfview` | PDF preview | `pdf_viewer_screen.dart` | Native PDF rendering | image preview only: can't show PDFs |
| `file_picker` | File selection (upload) | `upload_section.dart` | Cross-platform file picking with filters | image_picker: files only |
| `image_picker` + `image_cropper` | Profile image pick/crop | `drawer`, profile widgets | Camera + gallery + crop | file_picker: no camera |
| `flutter_rating_bar` | Star rating UI | `doctor_rating_section.dart` | Ready star widget | Custom: unnecessary work |
| `percent_indicator` | Circular/linear progress | `bmi_card.dart`, upload cards | BMI ring + upload progress | Custom painter: extra code |
| `dots_indicator` | Page indicator | `on_boarding_view_body.dart` | Customizable dots/pills | Manual dots row: extra code |
| `table_calendar` | Calendar widget | `calender_section.dart` (booking) | Full-featured calendar | Custom month grid: time |
| `timeline_tile` | Timeline | `child_details_view` (family) | Timeline for child history | Custom painter: unnecessary |
| `flutter_animate` | Quick animations | various widgets | Declarative animation chaining | Manual controllers: verbose |
| `flutter_spinkit` | Loading spinners | Loading states | `SpinKitThreeBounce` etc. | CircularProgressIndicator: boring in some spots |
| `shimmer` | Loading skeletons | `loading_shimer_list.dart`, home skeletons | Premium loading UX | plain progress: less "wow" |
| `lottie` | JSON animations | confirmation dialogs (`AppLottie.logout`) | Rich dialog animations | GIF: heavy; video: no |
| `cached_network_image` | Network images cache | doctor/department cards, article cards | Caching + placeholder + loading | Image.network: no cache |
| `connectivity_plus` | Network detection | `ConnectivityWatcher` in `main.dart` | Offline detection → cache sync | dio interceptor only: no stream |
| `flutter_svg` | SVG rendering | splash logo, assets | Crisp logos at any size | PNG: blurry on scale |
| `font_awesome_flutter` | Icons | drawer, misc | Free extra icons | Material icons: limited set |
| `logger` | Pretty debug logs | `logger_helper.dart` | Colorized logs | print: no levels |
| `pretty_dio_logger` | Dio request logs | `api_services.dart` (dioLoggerInterceptor) | HTTP debugging | Manual print interceptor: work |
| `intl_phone_field` | Phone input | auth/create account | Phone-code picker + validation | TextField manual: easy to break |
| `modal_progress_hud_nsn` | Full-screen blocker | loading overlays | Blocks interaction during loads | Custom: boilerplate |
| `url_launcher` | Open links | article details | Open external links | WebView: heavy |
| `equatable` | Equality for states/models | States & entities | Value equality | Manual ==: boilerplate |
| `freezed_annotation` + `freezed` (dev) | Immutable states codegen | Cubit states (`*.freezed.dart`) | Immutable, copyWith generated | Manual states: error-prone |
| `flutter_launcher_icons` (dev) | App icon gen | pubspec `flutter_launcher_icons` | Generate icons | Manual asset swap: time |
| `build_runner` (dev) | Codegen | run for freezed | Generates `.freezed.dart` | — |
| `flutter_lints` (dev) | Lints | analysis_options | Standard linting | custom lints: time |

---

## 4. Features Overview

| # | Feature folder | Route | What it does |
|---|---|---|---|
| 1 | `splash` | `/splash` | Logo animation, initialize Hive/Firebase, decide next screen by token |
| 2 | `on_boarding` | `/OnBoarding` | 2-page intro with animated CTA |
| 3 | `onboarding_medical_info` | `/medical-info`, `/children-info` | Patient & children medical profile (age auto-calc) |
| 4 | `auth` | `/firstPageAuth`, `/createAccount`, `/login`, `/otp`, `/forget_password`, `/back-page` | Register/Login/OTP/Forget password/Logout |
| 5 | `main_home` | `/mainHome` | Bottom-nav shell (Home, Articles, [FAB], Appointments, Family) |
| 6 | `home` | `/home`, `/doctorDetails`, `/departmenDetails` | Dashboard: departments, doctors, wellness (BMI, water, mood) |
| 7 | `doctors` | `/doctors-view` | Doctors list + search |
| 8 | `departments` | `/departments_view` | Departments list + search |
| 9 | `appointments` | `/appointments`, `/appointment-details`, `/appointment-archive` | Appointments tabs, details, medical analysis upload/preview, archive |
| 10 | `book_appointment` | `/book-appointment` | Multi-step booking (patient, symptoms, dept, doctor, date, payment) |
| 11 | `payment` | `/payment` | Payment methods (list + add) |
| 12 | `articles` | `/articles`, `/articlesDetails`, `/articlesFavorites` | Medical articles + favorites |
| 13 | `notification` | `/notification` | Notifications (FCM) |
| 14 | `family` | `/family`, `/childDetails` | Family members (children) + per-child history |
| 15 | `drawer` | (part of `/mainHome`) | Profile image, dark mode, language, favorites, archive, payments, logout |
| 16 | `profile` | `/profile`, `/editProfile-vieww`, `/patientProfile-vieww`, `/changePassword` | Edit profile, patient medical profile, change password |

---

## 5. Authentication Feature

Located in `lib/features/auth/` (sub-features: `first_page`, `login`, `create_account`, `OTP`, `forget_password`, `logout`).

### 5.1 First Page (`/firstPageAuth`)
- `FirstPageAuth` shows a language `DropDown` (en/ar) and entry points to Login / Create account.
- Language change handled by `ChangeLanguageCubit` (registered in `get_it`) which calls `changeLanguage(context, Locale('ar'|'en'))`.

### 5.2 Login
- `LoginView` → `LoginCubit` → `LoginRepoImpl` → `Api.post(endPoint: 'auth/login', data)`.
- On success the returned **token is stored in `SharedPrefKeys.userToken`** (via `SharedPrefHelper`).
- Validation of inputs is done by the shared `AuthValidateCubit` (registered globally in `get_it_service.dart`).

### 5.3 Create Account
- `CreateAccount` → `create_account_repo_imp` → `Api.post(endPoint: 'auth/register', data)`.
- Uses `intl_phone_field` for phone input with country code.

### 5.4 OTP (verification)
- `OTPView` (route `/otp`) receives `extra: {'isForgetPassword': bool}` from the router.
- `OtpRepoImpl`:
  - `GET resendCode` (with auth) to resend.
  - `POST varify` to verify the code.
- `custom_dowm_timer.dart`: a countdown timer drawn as a circular `CircularProgressIndicator` (percentage = seconds / totalDuration).

### 5.5 Forget Password
- `ForgetPasswordView` → `ForgetPasswordRepo` → `POST password/request`.
- `BackPageView` (`/back-page`) is the success/feedback page.

### 5.6 Logout
- `LogoutCubit` → `LogoutRepo` → `POST auth/logout`.
- On `LogoutSuccess`: `SharedPrefHelper.removeData(SharedPrefKeys.userToken)` then `context.go(FirstPageAuth.routeName)`.
- Confirmed via `showConfirmationDialog(lottie: AppLottie.logout, ...)`.

**Important auth facts for the demo:**
- The app considers the user logged-in **if `SharedPrefKeys.userToken` is non-empty** (checked in `splash_view_body.dart`).
- All protected API calls inject `Authorization: Bearer <token>` (see `Api.postWithAuth/getWithAuth/...`).

---

## 6. Home / Dashboard Feature

Located in `lib/features/home/`.

- `HomeView` (`/home`) → `home_view_body.dart`:
  - `WelcomeCard` (greets the user),
  - Health widgets row: `BmiCard`, `WaterTrackerCard`, `SmartWellnessMoodCard`,
  - Departments horizontal list (`DepartmentCubit`), Doctors list (`DoctorsCubit`) via `MultiBlocProvider`.
- `HomeRepoImpl` endpoints:
  - `GET department` — list of departments,
  - `GET doctor` — list of doctors,
  - `GET doctor/$doctorId` — single doctor details,
  - `GET department/doctor/$departmentId` — doctors of a department.
- **Hive caching:** `HomeRepoImpl` stores departments & doctors in Hive boxes (`departments`, `doctors`) through `HiveHomeLocalStorge` and reads from cache when the network fails.
- Doctor/department cards use **local asset images** picked by index (`Assets.departmentsImages[index]`, `doctorsImages[index % doctorsImages.length]`) — بحسب implementation الحالي: the visual image is decorative and not necessarily the server image.

### Wellness widgets (all in `lib/features/home/presentation/view/widgets/health_widgets/`)
- `bmi_card.dart` → see section 10.
- `water_tracker_card.dart` → glass-of-water counter, persisted in `SharedPrefKeys.waterTrackerGlasses` and reset by date stored in `SharedPrefKeys.waterTrackerDate`.
- `smart_wellness_mood_card.dart` → runs `PatientWellnessAlgorithm.compute(...)` locally (see section 10).

---

## 7. Doctors Feature (incl. Doctor Rating)

Located in `lib/features/doctors/` + rating in `lib/features/home/`.

- `DoctorsView` (`/doctors-view`): list of all doctors with **search** (`searchDoctors` endpoint via `DoctorsViewRepoImpl`).
- Search UI: `custom_search_field` + sticky search header (`search_header_delegate`).
- `DoctorDetailsView` (`/doctorDetails`): pushed with a **slide transition** (see section 11).
- `doctor_rating_section.dart` + `DoctorRateCubit`:
  - `GET getDoctorRate/$doctorId` — fetch user's current rate (parses `data` as number or map keys `rate/value/rate_value/avg`),
  - `POST addDoctorRate/$doctorId` — body `{'rate': rate}`,
  - `PUT updateDoctorRate/$doctorId`,
  - `DELETE deleteDoctorRate/$doctorId`.
  - UI uses `flutter_rating_bar`; submit button disabled while `isSubmitting` or no star selected.
- `DoctorCard` (`doctor_card.dart`) shows doctor info + image.

**Demo talking point:** rating flow = fetch → star select → `addDoctorRate` (or `updateDoctorRate` if already rated) → snackbar with server message.

---

## 8. Appointments Feature (incl. "Automatic Focus")

Located in `lib/features/appointments/`.

### 8.1 Lists & tabs
- `AppointmentsView` (`/appointments`, `extra: {'tab': int}`) → `AppointmentsTabCubit` controls tabs: **Accepted / Waiting / Incomplete** (status pages `accepted_page.dart`, `waiting_page.dart`, `incomplete_page.dart`).
- Status model: `appointment_types.dart` defines enum `AppointmentTypes { pending, accepted, incomplete, complete }` + converters `fromAppointmentTypesToApiString` / `fromStringToAppointmentTypes`.
- `AppointmentArchiveView` (`/appointment-archive`) shows archived appointments.

### 8.2 Appointments repository (`appointments_repo_impl.dart`)
- `GET getAppointments` — server list; success → also **caches accepted+waiting into Hive** (`AppointmentsLocalDataSourceImpl`).
- `getCachedAppointments()` — read from Hive; returns `CacheFailure` if empty.
- `GET getPreviews` — previews list; **cached in `AppCacheService`** under key `getPreviews` with `allowStale: true`.
- `DELETE deleteAppointment/$appointmentId`.
- `POST postMedicalAnalysis/$previewId` — multipart upload with progress (see 8.4).
- `GET getMedicalAnalysis/$previewId` — list analyses.
- `DELETE deleteMedicalAnalysis/$medicalId`.

### 8.3 Appointment details
- `AppointmentDetailsView` (`/appointment-details`, `extra: PrivewEntity`).
- Sub-widgets: doctor details section, appointment info rows, `AppointmentDoctorRating`, `medical_background_painter` (CustomPainter), medication items, and the `UploadSection`.

### 8.4 Medical analysis upload ("Upload section")
- **Gating logic** (بحسب implementation الحالي):
  - `canUploadMedicalAnalysis(entity)` → true when `diagnoseisType == 0` (partial/incomplete diagnosis) → upload allowed.
  - `isCompletedDiagnosis(entity)` → true when diagnosis completed → upload **read-only** (`readOnly: true`) if complete.
  - If neither → the section is hidden (`SizedBox.shrink()`).
- `_pickAndUpload`: `FilePicker` (custom type, **only `pdf`** allowed), validates `.pdf` extension + size ≤ **20 MB** (`_maxSizeBytes = 20 * 1024 * 1024`).
- `PreviewUploadCubit.upload(...)`:
  - builds `FormData.fromMap({'file': MultipartFile.fromFile(path)})`,
  - calls `postWithAuth(isMultipart: true, onSendProgress: ...)`,
  - progress = `(sent / total).clamp(0, 1)` emitted into state → `UploadAnalysisCard` shows a `LinearProgressIndicator` / percent bar,
  - `CancelToken` + `cancelUpload()` to abort mid-upload,
  - on success shows `upload_success`; for children it **optimistically** adds a local model (id=0) without re-fetching; for adults it re-fetches the analyses list.
- Files are **grouped by category** (`_buildSection`), with per-file view / replace / delete actions.
- `_resolveUrl`: if the file URL is relative, it is prefixed with `base` (`http://127.0.0.1:8000`).

### 8.5 File preview
- `PdfViewerScreen` (`core/widgets/pdf_viewer_screen.dart` + a copy in appointments): opens a PDF from URL using `flutter_pdfview`, with loading/error/download handling.

### 8.6 The "Automatic Focus" mechanics (auto-scroll on selection)
Inside `book_appointment`'s widgets (`book_appointment_view_body.dart` is a **single `SingleChildScrollView` with no page-level ScrollController** — the auto-scrolling happens on the **inner lists**):

- `doctor_section.dart`: has its own `ScrollController` and `_scrollToSelected(index, totalItems)`; when the user selects a doctor (tap on card or its index), it calls `_scrollController.animateTo(...)` to **center the selected doctor** in the horizontal list.
- `department_section.dart`: identical pattern to center the selected department.
- `calender_section.dart`: `_scrollToTimeSection()` — when a **date is selected**, it `animateTo`s the inner time-slots list so the available times come into view automatically.

So the "automatic focus" = the UI **auto-scrolls to the relevant sub-section** when a parent choice is made (date → time slots; card → selected item centered).

---

## 9. Patient Data & Automatic Age Calculation

Located in `lib/features/onboarding_medical_info/`.

### 9.1 Screens
- `PatientInfoView` (`/medical-info`) — adult patient info.
- `ChildrenInfoView` (`/children-info`) — add/edit children medical info.

### 9.2 Cards
- `birth_date_card.dart`: opens `DatePicker.showDatePicker` (`flutter_datetime_picker_plus`) with `minTime: DateTime(1900,1,1)`, `maxTime: DateTime.now()`, locale = `ar`/`en` per current app locale.
- **Age auto-calculation** on confirm:
  ```dart
  int _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age < 0 ? 0 : age;
  }
  ```
  Then `childCubit.updateBirthDate(date); childCubit.updateAge(calculatedAge);` (or the patient cubit).
- `age_card.dart`: shows the calculated age with the label `years_old` (e.g. "25 سنة"); **before** a birth date exists it shows `calculated_automatically` ("يُحسب تلقائياً") with an `auto_calculated` badge. (No manual age input — the age is derived from the birth date.)
- `gender_card.dart`, `blood_type_card.dart` — selection cards.
- `yes_no_question.dart` — yes/no answers for allergies, chronic diseases, medications, surgeries, illnesses.

### 9.3 Cubits — the "UI adapter" pattern
There are **two layers** of cubits:
- `PatientInfoCubit` / `ChildrenInfoCubit` → the **API layer** (send to server).
- `PatientInfoUiCubit` / `ChildrenInfoUiCubit` → the **UI layer** (form state, temp selections).
- Folder `presentation/view_model/Handler Questions/` contains adapters: `patient_ui_adapter.dart`, `children_ui_adapter.dart`, `info_ui_handler.dart` — they map UI state ↔ API payloads (بحسب implementation الحالي: this decouples "what the user is filling" from "what gets sent").

### 9.4 Repository (`medical_repo.dart`)
- `POST pateintProfile` — save patient medical profile.
- `POST addChild` — add child.
- `DELETE deleteChild/$id`.

### 9.5 Persisted profile keys (SharedPrefKeys)
`birthDate`, `age`, `gender`, `bloodType`, `medicationAllergies`, `chronicDiseases`, `permanentMedications`, `previousSurgeries`, `previousIllnesses` (+ `firstname`, `lastname`, `email`, `phone`).

---

## 10. BMI Calculator (+ Wellness Score)

### 10.1 BMI (`bmi_card.dart`)
- Height & weight sliders/fields, defaults `170` / `70`.
- Persisted: `SharedPrefKeys.bmiHeight`, `SharedPrefKeys.bmiWeight`.
- Formula: `bmi = weight / ((height/100) * (height/100))`.
- Categories (local, no backend):
  | BMI | Category | Color |
  |---|---|---|
  | < 18.5 | underweight (`bmi_underweight`) | `KInfo` |
  | 18.5 – 24.9 | normal (`bmi_normal`) | `KSuccess` |
  | 25 – 29.9 | overweight (`bmi_overweight`) | `KWarning` |
  | ≥ 30 | obese (`bmi_obese`) | `KError` |
- Result shown in a ring via `percent_indicator` (`value: (bmi / 40).clamp(0,1)`) with an `AnimationController` (600ms fade + `elasticOut` scale) replaying on each calculate.

### 10.2 Wellness score (`patient_wellness_algorithm.dart`)
A **pure local algorithm** — no backend. Inputs: `bmi`, `hasUpcomingAppointment`, `hasCompletedAppointment`, `medicalProfileFields` (count of filled profile fields, max 8).

```
appointmentScore: upcoming = 40 | completed = 22 | none = 8
careScore:        filled==0 → 6 ; else (filled/8 * 30).clamp(6,30)
bmiScore:         healthy BMI → 30 | near healthy → 20 | else 10 | no data → 15
score = (appointmentScore + careScore + bmiScore).clamp(0,100)
mood:  >=75 excellent (KSuccess) | >=45 good (KPrimaryColor) | else needsAttention (KWarning)
```

---

## 11. Animations System

| Animation | المكان (Where) | التقنية (Technique) | Trigger | المدة (Duration) | الهدف (Goal) |
|---|---|---|---|---|---|
| Splash logo scale/fade/rotate | `splash_view_body.dart` | `AnimationController` (1800ms) + `Tween` scale 0.5→1 (`elasticOut`), fade 0→1 (`easeIn`), rotation -0.05→0 (`easeOut`) | `initState` → `_controller.forward()` | 1800 ms | Elegant branded intro |
| Splash "lines" SVG mask fade | same | `FadeTransition` + nested `ShaderMask` | same controller | 1800 ms | Gradient-masked background texture |
| Onboarding page slide | `on_boarding_view_body.dart` | `PageController.nextPage` | Next CTA tap | 500 ms, `Curves.easeInOutCubic` | Page transition |
| Onboarding background circles | same | `AnimatedContainer` (position top-right / bottom-left) | page change (`currentPage`) | 600 ms | Color shift between pages (cyan/teal → purple) |
| Onboarding skip button opacity | same | `AnimatedOpacity` + `IgnorePointer` | page change | 300 ms | Fade skip in on page 0, hide on page 1 |
| Onboarding CTA morph (arrow → "Get Started") | same | `AnimatedContainer` (width 64→160) + `AnimatedCrossFade` | page change | 300 ms (width) / 250 ms (crossfade) | Arrow expands into text button; gradient cyan→purple |
| Router push slide | `router.dart` `_slideTransition` | go_router `CustomTransitionPage` + `SlideTransition` (Offset 1,0 → zero) | navigate to `DoctorDetailsView` | default | Slide-in from right |
| Birth date card border/shadow | `birth_date_card.dart` | `AnimatedContainer` | date selected | 200 ms | Highlight selected state |
| BMI result reveal | `bmi_card.dart` | `AnimationController` (600ms) + Fade + `elasticOut` scale | "Calculate" pressed | 600 ms | Result pop-in |
| Countdown ring | `custom_dowm_timer.dart` | `CircularProgressIndicator` value = seconds/total | OTP screen | per second | Visual time remaining |
| Article card custom shape | `article_card.dart` | `CustomPainter` (`MedicalGridAndPulsePainter`) | build | n/a | Styled article card |

---

## 12. How Navigation Animations Work

- **Routing** uses `go_router` (one `GoRouter` in `core/helper/router.dart`).
- Most routes are plain `builder: (_, state) => Screen(...)` → they use **Flutter's default page transition**.
- The **only custom transition** is `_slideTransition`, used for `DoctorDetailsView`:
  ```dart
  CustomTransitionPage(
    child: child,
    transitionsBuilder: (context, animation, _, child) =>
      SlideTransition(
        position: Tween<Offset>(begin: Offset(1,0), end: Offset.zero).animate(animation),
        child: child,
      ),
  );
  ```
- **Arguments** are passed via `state.extra` (e.g., `Map<String,dynamic>`, `PrivewEntity`, `ArticleEntity`, `ChildEntity`) and read in the builder.
- **Screen-level animations** are *not* router animations: Splash uses an `AnimationController`; Onboarding uses `PageController` + `Animated*` widgets driven by `currentPage` state (see table in section 11).

---

## 13. How to Animate Existing Widgets in This Project

General pattern used everywhere here (بحسب implementation الحالي):

1. **Simple property change → `AnimatedContainer` / `AnimatedOpacity` / `AnimatedCrossFade`** (state-driven, no controller):
   ```dart
   AnimatedContainer(duration: Duration(milliseconds: 300),
     width: condition ? 160 : 64, ...)
   ```
2. **Appear/disappear → `AnimatedOpacity` + `IgnorePointer`** (keep it interactive only when visible).
3. **Swap two children → `AnimatedCrossFade`** (e.g., arrow ↔ "Get Started").
4. **Progress/rings → `percent_indicator` + `TweenAnimationBuilder`** (e.g., BMI ring, upload bar, OTP countdown).
5. **Complex/chained animations → `AnimationController`** with `SingleTickerProviderStateMixin`, `CurvedAnimation`, `Tween` (Splash, BMI result).
6. **Navigation entry → `CustomTransitionPage`** in the router (`_slideTransition`).
7. **Repeatable little things → `flutter_animate`** (already a dependency).

To animate a new widget, pick the simplest tool from the list above; only add an `AnimationController` when you need coordinated multi-property animation with `forward(from: 0)`.

---

## 14. Onboarding Feature

Located in `lib/features/on_boarding/` (route `/OnBoarding`).

- `OnBoardingViewBody` (StatefulWidget):
  - `PageController pageController` + listener → `currentPage = pageController.page!.round()` (setState) drives all animations.
  - `WidgetsBinding.instance.addPostFrameCallback` → `ImageCacheHelper.cacheOnboardingImages(context)` pre-warms images.
  - Background: two `AnimatedContainer` circles (top-right, bottom-left) with radial gradients that switch color by page (cyan/teal ↔ purple).
  - **Skip button** (top-right, only visible on page 0): `AnimatedOpacity` + `IgnorePointer`, `onPressed → context.go(FirstPageAuth.routeName)`.
  - `OnBoardingPageView(pageController)` — a `PageView` with **2 pages** (`FirstPage`, `SecoundPage` — the second one has a typo in the class name; kept as-is بحسب implementation الحالي).
  - **Dots indicator**: `DotsIndicator(dotsCount: 2, position: currentPage)`, active dot is a pill `24×8`, inactive `8×8`; active color cyan (page 0) / purple (page 1).
  - **CTA button**: morphs from a circular arrow (64×64, RTL-aware icon: `arrow_back_rounded` when RTL, else `arrow_forward_rounded`) into a wide "Get Started" pill (160×64) using `AnimatedContainer` + `AnimatedCrossFade`; gradient `[primaryColor, KCyan]` → `[KPrimaryColor, purple.shade400]`.
  - Page 0 → `pageController.nextPage(duration: 500ms, curve: easeInOutCubic)`; Page 1 → `context.go(FirstPageAuth.routeName)`.

---

## 15. Medical Analyses / Lab Results

- Shown in `AppointmentDetailsView` under the `UploadSection` (see 8.4).
- Logic:
  - `isPartial = canUploadMedicalAnalysis(entity)` (diagnosis type 0) → **can upload/replace/delete**.
  - `isComplete = isCompletedDiagnosis(entity)` → **read-only** view (unless the view itself is not `readOnly`).
  - neither → hidden.
- Analyses are grouped by `category`; each file card shows `fileName`, `uploadedAt`, and actions (View / Replace / Delete).
- `_Loading` state while fetching; empty state shows `no_analysis_uploaded`.
- PDF-only; size limit 20 MB; URL resolution against `base` when relative.

---

## 16. File Preview

- `PdfViewerScreen` (`lib/core/widgets/pdf_viewer_screen.dart`, and a copy under `appointment_details_widgets/pdf_viewer_screen.dart` that hides the imported snackbar symbols).
- Uses `flutter_pdfview` (`PDFView`).
- Flow: resolve URL → check `.pdf` → `Navigator.push(MaterialPageRoute → PdfViewerScreen(pdfUrl, title))`.
- Handles: loading indicator, error message (`_errorMessage`), download failure, page rendering errors.
- Non-PDF selection is rejected with `only_pdf_supported`.

---

## 17. File Upload

`UploadSection` → `PreviewUploadCubit.upload(...)` → `AppointmentsRepoImpl.uploadMedicalAnalysis(...)`:

1. `FilePicker.pickFiles(type: FileType.custom, allowedExtensions: ['pdf'])`.
2. Validate `.pdf` extension + size ≤ 20 MB (`file_too_large` error otherwise).
3. Build `FormData`:
   ```dart
   FormData.fromMap({
     'file': await MultipartFile.fromFile(file.path, filename: fileName),
   });
   ```
4. `Api.postWithAuth(endPoint: 'postMedicalAnalysis/$previewId', data: formData, isMultipart: true, onSendProgress: ..., cancelToken: ...)`.
5. On success parse response with `_readUploadedFile` (looks for `file_url/fileUrl/url/path/file_path/analysis_file/file` and name keys; also accepts a raw string path).
6. Adult → re-fetch list; child → optimistic local model (id 0).
7. Replace flow: `replaceOldId` → after successful upload, calls `_delete(replaceOldId)`.
8. Cancel: `CancelToken.cancel('User cancelled the upload')` + state reset + `upload_cancelled` message.

---

## 18. Upload Progress

- `postWithAuth` accepts `onSendProgress: (sent, total)`. In `PreviewUploadCubit`:
  ```dart
  onSendProgress: (sent, total) {
    if (total <= 0) return;
    final progress = (sent / total).clamp(0.0, 1.0);
    emit(state.copyWith(isUploading: true, progress: progress));
  }
  ```
- UI: `UploadAnalysisCard` displays the progress (linear bar / percent) while `state.isUploading`.
- On completion state emits `progress: 1` and success feedback `upload_success`; on failure resets progress to 0 and shows `failure.message`.
- Also an active upload row is rendered at the top of the list in `_buildList` with a cancel button.

---

## 19. API Integration

Base URL: `base = "http://127.0.0.1:8000"`, `baseurl = "$base/api/"`, images: `baseurlImg = '$base/storage/project'`.

Auth header: `Authorization: Bearer <token>` (from `SharedPrefKeys.userToken`). Every `*WithAuth` call auto-adds the current `lang` (from `Intl.getCurrentLocale()`) — in the body for `postWithAuth` (except multipart) and in the query for `getWithAuth`.

| Feature | Endpoint | Method | Where (repo) | Notes |
|---|---|---|---|---|
| Login | `auth/login` | POST | `login_repo_impl.dart` | returns token → saved in prefs |
| Register | `auth/register` | POST | `create_account_repo_imp.dart` | |
| Verify OTP | `varify` | POST | `otp_repo_impl.dart` | |
| Resend code | `resendCode` | GET | `otp_repo_impl.dart` | with auth |
| Forget password | `password/request` | POST | `forget_password_repo.dart` | |
| Logout | `auth/logout` | POST | `logout_repo.dart` | |
| Patient profile | `pateintProfile` | POST | `medical_repo.dart` | (typographic endpoint, as-is) |
| Add child | `addChild` | POST | `medical_repo.dart` | |
| Delete child | `deleteChild/$id` | DELETE | `medical_repo.dart` | |
| Departments | `department` | GET | `home_repo_impl.dart` / `departments_view_repo_impl.dart` | Hive-cached |
| Search departments | `searchDepartments` | POST | `departments_view_repo_impl.dart` | |
| Doctors | `doctor` | GET | `home_repo_impl.dart` / `doctors_view_repo_impl.dart` | Hive-cached |
| Search doctors | `searchDoctors` | POST | `doctors_view_repo_impl.dart` | |
| Doctor details | `doctor/$doctorId` | GET | `home_repo_impl.dart` | |
| Dept. doctors | `department/doctor/$departmentId` | GET | `home_repo_impl.dart` | |
| Get my rate | `getDoctorRate/$doctorId` | GET | `doctor_rate_repo_impl.dart` | |
| Add rate | `addDoctorRate/$doctorId` | POST | `doctor_rate_repo_impl.dart` | body `{'rate': n}` |
| Update rate | `updateDoctorRate/$doctorId` | PUT | `doctor_rate_repo_impl.dart` | body `{'rate': n}` |
| Delete rate | `deleteDoctorRate/$doctorId` | DELETE | `doctor_rate_repo_impl.dart` | |
| Appointments | `getAppointments` | GET | `appointments_repo_impl.dart` | Hive-cached |
| Previews | `getPreviews` | GET | `appointments_repo_impl.dart` | `AppCacheService` TTL |
| Delete appointment | `deleteAppointment/$appointmentId` | DELETE | `appointments_repo_impl.dart` | body `{}` |
| Upload analysis | `postMedicalAnalysis/$previewId` | POST | `appointments_repo_impl.dart` | multipart + progress |
| List analyses | `getMedicalAnalysis/$previewId` | GET | `appointments_repo_impl.dart` | |
| Delete analysis | `deleteMedicalAnalysis/$medicalId` | DELETE | `appointments_repo_impl.dart` | |
| Book appointment | `bookAppointment/$doctorId` | POST | `book_appointment_repo_impl.dart` | body: `appointment_date`, `son_id`, `payment_id` |
| Analyse symptoms | `symptom/analyze` | POST | `book_appointment_repo_impl.dart` | body `{'symptoms': [...]}` |
| Symptoms list | `getSymbtoms` | GET | `book_appointment_repo_impl.dart` | query `lang` (endpoint spelling as-is) |
| Articles (paginated) | `getArticlesApp?page=$page` | GET | `article_repo_impl.dart` | `AppCacheService` TTL per page + `_lastPage` tracked |
| Favorite articles | `getArticlesFav` | GET | `article_repo_impl.dart` | |
| Add fav | `addArticleFav/$articleId` | POST | `article_repo_impl.dart` | |
| Remove fav | `deleteArticleFav/$articleId` | DELETE | `article_repo_impl.dart` | |
| Notifications | `notifications` | GET | `notification_repo_impl.dart` | |
| Children list | `getChilds` | GET | `family_repo.dart` | |
| Child appointment | `getAppointmentById/$patientId` | GET | `family_repo.dart` | |
| Child previews | `getPreviews` | GET | `family_repo.dart` | |
| Update child | `updateChild/$childId` | POST | `family_repo.dart` | |
| Profile header info | `getProfileImage` / profile endpoints | GET | `drawer_repo_impl.dart`, profile repos | |
| Upload profile image | `uploadImagesForPatientProfile` | POST | `drawer_repo_impl.dart` | |
| Delete profile image | `deleteProfileImage` | DELETE | `drawer_repo_impl.dart` | |
| Update profile | `updateProfileInfo` / `updatePatientProfile` | POST | `edit_profile_repo_impl.dart` | |
| Change password | `updatePassword` | POST | `edit_profile_repo_impl.dart` | |
| Add payment | `postNewPayment` | POST | `payment_repo_impl.dart` | |
| List payments | `getPayments` | GET | `payment_repo_impl.dart` | |

**Response convention used across repos:** success responses are read as `Map<String,dynamic>`; most endpoints expect `data` to contain the payload (e.g., `data['data']`). Error responses are parsed by `getErrorMessage` (see section 20).

---

## 20. Error Handling

- **Every repository returns `Future<Either<Failure, T>>`** (dartz). Cubits `fold` on it.
- `Failure` hierarchy (`core/utils/errors/failure.dart`):
  | Class | Default message | When |
  |---|---|---|
  | `ServerFailure` | "Error $statusCode, $errorMessage" | `badResponse` |
  | `NetworkFailure` | "No Internet connection" | `connectionError` |
  | `TimeoutFailure` | "Connection timeout" | timeout types |
  | `UnknownFailure` | "Unknown error happened" / "no internet connection" (unknown type) | unknown / canceled |
  | `ValidationFailure` | "Invalid data provided" | badCertificate, or missing token |
  | `CacheFailure` | "Failed to cache ..." | local cache read/write failures |
- `Api.handleDioError(DioException)` maps every `DioExceptionType` to the right failure.
- `getErrorMessage(data)` robustly extracts messages from: `String`, `Map` with `message` (string or **map of field→list** e.g. Laravel validation), or `List`.
- **User-facing feedback:** `CustomSnackbar.show(context, message, type: error|success|warning)`.
- `Api.post` (public) wraps unexpected exceptions → `UnknownFailure`.

---

## 21. Loading States

- **Full-page loading:** `SpinKitThreeBounce(color: KPrimaryColor)` (booking button, logout, etc.).
- **List loading:** `shimmer` (`loading_shimer_list.dart`) and `home_skeletons.dart`.
- **Small/inline loading:** `CircularProgressIndicator` (`_Loading` in upload section, `custom_dowm_timer`).
- **Blocking overlay:** `modal_progress_hud_nsn` (`ModalProgressHUD`) for whole-screen blocking.
- **Cubit pattern:** each cubit emits a `...Loading` state first (e.g., `BookAppointmentLoading`, `GetDoctorsLoading`, `isAnalysesLoading` in upload state).

---

## 22. Empty States

- `empty_appointment_state.dart` — empty appointments list.
- `_EmptyReadOnly` in `upload_section.dart` — "no_analysis_uploaded" when read-only.
- Router `errorBuilder` — `page_not_found` for unknown routes.
- Lists that load from cache-on-failure may still show content even if the server call fails (offline-first).

---

## 23. Validation

- **Auth inputs:** shared `AuthValidateCubit` (email/password/phone validation used by login & register flows).
- **Upload:** `.pdf` extension check + `file.length() > 20MB` → `file_too_large` (and `only_pdf_supported`).
- **Birth date:** picker restricts `minTime: 1900` and `maxTime: now`; age computed cannot be negative (clamped to 0).
- **Booking:** the "Book Appointment" button requires `selectedDoctor != null`; otherwise a warning snackbar `select_doctor_message`.
- **Rates:** submit disabled while no star selected or while `isSubmitting`.

---

## 24. Localization

- **Package:** `easy_localization`; locales `en`, `ar`; fallback `en`; files in `assets/translations/`.
- **Startup:** `startLocale` from `prefs.languageCode` (validated against `['en','ar']`, default `en`).
- **Fonts:** `MaterialApp.theme.textTheme` applies `Tajawal` for Arabic and `RobotoSlab` for English.
- **All UI strings** use `.tr()` with keys like `'book_appointment'.tr()`, and parameters via `tr(namedArgs: {'age': ...})`.
- **Date picker locale** follows `context.locale.languageCode`.
- **Language switching** via `ChangeLanguageCubit.changeLanguage(context, Locale('ar'|'en'))` (from FirstPageAuth dropdown and Drawer dialog).
- **API language injection:** every `postWithAuth` body (non-multipart) and `getWithAuth` query gets `'lang': lang` where `lang = Intl.getCurrentLocale().split('_').first`.
- **RTL-aware UI:** arrow icons flip (`Directionality.of(context).name == 'rtl'`), and go_router pages are full-screen so RTL mirroring is automatic.

---

## 25. Theme & UI System

- **Theme source of truth:** `core/theme/theme.dart` exports `lightMode` & `darkMode` `ThemeData`.
- **Runtime switching:** `ThemeProvider` (`ChangeNotifier`, provided via `provider`): `changeTheme()` flips light/dark and persists via `pref.setDarkMode(bool)`; read back in `init()`.
- `MaterialApp.router` sets `themeMode: ThemeMode.system` and `theme` = provider's current theme (with per-locale font).
- **Color palette** (`constants.dart`): primary cyan `KPrimaryColor = 0xFF32B2CF` with light/extraLight/dark shades; semantic colors `KSuccess/KWarning/KError/KInfo` (+ `...Light`/`...Dark`); surface & background pairs for light/dark; text & border & divider pairs.
- **Typography:** `TextStyles` (`core/helper/text_styles.dart`) — `H2`, `public`, `notes` etc.
- **Responsive:** `flutter_screenutil`, design size **390×844**, `minTextAdapt: true`, `splitScreenMode: true`.
- **Shared UI widgets (`core/widget/`):** `custom_button.dart`, `custom_snack_bar.dart`, `custom_app_bar.dart`, `pdf_viewer_screen.dart`, etc.

---

## 26. Reusable Widgets

| Widget | Location | Purpose |
|---|---|---|
| `CustomButton` | `core/widget/custom_button.dart` | Main action buttons |
| `CustomSnackbar` | `core/widget/custom_snack_bar.dart` | Success/error/warning toasts |
| `CustomAppBar` | `core/widget/custom_app_bar.dart` | App bars (main bar flag) |
| `PdfViewerScreen` | `core/widget/pdf_viewer_screen.dart` | PDF preview |
| `TextStyles` | `core/helper/text_styles.dart` | Typography presets |
| `ConfirmationDialog` | `core/helper_function/confirmation_dialog.dart` | Lottie confirmation dialogs (logout etc.) |
| `ImageCacheHelper` | `core/helper/cache_images.dart` | Pre-cache onboarding/app images |
| `LoggerHelper` | `core/utils/logger_helper.dart` | Colored logs |
| `SectionHeader` / `CustomDivider` | `book_appointment/.../widgets/` | Booking step headers & dividers |
| `YesNoQuestion` | `onboarding_medical_info/.../widgets/` | Yes/No questions |

---

## 27. Navigation System

- One `GoRouter` (`core/helper/router.dart`), `initialLocation: SplashView.routeName` (`/splash`), `errorBuilder` → "page_not_found".
- Every screen declares `static const routeName = '/...'`; routes are referenced by that constant (single source of truth).
- **Navigating with arguments** via `context.push(route, extra: {...})` or `context.go(...)`:
  - `OTPView`: `extra: {'isForgetPassword': bool}`.
  - `AppointmentsView`: `extra: {'tab': int}`.
  - `AppointmentDetailsView`: `extra: PrivewEntity`.
  - `DepartmentDetailsView` / `ChildDetailsView` / `DoctorDetailsView` / `ArticleDetailsView`: `extra: Map` or entity.
  - `PaymentView`: `extra: {'isInSplashs': bool}`.
- **Returning values:** `context.push(BookAppointmentView.routeName).then((value) { if (value == true) appointmentsCubit.getAppointments(); })` — the booking screen pops `true` on success (see section 28).
- **Custom transition:** `_slideTransition` for `DoctorDetailsView` only.

---

## 28. Data Flow

### 28.1 Booking an appointment (end-to-end)
```
MainHomeView FAB
  → context.push(BookAppointmentView)      // /book-appointment
    → BookAppointmentViewBody (SingleChildScrollView of 6 sections)
      → ChildOrMeSelector (me or child)
      → SelectSymptomsSection (loads symptoms: GET getSymbtoms?lang=)
          → analyse via SymptomAnalysisCubit → POST symptom/analyze
      → DepartmentSection  (GET department, auto-scroll centers selection)
      → DoctorSection      (GET doctor, auto-scroll centers selection)
      → CalenderSection    (date pick; auto-scroll to time slots)
      → PaymentSection     (list payments; or add payment)
      → BookAppointmentCubit.bookAppointment(doctorId)
          → POST bookAppointment/$doctorId {appointment_date, son_id, payment_id}
          → Success → snackbar + context.pop(true)
  → .then(true) → AppointmentsCubit.getAppointments() refresh
```

### 28.2 Medical analysis upload (end-to-end)
```
AppointmentDetailsView → UploadSection
  → PreviewUploadCubit.initialize(previewId, isChild) → GET getMedicalAnalysis/$previewId
  → FilePicker → validate (.pdf, ≤20MB) → FormData
  → AppointmentsRepoImpl.uploadMedicalAnalysis → POST postMedicalAnalysis/$previewId
      onSendProgress → state.progress → UploadAnalysisCard progress bar
      CancelToken cancel → cancelUpload()
  → success: adult → reload analyses; child → optimistic local card
  → replace: upload then DELETE old id
```

### 28.3 Offline / cache flow
```
getAppointments (online) → server → cache accepted+waiting → Hive 'appointments'
getAppointments (offline) → Api returns Left → getCachedAppointments() → Hive
getPreviews → AppCacheService.put('getPreviews') (with __savedAtMs__)
getPreviews (offline) → AppCacheService.get(..., allowStale: true)
Reconnect → ConnectivityWatcher → CacheSyncService.syncAll()
              → getPrivews() + getAppointments() + getArticles(page:1)
```

### 28.4 BMI / wellness (local only)
```
BmiCard sliders → SharedPrefs(bmiHeight, bmiWeight)
  → BMI = weight/((h/100)^2) → category → percent ring
SmartWellnessMoodCard → bmi (from prefs) + appointments + profile fields
  → PatientWellnessAlgorithm.compute(...) → score + mood
```

---

## 29. Why We Did NOT Use Popular Solutions

| Common choice | Not used because | What we use instead |
|---|---|---|
| `http` package | No interceptors / upload progress / cancellation | `dio` |
| `GetX` for everything | Implicit magic, harder to reason/test in a big app | `flutter_bloc` + `provider` |
| Named routes (`Navigator.pushNamed`) | No typed deep links, args boilerplate | `go_router` + `state.extra` |
| `sqflite` | SQL overhead; we only need simple key/list caches | `hive` |
| Only `shared_preferences` for all data | Can't hold typed lists/maps efficiently | Hive for lists; prefs for small keys |
| `intl` only | No live locale switching / RTL handling | `easy_localization` |
| Material `showDatePicker` | No Arabic locale support out-of-the-box | `flutter_datetime_picker_plus` |
| Custom exception classes returned from repos | Implicit error channel; easy to forget handling | `dartz` `Either<Failure, T>` |
| `image_picker` alone for uploads | Can't pick arbitrary files (PDF) | `file_picker` + `image_picker` |
| Plain `CircularProgressIndicator` everywhere | Less polished loading states | `flutter_spinkit`, `shimmer`, `percent_indicator` |
| No cache (always hit server) | Poor offline UX, wasted calls | Hive + `AppCacheService` TTL + `CacheSyncService` |

---

## 30. Important Technical Decisions

1. **Feature-first + layered clean architecture** — boundaries make features replaceable and testable.
2. **`Either<Failure, T>` everywhere** — repos never throw; cubits always `fold` and map to snackbars.
3. **Token in SharedPreferences** (`userToken`) — simplest session carrier; splash decides the first screen purely from its presence.
4. **Automatic `lang` injection** on every authed request — the server gets the UI language without manual params.
5. **Multipart upload with `onSendProgress` + `CancelToken`** — real progress bar + cancellable long uploads.
6. **Upload gating by diagnosis state** (`canUploadMedicalAnalysis` / `isCompletedDiagnosis`) — prevents invalid uploads per business rule.
7. **Offline-first caching** — departments, doctors, appointments (Hive) and previews/analyses (TTL `AppCacheService`), re-synced on reconnect via `CacheSyncService`.
8. **Automatic age calculation from birth date** — age is never typed manually (see section 9).
9. **Local wellness/BMI computation** — no backend round-trip for the home dashboard score.
10. **UI-cubit ↔ API-cubit split** in medical info ("Handler Questions" adapters) — the form state and the wire format are decoupled.
11. **Auto-scroll UX in booking** — date pick scrolls to time slots; selecting a card centers it.
12. **RTL-aware animations/icons** — arrows flip via `Directionality`, onboarding adapts to RTL.

---

## 31. Demo / Presentation Guide

### Easy questions (anyone can answer)
- What is the project? — Medical booking app, Flutter + Laravel API (`127.0.0.1:8000`).
- How do you change the app language? — `ChangeLanguageCubit.changeLanguage` → easy_localization; strings via `.tr()`.
- How is dark mode handled? — `ThemeProvider` (provider) ↔ `ThemeData` light/dark, persisted in prefs.
- Where are departments/doctors loaded from? — `home_repo_impl.dart`, `GET department` / `GET doctor`, cached in Hive.
- How does the user log out? — `LogoutCubit` → `auth/logout`, then `removeData(userToken)` → go to `/firstPageAuth`.

### Medium questions
- How is age calculated? — in `birth_date_card.dart._calculateAge` (year diff, minus one if the birthday hasn't passed), stored via `updateAge`, shown in `age_card.dart` with an "auto_calculated" badge.
- How does the upload progress work? — `onSendProgress(sent, total)` → `(sent/total).clamp(0,1)` → state.progress → progress bar; cancellable with `CancelToken`.
- What is the offline strategy? — Hive boxes for departments/doctors/appointments + `AppCacheService` (TTL) for previews; `CacheSyncService.syncAll()` on reconnect.
- How does the booking screen auto-scroll? — inner `ScrollController.animateTo` in `doctor_section`/`department_section` (center selected) and `calender_section` (jump to time slots).
- How is navigation done? — `go_router`; routes referenced by `static const routeName`; args via `state.extra`.

### Hard questions
- Why `Either<Failure, T>`? — guarantees the error channel; no thrown exceptions; every cubit folds and shows `CustomSnackbar`.
- How does the wellness score work? — pure local `PatientWellnessAlgorithm.compute` (appointment + care + BMI sub-scores → clamp 0..100 → mood).
- How is the multipart upload resilient? — cancel token, size/type validation, optimistic card for children, replace-then-delete old file, re-fetch for adults, URL resolution.
- Why two cubit layers in medical info? — UI adapter pattern (`Handler Questions`) separates form state from the server payload.
- What's the difference between cache paths? — `Hive` boxes (typed lists, no expiry) vs `AppCacheService` (generic JSON map with `__savedAtMs__` TTL + `allowStale`).

---

## 32. What the Examiner Is Most Likely to Focus On

1. **Architecture layering** (feature-first, presentation/domain/data) and why.
2. **State management choice** (bloc cubits + provider) — and error handling with `Either`.
3. **Offline/caching** (Hive + TTL + reconnect sync) — "what happens with no internet?".
4. **Upload flow with progress & cancellation** — the strongest demo feature.
5. **Localization & RTL** (Arabic support, font switching, lang injection into API).
6. **Age auto-calculation** logic and the birth-date picker.
7. **Navigation with typed args** (`state.extra`) and custom transitions.
8. **The booking screen's auto-scroll UX** (inner `ScrollController.animateTo`).
9. **BMI / wellness algorithm** — pure functions, easy to explain.
10. **Theme system** (provider + persisted light/dark, ThemeMode.system).

---

## 33. Demo Flow (recommended order)

1. **Splash** → animated logo; note Hive+Firebase init timing and route decision by token.
2. **Onboarding** → swipe 2 pages; skip button; CTA morph animation; dots.
3. **Create account / Login** → OTP screen with countdown ring; note `userToken` saved.
4. **Medical profile** → pick birth date → age **auto-computed**; gender/blood type; yes/no questions; then add a child (children-info).
5. **Home dashboard** → welcome card, departments row, doctors row; **BMI calculator** (set height/weight → ring + category); **water tracker**; **wellness mood** score.
6. **Doctors** → list + search; open doctor details (slide transition) → **rate the doctor** (stars; add/update).
7. **Book appointment** → choose me/child → symptoms analysis → department → doctor (watch the **auto-scroll**) → date (watch time-slot scroll) → payment → book → success → appointments refresh.
8. **Appointments** → tabs (Accepted/Waiting/Incomplete); open details; **upload a PDF analysis** and watch the **progress bar**; preview it; replace/delete.
9. **Articles** → list, open details, favorite, favorites screen.
10. **Notifications**, **Family** (child details timeline), **Profile** (edit, patient profile, change password), **Drawer** (dark mode, language, archive, payments, logout).
11. **Offline demo**: turn off network → lists still show from Hive; reconnect → auto `syncAll()`.

---

## 34. Troubleshooting Guide

| Problem | Cause / Fix |
|---|---|
| `flutter analyze` shows many **info lints** | Comments & `// ignore_for_file:`/`// dart format off` directives were removed from all Dart files (batch cleanup). These are **info-level only**, no errors. Fix: `dart format lib` (restores formatting), or re-add the minimal ignore comments if desired. |
| Requests fail | Backend must run at `http://127.0.0.1:8000` (`constants.dart`). For a real device change `base` to the machine's LAN IP. |
| "Token is missing or invalid" | `SharedPrefKeys.userToken` is empty → log in first. |
| Hive adapters / openBox errors | Run on a real device/emulator; clear app data if box type changed (adapters registered in `initHive`). |
| Missing translations | Add keys to `assets/translations/en.json` and `ar.json`; keys are referenced via `.tr()`. |
| Generated files out of date | `dart run build_runner build --delete-conflicting-outputs` for `*.freezed.dart`. |
| Tests | `flutter test` — currently 23 tests pass. |
| Run the app | `flutter run` (first time: `flutter pub get`). |

---

## 35. File & Folder Map

```
lib/
├── main.dart                        # bootstrap, global providers, ConnectivityWatcher
├── constants.dart                   # base URLs + full color palette
├── core/
│   ├── helper/
│   │   ├── router.dart              # GoRouter + _slideTransition
│   │   ├── shared_pref.dart         # SharedPrefHelper + SharedPrefKeys
│   │   ├── text_styles.dart
│   │   ├── observer.dart            # Bloc observer
│   │   └── cache_images.dart        # ImageCacheHelper
│   ├── helper_function/
│   │   ├── get_it_service.dart      # DI setup()
│   │   ├── hive_service.dart        # initHive()
│   │   ├── app_cache_service.dart   # TTL JSON cache
│   │   ├── cache_sync_service.dart  # reconnect sync
│   │   └── confirmation_dialog.dart
│   ├── theme/
│   │   ├── theme.dart               # lightMode / darkMode
│   │   └── theme_provider.dart
│   ├── utils/
│   │   ├── api_services.dart        # Api (Dio) class
│   │   ├── errors/failure.dart      # Failure hierarchy
│   │   ├── app_images.dart / app_lottie.dart / logger_helper.dart
│   └── widget/
│       ├── custom_button.dart, custom_snack_bar.dart,
│       ├── custom_app_bar.dart, pdf_viewer_screen.dart
├── features/
│   ├── splash/            # SplashView + SplashViewBody (init + route decision)
│   ├── on_boarding/       # OnBoardingView, PageView (FirstPage/SecoundPage)
│   ├── onboarding_medical_info/  # Patient/Children info + age calc + Handler Questions
│   ├── auth/              # first_page, login, create_account, OTP, forget_password, logout
│   ├── main_home/         # Bottom-nav shell + BottomNavCubit
│   ├── home/              # dashboard, wellness (BMI/water/mood), doctor details + rating
│   ├── doctors/           # doctors list + search
│   ├── departments/       # departments list + search
│   ├── appointments/      # tabs, details, upload/preview, archive, Hive cache
│   ├── book_appointment/  # 6-section booking + auto-scroll widgets
│   ├── payment/           # payment methods
│   ├── articles/          # articles + favorites + hive_article_model
│   ├── notification/      # notifications (FCM)
│   ├── family/            # family view + child details timeline
│   ├── drawer/            # drawer with profile image, theme, language...
│   └── profile/           # edit profile, patient profile, change password
assets/
├── translations/ (en.json, ar.json)
├── images/  departments_image/  doctors_images/  lottie/
test/                          # 23 passing tests
```

---

## 36. Quick Developer Guide ("If You Need To Modify…")

- **Add a new feature:** create `lib/features/<name>/{presentation,domain,data}`; add a view with `static const routeName`; register it in `router.dart`; register repos/cubits in `get_it_service.dart`; use the `Api` class + a repo returning `Either<Failure, T>`; add a cubit; strings in both translation files.
- **Add an API endpoint:** add a method to the relevant repo that calls `Api.postWithAuth/getWithAuth/putWithAuth/deleteWithAuth` (add `endPoint: '...'` and, if authed, the token/lang are auto-added).
- **Add an animation:** follow section 13 — prefer `AnimatedContainer`/`AnimatedOpacity`/`AnimatedCrossFade`; use `AnimationController` for multi-property; add route-level slides in `router.dart` `_slideTransition`.
- **Add a translation key:** add to `assets/translations/en.json` + `ar.json`, use `'key'.tr()` (or `tr(namedArgs: {...})`).
- **Add/change validation:** edit the relevant cubit (e.g., `AuthValidateCubit`) or the widget-level checks (upload extension/size in `upload_section.dart`).
- **Add a new uploadable file type:** currently hard-limited to `pdf` (20 MB) in `upload_section.dart` (`_allowedExtensions`, `_isPdf`, `_maxSizeBytes`) + preview gating in `_viewFile`.
- **Modify the BMI/wellness:** `bmi_card.dart` categories and `patient_wellness_algorithm.dart` scoring; both are pure/local.
- **Modify the appointment flow / gating:** `appointment_types.dart` (`canUploadMedicalAnalysis`, `isCompletedDiagnosis`), tabs in `appointments_view.dart`.
- **Change the theme palette:** edit `constants.dart` colors; light/dark `ThemeData` in `core/theme/theme.dart`.
- **Adjust auto-scroll behavior:** the `ScrollController.animateTo` calls in `doctor_section.dart`, `department_section.dart`, `calender_section.dart`.

---

## 37. Final Architecture Summary

```mermaid
flowchart LR
  UI[Views / Widgets] --> CUB[Cubits State Management]
  CUB --> REPO[Repo Interfaces (domain)]
  REPO --> IMPL[Repo Implementations (data)]
  IMPL --> API[Api - Dio wrapper]
  IMPL --> HIVE[(Hive boxes / AppCacheService)]
  IMPL --> PREFS[(SharedPreferences)]
  API --> BACK[Laravel API 127.0.0.1:8000/api]
  HIVE --> CACHE_SYNC[CacheSyncService on reconnect]
```

Single source of truth for dependencies: `get_it` (`setup()` + Hive boxes registered in `initHive()`).
Routing/state/repos are all behind interfaces → replaceable and testable.

---

## 38. Writing Style

This document is written **Senior → Junior/Mid developer**: technical, practical, and grounded in the real source files (paths + line references where useful). It avoids marketing fluff, uses tables and short code snippets, and explains *why* behind each decision. Where the code implies a reason that is not literally written, it is flagged as **بحسب implementation الحالي**.

---

## 39. Critical Requirement (what you must be able to explain)

For **every animation/behavior** in this app you must be able to answer: **WHAT** it is, **WHERE** it lives (file), **WHEN** it triggers, **HOW** it's implemented, which **CURVE/DURATION**, which **WIDGET** is used, and **WHY** it was done that way. Use the animation table in section 11 as the checklist:

- Splash logo (AnimationController 1800ms, elasticOut/easeIn/easeOut) → `splash_view_body.dart`.
- Onboarding page slide (500ms easeInOutCubic) + background circles (AnimatedContainer 600ms) + skip fade (AnimatedOpacity 300ms) + CTA morph (AnimatedContainer 300ms + AnimatedCrossFade 250ms) → `on_boarding_view_body.dart`.
- Doctor details push slide (go_router CustomTransitionPage + SlideTransition) → `router.dart`.
- Birth date card highlight (AnimatedContainer 200ms) → `birth_date_card.dart`.
- BMI result reveal (AnimationController 600ms + elasticOut scale + percent ring) → `bmi_card.dart`.
- OTP countdown ring (CircularProgressIndicator value=seconds/total) → `custom_dowm_timer.dart`.
- Upload progress bar (onSendProgress → state.progress) → `preview_upload_cubit.dart` + `upload_section.dart`.
- Auto-scroll on selection (ScrollController.animateTo) → `doctor_section.dart` / `department_section.dart` / `calender_section.dart`.

---

## 40. Final Quality Check

Before the demo / submission, verify:

- [ ] `flutter pub get` succeeds.
- [ ] `flutter run` builds and boots to Splash → Onboarding.
- [ ] `flutter analyze` shows **0 errors** (info lints are expected after comment cleanup — see section 34).
- [ ] `flutter test` passes (23 tests).
- [ ] Backend is running at `http://127.0.0.1:8000`; login flow works.
- [ ] Dark mode toggle works and persists.
- [ ] Language switch (en/ar) flips text + direction + fonts.
- [ ] Birth date → age auto-calculates; child flow works.
- [ ] BMI calculation + categories + ring; water tracker persists per day.
- [ ] Book appointment full flow (incl. auto-scroll) → appears in Appointments.
- [ ] Upload a PDF → progress bar → preview → replace/delete.
- [ ] Offline: lists still render (Hive); reconnecting triggers sync.
- [ ] All routes reachable from their entry points; no "page_not_found" screens in the happy path.

---

## 41. ممنوعات (Prohibitions)

1. **لا تختلق أي feature أو package أو endpoint أو architecture غير موجود في السورس.** كل ما في هذه الوثيقة مستخرج من الكود الفعلي.
2. **لا تستخدم تعابير مؤكدة ("the app does X") لما هو مجرد استنتاج** — استخدم **"بحسب implementation الحالي..."**.
3. **لا تعدّل الكود** بهدف جعل الوثيقة صحيحة؛ الوثيقة تتبع الكود وليس العكس.
4. **لا تدّع ميزات غير مدعومة** (مثل upload لأنواع غير PDF، أو age يُدخل يدويًا — العمر يُحسب تلقائيًا).
5. **لا تحذف الأقسام الأربعين** من هذه الوثيقة — هي عقد التسليم (Deliverable).

---

## 42. Deliverable

When this document is handed over, the recipient will get:

1. **Confirmation** — this `Medicore_app.md` file, created at the repository root.
2. **Summary** — a short list of what was documented (all sections above).
3. **Undocumented / uncertain points** — anything that was **not** documented because its intent was unclear (flagged with بحسب implementation الحالي).
4. **Top 10 expected examiner questions** — the curated list in section 32.
