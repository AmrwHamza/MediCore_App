import 'package:flutter/cupertino.dart';

// =======================
// Primary Palette
// =======================

const Color KPrimaryColor = Color(0xff32B2CF);

const Color KPrimaryLight = Color(0xFF5CC7DE);
const Color KPrimaryExtraLight = Color(0xFFDDF7FC);

const Color KPrimaryDark = Color(0xFF2497B2);
const Color KPrimaryExtraDark = Color(0xFF1B7288);

// =======================
// Background
// =======================

const Color KBackgroundLight = Color(0xffE7F9FE);
const Color KBackgroundDark = Color(0xFF1E1E2C);

const Color KSurfaceLight = Color(0xFFFFFFFF);
const Color KSurfaceDark = Color(0xFF273142);

const Color KCardDark = Color(0xFF2A3647);
const Color KAppBarDark = Color(0xFF273142);

// =======================
// Secondary
// =======================

const Color KCyan = Color(0xff81D2E4);
const Color KDarkBlue = Color(0xff46707A);

const Color KCyanLight = Color(0xFFE6F9FC);
const Color KCyanDark = Color(0xFF5CBACF);

// =======================
// Accent
// =======================

const Color KOrange = Color(0xffCF7C32);
const Color KOrangeLight = Color(0xFFFFE7D0);
const Color KOrangeDark = Color(0xFFB46218);

const Color KPurple = Color(0xffAE32CF);
const Color KPurpleLight = Color(0xFFF3D9FB);
const Color KPurpleDark = Color(0xFF8926A4);

// =======================
// Success
// =======================

const Color KSuccess = Color(0xFF2EBD85);
const Color KSuccessLight = Color(0xFFE5F8F0);
const Color KSuccessDark = Color(0xFF1F8C61);

// =======================
// Warning
// =======================

const Color KWarning = Color(0xFFFFB020);
const Color KWarningLight = Color(0xFFFFF4D9);
const Color KWarningDark = Color(0xFFC78500);

// =======================
// Error
// =======================

const Color KError = Color(0xFFE5484D);
const Color KErrorLight = Color(0xFFFFE7E8);
const Color KErrorDark = Color(0xFFB62F33);

// =======================
// Info
// =======================

const Color KInfo = Color(0xFF2F80ED);
const Color KInfoLight = Color(0xFFE8F2FF);
const Color KInfoDark = Color(0xFF1C62BD);

// =======================
// Text
// =======================

const Color KWhite = Color(0xffE7F9FE);
const Color KBlack = Color(0xff0B0D0E);

const Color KGrey = Color(0xff7C8283);

const Color KTextPrimaryLight = Color(0xFF1A1F24);
const Color KTextSecondaryLight = Color(0xFF6C757D);

const Color KTextPrimaryDark = Color(0xFFF5F7FA);
const Color KTextSecondaryDark = Color(0xFFB8C0CC);

// =======================
// Borders
// =======================

const Color KBorderLight = Color(0xFFD9E8EC);
const Color KBorderDark = Color(0xFF435063);

// =======================
// Divider
// =======================

const Color KDividerLight = Color(0xFFE7EEF2);
const Color KDividerDark = Color(0xFF3B4658);

// =======================
// Disabled
// =======================

const Color KDisabledLight = Color(0xFFCDD5DB);
const Color KDisabledDark = Color(0xFF4F5B6C);

// =======================
// Status Backgrounds
// =======================

const Color KSuccessBackground = Color(0xFFEAFBF4);
const Color KWarningBackground = Color(0xFFFFF8E5);
const Color KErrorBackground = Color(0xFFFFECEC);
const Color KInfoBackground = Color(0xFFEAF3FF);

const LinearGradient kBottomBarGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [KPrimaryColor, KPrimaryColor],
);

const LinearGradient kAppBarGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFFFFF), Color(0xFFF5F5F5), Color(0xFFEFEFEF)],
);

// const String base = "http://10.0.2.2:8000";
const String base = "http://127.0.0.1:8000";
const String baseurl =
    "$base"
    "/api/";
const String baseurlImg = '$base/storage/project';
