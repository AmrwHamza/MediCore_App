import 'package:flutter/cupertino.dart';

const Color KPrimaryColor = Color(0xff32B2CF);
const Color KBackgroundLight = Color(0xffE7F9FE);
// const Color KBackgroundDark = Color(0xaa111922);
const Color KBackgroundDark = Color(0xFF1E1E2C);
const Color KAppBarDark = Color(0xFF273142);
const Color KCardDark = Color(0xFF2A3647);
const Color KCyan = Color(0xff81D2E4);
const Color KDarkBlue = Color(0xff46707A);
const Color KOrange = Color(0xffCF7C32);
const Color KPurple = Color(0xffAE32CF);
const Color KWhite = Color(0xffE7F9FE);
const Color KGrey = Color(0xff7C8283);
const Color KBlack = Color(0xff0B0D0E);

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

const String base = "http://192.168.93.14:8000";
const String baseurl =
    "$base"
    "/api/";
const String baseurlImg = '$base/storage/project/';

class SharedPrefKeys {
  static const String userToken = 'userToken';
  static const String firstName = 'firstname';
  static const String lastName = 'lastname';
  static const String email = 'email';
  static const String phone = 'phone';
  static const String expireToken = 'expireToken';
  static const String id = 'id';
  static const String isDarkTheme = 'isDarkTheme';
  static const String language = 'language';
}
