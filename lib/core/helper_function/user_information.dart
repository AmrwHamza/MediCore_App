import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/shared_pref.dart';

Future<String> getUserEmail() async {
  final userEmail = await SharedPrefHelper.getString(SharedPrefKeys.email);
  return userEmail;
}

Future<String> getFullName() async {
  final firstName = await SharedPrefHelper.getString(SharedPrefKeys.firstName);
  final lastName = await SharedPrefHelper.getString(SharedPrefKeys.lastName);
  return '$firstName $lastName';
}

Future<String> getUserPhone() async {
  final userPhone = await SharedPrefHelper.getString(SharedPrefKeys.phone);
  return userPhone;
}


