import 'package:flutter/material.dart';

final TextEditingController c1 = TextEditingController();
final TextEditingController c2 = TextEditingController();
final TextEditingController c3 = TextEditingController();
final TextEditingController c4 = TextEditingController();
final TextEditingController c5 = TextEditingController();
final TextEditingController c6 = TextEditingController();

void disposeOtpControllers() {
  c1.dispose();
  c2.dispose();
  c3.dispose();
  c4.dispose();
  c5.dispose();
  c6.dispose();
}
